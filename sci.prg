/*
  ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 Ý³                                                                         ³
 Ý³   Programa.....: SCI.PRG                                                ³
 Ý³   Aplicacao....: SCI - SISTEMA COMERCIAL INTEGRADO SCI                  ³
 Ý³   Versao.......: 6.2.30                                                 ³
 Ý³   Escrito por..: Vilmar Catafesta                                       ³
 Ý³   Empresa......: Macrosoft Sistemas de Informatica Ltda.                ³
 Ý³   Inicio.......: 12 de Novembro de 1991.                                ³
 Ý³   Ult.Atual....: 25 de Julho de 2016.                                   ³
 Ý³   Linguagem....: Clipper 5.2e/C/Assembler                               ³
 Ý³   Linker.......: Blinker 6.00                                           ³
 Ý³   Bibliotecas..: Clipper/Funcoes/Mouse/Funcky15/Funcky50/Classe/Classic ³
 Ý³   Bibliotecas..: Oclip/Six3                                             ³
 ÝÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
 ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

/*
#ifdef __PLATFORM__WINDOWS
   REQUEST HB_GT_WVT_DEFAULT
   #define THREAD_GT hb_gtVersion()
#else
   REQUEST HB_GT_STD_DEFAULT
   #define THREAD_GT "XWC"
#endif
*/

#include <sci.ch>

REQUEST HB_CODEPAGE_PT850
REQUEST HB_CODEPAGE_PTISO
REQUEST HB_CODEPAGE_PT860
REQUEST HB_CODEPAGE_UTF8
REQUEST HB_LANG_EN
REQUEST HB_LANG_PT
static s_hMutex

init def Main(...)
*-----------*
	LOCAL lOk		  := OK
	LOCAL Opc		  := 1
	LOCAL cTela
	LOCAL ph1     
	PUBLI aMensagem  := {}
	PUBLI aItemNff	  := {}
	PUBLI aPermissao := {}
	PUBLI aInscMun	  := {}
	PUBLI aIss		  := {}
	PUBLI XCFGPIRACY := MsEncrypt( ENCRYPT )
	*:----------------------------------------------------------------------------
	hb_langSelect( "pt" ) 	
	//hb_cdpSelect( "PT860" )
   Altd(1)        //Debug
	PUBLI oAmbiente := TAmbiente():New()
	PUBLI oMenu     := oAmbiente
	PUBLI oIni		 := TIniNew("sci.ini")
	PUBLI oIndice	 := TIndiceNew()
	PUBLI oProtege	 := TProtegeNew()
   PUBLI oPrinter  := TPrinterNew()
	PUBLI oReindexa  // Controle de Reindexacao 
	PUBLI oSci       // Controle de Usuario
	PUBLI cCaixa   
	*:----------------------------------------------------------------------------
	//Eval( oAmbiente:TabelaFonte[ oAmbiente:Fonte ])
	//IntroMain()
	//Turbo(OK)
	//OL_AutoYield(OK)
	//SetMode(oAmbiente:AlturaFonteDefaultWindows, oAmbiente:LarguraFonteDefaultWindows)   
	SetColor("")
	SetaIni()
	//RddSetDefault( RDDNAME )   
	Acesso()
	*:----------------------------------------------------------------------------
	SetKey( F1, 		  {|| HelpReceposi() })
	SetKey( F8, 		  {|| AcionaSpooler() })
	//SetKey( F10,		  {|| FT_Adder()})
	SetKey( F10,		  {|| Calc() })
	SetKey( F12,		  {|| ConfigurarEtiqueta() })
	SetKey( TECLA_ALTC, {|| Altc() })
	SetKey( K_CTRL_P,   {|| AcionaSpooler() })
	SetKey( K_CTRL_END, {|| GravaDisco() })
	SetKey( K_SH_F10,   {|| AutorizaVenda() })
	*:----------------------------------------------------------------------------
	#IFDEF DEMO
		oMenu:Limpa()
		ErrorBeep()
		Alerta( oIni:ReadString("string", "string4") + ;
				  oIni:ReadString("string", "string5") + ;
				  oIni:ReadString("string", "string6") + ;
				  oIni:ReadString("string", "string7") + ;
				  oIni:ReadString("string", "string8") )
	#ENDIF
	*:----------------------------------------------------------------------------
	oAmbiente:Clock           := Time() 
	oAmbiente:HoraCerta       := Array(100)
	oAmbiente:TarefaConcluida := Array(100)
	Afill( oAmbiente:HoraCerta, Time())
	Afill( oAmbiente:TarefaConcluida, FALSO )
	//s_hMutex       := hb_mutexCreate()
	//s_mainThreadID := hb_threadSelf()/
	//hb_threadStart(HB_THREAD_INHERIT_MEMVARS, @RealClock())
	//ph1 := hb_idleAdd( {|| CronTab   Info(2)
	Empresa()
	FechaTudo()
	if !VerIndice()
		Alert("ERRO Tente mais tarde.")
		FChDir( oAmbiente:xBase )
		SalvaMem()
		SetMode(oAmbiente:AlturaFonteDefaultWindows, oAmbiente:LarguraFonteDefaultWindows)
		Cls
		Quit
	endif
	if AbreUsuario()
		Usuario()
	else
		SalvaMem()
		ResTela()
		SetMode(oAmbiente:AlturaFonteDefaultWindows, oAmbiente:LarguraFonteDefaultWindows)
		Quit
	endif
	SetaIni()
	oMenu:Limpa()
	SetaClasse()
	RefreshClasse()
	WHILE lOk
		BEGIN Sequence
			SetKey( F5, {|| PrecosConsulta()})
			oMenu:Limpa()
			Opc := oMenu:Show()
			Do Case
			Case opc = 0.0 .OR. opc = 1.01
				ErrorBeep()
				//hwg_MsgYesNo("Pergunta: Deseja finalizar esta sessao ?")
				IF conf("Pergunta: Deseja finalizar esta sessao ?" )
					lOk := FALSO
					Break
				EndIF
			Case opc = 1.03
				Empresa()
				IF !VerIndice()
					Alert("ERRO: Arquivos nao disponivel para indexacao. Tente mais tarde.")
					SalvaMem()
					ResTela()
					SetMode(oAmbiente:AlturaFonteDefaultWindows, oAmbiente:LarguraFonteDefaultWindows)
					Quit
				EndIF
				oMenu:Limpa()
				IF AbreUsuario()
					Usuario()
				Else
					SalvaMem()
					SetMode(oAmbiente:AlturaFonteDefaultWindows, oAmbiente:LarguraFonteDefaultWindows)
					Quit
				EndIF
				SetaClasse()
				RefreshClasse()
			Case opc = 1.04
				IF AbreUsuario()
					SetKey( F5, NIL )
					Usuario()
					SetaClasse()
					FechaTudo()
				EndIF
				RefreshClasse()
				SetKey( F5, {|| PrecosConsulta()})
			Case opc = 1.06
				MacroBackup()
			Case opc = 1.07
				MacroRestore()
			Case opc = 2.01
				#IFDEF TESTELAN
					//Acesso(OK)
					ListaLan()
					RefreshClasse()
				#ELSE
					Alerta("INFORME: Modulo nao disponivel para esse cliente.")
				#ENDIF
				
			Case opc = 2.02
				#IFDEF RECELAN
					if aPermissao[SCI_CONTAS_A_RECEBER]
						//Acesso(OK)
						Recelan()
						RefreshClasse()			
					else
						Alerta("INFORME ao usuario " + oAmbiente:xUsuario + ";;Voce nao tem permissao para usar esse modulo.;Consulte o gerente de suporte para maiores informacoes.")							
					endif	
				#ELSE
					Alerta("INFORME: Modulo nao disponivel para esse cliente.")
				#ENDIF
			Case opc = 2.03
				#IFDEF PAGALAN
					//Acesso(OK)
					PagaLan()
					RefreshClasse()
				#ELSE
					Alerta("INFORME: Modulo nao disponivel para esse cliente.")			
				#ENDIF
			Case opc = 2.04
				#IFDEF CHELAN
					//Acesso(OK)
					Chelan()
					RefreshClasse()
				#ELSE
					Alerta("INFORME: Modulo nao disponivel para esse cliente.")			
				#ENDIF
			Case Opc = 2.05
				#IFDEF SCP
					if aPermissao[SCI_CONTROLE_DE_PRODUCAO]
						//Acesso(OK)
						ScpLan()
						RefreshClasse()
					else	
						Alerta("INFORME ao usuario " + oAmbiente:xUsuario + ";;Voce nao tem permissao para usar esse modulo.;Consulte o gerente de suporte para maiores informacoes.")			
					endif
				#ELSE
					Alerta("INFORME: Modulo nao disponivel para esse cliente.")			
				#ENDIF
			Case Opc = 2.06
				#IFDEF PONTO
					//Acesso(OK)
					PontoLan()
					RefreshClasse()
				#ELSE
					Alerta("INFORME: Modulo nao disponivel para esse cliente.")			
				#ENDIF
			Case Opc = 2.07
				Carta()
			Case Opc = 2.08
				#IFDEF VENLAN
					//Acesso(OK)
					Venlan()
					RefreshClasse()
				#ELSE
					Alerta("INFORME: Modulo nao disponivel para esse cliente.")			
				#ENDIF
			Case opc = 3.01
				#IFDEF ORCALAN
					//Acesso(OK)
					Orcamento( FALSO )
				#ELSE
					Alerta("INFORME: Modulo nao disponivel para esse cliente.")			
				#ENDIF
			Case opc = 3.02
				IF !UsaArquivo("LISTA")    ; Break ; EndiF
				IF !UsaArquivo("GRUPO")    ; Break ; EndiF
				IF !UsaArquivo("SUBGRUPO") ; Break ; EndiF
				IF !UsaArquivo("PAGAR")    ; Break ; EndiF
				IF !UsaArquivo("REPRES")   ; Break ; EndiF
				TermPrecos()
			Case opc = 3.03
				cTela := Mensagem("Aguarde, Abrindo Arquivos.")
				IF !UsaArquivo("SAIDAS")  ; Break ; EndiF
				IF !UsaArquivo("RECEBER") ; Break ; EndiF
				IF !UsaArquivo("FORMA")   ; Break ; EndiF
				IF !UsaArquivo("LISTA")   ; Break ; EndiF
				IF !UsaArquivo("CEP")     ; Break ; EndiF
				IF !UsaArquivo("REGIAO")  ; Break ; EndiF
				ResTela( cTela )
				VendasTipo()
				FechaTudo()
			Case opc = 3.04
				cTela := Mensagem("Aguarde, Abrindo Arquivos.")
				IF !UsaArquivo("SAIDAS")  ; Break ; EndiF
				IF !UsaArquivo("RECEBER") ; Break ; EndiF
				IF !UsaArquivo("FORMA")   ; Break ; EndiF
				IF !UsaArquivo("REGIAO")  ; Break ; EndiF
				IF !UsaArquivo("RECEMOV") ; Break ; EndiF
				IF !UsaArquivo("CEP")     ; Break ; EndiF
				ResTela( cTela )
				WHILE OK
					oMenu:Limpa()
					M_Title("TIPO DE RELATORIO")
					nChoice := FazMenu( 03, 20, {"Por Vencimento", "Por Emissao *"})
					Do Case
					Case nChoice = 0
						Exit
					Case nChoice = 1
						PrnAlfabetica(1)
					Case nChoice = 2
						PrnAlfabetica(2)
					EndCase
				EndDo
				FechaTudo()
			Case opc = 3.05
				cTela := Mensagem("Aguarde, Abrindo Arquivos.")
				IF !UsaArquivo("SAIDAS")  ; Break ; EndiF
				IF !UsaArquivo("RECEBER") ; Break ; EndiF
				IF !UsaArquivo("RECEBIDO"); Break ; EndiF
				IF !UsaArquivo("VENDEDOR"); Break ; EndiF
				IF !UsaArquivo("FORMA")   ; Break ; EndiF
				IF !UsaArquivo("REGIAO")  ; Break ; EndiF
				ResTela( cTela )
				RelRecebido()
				FechaTudo()
			Case opc = 3.06
				IF UsaArquivo("VENDEDOR" )
					CadastraSenha()
					FechaTudo()
				EndIF
			Case opc = 3.08
				IF !UsaArquivo("RECEBIDO") ; Break ; EndiF
				IF !UsaArquivo("VENDEDOR") ; Break ; EndiF
				IF !UsaArquivo("CHEMOV")   ; Break ; EndiF
				IF !UsaArquivo("RECEMOV")  ; Break ; EndiF
				IF !UsaArquivo("RECEBER")  ; Break ; EndiF
				IF !UsaArquivo("SAIDAS")   ; Break ; EndiF
				DetalheCaixa(, FALSO )
				FechaTudo()
			Case opc = 3.09
				IF !UsaArquivo("RECEBIDO") ; Break ; EndiF
				IF !UsaArquivo("VENDEDOR") ; Break ; EndiF
				IF !UsaArquivo("CHEMOV")   ; Break ; EndiF
				IF !UsaArquivo("RECEMOV")  ; Break ; EndiF
				IF !UsaArquivo("RECEBER")  ; Break ; EndiF
				IF !UsaArquivo("SAIDAS")  ; Break ; EndiF
				DetalheCaixa(, OK )
				FechaTudo()
			Case opc = 3.10
				IF !UsaArquivo("RECEBIDO") ; Break ; EndiF
				IF !UsaArquivo("VENDEDOR") ; Break ; EndiF
				IF !UsaArquivo("CHEMOV")   ; Break ; EndiF
				IF !UsaArquivo("RECEMOV")  ; Break ; EndiF
				IF !UsaArquivo("RECEBER")  ; Break ; EndiF
				IF !UsaArquivo("CHEQUE")   ; Break ; EndiF
				IF !UsaArquivo("SAIDAS")   ; Break ; EndiF
				DetalheCaixa(, OK, Opc )
				FechaTudo()
			Case opc = 3.11
				IF !UsaArquivo("VENDEDOR") ; Break ; EndiF
				IF !UsaArquivo("RECIBO")   ; Break ; EndiF
				DetalheRecibo(,1)
				FechaTudo()
			Case opc = 3.12
				IF !UsaArquivo("VENDEDOR") ; Break ; EndiF
				IF !UsaArquivo("RECIBO")   ; Break ; EndiF
				DetalheRecibo(,2)
				FechaTudo()
			Case opc = 3.13
				IF !UsaArquivo("VENDEDOR") ; Break ; EndiF
				IF !UsaArquivo("RECIBO")   ; Break ; EndiF
				DetalheRecibo(,3)
				FechaTudo()
			Case opc = 3.15
				IF UsaArquivo("SAIDAS")
					IF UsaArquivo("LISTA")
						IF UsaArquivo("RECEBER")
							ImprimeDebito()
							FechaTudo()
						EndIF
					EndIF
				EndIF
			Case opc = 3.16
				IF UsaArquivo("SAIDAS")
					IF UsaArquivo("LISTA")
						IF UsaArquivo("RECEBER")
							IF UsaArquivo("CHEQUE")
								IF UsaArquivo("CHEMOV")
									MostraDebito()
									FechaTudo()
								EndIF
							EndIF
						EndIF
					EndIF
				EndIF
			Case opc = 3.17
				IF UsaArquivo("SAIDAS")
					IF UsaArquivo("LISTA")
						IF UsaArquivo("RECEBER")
							DebitoC_C()
							FechaTudo()
						EndIF
					EndIF
				EndIF
			Case opc = 3.18
				IF !UsaArquivo("LISTA")    ; Break ; EndiF
				IF !UsaArquivo("RECEBER")  ; Break ; EndiF
				IF !UsaArquivo("SAIDAS")   ; Break ; EndiF
				IF !UsaArquivo("CHEMOV")   ; Break ; EndiF
				IF !UsaArquivo("CHEQUE")   ; Break ; EndiF
				IF !UsaArquivo("VENDEDOR") ; Break ; EndiF
				BaixaDebitoc_c()
				FechaTudo()
			Case opc = 3.20
				EcfComandos()
			Case opc = 4.01
				MacroBackup()
			Case opc = 4.02
				MacroRestore()
				oMenu:Limpa()
				ErrorBeep()
				IF Conf("Pergunta: Reindexar os Arquivos Agora ?")
					IF MenuIndice()
						CriaIndice()
					EndIF
				EndIF
			Case Opc = 4.03
				GeraBatch()
			Case Opc = 4.05
				 if MenuIndice()
					 CriaIndice()
				 endif
			Case Opc = 4.06
				 IF MenuIndice()
					 FechaTudo()
					 IF AbreArquivo()
						 Duplicados()
						 CriaIndice()
					 EndIF
				 EndIF
			Case Opc = 4.07
				 IF MenuIndice()
					 Reindexar()
					 oIndice:Compactar	 := FALSO
					 oIndice:ProgressoNtx := FALSO
				 EndIF
			Case Opc = 4.08
				ExcluirTemporarios()
			Case Opc = 5.01
				Edicao()
			Case Opc = 5.02
				Impressao()
			Case Opc = 5.03
				FechaTudo()
				//WA_USE('PRINTER'); hb_threadJoin(hb_threadStart(HB_THREAD_INHERIT_MEMVARS, @CriaIndice(), "PRINTER"))			
				aThreads := {}
				s_hMutex := hb_mutexCreate()
				lEnd     := .F.
				WA_USE('PRINTER'); AAdd( aThreads, hb_threadStart(HB_THREAD_INHERIT_MEMVARS,@CriaIndice(), "PRINTER", @lEnd ))
				WA_USE('RECEBER'); AAdd( aThreads, hb_threadStart(HB_THREAD_INHERIT_MEMVARS,@CriaIndice(), "RECEBER", @lEnd ))
				WA_USE('RECEMOV'); AAdd( aThreads, hb_threadStart(HB_THREAD_INHERIT_MEMVARS,@CriaIndice(), "RECEMOV", @lEnd ))
				WA_USE('NOTA');    AAdd( aThreads, hb_threadStart(HB_THREAD_INHERIT_MEMVARS,@CriaIndice(), "NOTA",    @lEnd ))
				Inkey( 5 )
				lEnd := .T.
				AEval( aThreads, {| x | hb_threadJoin( x ) } )
            
			Case Opc = 5.04
            oPdf := TPdfNew()
				
			Case oPc = 6.01
				Spooler()
			Case oPc = 6.02
				oMenu:SetaFonte()
				SalvaMem()
			Case oPc = 6.04
				oMenu:SetaCor( 3 )
				SalvaMem()
			Case oPc = 6.05
				oMenu:SetaCor( 1 )
				SalvaMem()
			Case oPc = 6.06
				oMenu:SetaCor( 2 )
				SalvaMem()
			Case oPc = 6.07
				oMenu:SetaCorAlerta(8)
				oAmbiente:CorAlerta := oMenu:CorAlerta
				SalvaMem()
			Case oPc = 6.08
				oMenu:SetaCorBorda(10)
				SalvaMem()
			Case oPc = 6.09
				oMenu:SetaCor( 4 )
				SalvaMem()
			Case oPc = 6.10
				oMenu:SetaCorMsg(9)
				oAmbiente:CorMsg := oMenu:CorMsg
				SalvaMem()
			Case oPc = 6.11
				oMenu:SetaCor( 5 ) // ::CorLigthBar
				SalvaMem()
			Case oPc = 6.12
				oMenu:SetaCor( 6 ) // ::CorHotKey
				SalvaMem()			
			Case oPc = 6.13
				oMenu:SetaCor( 7 ) // ::CorLightBarHotKey
				SalvaMem()	
			Case oPc = 6.14
				oMenu:SetaCor( 11 ) 
				SalvaMem()	            
			Case oPc = 6.16
				oMenu:SetaPano()
				SalvaMem()
			Case oPc = 6.17
				oMenu:SetaFrame()
				SalvaMem()
			Case oPc = 6.18
				oMenu:Sombra	  := !(oIni:ReadBool( oAmbiente:xUsuario, 'sombra', FALSO ))
				oAmbiente:Sombra := oMenu:Sombra
				oMenu:SetaSombra()
				oMenu:Menu := oSciMenuSci()
				SalvaMem()
			Case oPc = 6.19
				oAmbiente:Get_Ativo := !(oIni:ReadBool( oAmbiente:xUsuario, 'get_ativo', FALSO ))
				oMenu:Menu := oSciMenuSci()
				SalvaMem()
			Case oPc = 6.20
				IF !UsaArquivo("USUARIO") ; Break ; EndIF
				IF !UsaArquivo("PRINTER") ; Break ; EndIF
				AltSenha()
				FechaTudo()
			Case Opc = 7.01
				oMenu:Limpa()
				Diretorio( 03, 05, LastRow() - 2, "W+/B,N/W,,,W+/N")
			Case Opc = 7.02
				TbDemo()
			Case Opc = 7.04
				 IF MenuIndice()
					 CriaIndice()
				 EndIF
			Case Opc = 7.05
				 IF MenuIndice()
					 FechaTudo()
					 IF AbreArquivo()
						 Duplicados()
						 CriaIndice()
					 EndIF
				 EndIF
			Case Opc = 7.07
				 ExcluirTemporarios()
			Case opc = 7.08
				IF !UsaArquivo("USUARIO") ; Break ; EndIF
				IF !UsaArquivo("PRINTER") ; Break ; EndIF
				CadastraUsuario()
				RefreshClasse()
				FechaTudo()
			Case opc = 7.09
				ConfBaseDados()
				FechaTudo()
			Case opc = 7.10
				#IFDEF MICROBRAS
					IF !UsaArquivo("RETORNO") ; Break ; EndIF
					IF !UsaArquivo("RECEBER") ; Break ; EndIF
					IF !UsaArquivo("RECEMOV") ; Break ; EndIF
					IF !UsaArquivo("CEP")     ; Break ; EndIF
					IF !UsaArquivo("REGIAO")  ; Break ; EndIF
					Retorno()
					FechaTudo()
				#ENDIF
			Case opc = 7.11
				Alerta("Informa: Em implantacao.")
				/*
				IF !UsaArquivo("CHEMOV") ; Break ; EndIF
				MoviAnual()
				FechaTudo()
				*/
			Case opc = 7.12
				AutoCaixa()
				FechaTudo()
			Case opc = 7.13
				ZeraCaixa()
				FechaTudo()
			Case oPc = 7.14
				CadastroImpressoras()
				FechaTudo()
			Case oPc =7.15
				PrinterDbedit()
				FechaTudo()
			Case oPc = 7.16
				CenturyOn()
				Hard( 3 )
				oMenu:Limpa()
				oMenu:CorCabec := Roloc( oMenu:CorCabec )
				oMenu:StatSup("SOBRE O " + SISTEM_NA1 + " " + SISTEM_VERSAO )
				Info(2)
				CenturyOff()
			Case opc = 8.01
				IntBaseDados()
			Case opc = 8.02
				CriaNewNota()
			Case oPc = 8.03
				 ErrorBeep()
				 if Conf("Pergunta: Continuar com a opera‡ao ?")
					 oPrinter:CriaNewPrinter()
					 FechaTudo()
					 if AbreArquivo('PRINTER')
						 oIndice:ProgressoNtx := true
						 CriaIndice('PRINTER')
						 oIndice:ProgressoNtx := false
						 FechaTudo()
                   oMenu:Limpa()
                   alert("Informa: Tarefa efetuada com sucesso")
					 endif
				 endif
			Case oPc = 8.04
				 ErrorBeep()
				 IF Conf("Pergunta: Continuar com a opera‡ao ?")
					 CriaNewEnt()
					 FechaTudo()
					 IF AbreArquivo('ENTNOTA')
						 oIndice:ProgressoNtx := OK
						 CriaIndice('ENTNOTA')
						 oIndice:ProgressoNtx := FALSO
						 FechaTudo()
                   oMenu:Limpa()
                   alert("Informa: Tarefa efetuada com sucesso")
					 EndIF
				 EndIF
			Case oPc = 8.05
				 ErrorBeep()
				 IF Conf("Pergunta: Continuar com a opera‡ao ?")
					 Fechatudo()
					 IF AbreArquivo('PREVENDA')
						 oIndice:ProgressoNtx := true
						 oIndice:Compactar	 := true
						 CriaIndice('PREVENDA')
						 oIndice:ProgressoNtx := FALSO
						 oIndice:Compactar	 := FALSO
						 FechaTudo()
                   oMenu:Limpa()
                   alert("Informa: Tarefa efetuada com sucesso")
					 EndIF
				 EndIF
			Case Opc = 9.01
				Dos()
			Case Opc = 9.02
				Comandos()
			Case opc = 10.01
				oMenu:Limpa()
				oMenu:CorCabec := Roloc( oMenu:CorCabec )
				oMenu:StatSup("SOBRE O " + SISTEM_NA1 + " " + SISTEM_VERSAO )
				Info(2)
			Case oPc = 10.02
				Novidades()
			Case oPc = 10.03
				//Help()
            HelpReceposi()            
			EndCase
		Recover
			//NNetTtsAb()
			FechaTudo()
		FINALLY
	EndDo
	Encerra()
endef

def SetaClasse()
*--------------*
	LOCAL cSn1 := SISTEM_NA1
	LOCAL cSn2 := SISTEM_NA2
	LOCAL cSn3 := SISTEM_NA3
	LOCAL cSn4 := SISTEM_NA4
	LOCAL cSn5 := SISTEM_NA5
	LOCAL cSn6 := SISTEM_NA6
	LOCAL cSn7 := SISTEM_NA7
	LOCAL cSn8 := SISTEM_NA8

	LOCAL cSv  := SISTEM_VERSAO
	LOCAL cSp  := Space(1)
	LOCAL cSt1 := "F1-HELP³F5-PRECOS³F10-CALC³"
	LOCAL cSt2 := "F1-HELP³F5-LISTA³F8-SPOOL³ESC-RETORNA³"
	LOCAL cSt3 := "F1-HELP³F5-LISTA³F8-SPOOL³ESC-RETORNA³"
	LOCAL cSt4 := "F1-HELP³F5-LISTA³F8-SPOOL³ESC-RETORNA³"
	LOCAL cSt5 := "F1-HELP³F5-LISTA³F8-SPOOL³ESC-RETORNA³"
	LOCAL cSt6 := "F1-HELP³F5-LISTA³F8-SPOOL³ESC-RETORNA³"
	LOCAL cSt7 := "F1-HELP³F5-LISTA³F8-SPOOL³ESC-RETORNA³"
	LOCAL cSt8 := "F1-HELP³F5-LISTA³F8-SPOOL³ESC-RETORNA³"

	oMenu:StSupArray               := { cSn1+cSp+cSv, cSn2+cSp+cSv,cSn3+cSp+cSv,cSn4+cSp+cSv,cSn5+cSp+cSv,cSn6+cSp+cSv, cSn7+cSp+cSv, cSn8+cSp+cSv }
	oMenu:StInfArray               := { cSt1, cSt2, cSt3, cSt4, cSt5, cSt6, cSt7, cSt8,  }
	oMenu:MenuArray                := { oSciMenuSci(), oMenuTesteLan(),   oMenuRecelan(),   oMenuPagaLan(),   oMenuChelan(),   oMenuVenLan(), oMenuScpLan(), oMenuPontoLan() }
	oMenu:DispArray                := { aDispSci(),    aDispTesteLan(),   aDispRecelan(),   aDispPagaLan(),   aDispChelan(),   aDispVenLan(), aDispScpLan(), aDispPontoLan() }
	//oMenu:LetraHotKeyArray         := { aLtHKSci(),    aLtHKTesteLan(),   aLtHKRecelan(),   aLtHKPagaLan(),   aLtHKChelan(),   aLtHKVenLan() }
	//oMenu:LetraLightBarHotKeyArray := { aLtLBHKSci(),  aLtLBHKTesteLan(), aLtLBHKRecelan(), aLtLBHKPagaLan(), aLtLBHKChelan(), aLtLBHKVenLan() }   
   //BrowseArray(oSciMenuSci())
	Return
endef

def RefreshClasse()
	oMenu:StatusSup		          := oMenu:StSupArray[1]
	oMenu:StatusInf	           	 := oMenu:StInfArray[1]
	oMenu:Menu		           	 	 := oMenu:MenuArray[1]
	oMenu:Disp				          := oMenu:DispArray[1]
	//oMenu:LetraHotKeyArray         := oMenu:LetraHotKeyArray[1]
	//oMenu:LetraLightBarHotKeyArray := oMenu:LetraLightBarHotKeyArray[1]
	return nil
endef	

def SalvaMem()	
	oIni:WriteString(  oAmbiente:xUsuario,	'frame',         oMenu:Frame )
	oIni:WriteString(  oAmbiente:xUsuario,	'panofundo',     oMenu:PanoFundo )
	oIni:WriteInteger( oAmbiente:xUsuario, 'selecionado',   oMenu:Selecionado )
	oIni:WriteInteger( oAmbiente:xUsuario, 'cormenu',       oMenu:CorMenu )
   oIni:WriteInteger( oAmbiente:xUsuario, 'corbarramenu',  oMenu:CorBarraMenu )
	oIni:WriteInteger( oAmbiente:xUsuario, 'CorLightBar',   oMenu:CorLightBar )
	oIni:WriteInteger( oAmbiente:xUsuario, 'CorHotKey',     oMenu:CorHotKey )
	oIni:WriteInteger( oAmbiente:xUsuario, 'CorHKLightBar', oMenu:CorHKLightBar)
	oIni:WriteInteger( oAmbiente:xUsuario, 'corfundo',      oMenu:Corfundo )
	oIni:WriteInteger( oAmbiente:xUsuario, 'corcabec',      oMenu:CorCabec )
	oIni:WriteInteger( oAmbiente:xUsuario, 'cordesativada', oMenu:CorDesativada )
	oIni:WriteInteger( oAmbiente:xUsuario, 'corbox',        oMenu:CorBox )
	oIni:WriteInteger( oAmbiente:xUsuario, 'corcima',       oMenu:CorCima )
	oIni:WriteInteger( oAmbiente:xUsuario, 'corantiga',     oMenu:CorAntiga )
	oIni:WriteInteger( oAmbiente:xUsuario, 'corborda',      oMenu:CorBorda )
	oIni:WriteInteger( oAmbiente:xUsuario, 'fonte',         oMenu:Fonte )
	oIni:WriteInteger( oAmbiente:xUsuario, 'fonte',         oMenu:Fonte )
	oIni:WriteInteger( oAmbiente:xUsuario, 'FonteManualAltura', oMenu:FonteManualAltura )
	oIni:WriteInteger( oAmbiente:xUsuario, 'FonteManualLargura', oMenu:FonteManualLargura )
	oIni:WriteInteger( oAmbiente:xUsuario, 'coralerta',     oAmbiente:CorAlerta )
	oIni:WriteInteger( oAmbiente:xUsuario, 'cormsg',        oAmbiente:CorMsg )
	oIni:WriteBool(    oAmbiente:xUsuario, 'sombra',        oMenu:Sombra )
	oIni:WriteBool(    oAmbiente:xUsuario, 'get_ativo',     oAmbiente:Get_Ativo )
	//oAmbiente:ShowVar(true, nil, true)	
	SetaIni()
	return NIL
endef

def SetaIni()		
	oMenu:Frame 				 := oIni:ReadString( oAmbiente:xUsuario,  'frame',         oAmbiente:Frame )
	oMenu:PanoFundo			 := oIni:ReadString( oAmbiente:xUsuario,  'panofundo',     oAmbiente:PanoFundo )
	oMenu:CorMenu				 := oIni:ReadInteger( oAmbiente:xUsuario, 'cormenu',       oAmbiente:CorMenu )
   oMenu:CorBarraMenu	    := oIni:ReadInteger( oAmbiente:xUsuario, 'corbarramenu',  oAmbiente:CorBarraMenu )
	oMenu:CorMsg				 := oIni:ReadInteger( oAmbiente:xUsuario, 'cormsg',        oAmbiente:CorMsg )
	oMenu:CorFundo 			 := oIni:ReadInteger( oAmbiente:xUsuario, 'corfundo',      oAmbiente:Corfundo )
	oMenu:CorCabec 			 := oIni:ReadInteger( oAmbiente:xUsuario, 'corcabec',      oAmbiente:CorCabec )
	oMenu:CorDesativada		 := oIni:ReadInteger( oAmbiente:xUsuario, 'cordesativada', oAmbiente:CorDesativada )
	oMenu:CorBox				 := oIni:ReadInteger( oAmbiente:xUsuario, 'corbox',        oAmbiente:CorBox )
	oMenu:CorCima				 := oIni:ReadInteger( oAmbiente:xUsuario, 'corcima',       oAmbiente:CorCima )
	oMenu:Selecionado 		 := oIni:ReadInteger( oAmbiente:xUsuario, 'selecionado',   oAmbiente:Selecionado )
	oMenu:CorAntiga			 := oIni:ReadInteger( oAmbiente:xUsuario, 'corantiga',     oAmbiente:CorAntiga )
	oMenu:CorBorda 			 := oIni:ReadInteger( oAmbiente:xUsuario, 'corborda',      oAmbiente:CorBorda )
	oMenu:CorAlerta			 := oIni:ReadInteger( oAmbiente:xUsuario, 'coralerta',     oAmbiente:CorAlerta )
	oMenu:Fonte 				 := oIni:ReadInteger( oAmbiente:xUsuario, 'fonte',         oAmbiente:Fonte )
	oMenu:FonteManualAltura  := oIni:ReadInteger( oAmbiente:xUsuario, 'FonteManualAltura', oAmbiente:FonteManualAltura )
	oMenu:FonteManualLargura := oIni:ReadInteger( oAmbiente:xUsuario, 'FonteManualLargura', oAmbiente:FonteManualLargura )
	oMenu:Sombra		 		 := oIni:ReadBool( oAmbiente:xUsuario,	  'sombra',        oAmbiente:Sombra )
   oMenu:lManterPosicaoMenuVertical := oIni:ReadBool('sistema','manterposicaomenuvertical')
	oMenu:CorLightBar        := oIni:ReadInteger( oAmbiente:xUsuario, 'CorLightBar',   oAmbiente:CorLightBar )
	oMenu:CorHotKey          := oIni:ReadInteger( oAmbiente:xUsuario, 'CorHotKey',     oAmbiente:CorHotKey )
	oMenu:CorHKLightBar      := oIni:ReadInteger( oAmbiente:xUsuario, 'CorHKLightBar', oAmbiente:CorHKLightBar)
	oMenu:SetaSombra()

	oAmbiente:Get_Ativo           := oIni:ReadBool( oAmbiente:xUsuario,    'get_ativo',     oAmbiente:Get_Ativo )
	oAmbiente:Mostrar_Desativados := oIni:ReadBool( "sistema",'Mostrar_Desativados', oAmbiente:Mostrar_Desativados )
	oAmbiente:Mostrar_Recibo      := oIni:ReadBool( "sistema",'Mostrar_Recibo', oAmbiente:Mostrar_Recibo )
	oAmbiente:Frame               := oMenu:Frame
	oAmbiente:PanoFundo     		:= oMenu:PanoFundo
	oAmbiente:CorMenu 	      	:= oMenu:CorMenu
   oAmbiente:CorBarraMenu 	     	:= oMenu:CorBarraMenu
	oAmbiente:CorLightBar         := oMenu:CorLightBar
	oAmbiente:CorHotKey           := oMenu:CorHotKey
	oAmbiente:CorHKLightBar       := oMenu:CorHKLightBar
	oAmbiente:CorMsg			      := oMenu:CorMsg
	oAmbiente:CorFundo		      := oMenu:CorFundo
	oAmbiente:CorCabec		      := oMenu:CorCabec
	oAmbiente:CorDesativada       := oMenu:CorDesativada
	oAmbiente:CorBox			      := oMenu:CorBox
	oAmbiente:CorCima 		      := oMenu:CorCima
	oAmbiente:Selecionado	      := oMenu:Selecionado
	oAmbiente:CorAntiga		      := oMenu:CorAntiga
	oAmbiente:CorBorda		      := oMenu:CorBorda
	oAmbiente:CorAlerta		      := oMenu:CorAlerta
	oAmbiente:Fonte			      := oMenu:Fonte
	oAmbiente:FonteManualAltura   := oMenu:FonteManualAltura
	oAmbiente:FonteManualLargura  := oMenu:FonteManualLargura
	oAmbiente:Sombra			      := oMenu:Sombra
   oAmbiente:lManterPosicaoMenuVertical := oMenu:lManterPosicaoMenuVertical
	IF oAmbiente:Fonte > 1
		Eval( oAmbiente:TabelaFonte[ oAmbiente:Fonte] )
	EndIF
	return( NIL)
		
	endef
	
Proc GeraBatch()
****************
LOCAL Handle
LOCAL xBatch := oAmbiente:xBase + "\SALVA.BAT"

oMenu:Limpa()
Alerta("Este procedimento ira gerar um arquivo para copia;de seguranca externa se porventura tiver algum ;problema ao fazer copia de seguranca interna.")
Ferase( xBatch )
handle := FCreate( xBatch )
IF ( Ferror() != 0 )
	Alert("Erro de Criacao de " + xBatch )
	Return
EndIF
MsWriteLine( Handle, "@ECHO OFF")
MsWriteLine( Handle, "CLS")
MsWriteLine( Handle, Left( oAmbiente:xBase, 2 ))
MsWriteLine( Handle, "CD " + oAmbiente:xBase )
MsWriteLine( Handle, "ECHO ÕÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¸")
MsWriteLine( Handle, "ECHO ³ ÝÝÝÝ  ÝÝÝÝMacrosoft           ³Av Castelo Branco, 693 - Pioneiros           ³")
MsWriteLine( Handle, "ECHO ³ ÝÝ ÝÝÝÝ ÝÝ   Informatica      ³Fone (69)3451-3085                           ³")
MsWriteLine( Handle, "ECHO ³ ÝÝ  ÝÝ  ÝÝ      Ltda          ³76976-000/Pimenta Bueno - Rondonia           ³")
MsWriteLine( Handle, "ECHO ÔÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¾")
MsWriteLine( Handle, "ECHO ")
MsWriteLine( Handle, "ECHO ÕÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¸")
MsWriteLine( Handle, "ECHO ³ Insira o disco de backup no drive A: e tecle ENTER para iniciar             ³")
MsWriteLine( Handle, "ECHO ³                                                                             ³")
MsWriteLine( Handle, "ECHO ³ CUIDADO!! Os dados do drive A: serao todos apagados.                        ³")
MsWriteLine( Handle, "ECHO ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ")
MsWriteLine( Handle, "PAUSE >NUL")
MsWriteLine( Handle, "COMPRIME -EX -RP -SMSIL -&F A:\SCI *.DBF + *.CFG + *.DOC + *.TXT + *.BAT + *.ETI + *.NFF + *.COB + *.DUP")
FClose( Handle )
Alerta("Arquivo criado: " + xBatch + ";Finalize a execucao do sistema e digite SALVA [enter].")
Return

def Impressao()
***************
   LOCAL GetList := {}
   LOCAL cScreen := SaveScreen()
   LOCAL Files   := '*.DOC'
   LOCAL lCancel := FALSO
   LOCAL nTam	  := MaxCol()
   LOCAL Arquivo
   LOCAL nCopias
   LOCAL x
   LOCAL Campo
   LOCAL Linha
   LOCAL Linhas
   LOCAL Imprime

   Arquivo := Space( 24 )
   MaBox( 16, 10, 18, 61 )
   @ 17, 11 Say "Arquivo a Imprimir..:" Get Arquivo PICT "@!"
   Read
   IF LastKey() = ESC
      ResTela( cScreen )
      Return
   EndIF
   FChDir( oAmbiente:xBaseDoc )
   Set Defa To ( oAmbiente:xBaseDoc )
   IF Empty( Arquivo )
      M_Title( "Setas CIMA/BAIXO Move")
      Arquivo := Mx_PopFile( 03, 10, 15, 61, Files, Cor())
      IF Empty( Arquivo )
         FChDir( oAmbiente:xBaseDados )
         Set Defa To ( oAmbiente:xBaseDados )
         ErrorBeep()
         ResTela( cScreen )
         Return
     EndIF
   Else
      IF !File( Arquivo )
         FChDir( oAmbiente:xBaseDados )
         Set Defa To ( oAmbiente:xBaseDados )
         ErrorBeep()
         ResTela( cScreen )
         Alert( Rtrim( Arquivo ) + " Nao Encontrado... " )
         ResTela( cScreen )
         Return
      EndIF
   EndIF
   nCopias := 1
   MaBox( 19, 10, 21, 31 )
   @ 20, 11 SAY "Qtde Copias...:" Get nCopias PICT "999" Valid nCopias > 0
   Read
   IF LastKey() = 27 .OR. !Instru80()
      FChDir( oAmbiente:xBaseDados )
      Set Defa To ( oAmbiente:xBaseDados )
      ResTela( cScreen )
      Return
   EndIF
   Mensagem("Aguarde, Imprimindo")
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
   FChDir( oAmbiente:xBaseDados )
   Set Defa To ( oAmbiente:xBaseDados )
   ResTela( cScreen )
   Return
endef   

*==================================================================================================*		

def Seta( Mode, Line, Col )
	Do Case
	Case Mode = 0
		Return(0)
	Case LastKey() = -1	 && F2	GRAVA E SAI
		Return( 23 )
	OtherWise
		Return(0)
	EndCase
endef	


def empresa( cTela )
	LOCAL cScreen := SaveScreen()
	LOCAL GetList := {}
	LOCAL cCodi   := Space(4)
	LOCAL cBase   := oAmbiente:xBase
	LOCAL cBaseDados	
	LOCAL cScr
	LOCAL cCmd
	LOCAL cSpooler
	LOCAL cHtm
	LOCAL cDoc
	LOCAL cTxt	
	LOCAL nTela

	if right(TrimStr(oAmbiente:xBase),1) == "/"
		//oAmbiente:xBase := left(oAmbiente:xBase, len(oAmbiente:xBase)-1)
		oAmbiente:xBase := oAmbiente:xRoot
	endif		
	//cBase := oAmbiente:xBase
   oAmbiente:xBase := oAmbiente:xRoot
   cBase           := oAmbiente:xRoot
	oMenu:Limpa()
	Info(2)
	FechaTudo()	
	FChDir(cBase)
	Set Defa To (cBase)
	CriaBcoDadosEmpresa()
	
	while(true)
		nTela := MaBox( 02, 10, 06, MaxCol()-15, "SELECIONE EMPRESA" )
		@ 03, 11 Say "Site Dados.: " + cBase
		@ 04, 11 Say "Codigo.....:" Get cCodi Pict "9999" Valid EmpErrada( @cCodi,,Row()+1, 24 )
		@ 05, 11 Say "Empresa....:"
		Read
		IF LastKey() = ESC
			IF Conf("Pergunta: Encerrar a Execucao do Sistema ?")
				Encerra()
			EndIF
			Loop
		EndIF		
		
		if Conf('Pergunta: Selecao de Empresa Correta ?')					
			oIni:Close()				
			cScr		  := Mensagem("Informa: Aguarde...")
			
			if (oAmbiente:Letoativo)
				__SEP              := ""
				cBase              := ""
				oAmbiente:xBase    := cBase
				oAmbiente:LetoPath := cBase
			else
			   __SEP := DEF_SEP
				cBase := oAmbiente:xBase
			endif
			
			oIni 		  := TIniNew('sci' + oAmbiente:_EMPRESA + '.ini')
			cCmd		  := cBase + __SEP + 'cmd'
			cDoc		  := cBase + __SEP + 'doc'		
			cSpooler   := cBase + __SEP + 'spooler'
			cTmp       := cBase + __SEP + 'tmp'
			cTxt       := cBase + __SEP + 'txt'
			cHtm       := cBase + __SEP + 'htm'			
			cBaseDados := cBase + __SEP + 'emp' + cCodi

			oMenu:CodiFirma            := cCodi
			oMenu:NomeFirma       		:= AllTrim( Empresa->Nome )		
			oAmbiente:RelatorioCabec   := oIni:ReadString('sistema','relatoriocabec', XFANTA   + Space(40-Len(XFANTA)))
			oAmbiente:xFanta           := oIni:ReadString('sistema','fantasia',       XFANTA   + Space(40-Len(XFANTA)))
			oAmbiente:xEmpresa         := oIni:ReadString('sistema','nomeempresa',    XNOMEFIR + Space(40-Len(XNOMEFIR)))
			oAmbiente:xNomefir         := oIni:ReadString('sistema','nomeempresa',    XNOMEFIR + Space(40-Len(XNOMEFIR)))
			oAmbiente:xJuroMesSimples  := oIni:ReadInteger('financeiro','JuroMesSimples', 0)
			oAmbiente:xJuroMesComposto := oIni:ReadInteger('financeiro','JuroMesComposto', 0)
         oAmbiente:lManterPosicaoMenuVertical := oIni:ReadBool('sistema','manterposicaomenuvertical')         
			oAmbiente:aSciArray[1,SCI_JUROMESSIMPLES]  := Empresa->Juro
			oAmbiente:aSciArray[1,SCI_DIASAPOS]        := Empresa->DiasApos
			oAmbiente:aSciArray[1,SCI_DESCAPOS]        := Empresa->DescApos
			oAmbiente:aSciArray[1,SCI_MULTA]           := Empresa->Multa
			oAmbiente:aSciArray[1,SCI_DIAMULTA]        := Empresa->DiaMulta
			oAmbiente:aSciArray[1,SCI_CARENCIA]        := Empresa->Carencia
			oAmbiente:aSciArray[1,SCI_DESCONTO]        := Empresa->Desconto
			oAmbiente:aSciArray[1,SCI_JUROMESCOMPOSTO] := oAmbiente:xJuroMesComposto		
			aMensagem  := { Empresa->Mens1, Empresa->Mens2, Empresa->Mens3, Empresa->Mens4 }
			aItemNff   := { Empresa->ItemNff }
			aInscMun   := { Empresa->InscMun  }
			aIss		  := { Empresa->Iss	}
			FechaTudo()
			ms_makeDir(cBaseDados, cCmd, cDoc, cSpooler, cTxt, cHtm, cTmp)			

			if (oAmbiente:Letoativo)			
				cBaseDados         += '/'
				cDoc  				 += '/'
				cTxt  				 += '/'
				cTmp  				 += '/'
			endif	
			oAmbiente:LetoPath   := cBaseDados 
			oAmbiente:xBase      := cBaseDados
			oAmbiente:xBaseDoc   := cDoc
			oAmbiente:xBaseTxt   := cTxt
         oAmbiente:xBaseHtm   := cHtm
			oAmbiente:xBaseTmp   := cTmp
			oAmbiente:xBaseDados := cBaseDados			
			Set Defa To (cBaseDados)
			fchdir( cBaseDados )
			resTela( cScr )
			CriaArquivo()
			return nil
		EndIF
	Enddo
endef	

def ms_makeDir(cBaseDados, cCmd, cDoc, cSpooler, cTxt, cHtm, cTmp)
	if (oAmbiente:LetoAtivo)
		Leto_MakeDir( cBaseDados )
		Leto_MakeDir( cCmd )
		Leto_MakeDir( cDoc )
		Leto_MakeDir( cSpooler )
		Leto_MakeDir( cTxt )
		Leto_MakeDir( cHtm )				
		Leto_MakeDir( cTmp )						
	else
		MkDir( cBaseDados )
		MkDir( cCmd )
		MkDir( cDoc )
		MkDir( cSpooler )
		MkDir( cTxt )
		MkDir( cHtm )	
		MkDir( cTmp )	
	endif
	return nil
endef

def EmpErrada( cCodi, cNome, nRow, nCol )
*----------------------------------------*
	LOCAL aRotina := {{|| CadastraEmpresa() }}
	LOCAL Arq_Ant := Alias()
	LOCAL Ind_Ant := IndexOrd()
	LOCAL Var1
	LOCAL Var2

	Area("Empresa")
	IF !DbSeek( cCodi )
		Escolhe( 00, 00, MaxRow(), "Codi + ' ' + Nome", "CODI NOME DA EMPRESA", aRotina )
	EndIF
	cCodi := Empresa->Codi
	cNome := Empresa->Nome
	IF nRow != Nil
		Write( nRow  , nCol, Empresa->Nome )
	EndiF
	oAmbiente:_Empresa := cCodi
	oAmbiente:xEmpresa := Empresa->Nome
	oAmbiente:xNomefir := Empresa->Nome
	AreaAnt( Arq_Ant, Ind_Ant )
	return( OK )
endef

Function CadastraEmpresa()
**************************
LOCAL cScreen := SaveScreen()
LOCAL GetList := {}
LOCAL cCodi   := Space(4)
LOCAL cNome   := Space(40)
LOCAL Var1
LOCAL Var2

Area("Empresa")
WHILE OK
	oMenu:Limpa()
	MaBox( 10, 10, 13, 60 )
	Empresa->(DbGoBoTTom())
	cCodi   := StrZero( Val( Codi ) + 1, 4 )
	cNome   := Space(40)
	@ 11, 11 Say "Codigo :" Get cCodi Pict "9999" Valid EmpCerto( cCodi )
	@ 12, 11 Say "Empresa:" Get cNome Pict "@!"
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Exit
	EndIF
	IF Conf("Pergunta: Confirma Inclusao da Empresa ?")
		Area("Empresa")
		DbAppend()
		Empresa->Codi		 := cCodi
		Empresa->Nome		 := cNome
		Empresa->ItemNff	 := 99
	EndIF
EndDo

Function EmpCerto( cCodi )
**************************
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
LOCAL RetVal  := OK
IF Empty( cCodi )
	ErrorBeep()
   Alerta("ERRO: Codigo Invalido.")
	Return( FALSO )
EndIF
Area("Empresa")
IF DbSeek( cCodi )
	ErrorBeep()
   Alerta("ERRO: Codigo Ja Registrado." )
	RetVal := FALSO
EndIF
AreaAnt( Arq_Ant, Ind_Ant )
Return(RetVal)

def CriaBcoDadosEmpresa()
*------------------------*
	LOCAL cDbf    := 'empresa.dbf'
	LOCAL cNtx    := 'empresa.' + CEXT
	LOCAL cScreen := SaveScreen()	
	LOCAL aDbf	  := {{ "CODI",     "C", 04, 0 },;
					  { "NOME",     "C", 40, 0 },;
					  { "DESCONTO", "N", 06, 2 },;
					  { "DESCAPOS", "N", 06, 2 },;
					  { "MENS1",    "C", 40, 0 },;
					  { "MENS2",    "C", 40, 0 },;
					  { "MENS3",    "C", 40, 0 },;
					  { "MENS4",    "C", 40, 0 },;
					  { "JURO",     "N", 03, 0 },;
					  { "MULTA",    "N", 03, 0 },;
					  { "DIAMULTA", "N", 03, 0 },;
					  { "ITEMNFF",  "N", 03, 0 },; // Quantidade de Items na nff
					  { "INSCMUN",  "C", 15, 0 },; // Inscricao Municipal do Usuario
					  { "ISS",      "N", 05, 2 },; // Percentual do ISS
					  { "CARENCIA", "N", 03, 0 },;
					  { "DIASAPOS", "N", 03, 0 }}	

	if !ms_swap_File(cDbf)
		oMenu:Limpa()
		Mensagem("Aguarde... Gerando o Arquivo EMPRESA")
		ms_swap_DbCreate(cDbf, aDbf )
	else
		if NetUse(cDbf, MULTI )
			Integridade(cDbf, aDbf)
		else
			SetMode(oAmbiente:AlturaFonteDefaultWindows, oAmbiente:LarguraFonteDefaultWindows)
			Cls		
			Quit
		endif
	endif

#ifdef FOXPRO	
	if !ms_swap_File(cNtx)
		oMenu:Limpa()
		Mensagem(" Aguarde... Verificando Arquivos.")
		FechaTudo()
		//IF !NetUse(xDbf, FALSO )
		//	SetMode(oAmbiente:AlturaFonteDefaultWindows, oAmbiente:LarguraFonteDefaultWindows)
		//	Cls
		//	Quit
		//EndIF
		MaBox( 10, 10, 13, 42, "EMPRESA" )
		Write( 12, 11, "CODIGO ÄÄÄÄÄÄÄÛ" )
		oIndice:DbfNtx("empresa")
		oIndice:AddNtx("Codi","empresa", "empresa" )
		oIndice:CriaNtx()
	endif
	
	oMenu:Limpa()
	ErrorBeep()
	Mensagem("Aguarde... Verificando os Arquivos.")
	FechaTudo()
	Mensagem("Aguarde... Abrindo o Arquivo EMPRESA.")	
	if NetUse(cDbf, MULTI )
		DbSetIndex(cNtx)
	else
		SetMode(oAmbiente:AlturaFonteDefaultWindows, oAmbiente:LarguraFonteDefaultWindows)
		Cls
		Quit
	endif
	return(resTela( cScreen ))	
	
#else 
	cNtx := "empresa1." + CEXT
	if !ms_swap_File(cIndice)	
		oMenu:Limpa()
		Mensagem(" Aguarde... Verificando Arquivos.")
		Fechatudo()
		//IF !NetUse(xDbf, FALSO )
		//	SetMode(oAmbiente:AlturaFonteDefaultWindows, oAmbiente:LarguraFonteDefaultWindows)
		//	Cls
		//	Quit
		//EndIF
		oIndice:DbfNtx("empresa")
		oIndice:AddNtx("Codi", "EMPRESA1", "EMPRESA" )
		oIndice:CriaNtx()
	EndIF
	oMenu:Limpa()
	ErrorBeep()
	Mensagem("Aguarde... Verificando os Arquivos.")
	Fechatudo()
	Mensagem("Aguarde... Abrindo o Arquivo EMPRESA.")
	if NetUse(cDbf, MULTI )
		DbSetIndex(cNtx)
	else
		SetMode(oAmbiente:AlturaFonteDefaultWindows, oAmbiente:LarguraFonteDefaultWindows)
		Cls
		Quit
	endif
	return(restela(cScreen))
#endif
endef

def PrecosAltera()
	IF !UsaArquivo("PAGAR") ; Break ; EndIF
	IF !UsaArquivo("LISTA") ; Break ; EndIF
	ConLista()
	FechaTudo()
	Return nil
endef	

def PrecosConsulta()
	LOCAL cScreen := SaveScreen()

	IF !UsaArquivo("LISTA")    ; Break ; EndIF
	IF !UsaArquivo("ENTRADAS") ; Break ; EndIF
	IF !UsaArquivo("SAIDAS")   ; Break ; EndIF
	IF !UsaArquivo("PAGAR")    ; Break ; EndIF
	SetKey( F5, NIL )
	TabPreco()
	FechaTudo()
	SetKey( F5, {|| PrecosConsulta()})
	ResTela( cScreen )
	Return
endef	

*==================================================================================================*		

def Usuario()
	LOCAL cScreen   := SaveScreen()
	LOCAL cLogin    := Space(10)
	LOCAL cPassword := Space(10)

	Area("Usuario")
	Usuario->(Order( USUARIO_NOME ))
	oAmbiente:lGreenCard := FALSO
	oMenu:Limpa()
	WHILE OK
		cPassword := Space(10)
		MaBox( 10, 20, 13, 48 )
		@ 11, 21 Say "Usuario.:  " Get cLogin    Pict "@!" Valid UsuarioErrado( @cLogin )
		@ 12, 21 Say "Senha...:  " Get cPassWord Pict "@S" Valid SenhaErrada(cLogin, cPassWord)
		Read
		IF LastKey() = ESC
			IF Conf("Pergunta: Encerrar a Execucao do Sistema ?")
				Encerra()
			EndIF
			Loop
		EndIF
		return(ResTela( cScreen ))
	EndDo
endef

*==================================================================================================*		

def SenhaErrada(cLogin, cPassWord)
	LOCAL cSenha  := Usuario->( AllTrim( Senha ))
	LOCAL cSenha1 := MSEncrypt(StrTran(Dtoc(Date()),'/'))
	LOCAL Passe   := MSEncrypt(Alltrim(Upper(cPassword)))
	LOCAL xAdmin  := AllTrim( Passe )
	MEMVAR cLpt1
	MEMVAR cLpt2
	MEMVAR cLpt3
	MEMVAR cLpd1
	MEMVAR cLpd2
	MEMVAR cLpd3
	MEMVAR cLpd4
	MEMVAR cLpd5
	MEMVAR cLpd6
	MEMVAR cLpd7
	MEMVAR cLpd8
	MEMVAR cLpd9
   
	IF Alltrim( cLogin ) == "ADMIN" .AND. !Empty( Passe ) .AND. cSenha1 == xAdmin
		oAmbiente:lGreenCard := OK
		Passe                := cSenha
	EndIF
	IF !Empty( Passe) .AND. cSenha == Passe
		aPermissao := {}
		Aadd( aPermissao, IF( Usuario->(MSDecrypt( Nivel1)) = "S", OK, FALSO ))
		Aadd( aPermissao, IF( Usuario->(MSDecrypt( Nivel2)) = "S", OK, FALSO ))
		Aadd( aPermissao, IF( Usuario->(MSDecrypt( Nivel3)) = "S", OK, FALSO ))
		Aadd( aPermissao, IF( Usuario->(MSDecrypt( Nivel4)) = "S", OK, FALSO ))
		Aadd( aPermissao, IF( Usuario->(MSDecrypt( Nivel5)) = "S", OK, FALSO ))
		Aadd( aPermissao, IF( Usuario->(MSDecrypt( Nivel6)) = "S", OK, FALSO ))
		Aadd( aPermissao, IF( Usuario->(MSDecrypt( Nivel7)) = "S", OK, FALSO ))
		Aadd( aPermissao, IF( Usuario->(MSDecrypt( Nivel8)) = "S", OK, FALSO ))
		Aadd( aPermissao, IF( Usuario->(MSDecrypt( Nivel9)) = "S", OK, FALSO ))
		Aadd( aPermissao, IF( Usuario->(MSDecrypt( Nivel0)) = "S", OK, FALSO ))
		Aadd( aPermissao, IF( Usuario->(MSDecrypt( NivelA)) = "S", OK, FALSO ))
		Aadd( aPermissao, IF( Usuario->(MSDecrypt( NivelB)) = "S", OK, FALSO ))
		Aadd( aPermissao, IF( Usuario->(MSDecrypt( NivelC)) = "S", OK, FALSO ))
		Aadd( aPermissao, IF( Usuario->(MSDecrypt( NivelD)) = "S", OK, FALSO ))
		Aadd( aPermissao, IF( Usuario->(MSDecrypt( NivelE)) = "S", OK, FALSO ))
		Aadd( aPermissao, IF( Usuario->(MSDecrypt( NivelF)) = "S", OK, FALSO ))
		Aadd( aPermissao, IF( Usuario->(MSDecrypt( NivelG)) = "S", OK, FALSO ))
		Aadd( aPermissao, IF( Usuario->(MSDecrypt( NivelH)) = "S", OK, FALSO ))
		Aadd( aPermissao, IF( Usuario->(MSDecrypt( NivelI)) = "S", OK, FALSO ))
		Aadd( aPermissao, IF( Usuario->(MSDecrypt( NivelJ)) = "S", OK, FALSO ))
		Aadd( aPermissao, IF( Usuario->(MSDecrypt( NivelK)) = "S", OK, FALSO ))
		Aadd( aPermissao, IF( Usuario->(MSDecrypt( NivelL)) = "S", OK, FALSO ))
		Aadd( aPermissao, IF( Usuario->(MSDecrypt( NivelM)) = "S", OK, FALSO ))
		Aadd( aPermissao, IF( Usuario->(MSDecrypt( NivelN)) = "S", OK, FALSO ))
		Aadd( aPermissao, IF( Usuario->(MSDecrypt( NivelO)) = "S", OK, FALSO ))
		Aadd( aPermissao, IF( Usuario->(MSDecrypt( NivelP)) = "S", OK, FALSO ))
		Aadd( aPermissao, IF( Usuario->(MSDecrypt( NivelQ)) = "S", OK, FALSO ))
		Aadd( aPermissao, IF( Usuario->(MSDecrypt( NivelR)) = "S", OK, FALSO ))
		Aadd( aPermissao, IF( Usuario->(MSDecrypt( NivelS)) = "S", OK, FALSO ))

		cLpt1 := Usuario->Lpt1
		cLpt2 := Usuario->Lpt2
		cLpt3 := Usuario->Lpt3
		cLpd1 := Usuario->Lpd1
		cLpd2 := Usuario->Lpd2
		cLpd3 := Usuario->Lpd3
		cLpd4 := Usuario->Lpd4
		cLpd5 := Usuario->Lpd5
		cLpd6 := Usuario->Lpd6
		cLpd7 := Usuario->Lpd7
		cLpd8 := Usuario->Lpd8
		cLpd9 := Usuario->Lpd9
      
				
		if empty( cLpt1 ) .or. empty( cLpd1 )
			if Usuario->(TravaReg())
				Usuario->Lpt1 := "06"
				Usuario->Lpt2 := "06"
				Usuario->Lpt3 := "06"
            Usuario->Lpd1 := "06"
            Usuario->Lpd2 := "06"
            Usuario->Lpd3 := "06"
            Usuario->Lpd4 := "06"
            Usuario->Lpd5 := "06"
            Usuario->Lpd6 := "06"
            Usuario->Lpd7 := "06"
            Usuario->Lpd8 := "06"
            Usuario->Lpd9 := "06"            
				Usuario->(Libera())
			endif
			cLpt1 := "06"
			cLpt2 := "06"
			cLpt3 := "06"
			cLpd1 := "06"
			cLpd2 := "06"
			cLpd3 := "06"
			cLpd4 := "06"
			cLpd5 := "06"
			cLpd6 := "06"
			cLpd7 := "06"
			cLpd8 := "06"
			cLpd9 := "06"
		endif
		
		oAmbiente:xUsuario := AllTrim( cLogin )
      oPrinter:EscolheImpressoraUsuario(cLpt1,cLpt2,cLpt3,cLpd1,cLpd2,cLpd3,cLpd4,cLpd5,cLpd6,cLpd7,cLpd8,cLpd9)
		//oAmbiente:ConfAmbiente( oAmbiente:xBase )		
		SetaIni()
		return true
	EndIF
	cPassword := Space(10)
	ErrorBeep()
	Alert("ERRO: Senha nao confere.")
	return false
endef

*==================================================================================================*		
	
def UsuarioErrado( cNome )
	LOCAL aRotinaInclusao  := NIL
	LOCAL aRotinaAlteracao := {{||AltSenha() }}
	LOCAL cScreen	        := SaveScreen()
	LOCAL Arq_Ant          := Alias()
	LOCAL Ind_Ant          := IndexOrd()

	Area("Usuario")
	( Usuario->(Order( USUARIO_NOME )), Usuario->(DbGoTop()))
	IF Usuario->(Eof()) .OR. Usuario->(!DbSeek("ADMIN"))
		GravaSenhaAdmin(OK)
	Else
		IF Empty(Usuario->Senha) 
			GravaSenhaAdmin(FALSO)
		EndIF	
	EndIF

	IF Usuario->(!DbSeek( cNome ))
		Usuario->(Escolhe( 00, 00, MaxRow(), "Nome", "USUARIO", aRotinaInclusao, NIL, aRotinaAlteracao, NIL, NIL, NIL ))
		cNome := Usuario->Nome
	EndIF

	AreaAnt( Arq_Ant, Ind_Ant )
	return( OK )
endef
	
def GravaSenhaAdmin(lIncluirOuAlterar)
	LOCAL Arq_Ant := Alias()
	LOCAL Ind_Ant := IndexOrd()
	LOCAL lDone   := FALSO
	LOCAL cPasse
	LOCAL cSim

	Area("Usuario")
	(Usuario->(Order( USUARIO_NOME )), Usuario->(DbGoTop()))
	
	if lIncluirOuAlterar              // Incluir
		lDone := Usuario->(Incluiu())
	else
		lDone := Usuario->(TravaReg())		
	endif
	
	while lDone
		cPasse			 := MSEncrypt("280966")
		cSim				 := MSEncrypt("S")
		Usuario->Nome	 := "ADMIN"
		Usuario->Senha  := cPasse
		Usuario->Nivel1 := cSim
		Usuario->Nivel2 := cSim
		Usuario->Nivel3 := cSim
		Usuario->Nivel4 := cSim
		Usuario->Nivel5 := cSim
		Usuario->Nivel6 := cSim
		Usuario->Nivel7 := cSim
		Usuario->Nivel8 := cSim
		Usuario->Nivel9 := cSim
		Usuario->Nivel0 := cSim
		Usuario->NivelA := cSim
		Usuario->NivelB := cSim
		Usuario->NivelC := cSim
		Usuario->NivelD := cSim
		Usuario->NivelE := cSim
		Usuario->NivelF := cSim
		Usuario->NivelG := cSim
		Usuario->NivelH := cSim
		Usuario->NivelI := cSim
		Usuario->NivelJ := cSim
		Usuario->NivelK := cSim
		Usuario->NivelL := cSim
		Usuario->NivelM := cSim
		Usuario->NivelN := cSim
		Usuario->NivelO := cSim
		Usuario->NivelP := cSim
		Usuario->NivelQ := cSim
		Usuario->NivelR := cSim
		Usuario->NivelS := cSim
		lDone := FALSO
	EndDo	
	Usuario->(Libera())
	AreaAnt( Arq_Ant, Ind_Ant )
	return lDone
endef	

def UsuarioCerto( cNome )
	LOCAL Arq_Ant := Alias()
	LOCAL Ind_Ant := IndexOrd()

	Area("usuario")
	Usuario->(Order( USUARIO_NOME ))
	Usuario->(DbGoTop())
	IF Usuario->(Eof())
		GravaSenhaAdmin(OK)
	EndIF
	Return( OK )
endef
	
def AbreUsuario()
	Return( UsaArquivo("usuario") )
endef	

def Terminate()
	FechaTudo()
	ScrollDir()	
	FChDir( oAmbiente:xBase )
	
	if oAmbiente:LetoAtivo
	   leto_DisConnect()
	endif	
	oIni:Close()	
	//oSci:Close()

	F_Fim( SISTEM_NA1 + " " + SISTEM_VERSAO )
	SetMode(oAmbiente:AlturaFonteDefaultWindows, oAmbiente:LarguraFonteDefaultWindows)
	Cls
	DevPos( 24, 0 )
	return( __Quit())
endef

def Encerra()
	FechaTudo()
	ScrollDir()	
	FChDir( oAmbiente:xBase )
	SalvaMem()	
	
	if oAmbiente:LetoAtivo
	   leto_DisConnect()
	endif	
	oIni:Close()	
	//oSci:Close()

	F_Fim( SISTEM_NA1 + " " + SISTEM_VERSAO )
	SetMode(oAmbiente:AlturaFonteDefaultWindows, oAmbiente:LarguraFonteDefaultWindows)
	Cls
	DevPos( 24, 0 )
	return( __Quit())
endef
	
def VerificarUsuario( cNome )
	LOCAL Arq_Ant := Alias()
	LOCAL Ind_Ant := IndexOrd()

	Area("Usuario")
	Usuario->(Order( USUARIO_NOME ))
	IF Usuario->(DbSeek( cNome ))
		ErrorBeep()
		Alerta("Erro: Usuario Ja Registrado.")
		Return( FALSO )
	EndIF
	Return( OK )
endef
	
Proc IncluirUsuario( cNome, cSenha1, lOk )
******************************************
LOCAL cScreen := SaveScreen()
LOCAL GetList := {}
LOCAL cSenha2

oMenu:Limpa()
Area("Usuario")
Usuario->(Order( USUARIO_NOME ))
MaBox( 00, 10, 04, 50 )
@ 01, 11 Say "Nome Usuario........: " Get cNome   Pict "@!" Valid VerificarUsuario( cNome ) .AND. !Empty( cNome )
Read
IF LastKey() = ESC
	lOk := FALSO
	ResTela( cScreen )
	Return
EndIF
WHILE OK
	Write( 02, 11, "Nova Senha...........: " )
	Write( 03, 11, "Confirme a Senha.....: " )
	cSenha1 := Senha( 02, 34, 11 )
	cSenha2 := Senha( 03, 34, 11 )
	IF LastKey() = ESC
		ResTela( cScreen )
		Return
	EndIF
	IF Empty( cSenha1 )
		Loop
	EndIF
	IF cSenha1 == cSenha2
		lOk := OK
		ResTela( cScreen )
		Return
	EndIF
	ErrorBeep()
	IF Conf("Erro: Senha nao Confere. Novamente ?")
		Loop
	EndIF
	cNome   := Space(10)
	cSenha1 := ""
	lOk	  := FALSO
	ResTela( cScreen )
	Return
EndDo
ResTela( cScreen )
Return

Proc AltSenha()
***************
LOCAL cNome   := Space(10)
LOCAL lOk     := FALSO
LOCAL Passe   := ''
LOCAL oVenlan := TIniNew(oAmbiente:xUsuario + ".INI")
LOCAL lAdmin  := oVenlan:ReadBool('permissao','usuarioadmin', FALSO )
LOCAL lDireto := FALSO

lDireto := lAdmin
AlterarUsuario( @cNome, @Passe, @lOk, lAdmin, lDireto )
IF !lOK
	Return
Else
  ErrorBeep()
  IF Conf( "Pergunta: Alterar Senha ?")
	  Passe := MSEncrypt( AllTrim( Passe ))
	  IF Usuario->(TravaReg())
		  Usuario->Nome  := cNome
		  Usuario->Senha := Passe
		  Usuario->(Libera())
		  Alerta("Informa: Senha Alterada com sucesso.")
	  EndIF
  EndIF
  Return
EndIF

Proc AlterarUsuario( cNome, cSenha1, lOk, lAdmin, lDireto )
***********************************************************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen()
LOCAL cSenha
LOCAL cSenha2

oMenu:Limpa()
Area("Usuario")
IfNil( lAdmin, FALSO )
IfNil( lDireto, FALSO )
Usuario->(Order( USUARIO_NOME ))
MaBox( 00, 10, 04, 50 )
@ 01, 11 Say "Nome Usuario........: " Get cNome   Pict "@!" Valid UsuarioErrado( @cNome )
Read
IF LastKey() = ESC
	lOk := FALSO
	ResTela( cScreen )
	Return
EndIF
cNome := Alltrim(cNome)
IF !lDireto
   cSenha := Usuario->( AllTrim( Senha ))
   IF lAdmin
      cSenha1 := MSDecrypt( AllTrim( cSenha ))
      lOk     := OK
      ResTela( cScreen )
      Return
   EndIF
EndIF
WHILE OK
   IF !lDireto
      Write( 02, 11, "Verificacao de Senha.: " )
      cSenha1 := Senha( 02, 34, 11 )
      IF LastKey() = ESC
         ResTela( cScreen )
         Return
      EndIF
   EndIF
   IF cSenha == MSEncrypt( AllTrim( cSenha1 )) .OR. lDireto
		WHILE OK
			Write( 02, 11, "Nova Senha...........: " )
			Write( 03, 11, "Confirme a Senha.....: " )
			cSenha1 := Senha( 02, 34, 11 )
			cSenha2 := Senha( 03, 34, 11 )
			IF LastKey() = ESC
				ResTela( cScreen )
				Return
			EndIF
			IF Empty( cSenha1 )
				Loop
			EndIF
			IF cSenha1 == cSenha2
				lOk := OK
				ResTela( cScreen )
				Return
			EndIF
			ErrorBeep()
			IF Conf("Erro: Senha nao Confere. Novamente ?")
				Loop
			EndIF
			cNome   := Space(10)
			cSenha1 := ""
			lOk	  := FALSO
			ResTela( cScreen )
			Return
		EndDo
	EndIF
	ErrorBeep()
	IF Conf("Erro: Senha nao Confere. Novamente ?")
		Loop
	EndIF
	cNome   := Space(10)
	cSenha1 := ""
	lOk	  := FALSO
	ResTela( cScreen )
	Return
EndDo
Return
ResTela( cScreen )

Proc CadastraUsuario( cCodi )
*****************************
LOCAL GetList	  := {}
LOCAL oVenlan	  := TIniNew(oAmbiente:xUsuario + ".INI")
LOCAL lAdmin	  := oVenlan:ReadBool('permissao','usuarioadmin', FALSO )
LOCAL cScreen	  := SaveScreen()
LOCAL aMenu 	  := {" Incluir Usuario",;
							" Alterar Usuario",;
							" Excluir Usuario",;
							" Alterar Senha",;
							" Impressoras Fiscais",;
							" Opcoes de Faturamento",;
							" Controle de Vendedores ",;
							" Controle de Ponto",;
							" Contas a Receber",;
							" Contas a Pagar",;
							" Contas Correntes",;
							" Controle de Producao",;
							" Controle de Estoque",;
							" Menu Principal"}
LOCAL cSenha
LOCAL Arq_Ant	  := Alias()
LOCAL Ind_Ant	  := IndexOrd()
LOCAL lParametro := FALSO
LOCAL lRegistro  := FALSO
LOCAL cEs		  := "S"
LOCAL cRe		  := "S"
LOCA	cPa		  := "S"
LOCAL cCo		  := "S"
LOCAL cVe		  := "S"
LOCAL cVn		  := "S"
LOCAL cUs		  := "S"
LOCAL cPr		  := "S"
LOCAL cInc		  := "S"
LOCAL cDel		  := "S"
LOCAL cDev		  := "S"
LOCAL cEnt		  := "S"
LOCAL cPag		  := "S"
LOCAL cRec		  := "S"
LOCAL cAlt		  := "S"
LOCAL cEmp		  := "S"
LOCAL cTro		  := "S"
LOCAL cFaz		  := "S"
LOCAL cRes		  := "S"
LOCAL cCom		  := "S"
LOCAL cZero 	  := "S"
LOCAL cVista	  := "N"
LOCAL cCadas	  := "S"
LOCAL cLimite	  := "S"
LOCAL cEstorado  := "S"
LOCAL cDescMax   := "S"
LOCAL cFat		  := "S"
LOCAL cDtRec	  := "S"
LOCAL cAtra 	  := "S"
LOCAL nChoice	  := 1
LOCAL cLpt1 	  := "06"
LOCAL cLpt2 	  := "06"
LOCAL cLpt3 	  := "06"

LOCAL cNome 	  := Space(10)
LOCAL Passe
LOCAL lOk

WHILE OK
	lOk := FALSO
	oMenu:Limpa()
	M_Title("INCLUSAO/ALTERACAO DE USUARIO")
	nChoice := FazMenu( 02, 10, aMenu, Cor())
	Do Case
	Case nChoice = 0
		Return

	Case nChoice = 1
		IncluirUsuario( @cNome, @Passe, @lOk )
		IF !lOK
			Return
		EndIF

	Case nChoice = 2
		AlterarUsuario( @cNome, @Passe, @lOk, lAdmin )
		IF !lOK
			Return
		EndIF
		cEs		 := MSDecrypt( Nivel1 )
		cRe		 := MSDecrypt( Nivel2 )
		cPa		 := MSDecrypt( Nivel3 )
		cCo		 := MSDecrypt( Nivel4 )
		cVe		 := MSDecrypt( Nivel5 )
		cVn		 := MSDecrypt( Nivel6 )
		cUs		 := MSDecrypt( Nivel7 )
		cPr		 := MSDecrypt( Nivel8 )
		cInc		 := MSDecrypt( Nivel9 )
		cAlt		 := MSDecrypt( Nivel0 )
		cDel		 := MSDecrypt( NivelA )
		cDev		 := MSDecrypt( NivelB )
		cPag		 := MSDecrypt( NivelC )
		cRec		 := MSDecrypt( NivelD )
		cEmp		 := MSDecrypt( NivelE )
		cTro		 := MSDecrypt( NivelF )
		cFaz		 := MSDecrypt( NivelG )
		cRes		 := MSDecrypt( NivelH )
		cCom		 := MSDecrypt( NivelI )
		cZero 	 := MSDecrypt( NivelJ )
		cEstorado := MSDecrypt( NivelK )
		cVista	 := MSDecrypt( NivelL )
		cCadas	 := MSDecrypt( NivelM )
		cLimite	 := MSDecrypt( NivelN )
		cDescMax  := MSDecrypt( NivelO )
		cEnt		 := MSDecrypt( NivelP )
		cFat		 := MSDecrypt( NivelQ )
		cDtRec	 := MSDecrypt( NivelR )
		cAtra 	 := MSDecrypt( NivelS )
		cLpt1 	 := Usuario->Lpt1
		cLpt2 	 := Usuario->Lpt2
		cLpt3 	 := Usuario->Lpt2

	Case nChoice = 3
		Area("USUARIO")
      Escolhe( 00, 00, MaxRow(), "Nome", "USUARIO", {{|| IncluirUsuario( @cNome, @Passe, @lOk)}}, {{|| AlterarUsuario( @cNome, @Passe, @lOk)}})
		Return

	Case nChoice = 4
		AltSenha()
		Loop

	Case nChoice = 5 // Impressoras Fiscais
      AlterarUsuario( @cNome, @Passe, @lOk, lAdmin )
		IF lOK
			ConfFiscal( cNome )
		EndIF
		Loop

	Case nChoice = 6 // Opcoes de Faturamento
      AlterarUsuario( @cNome, @Passe, @lOk, lAdmin )
		IF lOK
			ConfOpcoesFaturamento( cNome )
		EndIF
		Loop

	Case nChoice = 7
      AlterarUsuario( @cNome, @Passe, @lOk, lAdmin )
		IF lOK
			ConfIniVendedores( cNome )
		EndIF
		Loop

	Case nChoice = 8
      AlterarUsuario( @cNome, @Passe, @lOk, lAdmin )
		IF lOK
			ConfIniPonto( cNome )
		EndIF
		Loop

	Case nChoice = 9 // Contas a Receber
      AlterarUsuario( @cNome, @Passe, @lOk, lAdmin )
		IF lOK
			ConfIniReceber( cNome )
		EndIF
		Loop
	Case nChoice = 10 // Contas a Pagar
      AlterarUsuario( @cNome, @Passe, @lOk, lAdmin )
		IF lOK
			ConfIniPagar( cNome )
		EndIF
		Loop
	Case nChoice = 11 // Contas Correntes
      AlterarUsuario( @cNome, @Passe, @lOk, lAdmin )
		IF lOK
			ConfIniCorrentes( cNome )
		EndIF
		Loop
	Case nChoice = 12 // Controle de Producao
      AlterarUsuario( @cNome, @Passe, @lOk, lAdmin )
		IF lOK
			ConfIniProducao( cNome )
		EndIF
		Loop
	Case nChoice = 13 // Controle de Estoque
      AlterarUsuario( @cNome, @Passe, @lOk, lAdmin )
		IF lOK
			ConfIniEstoque( cNome )
		EndIF
		Loop
	Case nChoice = 14 // Menu Principal
      AlterarUsuario( @cNome, @Passe, @lOk, lAdmin )
		IF lOK
			ConfIniSci( cNome )
		EndIF
		Loop
	EndCase
	oMenu:Limpa()
	Area("Usuario")
	Usuario->(Order( USUARIO_NOME ))
	IF CadPermissao( cNome, @cEs, @cRe, @cPa, @cCo, @cVe, @cVn, @cUs, @cPr, @cInc, @cDel, @cDev, @cPag, @cRec, @cAlt, @cEmp, @cTro, @cFaz, @cRes, @cCom, @cZero, @cVista, @cCadas, @cLimite, @cEstorado, @cLpt1, @cLpt2, @cLpt3, @cDescMax, @cEnt, @cFat, @cDtRec, @cAtra )
		ErrorBeep()
		IF Conf( "Pergunta: Incluir/Alterar Usuario ?")
			Passe := MSEncrypt( AllTrim( Passe ))
			IF nChoice = 1
				IF Usuario->(Incluiu())
					Usuario->Nome	:= cNome
					Usuario->Senha := Passe
				EndIF
			Else
				IF Usuario->(TravaReg())
					Usuario->Nome	:= cNome
					Usuario->Senha := Passe
				EndIF
			EndIF
			Usuario->Nivel1 := MSEncrypt( cEs )		 //	1
			Usuario->Nivel2 := MSEncrypt( cRe )		 //	2
			Usuario->Nivel3 := MSEncrypt( cPa )		 //	3
			Usuario->Nivel4 := MSEncrypt( cCo )		 //	4
			Usuario->Nivel5 := MSEncrypt( cVe )		 //	5
			Usuario->Nivel6 := MSEncrypt( cVn )		 //	6
			Usuario->Nivel7 := MSEncrypt( cUs )		 //	7
			Usuario->Nivel8 := MSEncrypt( cPr )		 //	8
			Usuario->Nivel9 := MSEncrypt( cInc )		 //	9
			Usuario->Nivel0 := MSEncrypt( cAlt )		 //  10
			Usuario->NivelA := MSEncrypt( cDel )		 //  11
			Usuario->NivelB := MSEncrypt( cDev )		 //  12
			Usuario->NivelC := MSEncrypt( cPag )		 //  13
			Usuario->NivelD := MSEncrypt( cRec )		 //  14
			Usuario->NivelE := MSEncrypt( cEmp )		 //  15
			Usuario->NivelF := MSEncrypt( cTro )		 //  16
			Usuario->NivelG := MSEncrypt( cFaz )		 //  17
			Usuario->NivelH := MSEncrypt( cRes )		 //  18
			Usuario->NivelI := MSEncrypt( cCom )		 //  19
			Usuario->NivelJ := MSEncrypt( cZero ) 	 //  20
			Usuario->NivelK := MSEncrypt( cEstorado ) //  21
			Usuario->NivelL := MSEncrypt( cVista )	 //  22
			Usuario->NivelM := MSEncrypt( cCadas )	 //  23
			Usuario->NivelN := MSEncrypt( cLimite )	 //  24
			Usuario->NivelO := MSEncrypt( cDescMax )  //  25
			Usuario->NivelP := MSEncrypt( cEnt 	 )  //  26
			Usuario->NivelQ := MSEncrypt( cFat 	 )  //  27
			Usuario->NivelR := MSEncrypt( cDtRec	 )  //  28
			Usuario->NivelS := MSEncrypt( cAtra	 )  //  29
			Usuario->Lpt1	 := cLpt1
			Usuario->Lpt2	 := cLpt2
			Usuario->Lpt3	 := cLpt3
			Usuario->(Libera())

			aPermissao := {}
			Aadd( aPermissao, IF( cEs	     = "S", OK, FALSO ))  //   1
			Aadd( aPermissao, IF( cRe	     = "S", OK, FALSO ))  //   2
			Aadd( aPermissao, IF( cPa	     = "S", OK, FALSO ))  //   3
			Aadd( aPermissao, IF( cCo	     = "S", OK, FALSO ))  //   4
			Aadd( aPermissao, IF( cVe       = "S", OK, FALSO ))  //   5
			Aadd( aPermissao, IF( cVn	     = "S", OK, FALSO ))  //   6
			Aadd( aPermissao, IF( cUs	     = "S", OK, FALSO ))  //   7
			Aadd( aPermissao, IF( cPr	     = "S", OK, FALSO ))  //   8
			Aadd( aPermissao, IF( cInc      = "S", OK, FALSO ))  //   9
			Aadd( aPermissao, IF( cAlt      = "S", OK, FALSO ))  //  10
			Aadd( aPermissao, IF( cDel      = "S", OK, FALSO ))  //  11
			Aadd( aPermissao, IF( cDev      = "S", OK, FALSO ))  //  12
			Aadd( aPermissao, IF( cPag      = "S", OK, FALSO ))  //  13
			Aadd( aPermissao, IF( cRec      = "S", OK, FALSO ))  //  14
			Aadd( aPermissao, IF( cEmp      = "S", OK, FALSO ))  //  15
			Aadd( aPermissao, IF( cTro      = "S", OK, FALSO ))  //  16
			Aadd( aPermissao, IF( cFaz      = "S", OK, FALSO ))  //  17
			Aadd( aPermissao, IF( cRes      = "S", OK, FALSO ))  //  18
			Aadd( aPermissao, IF( cCom      = "S", OK, FALSO ))  //  19
			Aadd( aPermissao, IF( cZero     = "S", OK, FALSO ))  //  20
			Aadd( aPermissao, IF( cEstorado = "S", OK, FALSO ))  //  21
			Aadd( aPermissao, IF( cVista    = "S", OK, FALSO ))  //  22
			Aadd( aPermissao, IF( cCadas    = "S", OK, FALSO ))  //  23
			Aadd( aPermissao, IF( cLimite   = "S", OK, FALSO ))  //  24
			Aadd( aPermissao, IF( cDescMax  = "S", OK, FALSO ))  //  25
			Aadd( aPermissao, IF( cEnt 	  = "S", OK, FALSO ))  //  26
			Aadd( aPermissao, IF( cFat 	  = "S", OK, FALSO ))  //  27
			Aadd( aPermissao, IF( cDtRec	  = "S", OK, FALSO ))  //  28
			Aadd( aPermissao, IF( cAtra	  = "S", OK, FALSO ))  //  29
		EndIF
	EndIF
	ResTela( cScreen )
	AreaAnt( Arq_Ant, Ind_Ant )
	Exit
EndDo

Function CadPermissao( cNome, cEs, cRe, cPa, cCo, cVe, cVn, cUs, cPr, cInc, cDel, cDev, cPag, cRec, cAlt, cEmp, cTro, cFaz, cRes, cCom, cZero, cVista, cCadas, cLimite, cEstorado, cLpt1, cLpt2, cLpt3, cDescMax, cEnt, cFat, cDtRec, cAtra )
*********************************************************************************************************************************************************************************************************************************************
LOCAL nChoice       := 1
LOCAL cScreen       := SaveScreen ()
LOCAL GetList       := {}
LOCAL oVenlan       := TIniNew( cNome + ".INI")
LOCAL cCtrlP        := IF( oVenlan:ReadBool('permissao','usarteclactrlp', OK ), "S", "N")
LOCAL cCaix         := IF( oVenlan:ReadBool('permissao','visualizardetalhecaixa', OK ), "S", "N")
LOCAL cAdmin        := IF( oVenlan:ReadBool('permissao','usuarioadmin', FALSO ), "S", "N")
LOCAL cDebAtr       := IF( oVenlan:ReadBool('permissao','vendercomdebito', FALSO ), "S", "N")
LOCAL cRolCob       := IF( oVenlan:ReadBool('permissao','imprimirrolcobranca', FALSO ), "S", "N")
LOCAL cAutoVenda    := IF( oVenlan:ReadBool('permissao','autovenda', FALSO), "S", "N")
LOCAL cReciboZerado := IF( oVenlan:ReadBool('permissao','recibozerado', FALSO), "S", "N")

LOCAL nCol1
LOCAL nCol2
LOCAL nOpcao

WHILE OK
	nCol1 := 02
	nCol2 := 40
	MaBox( 02, 01, 11, 38, "ESCOLHA O ACESSO DE " + AllTrim( cNome ))
	@ 03, 	  nCol1 Say "CONTROLE DE ESTOQUE...:" Get cEs  Pict "@!" Valid PickSimNao( @cEs )
	@ Row()+1, nCol1 Say "CONTAS A RECEBER......:" Get cRe  Pict "@!" Valid PickSimNao( @cRe )
	@ Row()+1, nCol1 Say "CONTAS A PAGAR........:" Get cPa  Pict "@!" Valid PickSimNao( @cPa )
	@ Row()+1, nCol1 Say "CONTAS CORRENTES......:" Get cCo  Pict "@!" Valid PickSimNao( @cCo )
	@ Row()+1, nCol1 Say "CONTROLE DE PRODUCAO..:" Get cPr  Pict "@!" Valid PickSimNao( @cPr )
	@ Row()+1, nCol1 Say "VENDEDORES............:" Get cVe  Pict "@!" Valid PickSimNao( @cVe )
	@ Row()+1, nCol1 Say "VENDAS NO VAREJO......:" Get cVn  Pict "@!" Valid PickSimNao( @cVn )
	@ Row()+1, nCol1 Say "MANUTENCAO DE USUARIO.:" Get cUs  Pict "@!" Valid PickSimNao( @cUs )


	MaBox( 12, 01, 23, 38, "CONFIGURACAO GERAL DO SISTEMA" )
   @ 13,      nCol1 Say "BAIXAR TITULO QDO VENDA A VISTA.:" Get cVista     Pict "@!" Valid PickSimNao( @cVista )
   @ Row()+1, nCol1 Say "VERIFICAR LIMITE DE CREDITO.....:" Get cLimite    Pict "@!" Valid PickSimNao( @cLimite )
   @ Row()+1, nCol1 Say "VERIFICAR DEBITO EM ATRASO......:" Get cAtra      Pict "@!" Valid PickSimNao( @cAtra )
   @ Row()+1, nCol1 Say "VENDER COM DEBITO EM ATRASO.....:" Get cDebAtr    Pict "@!" Valid PickSimNao( @cDebAtr )
   @ Row()+1, nCol1 Say "VENDER COM LIMITE ESTOURADO.....:" Get cEstorado  Pict "@!" Valid PickSimNao( @cEstorado )
   @ Row()+1, nCol1 Say "IMPRESSORA EM LPT1..............:" Get cLpt1      Pict "99" Valid PrinterErrada( @cLpt1 )
   @ Row()+1, nCol1 Say "IMPRESSORA EM LPT2..............:" Get cLpt2      Pict "99" Valid PrinterErrada( @cLpt2 )
   @ Row()+1, nCol1 Say "IMPRESSORA EM LPT3..............:" Get cLpt3      Pict "99" Valid PrinterErrada( @cLpt3 )
   @ Row()+1, nCol1 Say "AUTOMATIZAR VENDA...............:" Get cAutoVenda Pict "!"  Valid PickSimNao( @cAutoVenda )

   MaBox( 02, 39, 24, MaxCol()-1, "ESCOLHA A PERMISSAO DE " + AllTrim( cNome ))
	@ 03, 	  nCol2 Say "PODE INCLUIR REGISTROS........:" Get cInc      Pict "@!" Valid PickSimNao( @cInc )
	@ Row()+1, nCol2 Say "PODE ALTERAR REGISTROS........:" Get cAlt      Pict "@!" Valid PickSimNao( @cAlt )
	@ Row()+1, nCol2 Say "PODE EXCLUIR REGISTROS........:" Get cDel      Pict "@!" Valid PickSimNao( @cDel )
	@ Row()+1, nCol2 Say "PODE DEVOLVER FATURA SAIDAS...:" Get cDev      Pict "@!" Valid PickSimNao( @cDev )
	@ Row()+1, nCol2 Say "PODE DEVOLVER FATURA ENTRADAS.:" Get cEnt      Pict "@!" Valid PickSimNao( @cEnt )
	@ Row()+1, nCol2 Say "PODE FAZER PAGAMENTOS.........:" Get cPag      Pict "@!" Valid PickSimNao( @cPag )
	@ Row()+1, nCol2 Say "PODE FAZER RECEBIMENTOS.......:" Get cRec      Pict "@!" Valid PickSimNao( @cRec )
	@ Row()+1, nCol2 Say "PODE INCLUIR EMPRESAS.........:" Get cEmp      Pict "@!" Valid PickSimNao( @cEmp )
	@ Row()+1, nCol2 Say "PODE TROCAR DE EMPRESA........:" Get cTro      Pict "@!" Valid PickSimNao( @cTro )
	@ Row()+1, nCol2 Say "PODE FAZER COPIA SEGURANCA....:" Get cFaz      Pict "@!" Valid PickSimNao( @cFaz )
	@ Row()+1, nCol2 Say "PODE RESTAURAR COPIA SEGURANCA:" Get cRes      Pict "@!" Valid PickSimNao( @cRes )
	@ Row()+1, nCol2 Say "PODE ALTERAR COMISSAO VENDA...:" Get cCom      Pict "@!" Valid PickSimNao( @cCom )
	@ Row()+1, nCol2 Say "FATURAR COM ESTOQUE NEGATIVO..:" Get cZero     Pict "@!" Valid PickSimNao( @cZero )
	@ Row()+1, nCol2 Say "PODE EXCEDER DESC MAXIMO......:" Get cDescMax  Pict "@!" Valid PickSimNao( @cDescMax )
	@ Row()+1, nCol2 Say "PODE ALTERAR EMISSAO DA FATURA:" Get cFat      Pict "@!" Valid PickSimNao( @cFat )
	@ Row()+1, nCol2 Say "PODE ALTERAR DATA RECEBIMENTO.:" Get cDtRec    Pict "@!" Valid PickSimNao( @cDtRec )
	@ Row()+1, nCol2 Say "PODE USAR TECLA CLTR+P........:" Get cCtrlP    Pict "@!" Valid PickSimNao( @cCtrlP )
	@ Row()+1, nCol2 Say "PODE VISUALIZAR CAIXA.........:" Get cCaix     Pict "@!" Valid PickSimNao( @cCaix  )
	@ Row()+1, nCol2 Say "PODE IMPRIMIR ROL COBRANCA....:" Get cRolCob   Pict "@!" Valid PickSimNao( @cRolCob )
   @ Row()+1, nCol2 Say "PODE IMPRIMIR RECIBO ZERADO...:" Get cReciboZerado Pict "@!" Valid PickSimNao( @cReciboZerado )
	@ Row()+1, nCol2 Say "USUARIO ADMINISTRADOR.........:" Get cAdmin    Pict "@!" Valid PickSimNao( @cAdmin )
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Return( FALSO )
	EndIF
	ErrorBeep()
	nOpcao := Alerta(" Pergunta: Voce Deseja ? ", {" Continuar ", " Alterar ", " Sair " })
	IF nOpcao = 1
		oVenlan:WriteBool('permissao', 'usarteclactrlp',         IF( cCtrlP  = "S", OK, FALSO ))
		oVenlan:WriteBool('permissao', 'visualizardetalhecaixa', IF( cCaix   = "S", OK, FALSO ))
		oVenlan:WriteBool('permissao', 'usuarioadmin',           IF( cAdmin  = "S", OK, FALSO ))
		oVenlan:WriteBool('permissao', 'vendercomdebito',        IF( cDebAtr = "S", OK, FALSO ))
		oVenlan:WriteBool('permissao', 'imprimirrolcobranca',    IF( cRolCob = "S", OK, FALSO ))
      oVenlan:WriteBool('permissao', 'autovenda',              IF( cAutoVenda = "S", OK, FALSO ))
      oVenlan:WriteBool('permissao', 'recibozerado',           IF( cReciboZerado = "S", OK, FALSO ))
      oVenlan:WriteBool('permissao', 'PodeExcluirRegistros',   IF( cDel          = "S", OK, FALSO ))
		Return( OK )
	ElseIF nOpcao = 2
		Loop
	ElseIf nOpcao = 3
		Return( FALSO )
	EndIF
END

Function Permissao( cVariavel )
*******************************
LOCAL cScreen := SaveScreen()
LOCAL aMenu   := { " Com Permissao de Acesso ", " Sem Permissao de Acesso " }
LOCAL aSimNao := { "SIM", "NAO" }
LOCAL nChoice := 1

MaBox( 10, 49, 13, 79 )
nChoice	 := Achoice( 11, 50, 16, 78, aMenu )
IF nChoice = 0
	nChoice = 2
EndIF
cVariavel := aSimNao[ nChoice ]
Keyb Chr( ENTER )
ResTela( cScreen )
Return OK

Proc MostraPermissao()
**********************
LOCAL lNenhum := OK
LOCAL cSTring := ""
LOCAL aMostra := { "Modulo de {Estoque}      ",;
						 ";Modulo de {Receber}      ",;
						 ";Modulo de {Pagar}        ",;
						 ";Modulo de {C. Correntes} ",;
						 ";Modulo de {Vendedores}   " ,;
						 ";Modulo de {Vendas}       ",;
						 ";Modulo de {Usuario}      ",;
						 ";Modulo de {Producao}     " }
For nX := 1 To 8
	IF aPermissao[nX]
		cString += aMostra[nX]
		lNenhum := FALSO
	EndIF
Next
ErrorBeep()
IF lNenhum
	cString := "Nenhum Modulo {...}"
EndIF
Alert("Erro: Usuario Com Acesso Restrito ao:;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ;" + cString )
Return( NIL )

Proc Carta( lFecharTudo )
*************************
LOCAL GetList		:= {}
LOCAL cScreen		:= SaveScreen()
LOCAL Files 	  := '*.DOC'
LOCAL lNovoCodigo := OK
LOCAL cUltCodigo	:= ""
LOCAL aMenu 		:= {"Individual", "Por Cidade", "Por Estado", "Por Regiao", "Por Aniversario", "Parcial", "Geral" }
LOCAL aTipo 		:= {"Normal", "Ultima Compra"}
LOCAL oBloco
LOCAL Campo
LOCAL Linha
LOCAL Linhas
LOCAL Imprime
LOCAL cDebitos 	:= "N"
LOCAL nTipo 		:= 0
LOCAL nDias 		:= 0
LOCAL nChoice		:= 0
LOCAL nFormulario := 66

lFechartudo := IF( lFecharTudo = NIL, OK, FALSO )
WHILE OK
	M_Title("IMPRESSAO DE MALA DIRETA")
	nChoice := FazMenu( 03, 02, aMenu, Cor())
	IF nChoice = 0
		ResTela( cScreen )
		Return
	EndIF
	M_Title("TIPO DE MALA DIRETA")
	nTipo := FazMenu( 04, 03, aTipo, Cor())
	IF nTipo = 0
		ResTela( cScreen )
		Return
	EndIF
	Arq := "CARTA.DOC" + Space(03)
	MaBox( 03 , 39 , 06 , 79 )
	@ 04, 40 Say  "Tamanho Formulario..:" Get nFormulario Pict "99" Valid PickTam({"33 Colunas", "66 Colunas"}, {33,66}, @nFormulario )
	@ 05, 40 Say  "Arquivo a imprimir..:" Get Arq Pict "@!"
	Read
	IF LastKey( ) = ESC
		IF lFecharTudo
			FechaTudo()
		EndIf
		ResTela( cScreen )
		Loop
	EndIF
	FChdir( oAmbiente:xBaseDoc )
	Set Defa To ( oAmbiente:xBaseDoc )
	IF !File( Arq ) .OR. Empty( Arq )
		M_Title( "Setas CIMA/BAIXO Move")
		Arq := Mx_PopFile( 07, 39, 22, 79, Files, Cor())
		IF Empty( Arq )
			FChdir( oAmbiente:xBaseDados )
			Set Defa To ( oAmbiente:xBaseDados )
			ErrorBeep()
			ResTela( cScreen )
			Return
		EndIF
	EndIF
	FChdir( oAmbiente:xBaseDados )
	Set Defa To ( oAmbiente:xBaseDados )
	IF !Selecao( nChoice, @oBloco )
		IF lFecharTudo
			FechaTudo()
		EndIF
		ResTela( cScreen )
		Loop
	EndiF
	IF nTipo = 2
		oMenu:Limpa()
		MaBox( 10, 10, 13, 45 )
		@ 11, 11 Say "Dias da Ultima Compra........:" Get nDias    Pict "999"
		@ 12, 11 Say "Imprimir Carta se tem debitos:" Get cDebitos Pict "!" Valid cDebitos $ "SN"
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Loop
		EndIF
	EndIF
	IF !InsTru80() .OR. !LptOk()
		IF lFecharTudo
			FechaTudo()
		EndIF
		ResTela( cScreen )
		Loop
	EndIF
	oMenu:Limpa()
	cTela 		:= Mensagem("Informa: Aguarde... Imprimindo Mala Direta.")
	cUltCodigo	:= Codi
	lNovoCodigo := OK
	PrintOn()
	Fprint( Chr(ESC) + "C" + Chr( nFormulario ))
	SetPrc( 0 , 0 )
	Recemov->(Order( RECEMOV_CODI ))
	WHILE Eval( oBloco ) .AND. REL_OK( )
		IF nTipo = 2
			IF ( Date() - UltCompra ) >= nDias
				IF cDebitos = "N"
					IF Recemov->(DbSeek( cUltCodigo ))
						cUltCodi := Codi
						DbSkip(1)
						Loop
					EndIF
				EndIF
			Else
				cUltCodi := Codi
				DbSkip(1)
				Loop
			EndIF
		EndIF
		IF lNovoCodigo
			lNovoCodigo := FALSO
			Write( 02 , 0, DataExt( Date()))
			Write( 06 , 0, "A" )
			Write( 07 , 0, NG + Codi + ' ' + Nome + NR )
			Write( 08 , 0, Ende )
			Write( 09 , 0, LIGSUB + Cep + "/" + Rtrim( Cida )  + "/" + Esta + DESSUB )
			FChdir( oAmbiente:xBaseDoc )
			Set Defa To ( oAmbiente:xBaseDoc )
			Campo  := MemoRead( Arq )
			Linhas := MlCount( Campo , 80 )
			FOR Linha  :=	1 TO Linhas
				Imprime :=	MemoLine( Campo , 80 , Linha )
				Write( 14 + Linha -1 , 0, Imprime )
			Next
			FChdir( oAmbiente:xBaseDados )
			Set Defa To ( oAmbiente:xBaseDados )
		EndIF
		cUltCodi := Codi
		DbSkip(1)
		IF cUltCodi != Codi .OR. Eof()
			lNovoCodigo := OK
			__Eject()
		EndIF
	EndDo
	DbClearFilter()
	DbGoTop()
	IF lFecharTudo
		FechaTudo()
	EndIF
	Fprint( Chr(ESC) + "C" + Chr( 66 ))
	PrintOff()
	ResTela( cScreen )
EndDo

Function Selecao( nChoice, oBloco )
***********************************
LOCAL cScreen	:= SaveScreen()
LOCAL cCodi 	:= Space(05)
LOCAL cCodi1	:= Space(05)
LOCAL cCida 	:= Space(25)
LOCAL cEsta 	:= Space(02)
LOCAL dIni		:= Space(05)
LOCAL xArquivo := FTempName(".tmp")
LOCAL dFim		:= Space(05)
LOCAL cRegiao	:= Space(02)

IF !UsaArquivo("RECEBER") ; FechaTudo() ; Break ; EndIF
IF !UsaArquivo("REGIAO")  ; FechaTudo() ; Break ; EndIF
IF !UsaArquivo("RECEMOV") ; FechaTudo() ; Break ; EndIF
Area("Receber")
Receber->( Order( RECEBER_CODI ))
Do Case
	Case nChoice = 1
		MaBox( 15, 02, 17, 63 )
		@ 16, 03 Say "Cliente...:" Get cCodi Pict PIC_RECEBER_CODI Valid RecErrado( @cCodi,, Row(), Col()+1 )
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Return( FALSO )
		EndIF
		Receber->( Order( RECEBER_CODI ))
		Receber->(DbSeek( cCodi ))
		oBloco := {|| Receber->Codi = cCodi }
		Return( OK )

	Case nChoice = 2
		MaBox( 15, 02, 17, 63 )
		@ 16, 03 Say "Cidade....:" Get cCida Pict "@!" Valid !Empty( cCida )
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Return( FALSO )
		EndIF
		Receber->( Order( RECEBER_CIDA ))
		IF Receber->(!DbSeek( cCida ))
			Nada()
			Return( FALSO )
		EndIF
		oBloco := {|| Receber->Cida = cCida }
		Return( OK )

	Case nChoice = 3
		MaBox( 15, 02, 17, 63 )
		@ 16, 03 Say "Estado....:" Get cEsta Pict "@!" Valid !Empty( cEsta )
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Return( FALSO )
		EndIF
		Receber->( Order( RECEBER_ESTA ))
		IF Receber->(!DbSeek( cEsta ))
			Nada()
			Return( FALSO )
		EndIF
		oBloco := {|| Receber->Esta = cEsta }
		Return( OK )

	Case nChoice = 4
		MaBox( 15, 02, 17, 63 )
		@ 16, 03 Say "Regiao....:" Get cRegiao Pict "@!" Valid Regiao->(RegiaoErrada( @cRegiao ))
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Return( FALSO )
		EndIF
		Receber->( Order( RECEBER_REGIAO ))
		IF Receber->(!DbSeek( cRegiao ))
			Nada()
			Return( FALSO )
		EndIF
		oBloco := {|| Receber->Regiao = cRegiao }
		Return( OK )

	Case nChoice = 5
		MaBox( 15, 02, 18, 63 )
		@ 16, 03 Say "Dia/Mes do Aniversario Inicial.:" Get dIni Pict "##/##"
		@ 17, 03 Say "Dia/Mes do Aniversario Final...:" Get dFim Pict "##/##" Valid dFim >= dIni
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Return( FALSO )
		EndIF
		IF Conf("Informa: Procura podera demorar. Continua ?")
			oMenu:Limpa()
			cTela := Mensagem("Informa: Aguarde, Localizando Registros.")
			Copy Stru To ( xArquivo )
			Use ( xArquivo) Exclusive Alias xAlias New
			nConta := 0
			cIni1  := Left(StrTran( dIni, "/"),2)
			cIni2  := Right(StrTran( dIni, "/"),2)
			cFim1  := Left(StrTran( dFim, "/"),2)
			cFim2  := Right(StrTran( dFim, "/"),2)
			Receber->( Order( RECEBER_CODI ))
			Receber->(DbGoTop())
			WHILE Receber->(!Eof())
				cData  := Receber->(Left(DToc( Nasc ), 5 ))
				cData1 := Left( StrTran( cData, "/"), 2 )
				cData2 := Right( StrTran( cData, "/"), 2 )
				IF cData1 >= cIni1 .AND. cData1 <= cFim1
					IF cData2 >= cIni2 .AND. cData2 <= cFim2
						nConta++
						xAlias->(DbAppend())
						For nField := 1 To FCount()
							xAlias->(FieldPut( nField, Receber->(FieldGet( nField ))))
						Next
					EndIF
				EndIF
				Receber->(DbSkip(1))
			EnDdo
			IF nConta = 0
				xAlias->(DbCloseArea())
				Ferase( xArquivo )
				oMenu:Limpa()
				Alerta("Informa: Nenhum Registro atende a Condicao.")
			Else
				Sele xAlias
				xAlias->(DbGoTop())
				oBloco := {|| !Eof() }
				ResTela( cTela )
				Return( OK )
			EndIF
		EndIF
		Return( FALSO )

	Case nChoice = 6
		MaBox( 15, 02, 18, 63 )
		@ 16, 03 Say "Codigo Ini:" Get cCodi  Pict PIC_RECEBER_CODI Valid RecErrado( @cCodi,, Row(), Col()+1 )
		@ 17, 03 Say "Codigo Fim:" Get cCodi1 Pict PIC_RECEBER_CODI Valid RecErrado( @cCodi1,, Row(), Col()+1 )
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Return( FALSO )
		EndIF
		Receber->( Order( RECEBER_CODI ))
		oBloco := {|| Receber->Codi >= cCodi .AND. Receber->Codi <= cCodi1 }
		Receber->(DbSeek( cCodi ))
		Return( OK )

	Case nChoice = 7
		Receber->( Order( RECEBER_CODI ))
		Receber->(DbGoTop())
		oBloco := {|| !Eof() }
		Return( OK )
EndCase

def Novidades()
   #if defined( __PLATFORM__UNIX )
      LOCAL cFile := oAmbiente:xRoot + "/sci.new"
   #else   
      LOCAL cFile := oAmbiente:xRoot + "\sci.new"   
   #endif   
	
   oMenu:Limpa()
	if file( cFile )
		M_Title("ULTIMAS ALTERACOES NO SISTEMA")
		M_View( 01, 00, LastRow()-1, LastCol(), cFile,  Cor())
	else
		ErrorBeep()
		Alerta("Erro: Arquivo [" + cFile + "] nao foi localizado.")
	endif
endef   

Proc ImprimeDebito()
********************
LOCAL GetList		:= {}
LOCAL cScreen		:= SaveScreen()
LOCAL cCodi 		:= Space(05)
LOCAL nSubTotal	:= 0
LOCAL nTotal		:= 0
LOCAL Col			:= 0
LOCAL Pagina		:= 0
LOCAL nSobra		:= 0
LOCAL nJuro 		:= 0
LOCAL nSubJuros	:= 0
LOCAL nCarencia	:= 30
LOCAL nTotalJuros := 0
LOCAL Tam			:= 132
LOCAL nTamForm 	:= 33
LOCAL dIni			:= Date()-30
LOCAL dFim			:= Date()
LOCAL cMensagem	:= "AGRADECEMOS A SUA PREFERENCIA."
LOCAL cNome
LOCAL cEnde
LOCAL cFone
LOCAL oBloco

cMensagem += Space(40 - Len( cMensagem ))
WHILE OK
	oMenu:Limpa()
	MaBox( 10, 05, 18, 78 )
	@ 11, 06 Say "Codigo Cliente..... : " Get cCodi       Pict PIC_RECEBER_CODI Valid RecErrado( @cCodi,, Row(), Col()+1 )
	@ 12, 06 Say "Data Inicial....... : " Get dIni        Pict "##/##/##"
	@ 13, 06 Say "Data Final......... : " Get dFim        Pict "##/##/##"
	@ 14, 06 Say "Taxa Juros Mes..... : " Get nJuro       Pict "99.99"
	@ 15, 06 Say "Dias Carencia...... : " Get nCarencia   Pict "99"
	@ 16, 06 Say "Mensagem............: " Get cMensagem   Pict "@1"
	@ 17, 06 Say "Comp do Formulario..: " Get nTamForm    Pict "99" Valid nTamForm >= 20 .AND. nTamForm <= 66
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Exit
	EndIF
	IF !Instru80() .OR. !LptOk()
		Loop
	EndIF
	cEnde := Receber->Ende
	cFone := Receber->Fone
	cNome := Receber->(AllTrim( Nome ))
	Lista->(Order( LISTA_CODIGO ))
	Area("Saidas")
	Set Rela To Saidas->Codigo Into Lista
	Saidas->(Order( SAIDAS_CODI ))
	IF Saidas->(!DbSeek( cCodi ))
		Saidas->(DbClearRel())
		Saidas->(DbGoTop())
		ErrorBeep()
		Alerta(" Nenhum Debito aberto em C/C !")
		Loop
	EndIF
	oBloco		:= {|| Saidas->Codi = cCodi }
	oBloco2		:= {|| Saidas->Data >= dIni .AND. Saidas->Data <= dFim }
	nSubTotal	:= 0
	nSubJuros	:= 0
	nTotalJuros := 0
	nTotal		:= 0
	Mensagem(" Aguarde... Verificando e Imprimindo Movimento.")
	Col			:= 58
	Pagina		:= 0
	nSobra		:= 0
	Tam			:= 132
	PrintOn()
	FPrint( PQ )
	FPrInt( Chr(ESC) + "C" + Chr( nTamForm ))
	SetPrc( 0, 0 )
	WHILE Eval( oBloco ) .AND. !Eof()
		IF Col >= nTamForm
			Write( 00, 00, Linha1( Tam, @Pagina))
			Write( 01, 00, Linha2())
         Write( 02, 00, Padc( oAmbiente:xFanta, Tam ) )
			Write( 03, 00, Linha4(Tam, SISTEM_NA2 ))
			Write( 04, 00, Padc( "RELATORIO DE DEBITO C/C", Tam ) )
			Write( 05, 00, Linha5( Tam ))
			Write( 06, 00, "Data : " + Dtoc( Date()))
			Write( 07, 00, "Nome : " + cCodi + "  " + cNome )
			Write( 08, 00, "End  : " + cEnde )
			Write( 09, 00, "Tel  : " + cFone )
			Write( 10, 00, Linha5( Tam ))
			Write( 11, 00, "DATA           ATRASO   FATURA   CODIGO    QUANT  DESCRICAO DO PRODUTO                         UNITARIO         TOTAL   VLR A PAGAR")
			Write( 12, 00, Linha5(Tam))
			Col := 13
		EndIF
		IF !Saidas->c_c  // Movimento nao eh conta corrente ?
			Saidas->(DbSkip(1))
			Loop
		EndIF
		IF Saidas->Saida = Saidas->SaidaPaga
			Saidas->(DbSkip(1))
			Loop
		EndIF
		IF !Eval( oBloco2 )
			Saidas->(DbSkip(1))
			Loop
		EndIF
		nSobra	:= ( Saidas->Saida - Saidas->SaidaPaga )
		nConta	:= Pvendido * nSobra
		nJurodia := 0
		nJdia 	:= 0
		nAtraso	:= ( Date() - Data ) - nCarencia
		nConta  := Lista->Varejo * nSobra
		IF nAtraso > 1
			nJdia 	  := JuroDia( nConta, nJuro )
			nJuroDia   := nJdia * nAtraso
		EndIF
		Qout( Data, nAtraso, Fatura, Codigo, Str( nSobra, 9, 2), Lista->(Ponto(Descricao,40)),;
				Lista->(Tran( Varejo, "@E 9,999,999.99")),;
				Tran( nConta, "@E 99,999,999.99"),;
				Tran( nConta + nJurodia, "@E 99,999,999.99"))
		nSubTotal	+= nConta
		nTotal		+= nConta
		nSubJuros	+= nConta + nJurodia
		nTotalJuros += nConta + nJurodia
		Saidas->(DbSkip(1))
		++Col
		IF Col >= nTamForm
			nRow1 := 104
			nRow2 := 118
			Write(	Col,	00,	 Linha5(Tam))
			Write( ++Col,	00,	 "** SubTotal ** " )
			Write(	Col,	nRow1, Tran( nSubTotal, "@E 99,999,999.99"))
			Write(	Col,	nRow2, Tran( nSubJuros, "@E 99,999,999.99"))
			nSubTotal := 0
			nSubJuros := 0
			++Col
			__Eject()
		EndIF
	EndDo
	nRow1 := 104
	nRow2 := 118
	Write(	Col,	00,	Linha5(Tam))
	Write( ++Col,	00,	"** SubTotal ** " )
	Write(	Col, nRow1, Tran( nSubTotal,	 "@E 99,999,999.99"))
	Write(	Col, nRow2, Tran( nSubJuros,	 "@E 99,999,999.99"))
	Write( ++Col,	00,	"**    Total ** " )
	Write(	Col, nRow1, Tran( nTotal,		 "@E 99,999,999.99"))
	Write(	Col, nRow2, Tran( nTotalJuros, "@E 99,999,999.99"))
	Qout()
	Qout( NG + GD + cMensagem + CA + NR )
	__Eject()
	PrintOff()
	Saidas->(DbClearRel())
	Saidas->(DbGoTop())
EndDo

Function Linha1( Tam, Pagina )
********************************
LOCAL nDiv := Tam / 2
Return( Padr( "Pagina N§ " + StrZero(++Pagina,5), nDiv ) + Padl(Time(), nDiv ))

Function Linha2()
*****************
Return(Date())

Function Linha3( Tam )
**********************
Return( Padc( XNOMEFIR, Tam ))

Function Linha4( Tam, cSistema )
********************************
Return(Padc( cSistema, Tam ))

Function Linha5( Tam )
**********************
Tam := IF( Tam = Nil, 80, Tam)
Return(Repl( SEP, Tam ))

Proc DebitoC_C()
****************
#DEFINE SP			Space(1)
LOCAL cScreen		:= SaveScreen()
LOCAL cCodi 		:= Space(05)
LOCAL nTotal		:= 0
LOCAL nSubTotal	:= 0
LOCAL nJuro 		:= 0
LOCAL nSubJuros	:= 0
LOCAL nTotalJuros := 0
LOCAL nSobra		:= 0
LOCAL aArray		:= {}
LOCAL nCarencia	:= 30
LOCAL dIni			:= Date()-30
LOCAL dFim			:= Date()
LOCAL cNome
LOCAL oBloco
LOCAL oBloco1

WHILE OK
	oMenu:Limpa()
	aArray := {}
	MaBox( 00, 00, 08, 79 )
	@ 01, 01 Say "Cliente..:" Get cCodi Pict PIC_RECEBER_CODI Valid RecErrado( @cCodi,, Row(), Col()+1 )
	@ 02, 01 Say "Data Ini.:" Get dIni  Pict "##/##/##"
	@ 03, 01 Say "Data Fim.:" Get dFim  Pict "##/##/##"
	@ 04, 01 Say "Juros Mes:" Get nJuro Pict "99.99"
	@ 05, 01 Say "Carencia.:" Get nCarencia Pict "999"
	@ 06, 01 Say "Endereco.:"
	@ 07, 01 Say "Telefone.:"
	Read
	IF LastKey() = ESC
		Saidas->(DbClearRel())
		Exit
	EndIF
	cNome := Receber->(AllTrim( Nome ))
	Write( 06, 12, Receber->Ende )
	Write( 07, 12, Receber->Fone )
	Lista->(Order( LISTA_CODIGO ))
	Area("Saidas")
	Set Rela To Codigo Into Lista
	Saidas->(Order( SAIDAS_CODI ))
	IF !DbSeek( cCodi )
		ErrorBeep()
		Alerta(" Nenhum Debito aberto em C/C !")
		Loop
	EndIF
	oBloco		:= {|| Saidas->Codi = cCodi }
	oBloco1		:= {|| Saidas->Data >= dIni .AND. Saidas->Data <= dFim }
	nTotal		:= 0
	nTotalJuros := 0
	nSobra		:= 0
	cTela := Mensagem(" Aguarde... Verificando Movimento.", Roloc(Cor()))
	WHILE Eval( oBloco ) .AND. !Eof()
		IF !Eval( oBloco1 )
			Saidas->(DbSkip(1))
			Loop
		EndIF
		IF !Saidas->c_c  // Movimento nao eh conta corrente ?
			Saidas->(DbSkip(1))
			Loop
		EndIF
		IF Saidas->Saida = Saidas->SaidaPaga
			Saidas->(DbSkip(1))
			Loop
		EndIF
		nSobra	:= ( Saidas->Saida - Saidas->SaidaPaga )
		nConta	:= ( nSobra * Lista->Varejo)
		nJurodia := 0
		nJdia 	:= 0
		nAtraso	:= ( Date() - Data ) - nCarencia
		IF nAtraso > 1
			nJdia 	  := JuroDia( nConta, nJuro )
			nJuroDia   := nJdia * nAtraso
		EndIF
		nTotal		+= nConta
		nTotalJuros += nConta + nJurodia
		Aadd( aArray, Dtoc( Data) + SP + Fatura + Codigo + SP + ;
				Lista->(Ponto(Left(Descricao,32),31)) + SP + Str( nSobra, 9,2) + SP + ;
				Lista->(Tran( Varejo, "@E 999,999.99")))
		Saidas->(DbSkip(1))
	EndDo
	ResTela( cTela )
	IF Len( aArray ) != 0
		MaBox( 09, 00, 24, 79 )
		Aadd( aArray, Repl("Ä",80))
		Aadd( aArray, Rjust("VALOR TOTAL " + Tran( nTotal, "@E 999,999,999.99"), 78))
		Aadd( aArray, Rjust("  COM JUROS " + Tran( nTotalJuros, "@E 999,999,999.99"), 78))
		Print( 09, 01, "DATA     FATURA   CODIGO DESCRICAO DO PRODUTO                 QUANT   UNITARIO", Roloc( Cor()))
		M_Title("[ESC] RETORNA")
		aChoice( 10, 01, 23, 78, aArray, OK )
	Else
		Alerta("Erro: Nenhum Debito em Aberto.")
	EndIF
	Saidas->(DbClearRel())
	Saidas->(DbGoTop())
EndDo
ResTela( cScreen )
Return

Proc MostraDebito()
*******************
LOCAL cScreen		:= SaveScreen()
LOCAL aTodos		:= {}
LOCAL aFatura		:= {}
LOCAL aValor		:= {}
LOCAL aVlrFatura	:= {}
LOCAL aMenuArray	:= Array(3)
LOCAL aMenu 		:= Array(3)
LOCAL cCodi 		:= Space(05)
LOCAL nPos			:= 0
LOCAL nTam			:= 0
LOCAL nVlrFatura	:= 0
LOCAL nVlrAnt		:= 0
LOCAL nVlrAtu		:= 0
LOCAL nAnt			:= 0
LOCAL nPrecoAtual := 0
LOCAL nBase 		:= 0
LOCAL nChoice		:= 0
LOCAL nCarencia	:= 0
LOCAL nJuro 		:= 0
LOCAL cTipoVenda
LOCAL cTela
LOCAL oBloco
LOCAL cFatura

aMenuArray[1] := " Conforme Preco Varejo  "
aMenuArray[2] := " Conforme Preco Atacado "
aMenuArray[3] := " Conforme Taxa de Juros "
	  aMenu[1] := " Preco Varejo  Atual "
	  aMenu[2] := " Preco Atacado Atual "
	  aMenu[3] := " Preco Vendido       "
WHILE OK
	oMenu:Limpa()
	MaBox( 05, 05, 07, 78 )
	@ 06, 06 Say "Codigo Cliente : " Get cCodi Pict PIC_RECEBER_CODI Valid RecErrado( @cCodi,, Row(), Col()+1 )
	Read
	IF LastKey() = ESC
		Saidas->(DbClearRel())
		ResTela( cScreen )
		Exit
	EndIF
	IF !Saidas->(TravaArq()) ; DbUnLockAll() ; Restela( cScreen ) ; Loop ; EndIf
	IF !Chemov->(TravaArq()) ; DbUnLockAll() ; Restela( cScreen ) ; Loop ; EndIf
	IF !Cheque->(TravaArq()) ; DbUnLockAll() ; Restela( cScreen ) ; Loop ; EndIf
	Lista->(Order( LISTA_CODIGO ))
	Area("Saidas")
	Set Rela To Codigo Into Lista
	Saidas->(Order( SAIDAS_CODI ))
	IF Saidas->(!DbSeek( cCodi ))
		ResTela( cScreen )
		ErrorBeep()
		Alerta(" Nenhum Debito aberto em C/C !")
		ResTela( cScreen )
		Loop
	EndIF
	M_Title("ESCOLHA O TIPO DE REAJUSTE")
	nChoice := FazMenu( 08, 05, aMenuArray, Cor())
	IF nChoice = 0
		Saidas->(DbClearRel())
		ResTela( cScreen )
		Loop
	EndIF
	nCarencia := 0
	nJuro 	 := 0
	IF nChoice = 3
		MaBox( 15, 05, 18, 33 )
		@ 16, 06 Say "Dias de Carencia :" Get nCarencia Pict "999"
		@ 17, 06 Say "Juro Mes.........:" Get nJuro     Pict "999.99"
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Loop
		EndIF
		M_Title("TOMAR POR BASE O")
		nBase := FazMenu( 15, 34, aMenu, Cor())
		IF nBase = 0
			Saidas->(DbClearRel())
			ResTela( cScreen )
			Loop
		EndIF
	EndIF
	IF Conf("Pergunta: Confirma Atualizacao do Movimento ?")
		oBloco	  := {|| Saidas->Codi = cCodi }
		cTipoVenda := OK
		aTodos	  := {}
		aFatura	  := {}
		aValor	  := {}
		aVlrFatura := {}
		nTam		  := 0
		nAnt		  := 0
		nVlrAnt	  := 0
		nVlrAtu	  := 0
		nVlrFatura := 0
		nPrecoAtual := 0
		Mensagem(" Aguarde... Verificando e atualizando Movimento.")
		WHILE Eval( oBloco ) .AND. !Eof()
			nVlrFatura += ( Saidas->Saida * Saidas->Pvendido )
			cFatura	  := Saidas->Fatura
			nPos		  := Ascan( aFatura, cFatura )
			IF Saidas->c_c  // Movimento eh conta corrente ?
				nSobra	  := ( Saidas->Saida - Saidas->SaidaPaga )
				nVlrAnt	  := ( nSobra * Saidas->Pvendido )
				IF nChoice		= 1 // Varejo
					nVlrAtu	  := ( nSobra * Lista->Varejo )
					Saidas->Pvendido := Lista->Varejo
				ElseIF nChoice = 2 // Atacado
					nVlrAtu	  := ( nSobra * Lista->Atacado )
					Saidas->Pvendido := Lista->Atacado
				ElseIF nChoice = 3 // Juro Mensal
					IF nBase = 1 // Base o Varejo
						nAtraso			  := (( Date() - Data ) - nCarencia )
						nAtraso			  := IF( nAtraso >= 0, nAtraso, 0 )
						nJdia 			  := JuroDia( Lista->Varejo, nJuro )
						nJTotal			  := nJdia * nAtraso
						nVlrAtu			  := ( nSobra * ( Lista->Varejo + nJTotal ))
						Saidas->Pvendido := nVlrAtu
					ElseIF nBase = 2 // Base o Atacado
						nAtraso			  := (( Date() - Data ) - nCarencia )
						nAtraso			  := IF( nAtraso >= 0, nAtraso, 0 )
						nJdia 			  := JuroDia( Lista->Atacado, nJuro )
						nJTotal			  := nJdia * nAtraso
						nVlrAtu			  := ( nSobra * ( Lista->Atacado + nJTotal ))
						Saidas->Pvendido := nVlrAtu
					ElseIF nBase = 3 // Base o Vendido
						nAtraso			  := (( Date() - Data ) - nCarencia )
						nAtraso			  := IF( nAtraso >= 0, nAtraso, 0 )
						nJdia 			  := JuroDia( Saidas->Pvendido, nJuro )
						nJTotal			  := nJdia * nAtraso
						nVlrAtu			  := ( nSobra * ( Saidas->Pvendido + nJTotal ))
						Saidas->Pvendido := nVlrAtu
					EndIF
				EndIF
				nPrecoAtual := Saidas->Pvendido
				Aadd( aTodos, Codigo + " " + Lista->Descricao + " " +;
								  Str( nSobra,6 ) + " " + Lista->(Tran( nPrecoAtual, "@E 99,999,999,999.99")))
			EndIF
			IF nPos = 0
				Aadd( aFatura, 	cFatura )
				Aadd( aValor,		( nVlrAtu - nVlrAnt) )
				Aadd( aVlrFatura, nVlrFatura )
			Else
				aValor[nPos]	  += ( nVlrAtu - nVlrAnt )
				aVlrFatura[nPos] +=	nVlrFatura
			EndIF
			nVlrAnt	  := 0
			nVlrAtu	  := 0
			nVlrFatura := 0
			nSobra	  := 0
			Saidas->(Dbskip(1))
		EndDo
		Saidas->(Libera())
		nTam := Len( aFatura )
		IF nTam != 0
			ResTela( cScreen )
			Chemov->(Order( CHEMOV_FATURA ))
			For nX := 1 To nTam
				IF Chemov->(DbSeek( aFatura[nX]))
					nAnt			  := Chemov->Saldo
					Chemov->Deb   := aVlrFatura[ nX ]
					Chemov->Deb   += aValor[ nX ]
					Chemov->Saldo -= aValor[ nX ]
				EndIf
			Next
			Chemov->(Libera())
			IndexarData( cCodi )
		Else
			Chemov->(Libera())
			ResTela( cScreen )
			ErrorBeep()
			Alerta("Nenhum Debito aberto em C/C !")
		EndIF
	EndIF
	ResTela( cScreen )
EndDo

def ExcluirTemporarios()
*-----------------------*
	LOCAL cTela := Mensagem("Aguarde, Excluindo Arquivos Temporarios.")
   
	Aeval( Directory( "*.$*"),  { | aFile | Ferase( aFile[ F_NAME ] )})
	Aeval( Directory( "*.$$$"), { | aFile | Ferase( aFile[ F_NAME ] )})
	Aeval( Directory( "*.tmp"), { | aFile | Ferase( aFile[ F_NAME ] )})
	Aeval( Directory( "*.bak"), { | aFile | Ferase( aFile[ F_NAME ] )})
	Aeval( Directory( "*.mem"), { | aFile | Ferase( aFile[ F_NAME ] )})
   Aeval( Directory( "COM*"),  { | aFile | Ferase( aFile[ F_NAME ] )})
   Aeval( Directory( "LPT*"),  { | aFile | Ferase( aFile[ F_NAME ] )})
	Aeval( Directory( "t0*.*"), { | aFile | Ferase( aFile[ F_NAME ] )})
	Aeval( Directory( "t1*.*"), { | aFile | Ferase( aFile[ F_NAME ] )})
	Aeval( Directory( "t2*.*"), { | aFile | Ferase( aFile[ F_NAME ] )})
	Aeval( Directory( "t3*.*"), { | aFile | Ferase( aFile[ F_NAME ] )})
	Aeval( Directory( "t4*.*"), { | aFile | Ferase( aFile[ F_NAME ] )})
	Aeval( Directory( "t5*.*"), { | aFile | Ferase( aFile[ F_NAME ] )})
	Aeval( Directory( "t6*.*"), { | aFile | Ferase( aFile[ F_NAME ] )})
	Aeval( Directory( "t7*.*"), { | aFile | Ferase( aFile[ F_NAME ] )})
	Aeval( Directory( "t8*.*"), { | aFile | Ferase( aFile[ F_NAME ] )})
	Aeval( Directory( "t9*.*"), { | aFile | Ferase( aFile[ F_NAME ] )})
	Aeval( Directory( "*."),    { | aFile | Ferase( aFile[ F_NAME ] )})
	return(ResTela(cTela))
endef	

def Duplicados()
****************
   LOCAL cFile
   LOCAL xDbf
   LOCAL xNtx
   LOCAL nx

   Mensagem("Informa: Aguarde, Excluindo Arquivos Temporarios.")
   oMenu:Limpa()
   Aeval( Directory( "*.cdx"), { | aFile | Ferase( aFile[ F_NAME ] )})
   Aeval( Directory( "*.ntx"), { | aFile | Ferase( aFile[ F_NAME ] )})
   Aeval( Directory( "*.nsx"), { | aFile | Ferase( aFile[ F_NAME ] )})
   Aeval( Directory( "*.lix"), { | aFile | Ferase( aFile[ F_NAME ] )})   
   ExcluirTemporarios()
   /*************************************************************************************************/
   cFile := "SAIDAS"
   xNtx	:= FTempName("t*.tmp")
   cTela := Mensagem("Verificando: " + cFile )
   xDbf := ""

   Sele Saidas
   Inde On Codigo + Docnr + CodiVen + Codi + Fatura + Pedido + Dtos( Data ) To ( xNtx ) Unique
   nX := 0
   WHILE File(( xDbf := cFile + "." + StrZero( ++nX, 3 )))
   EndDo
   Copy To ( xDbf )
   RenDup( cFile, xDbf, xNtx )
   /*************************************************************************************************/
   cFile := "RECEMOV"
   xNtx	:= FTempName("t*.tmp")
   cTela := Mensagem("Verificando: " + cFile )
   xDbf := ""

   Sele Recemov
   Inde On Docnr + Fatura + Codi + CodiVen + Caixa + Str( Vlr, 13,2 ) + dTos( Vcto ) To ( xNtx ) Unique
   nX := 0
   WHILE File(( xDbf := cFile + "." + StrZero( ++nX, 3 )))
   EndDo
   Copy To ( xDbf )
   RenDup( cFile, xDbf, xNtx )
   /*************************************************************************************************/
   cFile := "VENDEMOV"
   xNtx	:= FTempName("t*.tmp")
   cTela := Mensagem("Verificando: " + cFile )
   xDbf := ""

   Sele Vendemov
   Inde On Fatura + CodiVen + Codi + Str( Vlr, 13,2 ) + dTos( Data ) To ( xNtx) Unique
   nX := 0
   WHILE File(( xDbf := cFile + "." + StrZero( ++nX, 3 )))
   EndDo
   Copy To ( xDbf )
   RenDup( cFile, xDbf, xNtx )
   /*************************************************************************************************/
   cFile := "NOTA"
   xNtx	:= FTempName("t*.tmp")
   cTela := Mensagem("Verificando: " + cFile )
   xDbf := ""

   Sele Nota
   Inde On Numero To ( xNtx ) Unique
   nX := 0
   WHILE File(( xDbf := cFile + "." + StrZero( ++nX, 3 )))
   EndDo
   Copy To ( xDbf )
   RenDup( cFile, xDbf, xNtx )
   /*************************************************************************************************/
   cFile := "PAGO"
   xNtx	:= FTempName("t*.tmp")
   cTela := Mensagem("Verificando: " + cFile )
   xDbf := ""

   Sele Pago
   Inde On Codi + Str( Vlr, 13, 2 ) + dTos( Vcto ) + Docnr + dTos( DataPag) + Str( VlrPag, 13, 2 ) To ( xNtx ) Unique
   nX := 0
   WHILE File(( xDbf := cFile + "." + StrZero( ++nX, 3 )))
   EndDo
   Copy To ( xDbf )
   RenDup( cFile, xDbf, xNtx )
   /*************************************************************************************************/
   cFile := "CHEQUE"
   xNtx	:= FTempName("t*.tmp")
   cTela := Mensagem("Verificando: " + cFile )
   xDbf := ""

   Sele Cheque
   Inde On Codi To ( xNtx ) Unique
   nX := 0
   WHILE File(( xDbf := cFile + "." + StrZero( ++nX, 3 )))
   EndDo
   Copy To ( xDbf )
   RenDup( cFile, xDbf, xNtx )
   /*************************************************************************************************/
   cFile := "LISTA"
   xNtx	:= FTempName("t*.tmp")
   cTela := Mensagem("Verificando: " + cFile )
   xDbf := ""

   Sele Lista
   Inde On Codigo + Descricao + Codi + CodGrupo + CodSgrupo To ( xNtx ) Unique
   nX := 0
   WHILE File(( xDbf := cFile + "." + StrZero( ++nX, 3 )))
   EndDo
   Copy To ( xDbf )
   RenDup( cFile, xDbf, xNtx )
   /*************************************************************************************************/
   cFile := "REGIAO"
   xNtx	:= FTempName("t*.tmp")
   cTela := Mensagem("Verificando: " + cFile )
   xDbf := ""

   Sele Regiao
   Inde On Regiao + Nome To ( xNtx ) Unique
   nX := 0
   WHILE File(( xDbf := cFile + "." + StrZero( ++nX, 3 )))
   EndDo
   Copy To ( xDbf )
   RenDup( cFile, xDbf, xNtx )
   /*************************************************************************************************/
   cFile := "CURSOS"
   xNtx	:= FTempName("t*.tmp")
   cTela := Mensagem("Verificando: " + cFile )
   xDbf := ""

   Sele Cursos
   Inde On Curso + Obs To ( xNtx ) Unique
   nX := 0
   WHILE File(( xDbf := cFile + "." + StrZero( ++nX, 3 )))
   EndDo
   Copy To ( xDbf )
   RenDup( cFile, xDbf, xNtx )
   /*************************************************************************************************/
   cFile := "FORMA"
   xNtx	:= FTempName("t*.tmp")
   cTela := Mensagem("Verificando: " + cFile )
   xDbf := ""

   Sele Forma
   Inde On Forma + Condicoes To ( xNtx ) Unique
   nX := 0
   WHILE File(( xDbf := cFile + "." + StrZero( ++nX, 3 )))
   EndDo
   Copy To ( xDbf )
   RenDup( cFile, xDbf, xNtx )
   /*************************************************************************************************/
   cFile := "RECEBER"
   xNtx	:= FTempName("t*.tmp")
   cTela := Mensagem("Verificando: " + cFile )
   xDbf := ""

   Sele Receber
   Inde On Codi To ( xNtx ) Unique
   nX := 0
   WHILE File(( xDbf := cFile + "." + StrZero( ++nX, 3 )))
   EndDo
   Copy To ( xDbf )
   RenDup( cFile, xDbf, xNtx )
   /*************************************************************************************************/
   cFile := "PAGAR"
   xNtx	:= FTempName("t*.tmp")
   cTela := Mensagem("Verificando: " + cFile )
   xDbf := ""

   Sele Pagar
   Inde On Codi To ( xNtx ) Unique
   nX := 0
   WHILE File(( xDbf := cFile + "." + StrZero( ++nX, 3 )))
   EndDo
   Copy To ( xDbf )
   RenDup( cFile, xDbf, xNtx )
   /*************************************************************************************************/
   cFile := "USUARIO"
   xNtx	:= FTempName("t*.tmp")
   cTela := Mensagem("Verificando: " + cFile )
   xDbf := ""

   Sele Usuario
   Inde On Nome To ( xNtx ) Unique
   nX := 0
   WHILE File(( xDbf := cFile + "." + StrZero( ++nX, 3 )))
   EndDo
   Copy To ( xDbf )
   RenDup( cFile, xDbf, xNtx )
   /*************************************************************************************************/
   cFile := "GRUPO"
   xNtx	:= FTempName("t*.tmp")
   cTela := Mensagem("Verificando: " + cFile )
   xDbf := ""

   Sele Grupo
   Inde On CodGrupo + DesGrupo To ( xNtx ) Unique
   nX := 0
   WHILE File(( xDbf := cFile + "." + StrZero( ++nX, 3 )))
   EndDo
   Copy To ( xDbf )
   RenDup( cFile, xDbf, xNtx )
   /*************************************************************************************************/
   cFile := "SUBGRUPO"
   xNtx	:= FTempName("t*.tmp")
   cTela := Mensagem("Verificando: " + cFile )
   xDbf := ""

   Sele SubGrupo
   Inde On CodsGrupo + DesSgrupo To ( xNtx ) Unique
   nX := 0
   WHILE File(( xDbf := cFile + "." + StrZero( ++nX, 3 )))
   EndDo
   Copy To ( xDbf )
   RenDup( cFile, xDbf, xNtx )
   /*************************************************************************************************/
   cFile := "VENDEDOR"
   xNtx	:= FTempName("t*.tmp")
   cTela := Mensagem("Verificando: " + cFile )
   xDbf := ""

   Sele Vendedor
   Inde On CodiVen + Nome To ( xNtx ) Unique
   nX := 0
   WHILE File(( xDbf := cFile + "." + StrZero( ++nX, 3 )))
   EndDo
   Copy To ( xDbf )
   RenDup( cFile, xDbf, xNtx )
   /*************************************************************************************************/
   cFile := "CHEMOV"
   xNtx	:= FTempName("t*.tmp")
   cTela := Mensagem("Verificando: " + cFile )
   xDbf := ""

   Sele Chemov
   Inde On Codi + dTos( Data ) + dTos( Emis ) + Hist + Docnr + Fatura + Caixa + Str( Cre, 13,2) + Str(Deb, 13,2) + Tipo To ( xNtx ) Unique
   nX := 0
   WHILE File(( xDbf := cFile + "." + StrZero( ++nX, 3 )))
   EndDo
   Copy To ( xDbf )
   RenDup( cFile, xDbf, xNtx )
   /*************************************************************************************************/
   cFile := "RECEBIDO"
   xNtx	:= FTempName("t*.tmp")
   cTela := Mensagem("Verificando: " + cFile )
   xDbf := ""

   Sele Recebido
   Inde On Codi + Str(Vlr,13,2) + dTos(Emis) + dTos(Vcto) + Docnr + Fatura + dTos( DataPag ) + Str(VlrPag, 13,2 ) To ( xNtx ) Unique
   nX := 0
   WHILE File(( xDbf := cFile + "." + StrZero( ++nX, 3 )))
   EndDo
   Copy To ( xDbf )
   RenDup( cFile, xDbf, xNtx )
   /*************************************************************************************************/
   cFile := "ENTRADAS"
   xNtx	:= FTempName("t*.tmp")
   cTela := Mensagem("Verificando: " + cFile )
   xDbf := ""

   Sele Entradas
   Inde On Codi + dTos( Data ) + Codigo + Fatura + Str(VlrFatura,13,2) To ( xNtx ) Unique
   nX := 0
   WHILE File(( xDbf := cFile + "." + StrZero( ++nX, 3 )))
   EndDo
   Copy To ( xDbf )
   RenDup( cFile, xDbf, xNtx )
   /*************************************************************************************************/
   cFile := "CHEPRE"
   xNtx	:= FTempName("t*.tmp")
   cTela := Mensagem("Verificando: " + cFile )
   xDbf := ""

   Sele Chepre
   Inde On Codi + Docnr + dTos( Data ) + dTos( Vcto ) + Hist + DebCre + Str( Valor, 13 ,2 ) To ( xNtx ) Unique
   nX := 0
   WHILE File(( xDbf := cFile + "." + StrZero( ++nX, 3 )))
   EndDo
   Copy To ( xDbf )
   RenDup( cFile, xDbf, xNtx )
   /*************************************************************************************************/
   FechaTudo()
   ResTela( cTela )
   Return
endef   

def RenDup( cFile, xDbf, xNtx )
*******************************
   DbCloseArea()
   IF !MsRename( cFile + ".dbf", cFile + ".lix")
      Ferase( cFile + ".lix")
      MsRename( cFile + ".dbf", cFile + ".lix")
   EndIF
   IF !MsRename( xDbf, cFile + ".dbf")
      oMenu:Limpa()
      ErrorBeep()
      Alerta("Erro # " + AllTrim( Str( Ferror())) + " : Erro ao renomear arquivo " + cFile + ".dbf.")
      FechaTudo()
      Return nil
   EndIF
   Ferase( xNtx )
endef   

def DupSaidas()
***************
   LOCAL cFile
   LOCAL xDbf
   LOCAL xNtx
   LOCAL nx

   Mensagem("Informa: Aguarde, Excluindo Arquivos Temporarios.")
   oMenu:Limpa()
   ExcluirTemporarios()
   /*************************************************************************************************/
   IF !UsaArquivo("SAIDAS") ; Break ; EndiF
   cFile := "SAIDAS"
   xNtx	:= FTempName("t*.tmp")
   cTela := Mensagem("Verificando: " + cFile )
   xDbf := ""

   Sele Saidas
   Inde On Codigo + Docnr + CodiVen + Codi + Fatura + Pedido + dTos( Data ) To ( xNtx ) Unique
   nX := 0
   WHILE File(( xDbf := cFile + "." + StrZero( ++nX, 3 )))
   EndDo
   Copy To ( xDbf )
   RenDup( cFile, xDbf, xNtx )
   ResTela( cTela )
   return nil
endef   

def DupRecemov()
****************
   LOCAL cFile
   LOCAL xDbf
   LOCAL xNtx
   LOCAL nx

   Mensagem("Informa: Aguarde, Excluindo Arquivos Temporarios.")
   oMenu:Limpa()
   ExcluirTemporarios()
   /*************************************************************************************************/
   IF !UsaArquivo("RECEMOV") ; Break ; EndiF
   cFile := "RECEMOV"
   xNtx	:= FTempName("t*.tmp")
   cTela := Mensagem("Verificando: " + cFile )
   xDbf := ""

   Sele Recemov
   Inde On Docnr + Fatura + Codi + CodiVen + Caixa + Str( Vlr, 13,2 ) + dTos( Vcto) To ( xNtx ) Unique
   nX := 0
   WHILE File(( xDbf := cFile + "." + StrZero( ++nX, 3 )))
   EndDo
   Copy To ( xDbf )
   RenDup( cFile, xDbf, xNtx )
   ResTela( cTela )
   return nil
endef   

def DupRecebido()
*****************
   LOCAL cFile
   LOCAL xDbf
   LOCAL xNtx
   LOCAL nx

   Mensagem("Informa: Aguarde, Excluindo Arquivos Temporarios.")
   oMenu:Limpa()
   ExcluirTemporarios()
   /*************************************************************************************************/
   IF !UsaArquivo("RECEBIDO") ; Break ; EndiF
   cFile := "RECEBIDO"
   xNtx	:= FTempName("t*.tmp")
   cTela := Mensagem("Verificando: " + cFile )
   xDbf := ""

   Sele Recebido
   Inde On Codi + dTos( DataPag ) + dTos( Emis ) + Docnr + Fatura + Str( VlrPag, 13, 2 ) + Tipo  To ( xNtx ) Unique
   nX := 0
   WHILE File(( xDbf := cFile + "." + StrZero( ++nX, 3 )))
   EndDo
   Copy To ( xDbf )
   RenDup( cFile, xDbf, xNtx )
   return(ResTela( cTela ))
endef    

def DupChemov()
***************
   LOCAL cFile
   LOCAL xDbf
   LOCAL xNtx
   LOCAL nx

   Mensagem("Informa: Aguarde, Excluindo Arquivos Temporarios.")
   oMenu:Limpa()
   ExcluirTemporarios()
   /*************************************************************************************************/
   IF !UsaArquivo("CHEMOV") ; Break ; EndiF
   cFile := "CHEMOV"
   xNtx	:= FTempName("t*.tmp")
   cTela := Mensagem("Verificando: " + cFile )
   xDbf := ""

   Sele Chemov
   Inde On Codi + dTos( Data ) + dTos( Emis ) + Hist + Docnr + Fatura + Caixa + Str( Cre, 13,2) + Str(Deb, 13,2) + Tipo To ( xNtx ) Unique
   nX := 0
   WHILE File(( xDbf := cFile + "." + StrZero( ++nX, 3 )))
   EndDo
   Copy To ( xDbf )
   RenDup( cFile, xDbf, xNtx )
   return(ResTela( cTela ))
endef   

def DupLista()
**************
   LOCAL cFile
   LOCAL xDbf
   LOCAL xNtx
   LOCAL nx

   Mensagem("Informa: Aguarde, Excluindo Arquivos Temporarios.")
   oMenu:Limpa()
   ExcluirTemporarios()
   /*************************************************************************************************/
   IF !UsaArquivo("LISTA") ; Break ; EndiF
   cFile := "LISTA"
   xNtx	:= FTempName("t*.tmp")
   cTela := Mensagem("Verificando: " + cFile )
   xDbf := ""

   Sele Lista
   Inde On Codigo + Descricao + Codi + CodGrupo + CodSgrupo To ( xNtx ) Unique
   nX := 0
   WHILE File(( xDbf := cFile + "." + StrZero( ++nX, 3 )))
   EndDo
   Copy To ( xDbf )
   RenDup( cFile, xDbf, xNtx )
   return(ResTela( cTela ))
endef   

def DupReceber()
****************
   LOCAL cFile
   LOCAL xDbf
   LOCAL xNtx
   LOCAL nx

   Mensagem("Informa: Aguarde, Excluindo Arquivos Temporarios.")
   oMenu:Limpa()
   ExcluirTemporarios()
   /*************************************************************************************************/
   IF !UsaArquivo("RECEBER") ; Break ; EndiF
   cFile := "RECEBER"
   xNtx	:= FTempName("t*.tmp")
   cTela := Mensagem("Verificando: " + cFile )
   xDbf := ""

   Sele Receber
   Inde On Codi To ( xNtx ) Unique
   nX := 0
   WHILE File(( xDbf := cFile + "." + StrZero( ++nX, 3 )))
   EndDo
   Copy To ( xDbf )
   RenDup( cFile, xDbf, xNtx )
   return(ResTela( cTela ))
endef   

def DupEntradas()
*----------------*
	LOCAL cFile := "ENTRADAS"	
	LOCAL nx
	PRIVA xNtx   := FTempMemory()		
	PRIVA xDbf   := FTempMemory()		

	Mensagem("Informa: Aguarde, Excluindo Arquivos Temporarios.")
	oMenu:Limpa()
	ExcluirTemporarios()
	if !UsaArquivo("ENTRADAS") ; Break ; endif
	cTela := Mensagem("Verificando: " + cFile )
	
	Area("ENTRADAS")
	Inde On Codi + dTos( Data ) + Codigo + Fatura + Str(VlrFatura,13,2) To MEM:&xNtx Unique Temporary
	Copy To MEM:&xDbf
	RenDup( cFile, MEM:&xDbf, xNtx )
	return(ResTela( cTela ))
endef	

def DupPagamov()
*---------------*
	LOCAL cFile := "PAGAMOV"
	LOCAL nx
	PRIVA xNtx   := FTempMemory()		
	PRIVA xDbf   := FTempMemory()		

	Mensagem("Informa: Aguarde, Excluindo Arquivos Temporarios.")
	oMenu:Limpa()
	ExcluirTemporarios()
	IF !UsaArquivo("PAGAMOV") ; Break ; EndiF	
	cTela := Mensagem("Verificando: " + cFile )

	Area("PAGAMOV")
	Inde On Docnr + Fatura + Codi + Str( Vlr, 13,2 ) + dTos( Vcto) + dTos( Emis ) To MEM:&xNtx Unique Temporary
	hb_vfCopyFile( "mem:test.dbf", "test1.dbf" )
	Copy To MEM:&xDbf
	RenDup( cFile, MEM:&xDbf, xNtx )
	return(ResTela( cTela ))	
endef	

*==================================================================================================*	

def CriaNewNota( lSimNao )
*+------------------------+*
	LOCAL GetList  := {}
	LOCAL cScreen  := SaveScreen()
	LOCAL cFatura  := ""
	LOCAL cTela
	PRIVA xNtx     := FTempMemory()		
	PRIVA xNewNota := FTempMemory()

	if lSimNao = NIL
		ErrorBeep()
		if !Conf("Pergunta: Verificacao  podera demorar. Continuar ?")
			return(ResTela( cScreen))
		endif
	endif	
	
	cTela := Mensagem(" Aguarde... Verificando e abrindo arquivos.")
	FechaTudo()
	IF !NetUse("Saidas",  MONO )   ; ResTela( cTela ); Return(FALSO) ; EndIF
	IF !NetUse("Nota",    MONO )   ; ResTela( cTela ); Return(FALSO) ; EndIF
	IF !NetUse("Recemov", MONO )   ; ResTela( cTela ); Return(FALSO) ; EndIF
	ResTela( cTela )
	
	cTela := Mensagem("Verificando: SAIDAS.DBF")
	Area("Recemov")
	Area("Saidas")
	Area("Nota")
	Nota->(__DbZap())			
	Inde On Numero To mem:&xNtx Temporary
	Saidas->(Order( SAIDAS_FATURA ))
	Saidas->(DbGoTop())
	
	WHILE Saidas->(!Eof()) .AND. lCancelou() .AND. oMenu:ContaReg()    
		cFatura := Saidas->Fatura
		IF Nota->(!DbSeek( cFatura ))
			Nota->(DbAppend())
			Nota->Codi		  := Saidas->Codi
			Nota->Numero	  := Saidas->Fatura
			Nota->Atualizado := Date()
			Nota->Data		  := Saidas->Data
			Nota->Situacao   := Saidas->Situacao
			Nota->Caixa      := Saidas->Caixa
		EndIF
		Saidas->(DbSkip(1))
	EndDo

	cTela := Mensagem("Verificando: RECEMOV.DBF")
	Recemov->(Order(RECEMOV_FATURA))
	Recemov->(DbGotop())
	
	while Recemov->(!Eof()) .AND. lCancelou() .AND. oMenu:ContaReg() 
		cFatura := Recemov->Fatura
		IF Nota->(!DbSeek( cFatura ))
			Nota->(DbAppend())
			Nota->Codi		  := Recemov->Codi
			Nota->Numero	  := Recemov->Fatura
			Nota->Atualizado := Date()
			Nota->Data		  := Recemov->Emis
			Nota->Situacao   := 'RECEBER'
			Nota->Caixa      := Recemov->Caixa
		EndIF
		Recemov->(DbSkip(1))
	enddo
	
	Nota->(Order( NATURAL ))
	ms_swap_ferase("NEWNOTA.DBF")	
	Sort On Numero To mem:&xNewNota
	Nota->(__DbZap())
	Nota->(__DbPack())
	Appe From mem:&xNewNota
	FechaTudo()
	ms_swap_ferase('NOTA.' + CEXT)
	//VerIndice()
	//oReindexa:WriteBool('reindexando', 'NOTA.DBF', OK )
	//FechaTudo()
	ResTela( cScreen )
   alert("Informa: Tarefa efetuada com sucesso")
   return true
endef
	
def CriaNewEnt()
*+---------------+*
	LOCAL cFatura := ""	
	LOCAL cTela   := Mensagem("Aguarde... Verificando Arquivos.")
	PRIVA xNtx    := FTempMemory()		

	FechaTudo()
	IF !NetUse("Entradas", MONO ) ; ResTela( cTela ); Return(FALSO) ; EndIF
	IF !NetUse("EntNota",  MONO ) ; ResTela( cTela ); Return(FALSO) ; EndIF
	ResTela( cTela )

	cTela := Mensagem("Verificando: ENTRADAS.DBF")
	Area("Entradas")
	Area("EntNota")
	EntNota->(__DbZap())
	Inde On Numero To mem:&xNtx Temporary
	Entradas->(DbGoTop())
	
	while Entradas->(!Eof())
		cFatura := Entradas->Fatura
		IF EntNota->(!DbSeek( cFatura ))
			EntNota->(DbAppend())
			EntNota->Codi		  := Entradas->Codi
			EntNota->Numero	  := Entradas->Fatura
			EntNota->VlrFatura  := Entradas->VlrFatura
			EntNota->VlrNff	  := Entradas->VlrNFF
			EntNota->Icms		  := Entradas->Icms
			EntNota->Entrada	  := Entradas->DEntrada
			EntNota->Data		  := Entradas->Data
			EntNota->Condicoes  := Entradas->Condicoes
			EntNota->Atualizado := Date()
		EndIF
		Entradas->(DbSkip(1))
	EndDo
	FechaTudo()
	ms_swap_ferase("ENTNOTA." + CEXT)
	//VerIndice()
	//oReindexa:WriteBool('reindexando', "ENTNOTA.DBF", OK )
	//FechaTudo()	   
	ResTela( cTela )   
	return true
endef

def lCancelou()
*+-------------+*
	if LastKey() = K_ESC
		if alerta("INFO: Tarefa n„o concluida. Banco de Dados poder  ficar inconsitente.;; Deseja cancelar mesmo assim?", {" Sim ", " Nao "}) == 1
			FechaTudo()
			return false
		endif
	endif
	return true
endef	

def _SaidaVideo()
*+------------------------+*
	LOCAL cScreen := SaveScreen()
	LOCAL aCep	  := {}
	LOCAL cTela

	Area("Cep")
	Cep->(Order( CEP_CEP ))
	Cep->(DbGoTop())
	cTela := Mensagem("Aguarde ... ")

	while !Eof() .AND. Rep_Ok()
		Aadd( aCep,  Cep->Cep + " " + Cep->Cida + " " + Cep->Esta + " " + Cep->Bair )
		Cep->(DbSkip(1))
	enddo
	
	if Len( aCep ) != ZERO
		ResTela( cTela )
		cString := " CEP       CIDADE                    UF BAIRRO"
		Print( 00, 00, cString + Space( 80 - Len(  cString )), Roloc(Cor()))
		M_Title( "ESC Retorna ")
		FazMenu( 01, 00, aCep, Cor())
	EndIF
	return(ResTela( cScreen ))
endef

Proc DetalheRecibo( cCaixa, cTipoDetalhe )
******************************************
LOCAL GetList         := {}
LOCAL cScreen			 := SaveScreen()
LOCAL Arq_Ant			 := Alias()
LOCAL Ind_Ant			 := IndexOrd()
LOCAL aMenu 	       := {"Normal", "Somente Creditos", "Somente Debitos" }
LOCAL nRolCaixa		 := oIni:ReadInteger('relatorios','rolcaixa', 1 )
LOCAL nTipoCaixa		 := oIni:ReadInteger('relatorios','tipocaixa', 2 )
LOCAL nPartida 		 := oIni:ReadInteger('relatorios','rolcontrapartida', 2 )
LOCAL lVisualizarDetalheCaixa := oSci:ReadBool('permissao','visualizardetalhecaixa', OK )
LOCAL Pagina			 := 0
LOCAL nTamArray		 := 0
LOCAL Tam				 := 132
LOCAL dIni				 := Date()
LOCAL dFim				 := Date()
LOCAL nDif				 := 0
LOCAL lDetalhe        := OK
LOCAL nOpcao          := NIL
LOCAL nSoma           := 0
LOCAL nSomaRec        := 0 
LOCAL nPagDia         := 0
LOCAL nPagDiv         := 0   
LOCAL nQtDocumento    := 0
LOCAL nQtRec          := 0 
LOCAL nQtPagDiv       := 0
LOCAL nQtPagDia       := 0
LOCAL aTodos          := {}
LOCAL lVideo          := OK
LOCAL cTitular
LOCAL oRelato
FIELD Caixa
FIELD Tipo
FIELD Cre
FIELD Deb
FIELD Data
FIELD Hist
FIELD Docnr
FIELD Codi
FIELD Vlr
FIELD Vcto

oMenu:Limpa()
IF nOpcao = NIL
	IF cCaixa = Nil
		cCaixa := Space(4)
		IF !VerSenha( @cCaixa )
			AreaAnt( Arq_Ant, Ind_Ant )
			ResTela( cScreen )
			Return
		EndIF
	EndIF
EndIF
IF !lVisualizarDetalheCaixa
	IF !PedePermissao( SCI_VISUALIZAR_DETALHE_CAIXA )
		Restela( cScreen )
		Return
	EndIF
EndIF

WHILE OK
	oMenu:Limpa()
	M_Title("ESCOLHA UMA OPCAO")
	nChoice := FazMenu( 03, 10, aMenu )
	
	if nChoice = 0
		Return NIL
	endif

   MaBox( 10, 10, 13, 37 )
   @ 11, 11 Say "Data Inicial : " Get dIni Pict PIC_DATA
   @ 12, 11 Say "Data Final   : " Get dFim Pict PIC_DATA Valid dFim >= dIni
   Read
   IF LasTkey() = ESC
      Loop
   EndIF
	lVideo := Alerta("Imprimir em qual saida?", {"Saida em Video", "Saida em Impressora"}) == 1	
   IF nOpcao = NIL
      Vendedor->(Order( VENDEDOR_CODIVEN ))
      Vendedor->(DbSeek( cCaixa ))
      cTitular := Vendedor->Nome
   EndIF
   cIni    := Dtoc( dIni )
   cFim    := Dtoc( dFim )
   IF cTipoDetalhe = 1
      cTitulo := "RELATORIO EMISSAO DE RECIBO EM CARTEIRA REF &cIni. A &cFim. EMITIDO POR: " + cCaixa + " - " + Trim( cTitular )
   ElseIF cTipoDetalhe = 2
      cTitulo := "RELATORIO EMISSAO DE RECIBO EM BANCO REF &cIni. A &cFim. EMITIDO POR: " + cCaixa + " - " + Trim( cTitular )
   ElseIF cTipoDetalhe = 3
      cTitulo := "RELATORIO EMISSAO DE RECIBO DE OUTROS REF &cIni. A &cFim. EMITIDO POR: " + cCaixa + " - " + Trim( cTitular )
   EndIF
   Mensagem("Aguarde... Verificando Movimento.")
   Area("Recibo")
   Recibo->(Order( RECIBO_DATA ))
   Sx_ClrScope( S_TOP )
   Sx_ClrScope( S_BOTTOM )
   Recibo->(DbGoTop())
   Sx_SetScope( S_TOP, dIni)
   Sx_SetScope( S_BOTTOM, dFim )
   Recibo->(DbGoTop())	
		
   nSoma        := 0
	nSomaRec     := 0
	nPagDia      := 0
	nPagDiv      := 0
	nQtRec       := 0
   nQtDocumento := 0
	nQtPagDiv    := 0
	nQtPagDia    := 0
	aTodos       := {}	
	
	oMenu:Limpa()	
   oRelato				:= TRelatoNew()	
	oRelato:Tamanho	:= 132
	oRelato:NomeFirma := AllTrim(oAmbiente:xFanta)
	oRelato:Sistema	:= SISTEM_NA3
	oRelato:Titulo 	:= cTitulo
	oRelato:Cabecalho := "TIPO    CODI NOME CLIENTE                     DOCTO N§     VCTO    PAGTO     HORA  RECEBIDO CAIXA HISTORICO"
	
	if !lVideo
		IF !Instru80()
			Sx_ClrScope( S_TOP )
			Sx_ClrScope( S_BOTTOM )
			AreaAnt( Arq_Ant, Ind_Ant )
			ResTela( cScreen )
			Return
		EndIF
		cTela := Mensagem("Aguarde, Imprimindo Relatorio de Recibos.")
		oRelato:PrintOn(Chr(ESC) + "C" + Chr(33) + PQ )
		//oRelato:Cabecalho := "TIPO    CODI NOME CLIENTE                     DOCTO N§     VCTO    PAGTO     HORA  RECEBIDO CAIXA HISTORICO"
		oRelato:Inicio()         
	else
		cTela := Mensagem("Aguarde, Imprimindo Relatorio de Recibos.")
		aadd( aTodos, Padc(oRelato:Titulo, oRelato:Tamanho))
		aadd( aTodos, Repl( oRelato:Separador, oRelato:Tamanho ))
		aadd( aTodos, "TIPO    CODI NOME CLIENTE                     DOCTO N§     VCTO    PAGTO     HORA  RECEBIDO CAIXA HISTORICO")			
		aadd( aTodos, Repl( oRelato:Separador, oRelato:Tamanho ))
	endif		
	WHILE Recibo->(!Eof()) //.AND. Rel_Ok()      
		if !lVideo
			IF oRelato:RowPrn = 0		   
				oRelato:Cabec()         
			endif	
      endIF
		
      IF Recibo->Tipo == "BAIXAS"
         Recibo->(DbSkip(1))
         Loop
      EndIF

      IF cTipoDetalhe == 1
         IF Recibo->Tipo == "RECBCO" .OR. Recibo->Tipo == "RECOUT"
            Recibo->(DbSkip(1))
            Loop
         EndIF
      EndIF

      IF cTipoDetalhe == 2
         IF Recibo->Tipo != "RECBCO"
            Recibo->(DbSkip(1))
            Loop
         EndIF
      EndIF

      IF cTipoDetalhe == 3
         IF Recibo->Tipo != "RECOUT"
            Recibo->(DbSkip(1))
            Loop
         EndIF
      EndIF
		
		nVlr := Recibo->Vlr
		
		if nChoice = 2 // Somente Creditos
		   if nVlr < 0
				Recibo->(DbSkip(1))
				Loop
			endif
		endif	
		if nChoice = 3 // Somente Debitos
		   if nVlr >= 0
				Recibo->(DbSkip(1))
				Loop
			endif
		endif	

      nQtDocumento++
      nSoma += nVlr
		
		if     Recibo->Tipo = "PAGDIA"
		   nQtPagDia++
		   nPagDia += nVlr
		elseif Recibo->Tipo = "PAGDIV"
		   nQtPagDiv++
		   nPagDiv += nVlr
		else
		   nQtRec++
		   nSomaRec += nVlr
		endif		
		cLine := Recibo->( Tipo + ' ' + Codi + ' ' + Left(Nome,31) + ' ' + Docnr + ' ' + Dtoc(Vcto) + ' ' + Dtoc(Data) + ' ' + Hora + ' ' + Tran( nVlr, "@E 99,999.99") + ' ' + Left(Usuario,5) + ' ' + Left(Hist,34))
		if !lVideo
			Recibo->( Qout( Tipo, Codi, Left(Nome,31), Docnr, Vcto, Data, Hora, Tran( nVlr, "@E 99,999.99"), Left(Usuario,5), Left(Hist,34)))
		else	
			aadd( aTodos, cLine )
		endif
		Recibo->(DbSkip(1))
		if !lVideo
			IF ++oRelato:RowPrn >= 25
				oRelato:Eject()
			endif	
		endif	
   EndDo
	if !lVideo
		Qout()
		Qout("TOTAL RECEBIMENTOS......:", StrZero( nQtRec,       4) + Space(48) + NG + Tran( nSomaRec, "@E 9,999,999.99") + NR)
		Qout("TOTAL DIARIAS PAGAS.....:", StrZero( nQtPagDia,    4) + Space(48) + NG + Tran( nPagDia,  "@E 9,999,999.99") + NR)
		Qout("TOTAL DESPESAS DIVERSAS.:", StrZero( nQtPagDiv,    4) + Space(48) + NG + Tran( nPagDiv,  "@E 9,999,999.99") + NR)
		Qout("TOTAL REGISTROS.........:", StrZero( nQtDocumento, 4) + Space(48) + NG + Tran( nSoma,    "@E 9,999,999.99") + NR)
		Qout()
		Qout()
		Qout(Repl("_",40))
		Qqout(Space(06) + Repl("_",40))
		Qqout(Space(06) + Repl("_",40))
		Qout(Space(16) + "CAIXA")
		Qqout(Space(42) + "CONFERENTE")
		Qqout(Space(34) + "TESOUREIRO")
		oRelato:Eject()
		ORelato:PrintOff(Chr(ESC) + "C" + Chr(66))
		ResTela( cTela )
	else	   	
		aadd( aTodos, ' ')
		aadd( aTodos, "TOTAL RECEBIMENTOS......:" + '  ' + StrZero( nQtRec,       4) + Space(48) + Tran( nSomaRec, "@E 9,999,999.99"))
		aadd( aTodos, "TOTAL DIARIAS PAGAS.....:" + '  ' + StrZero( nQtPagDia,    4) + Space(48) + Tran( nPagDia,  "@E 9,999,999.99"))
		aadd( aTodos, "TOTAL DESPESAS DIVERSAS.:" + '  ' + StrZero( nQtPagDiv,    4) + Space(48) + Tran( nPagDiv,  "@E 9,999,999.99"))
		aadd( aTodos, "TOTAL REGISTROS.........:" + '  ' + StrZero( nQtDocumento, 4) + Space(48) + Tran( nSoma,    "@E 9,999,999.99"))
		aadd( aTodos, ' ')
		aadd( aTodos, ' ')
		aadd( aTodos, Repl("_",40) + ' ' + Space(06) + Repl("_",40) + ' ' + Space(06) + Repl("_",40))
		aadd( aTodos, Space(16) + "CAIXA" + ' ' + Space(42) + "CONFERENTE" + ' ' + Space(34) + "TESOUREIRO")
		ResTela( cTela )
		M_Title( "ESC Retorna ")
		FazMenu( 00, 00, aTodos)	
	endif	
   Sx_ClrScope( S_TOP )
   Sx_ClrScope( S_BOTTOM )
EndDO
AreaAnt( Arq_Ant, Ind_Ant )
ResTela( cScreen )
Return

def Retorno()
*************
   LOCAL cCodigo
   LOCAL Data_Limite
   LOCAL cExecucoes
   LOCAL nNumero
   LOCAL nTemp
   LOCAL cSenha
   LOCAL nCrc
   LOCAL cEmpresa
   LOCAL lTemDebito := FALSO
   LOCAL cCodi      := Space(05)
   LOCAL nVersao    := 2  //1=Velha 2=Nova
   LOCAL cDia       := "01"
   LOCAL cMesRet    := StrZero( Month( Date())+1,2)
   LOCAL cAno       := StrZero( Year( Date()), 4 )
   LOCAL aDias      := {'28','29','30','31'}

   while true
      oMenu:Limpa()
      SetKey( F5, NIL )
      MaBox( 10, 01, 14, MaxCol()-1 )
      lTemDebito  := FALSO
      cCodi       := Space(05)
      cDia        := "01"
      cMesRet     := StrZero( Month( Date())+1,2)
      cAno        := StrZero( Year( Date()), 4 )
      cEmpresa    := Space(40)
      cCodigo     := Space(10)
      cDia        := StrZero(Day(Date()),2)
      cMesRet     := Month( Date())+1
      cAno        := Year( Date())
      IF Ascan( aDias, cDia ) > 0
         cMesRet ++
         IF cMesRet > 12
            cMesRet = 1
            cAno  ++
         EndIF
      EndIF
      cDia        := '01'
      cMesRet     := StrZero( cMesRet, 2 )
      cAno        := StrZero( cAno, 4)
      cData       := cDia + "/" + cMesRet +  "/" + cAno
      Data_Limite := Ctod( cData )
      cExecucoes	:= Right( StrTran( Time(), ":"),2)
      cExecucoes	+= Right( StrTran( Time(), ":"),2)
      @ 11, 02 Say "Cliente..................:" Get cCodi Pict PIC_RECEBER_CODI Valid ;
                                                RecErrado( @cCodi,, Row(), Col()+1 ) .AND. ;
                                                ClienteSci( cCodi ) .AND. ;
                                                PosicaoDebito( cCodi, @lTemDebito, @Data_Limite ) .AND. ;
                                                UltRetorno( cCodi )
      @ 12, 02 Say "Codigo Interno Fornecido.:" Get cCodigo  Pict "@R 999.999.9999" Valid VerRetorno( cCodigo )
      @ 13, 02 Say "Data Limite de Execucoes.:" Get Data_Limite Pict PIC_DATA Valid RetLimite( @Data_Limite, lTemDebito  )
      Read
      if LastKey() = ESC
         SetKey( F5, {|| PrecosConsulta()})
         return nil
      EndIF

      // Monte a Senha Para calculo

      cData_Limite := StrTran( Dtoc( Data_Limite ), "/" )
      cSenha		 := cData_Limite + cExecucoes

      // Calcula o Crc

      nCrc := 0
      nX   := 0
      /*
      For Contador := 1 To 10
         nCrc += Val( SubStr( cCodigo, Contador, 1 )) * ;
                 Val( SubStr( cSenha, Contador, 1 )) + ;
                 Val( SubStr( cSenha, Contador, 1 ))
      Next
      */
      For nX := 1 To 10
         nCrc += Val( SubStr( cSenha,	nX, 1 )) * ;
                 Val( SubStr( cSenha,	nX, 1 )) + ;
                 Val( SubStr( cCodigo, nX, 1 ))
      Next
      cCrc := Right( StrZero( nCrc, 10),3)
      cSenha += cCrc
      Alert( "Codigo de Retorno " + Transform( cSenha, "@R 999.999.999.999.9"))
      Retorno->(DbGoBottom())
      nId := Retorno->Id
      nId++
      Receber->(Order( RECEBER_CODI ))
      Receber->(DbSeek( cCodi ))
      IF Retorno->(Incluiu())
         Retorno->Id 	  := nId
         Retorno->Codi	  := cCodi
         Retorno->Empresa := Receber->Nome
         Retorno->Interno := cCodigo
         Retorno->Codigo  := cSenha
         Retorno->Limite  := Data_Limite
         Retorno->Data	  := Date()
         Retorno->Versao  := nVersao
         Retorno->Hora	  := Time()
         Retorno->Nome	  := oAmbiente:xUsuario
         Retorno->Atualizado := Date()
         Retorno->(Libera())
      EndIF
   EndDo
endef

def RetLimite( Data_Limite, lTemDebito )
****************************************
   if LastKey() = UP
      return true
   elseif lTemDebito
      Data_Limite := Date() + 1
      return true
   elseif Data_Limite < Date()
      ErrorBeep()
      Alerta("Erro: Data Limite nao pode ser antes de Hoje.")
      return false
   endif
   return true
endef   

def UltRetorno( xCliente )
***************************
   LOCAL cScreen			:= SaveScreen()
   LOCAL Arq_Ant			:= Alias()
   LOCAL Ind_Ant			:= IndexOrd()
   LOCAL nSoma 			:= 0
   LOCAL nChoice			:= 0
   LOCAL lAtraso			:= FALSO

   Retorno->(Order( RETORNO_CODI ))
   IF Retorno->(DbSeek( xCliente ))
      While Retorno->Codi = xCliente
         IF Retorno->Limite > Date()
            ErrorBeep()
            MaBox( 00, 00, 09, MaxCol())
            Write( 01, 01, "Ja foi fornecido Codigo para " + Dtoc( Retorno->Limite ) + ". Verifique com o cliente as opcoes.")
            Write( 03, 01, "1 - O SCI esta sendo instalado pela 1¦ vez?")
            Write( 04, 01, "2 - Esta atualizando a versao do SCI?")
            Write( 05, 01, "3 - Esta instalando um novo terminal?")
            Write( 06, 01, "4 - A data do Sistema Operacional esta correta?")
            Write( 07, 01, "5 - O arquivo SCI.EXE esta com data diferente do DOS?")
            Write( 08, 01, "6 - Antecipacao de Codigo de Acceso?")
            Return( OK )
         EndIF
         Retorno->(DbSkip(1))
      EndDo
   endif
   return true
endef

def ClienteSci( xCliente )
**************************
   LOCAL cScreen			:= SaveScreen()
   LOCAL Arq_Ant			:= Alias()
   LOCAL Ind_Ant			:= IndexOrd()
   LOCAL lRetVal			:= false

   Receber->(Order( RECEBER_CODI ))
   IF Receber->(DbSeek( xCliente ))
      IF Receber->Sci = OK
         lRetVal := true
      Else
         ErrorBeep()
         Alerta('Erro: Nao nao tem Sistema Registrado.')
      EndIF
   EndIF
   return lRetVal
endef   

Function PosicaoDebito( xCliente, lTemDebito, Data_Limite )
***********************************************************
LOCAL cScreen			:= SaveScreen()
LOCAL Arq_Ant			:= Alias()
LOCAL Ind_Ant			:= IndexOrd()
LOCAL nSoma 			:= 0
LOCAL nChoice			:= 0
LOCAL lAtraso			:= FALSO
LOCAL aMenu 			:= {"Cancelar", "Continuar", "Consultar"}

Recemov->(Order( RECEMOV_CODI ))
IF Recemov->(DbSeek( xCliente ))
	While Recemov->Codi = xCliente
		IF Recemov->Vcto < Date()
			lAtraso := OK
			Exit
		EndIF
		Recemov->(DbSkip(1))
	EndDo
EndIF
IF lAtraso
	Data_Limite := Date() + 1
	lTemDebito	:= OK
	MaBox( 00, 00, 04, MaxCol())
	Write( 01, 01, "1-Informe ao cliente que ele se encontra em atraso")
	Write( 02, 01, "  e que o sistema so permite liberar codigo de acesso")
	Write( 03, 01, "  somente para 1 dia, ate regularizacao do debito.")
	ErrorBeep()
	WHILE OK
		M_Title("INFORMA: CLIENTE EM ATRASO. ESCOLHA UMA OPCAO")
		nChoice := FazMenu( 15, 10, aMenu)
		Do Case
		Case nChoice = 0 .OR. nChoice = 1
		  ResTela( cScreen )
		  Return( FALSO )
		Case nChoice = 2
			ResTela( cScreen )
			Return( OK )
		Case nChoice = 3
			PosiReceber( 1, xCliente )
		EndCase
	EndDo
EndIF
Return( OK )

def VerRetorno( cCodigo )
*************************
   LOCAL nLen := Len( AllTrim( StrTran( cCodigo, ".")))

   IF LastKey() = UP
      return true
   ElseIF Empty( cCodigo )
      ErrorBeep()
      Alerta("Erro: Campo nao Pode ser Vazio")
      return false
   ElseIF nLen < 10
      ErrorBeep()
      Alerta("Erro: Codigo Interno Invalido.")
      return false
   EndIF
   return true
endef

def AbreEmpresa()
*****************
   set defa to (oAmbiente:xBase)
   if !UsaArquivo("EMPRESA")
      set defa to (oAmbiente:xBaseDados)
      return false
   EndIF
   set defa to (oAmbiente:xBaseDados)
   return true
endef   

def MoviAnual()
****************
   LOCAL GetList := {}
   LOCAL cScreen := SaveScreen()
   LOCAL nAnoIni := 1990
   LOCAL nAnoFim := Year( Date()-1)

   while true
      MaBox( 10, 10, 12, 40 )
      @ 11, 11 Say "Ano..........." Get nAnoIni Pict "9999" Valid nAnoIni >= 1
      Read
      if LastKey() = ESC
         return(ResTela( cScreen ))
      endif
      
      if !AbreEmpresa()
         return(ResTela( cScreen ))
     endif
     
     Empresa->(DbGoBottom())
     cCodi := StrZero( Val( Empresa->Codi)+1,4)
     
     if Empresa->(!Incluiu())
        Loop
     endif
     
     Empresa->Codi := cCodi
     Empresa->Nome := "MOVIMENTO DO ANO " + StrZero( nAnoIni,4 )
     Empresa->(Libera())
     CriaEmpresa( cCodi )
     Area("Chemov")
   EndDo
endef   

def CriaEmpresa( cCodi )
************************
   LOCAL cDir := oAmbiente:xRoot + _SLASH_ + "backup" + cCodi
   
   oAmbiente:xBaseDados := cDir
   set defa to (cDir)
   MkDir( cDir )
   set defa to (oAmbiente:xBaseDados)
   return nil
endef   

def AutoCaixa()
*:-------------
   LOCAL GetList	:= {}
   LOCAL cScreen	:= SaveScreen()
   LOCAL cDeb_Deb := ""
   LOCAL cDeb_Cre := ""
   LOCAL cCre_Deb := ""
   LOCAL cCre_Cre := ""
   LOCAL xDbf		:= FTempName("t*.tmp")
   LOCAL cCaixa	:= Space(04)
   LOCAL cCodiIni := Space(04)
   LOCAL cCodiFim := Space(04)

   IF !UsaArquivo("CHEQUE") ; Break ; EndIF
   IF !UsaArquivo("CHEMOV") ; Break ; EndIF

   MaBox( 10, 10, 14, 40 )
   @ 11, 11 Say "Conta Caixa...." Get cCaixa   Pict "####" Valid Cheerrado( @cCaixa )
   @ 12, 11 Say "Conta Inicial.." Get cCodiIni Pict "####" Valid Cheerrado( @cCodiIni )
   @ 13, 11 Say "Conta Final...." Get cCodiFim Pict "####" Valid Cheerrado( @cCodiFim )
   Read
   IF LastKey() = ESC
      ResTela( cScreen )
      Return
   EndIF
   ErrorBeep()
   IF !Conf("Pergunta: Deseja continuar a operacao ?")
      ResTela( cScreen )
      Return
   EndIF
   Area("CHEMOV")
   Copy Stru To ( xDbf )
   Use ( xDbf ) Alias xAlias Exclusive New
   Chemov->(Order( CHEMOV_CODI ))
   Area("Cheque")
   Cheque->(Order( CHEQUE_CODI ))
   Cheque->(DbSeek( cCodiIni ))
   Mensagem("Informa: Processando Movimento")
   WHILE Cheque->Codi >= cCodiIni .AND. Cheque->Codi <= cCodiFim .AND. Rel_Ok()
      cCodi := Cheque->Codi
      IF cCodi == cCaixa
         Cheque->(DbSkip(1))
         Loop
      EndIF
      cDeb_Deb := Cheque->Deb_Deb
      cDeb_Cre := Cheque->Deb_Cre
      cCre_Deb := Cheque->Cre_Deb
      cCre_Cre := Cheque->Cre_Cre
      IF Empty( cDeb_Deb )
         IF Empty( cDeb_Cre )
            IF Empty( cCre_Deb )
               IF Empty( cCre_Cre )
                  Cheque->(DbSkip(1))
                  Loop
               EndIF
            EndIF
         EndIF
      EndIF
      IF Chemov->(DbSeek( cCodi ))
         WHILE Chemov->Codi = cCodi
            nReg := Chemov->(Recno())
            IF Chemov->Deb <> 0
               nVlr := Chemov->Deb
               IF !Empty( cDeb_Cre )
                  Deb_Cre( cCaixa, nVlr )
               EndIF
               IF !Empty( cDeb_Deb )
                  Deb_Deb( cCaixa, nVlr )
               EndIF
            ElseIF Chemov->Cre <> 0
               nVlr := Chemov->Cre
               IF !Empty( cCre_Cre )
                  Cre_Cre( cCaixa, nVlr )
               EndIF
               IF !Empty( cCre_Deb )
                  Cre_Deb( cCaixa,	nVlr )
               EndIF
            EndIF
            Chemov->(DbgoTo( nReg ))
            Chemov->(DbSkip(1))
         EndDo
      EndIF
      Cheque->(DbSkip(1))
   EndDo
endef

def Deb_Cre( cCaixa, nVlr )
***************************
   xAlias->(DbAppend())
   For nField := 1 To Chemov->(FCount())
      xAlias->(FieldPut( nField, Chemov->(FieldGet( nField ))))
   Next
   xAlias->Codi := cCaixa
   xAlias->Deb  := 0
   xAlias->Cre  := nVlr
   Chemov->(DbAppend())
   For nField := 1 To xAlias->(FCount())
      Chemov->(FieldPut( nField, xAlias->(FieldGet( nField ))))
   Next
   xAlias->(__DbZap())
   return nil

def Deb_Deb( cCaixa, nVlr )
***************************
   xAlias->(DbAppend())
   For nField := 1 To Chemov->(FCount())
      xAlias->(FieldPut( nField, Chemov->(FieldGet( nField ))))
   Next
   xAlias->Codi := cCaixa
   xAlias->Cre  := 0
   xAlias->Deb  := nVlr
   Chemov->(DbAppend())
   For nField := 1 To xAlias->(FCount())
      Chemov->(FieldPut( nField, xAlias->(FieldGet( nField ))))
   Next
   xAlias->(__DbZap())
   return nil
endef   
   
def Cre_Cre( cCaixa, nVlr )
***************************
   xAlias->(DbAppend())
   For nField := 1 To Chemov->(FCount())
      xAlias->(FieldPut( nField, Chemov->(FieldGet( nField ))))
   Next
   xAlias->Codi := cCaixa
   xAlias->Cre  := nVlr
   xAlias->Deb  := 0
   Chemov->(DbAppend())
   For nField := 1 To xAlias->(FCount())
      Chemov->(FieldPut( nField, xAlias->(FieldGet( nField ))))
   Next
   xAlias->(__DbZap())
   return nil
endef   

def Cre_Deb( cCaixa, nVlr )
***************************
   xAlias->(DbAppend())
   For nField := 1 To Chemov->(FCount())
      xAlias->(FieldPut( nField, Chemov->(FieldGet( nField ))))
   Next
   xAlias->Codi := cCaixa
   xAlias->Cre  := 0
   xAlias->Deb  := nVlr
   Chemov->(DbAppend())
   For nField := 1 To xAlias->(FCount())
      Chemov->(FieldPut( nField, xAlias->(FieldGet( nField ))))
   Next
   xAlias->(__DbZap())
   return nil
endef   

def ZeraCaixa()
***************
   LOCAL GetList	:= {}
   LOCAL cScreen	:= SaveScreen()
   LOCAL cCaixa	:= Space(04)

   IF !UsaArquivo("CHEQUE") ; Break ; EndIF
   IF !UsaArquivo("CHEMOV") ; Break ; EndIF
   MaBox( 10, 10, 12, 40 )
   @ 11, 11 Say "Codigo Conta..." Get cCaixa   Pict "####" Valid Cheerrado( @cCaixa ) .AND. VerZeraTem( @cCaixa )
   read
   if LastKey() = ESC
      return(ResTela( cScreen ))
   endif
   ErrorBeep()
   IF !Conf("Pergunta: Deseja continuar a operacao ?")
      return(ResTela( cScreen ))
   EndIF
   ErrorBeep()
   IF !Conf("Pergunta: Tem Certeza ?")
      return(ResTela( cScreen ))
   EndIF
   Area("CHEMOV")
   Chemov->(Order( CHEMOV_CODI ))
   if Chemov->(DbSeek( cCaixa ))
      oMenu:Limpa()
      IF Chemov->(TravaArq())
         Mensagem("Aguarde, Zerando conta : " + cCaixa )
         WHILE Chemov->Codi == cCaixa
            Chemov->(DbDelete())
            Chemov->(DbSkip(1))
         EndDo
         Chemov->(Libera())
         Alerta("Informa: Zeramento Completado.")
      EndIF
   else
      oMenu:Limpa()
      Alerta("Informa: Nenhum movimento a zerar.")
   EndIF
   return(ResTela( cScreen ))
endef   

Function VerZeraTem( cCaixa )
*****************************
LOCAL cScreen := SaveScreen()

Chemov->(Order( CHEMOV_CODI ))
IF Chemov->(!DbSeek( cCaixa ))
	cCaixa := Space( 04 )
	oMenu:Limpa()
	ErrorBeep()
	Alerta("Informa: Nenhum movimento a zerar.")
	ResTela( cScreen )
	Return( FALSO )
EndIF
Return( OK )

Proc ProtegerDbf( lProteger, lSemPergunta )
*******************************************
LOCAL cScreen	  := SaveScreen()
LOCAL aBase 	  := {}
LOCAL aBaseDados := {}
LOCAL OldDir	  := FCurdir()
LOCAL nX
LOCAL nLen

oMenu:Limpa()
IF lSemPergunta = NIL
	MaBox( 10, 20, 12, 48 )
	@ 11, 21 Say "Senha...: "
	Passe := Senha( 11, 33, 11 )
	IF Empty( Passe) .OR. Passe != '63771588'
		ErrorBeep()
		Alerta('Erro: Senha invalida. Verifique com o supervisor.')
		Restela( cScreen )
		Return
	EndIF
	ErrorBeep()
	IF !Conf('Pergunta: Tem Certeza ?')
		ResTela( cScreen )
		Return
	EndIF
EndIF
Mensagem('Aguarde, Alterando dados.')
Aadd( aBaseDados, "lista.dbf")
Aadd( aBaseDados, "saidas.dbf")
Aadd( aBaseDados, "receber.dbf")
Aadd( aBaseDados, "repres.dbf")
Aadd( aBaseDados, "grupo.dbf")
Aadd( aBaseDados, "subgrupo.dbf")
Aadd( aBaseDados, "vendedor.dbf")
Aadd( aBaseDados, "vendemov.dbf")
Aadd( aBaseDados, "recemov.dbf")
Aadd( aBaseDados, "nota.dbf")
Aadd( aBaseDados, "entradas.dbf")
Aadd( aBaseDados, "pagar.dbf")
Aadd( aBaseDados, "pagamov.dbf")
Aadd( aBaseDados, "taxas.dbf")
Aadd( aBaseDados, "pago.dbf")
Aadd( aBaseDados, "recebido.dbf")
Aadd( aBaseDados, "cheque.dbf")
Aadd( aBaseDados, "chemov.dbf")
Aadd( aBaseDados, "chepre.dbf")
Aadd( aBaseDados, "forma.dbf")
Aadd( aBaseDados, "cursos.dbf")
Aadd( aBaseDados, "cursado.dbf")
Aadd( aBaseDados, "regiao.dbf")
Aadd( aBaseDados, "cep.dbf")
Aadd( aBaseDados, "ponto.dbf")
Aadd( aBaseDados, "servidor.dbf")
Aadd( aBaseDados, "printer.dbf")
Aadd( aBaseDados, "entnota.dbf")
Aadd( aBaseDados, "conta.dbf")
Aadd( aBaseDados, "subconta.dbf")
Aadd( aBaseDados, "retorno.dbf")
Aadd( aBaseDados, "funcimov.dbf")
Aadd( aBaseDados, "grpser.dbf")
Aadd( aBaseDados, "servico.dbf")
Aadd( aBaseDados, "cortes.dbf")
Aadd( aBaseDados, "movi.dbf")
Aadd( aBaseDados, "recibo.dbf")
Aadd( aBaseDados, "agenda.dbf")
Aadd( aBaseDados, "cm.dbf")
//Aadd( aBase, "EMPRESA.DBF")
//Aadd( aBase, "SCI.DBF")

FechaTudo()
FChDir( oAmbiente:xBaseDados )
nLen := Len( aBaseDados )
For nX := 1 To nLen
//  oProtege:Protege( aBaseDados[nX])
  IF lProteger
	  oProtege:Encryptar( aBaseDados[nX])
  Else
	  oProtege:Decryptar( aBaseDados[nX])
  EndIF
Next
FChDir( oAmbiente:xBase )
nLen := Len( aBase )
For nX := 1 To nLen
//  oProtege:Protege( aBase[nX])
  IF lProteger
	  oProtege:Encryptar( aBase[nX])
  Else
	  oProtege:Decryptar( aBase[nX])
  EndIF
Next
FChDir( OldDir )
FechaTudo()
ResTela( cScreen )
Return
	
Function PickTipoVenda( cPick )
	LOCAL aList 	 := { "Normal", "Conta Corrente"}
	LOCAL aSituacao := { "N", "S" }
	LOCAL cScreen	 := SaveScreen()
	LOCAL nChoice

	IF Ascan( aSituacao, cPick ) != 0
		Return( OK )
	EndIF
	MaBox( 11, 01, 14, 44, NIL, NIL, Roloc( Cor()) )
	IF (nChoice := AChoice( 12, 02, 13, 43, aList )) != 0
		cPick := aSituacao[ nChoice ]
	EndIf
	ResTela( cScreen )
	Return( OK )
endef
	
def lPickSimNao( lPick )
************************
   LOCAL aList 	 := { "Sim", "Nao"}
   LOCAL aSituacao := { true, false }
   LOCAL cScreen	 := SaveScreen()
   LOCAL nPos		 := 0
   LOCAL nChoice

   nPos := Ascan( aSituacao, lPick )
   MaBox( 11, 01, 14, 44, NIL, NIL, Roloc( Cor()) )
   if (nChoice := AChoice( 12, 02, 13, 43, aList, NIL, NIL, NIL, 2 )) != 0
      lPick := aSituacao[ nChoice ]
   endif
   resTela( cScreen )
   return true
endef   

def PickSimNao( cPick )
************************
   LOCAL aList 	 := { "Sim", "Nao"}
   LOCAL aSituacao := { "S", "N" }
   LOCAL cScreen	 := SaveScreen()
   LOCAL nChoice

   IF Ascan( aSituacao, cPick ) != 0
      return true
   EndIF
   MaBox( 11, 01, 14, 44, NIL, NIL, Roloc( Cor()) )
   IF (nChoice := AChoice( 12, 02, 13, 43, aList )) != 0
      cPick := aSituacao[ nChoice ]
   EndIf
   ResTela( cScreen )
   return true
endef   

Function ConfBaseDados()
************************
LOCAL cScreen		:= SaveScreen()
LOCAL GetList		:= {}
LOCAL nChoice		:= 0
LOCAL aMenu 		:= {"Saidas", ;
							 "Entradas",;
							 "financeiro",;
							 "Nota Fiscal",; 
							 "ECF Cupom Fiscal",;
							 "Relatorios",;
							 "Arquivos de Impressao",;
							 "Prevenda",; 
							 "Servidor banco de Dados",; 
							 "Geral"}

WHILE OK
	oMenu:Limpa()
	M_Title("Configuracao da Base de Dados")
	nChoice := FazMenu( 05, 10, aMenu )
	Do Case
	Case nChoice = 0
      FChDir( oAmbiente:xBaseDados )
      Set Defa To (oAmbiente:xBaseDados)      
		ResTela( cScreen )
		Return
	Case nChoice = 1
		ConfFaturamento()
	Case nChoice = 2
		ConfEntradas()
	Case nChoice = 3
		ConfReceber()
	Case nChoice = 4
		ConfNota()
	Case nChoice = 5
		ConfEcf()
	Case nChoice = 6
		ConfRelatorios()
	Case nChoice = 7
		ConfImpressao()
	Case nChoice = 8
		ConfPrevenda()
	Case nChoice = 9
		ConfServidorBcoDados()		
	Case nChoice = 10
		ConfGeral()
	EndCase
EndDo

def ConfFaturamento()
**********************
   LOCAL cScreen		:= SaveScreen()
   LOCAL GetList		:= {}
   LOCAL cMens1		:= Space(40)
   LOCAL cMens2		:= Space(40)
   LOCAL cMens3		:= Space(40)
   LOCAL cMens4		:= Space(40)
   LOCAL cCodi 		:= Right( oAmbiente:xBaseDados, 4 )
   LOCAL xIndiceNtx	:= "empresa1." + CEXT
   LOCAL xIndiceNsx	:= "empresa." + CEXT
   LOCAL nSegundos	:= 2
   LOCAL lFechado 	:= OK
   LOCAL cPath 		:= oAmbiente:xBasedados
   LOCAL nItens		:= 20
   LOCAL cInscMun 	:= Space(15)
   LOCAL nIss			:= 0
   LOCAL cAutoFatura
   LOCAL cAutoDocumento
   LOCAL cAltDescricao
   LOCAL cTipoVenda
   LOCAL cPrecoTicket
   LOCAL cPrecoPrevenda
   LOCAL cSerieProduto
   LOCAL cDuplicidade
   LOCAL nOrderTicket
   LOCAL cZerarDesconto
   LOCAL cRamo
   LOCAL cPvRamo
   LOCAL cPvCabec
   LOCAL cCabecIni
   LOCAL cMinimoMens
   LOCAL cAutoEmissao
   LOCAL cAutoDesconto
   LOCAL cAutoLiquido
   LOCAL cAutoFecha
   LOCAL cEditarQuant
   LOCAL cFantaCodebar
   LOCAL cEndeFir  := XENDEFIR + ' - ' + XFONE + ' - ' + XCCIDA + '/' + XCESTA
   
   Set Defa To ( oAmbiente:xRoot )
   IF !NetUse("EMPRESA", MULTI, nSegundos, lFechado )
      Set Defa To ( cPath )
      ResTela( cScreen )
      Return
   EndIF
   #IFDEF FOXPRO
      DbSetIndex( xIndiceNsx )
   #ELSE
      DbSetIndex( xIndiceNtx )
   #ENDIF
   */

   WHILE OK
      Area("Empresa")
      Empresa->(Order( EMPRESA_CODI ))
      Empresa->(DbSeek( cCodi ))
      oMenu:Limpa()
      cMens1			:= Empresa->Mens1
      cMens2			:= Empresa->Mens2
      cMens3			:= Empresa->Mens3
      cMens4			:= Empresa->Mens4
      nItemNff 		:= Empresa->ItemNff
      cInscMun 		:= Empresa->InscMun
      nIss				:= Empresa->Iss
      cEditarQuant   := IF( oIni:ReadBool('sistema','editarquant', FALSO), "S", "N")
      cAutoFecha		:= IF( oIni:ReadBool('sistema','autofecha', FALSO), "S", "N")
      cAutoLiquido	:= IF( oIni:ReadBool('sistema','autoliquido', FALSO ), "S", "N")
      cAutoDesconto	:= IF( oIni:ReadBool('sistema','autodesconto', FALSO ), "S", "N")
      cAutoEmissao	:= IF( oIni:ReadBool('sistema','autoemissao', FALSO ), "S", "N")
      cAutoFatura 	:= IF( oIni:ReadBool('sistema','autofatura', OK ), "S", "N")
      cAutoDocumento := IF( oIni:ReadBool('sistema','autodocumento', OK ), "S", "N")
      cAltDescricao	:= IF( oIni:ReadBool('sistema','alterardescricao', FALSO ), "S", "N")
      cTipoVenda		:= oIni:ReadString('sistema',  'tipovenda', "N")
      cPrecoTicket	:= IF( oIni:ReadBool('sistema','precoticket', OK ), "S", "N")
      cPrecoPrevenda := IF( oIni:ReadBool('sistema','precoprevenda', OK ), "S", "N")
      cSerieProduto	:= IF( oIni:ReadBool('sistema','serieproduto', FALSO ), "S", "N")
      cDuplicidade	:= IF( oIni:ReadBool('sistema','duplicidade', FALSO ), "S", "N")
      nOrderTicket	:= oIni:ReadInteger('sistema','orderticket', 1 )
      cZerarDesconto := IF( oIni:ReadBool('sistema','zerardesconto', FALSO ), "S", "N")
      cMinimoMens 	:= IF( oIni:ReadBool('sistema','minimomens', FALSO ), "S", "N")
      cPvCabec       := Trim( oIni:ReadString('sistema', 'prilinpv', Left( oAmbiente:xFanta,40)))
      cPvCabec       += Space( 40 - Len( Trim( cPvCabec )))
      cPvRamo        := Trim( oIni:ReadString('sistema', 'seglinpv', Left( cEndefir,40)))
      cPvRamo        += Space( 40 - Len( Trim( cPvRamo )))
      cRamo          := Trim( oIni:ReadString('sistema', 'ramo', Left( cEndefir,40)))
      cRamo          += Space( 40 - Len( Trim( cRamo )))
      cCabecIni      := Trim( oIni:ReadString('sistema', 'cabec', Left( oAmbiente:xFanta,40)))
      cCabecIni      += Space( 40 - Len( Trim( cCabecIni )))
      cFantaCodeBar  := oIni:ReadString('sistema', 'fantacodebar', FANTACODEBAR + Space(10-Len(FANTACODEBAR)))
      oMenu:MaBox( 01, 01, 21, 78, "CONFIGURACAO - SAIDAS")
      @ 02, 	  02 Say "N§ Fatura Automatica.: " Get cAutoFatura    Pict "!"     Valid PickSimNao( @cAutoFatura )
      @ Row(),   41 Say "N§ Docto Automatico..: " Get cAutoDocumento Pict "!"     Valid PickSimNao( @cAutoDocumento )
      @ Row()+1, 02 Say "Data Emis Automatica.: " Get cAutoEmissao   Pict "!"     Valid PickSimNao( @cAutoEmissao )
      @ Row(),   41 Say "Desconto Automatico..: " Get cAutoDesconto  Pict "!"     Valid PickSimNao( @cAutoDesconto )
      @ Row()+1, 02 Say "Liquido Automatico...: " Get cAutoLiquido   Pict "!"     Valid PickSimNao( @cAutoLiquido )
      @ Row(),   41 Say "Fechamento Automatico: " Get cAutoFecha     Pict "!"     Valid PickSimNao( @cAutoFecha )
      @ Row()+1, 02 Say "Alterar Descricao....: " Get cAltDescricao  Pict "!"     Valid PickSimNao( @cAltDescricao  )
      @ Row(),   41 Say "Qtde Items Nff.......: " Get nItemNff       Pict "999"   Valid if( nItemNff <=0, ( ErrorBeep(), Alerta("Erro: Entrada invalida. Valor de 1 a 999"), FALSO ), OK )
      @ Row()+1, 02 Say "Tipo Venda Preferen..: " Get cTipoVenda     Pict "!"     Valid PickTipoVenda( @cTipoVenda )
      @ Row(),   41 Say "Preco Ticket Venda...: " Get cPrecoTicket   Pict "!"     Valid PickSimNao( @cPrecoTicket )
      @ Row()+1, 02 Say "N§ Serie Produto.....: " Get cSerieProduto  Pict "!"     Valid PickSimNao( @cSerieProduto )
      @ Row(),   41 Say "Permitir Duplicidade.: " Get cDuplicidade   Pict "!"     Valid PickSimNao( @cDuplicidade )
      @ Row()+1, 02 Say "Percentual ISS.......: " Get nIss           Pict "99.99"
      @ Row(),   41 Say "Inscricao Municipal..: " Get cInscMun       Pict "@!"
      @ Row()+1, 02 Say "Ordem Ticket Venda...: " Get nOrderTicket   Pict "9"     Valid PickTam({"Ordem Cadastro", "Ordem Codigo"}, {1,2}, @nOrderTicket )
      @ Row(),   41 Say "Zerar Desconto.......: " Get cZerarDesconto Pict "!"     Valid PickSimNao( @cZerarDesconto )
      @ Row()+1, 02 Say "Avisar Estoque Min...: " Get cMinimoMens    Pict "!"     Valid PickSimNao( @cMinimoMens )
      @ Row(),   41 Say "Preco Ticket Prevenda: " Get cPrecoPrevenda Pict "!"     Valid PickSimNao( @cPrecoPrevenda )
      @ Row()+1, 02 Say "Editar Quant Saida...: " Get cEditarQuant   Pict "!"     Valid PickSimNao( @cEditarQuant )
      @ Row()+1, 02 Say "Mens 1 Posicao Fat...: " Get cMens1         Pict "@!"
      @ Row()+1, 02 Say "Mens 2 Posicao Fat...: " Get cMens2         Pict "@!"
      @ Row()+1, 02 Say "Mens 3 Posicao Fat...: " Get cMens3         Pict "@!"
      @ Row()+1, 02 Say "Mens 4 Posicao Fat...: " Get cMens4         Pict "@!"
      @ Row()+1, 02 Say "Mens 1§ Lin Ticket...: " Get cCabecIni      Pict "@!"
      @ Row()+1, 02 Say "Mens 2§ Lin Ticket...: " Get cRamo          Pict "@!"
      @ Row()+1, 02 Say "Mens 1§ Lin Ticket PV: " Get cPvCabec       Pict "@!"
      @ Row()+1, 02 Say "Mens 2§ Lin Ticket PV: " Get cPvRamo        Pict "@!"
      @ Row()+1, 02 Say "Fantasia Codigo Barra: " Get cFantaCodeBar  Pict "@!"
      Read
      IF LastKey() = ESC
         Fechatudo()
         Set Defa To ( cPath )
         return(restela( cScreen ))         
      EndIF
      ErrorBeep()
      IF Conf("Pergunta: Confirma  ?")
         IF Empresa->(TravaReg())
            Empresa->Mens1 	 := cMens1
            Empresa->Mens2 	 := cMens2
            Empresa->Mens3 	 := cMens3
            Empresa->Mens4 	 := cMens4
            Empresa->ItemNff	 := nItemNff
            Empresa->InscMun	 := cInscMun
            Empresa->Iss		 := nIss
            aMensagem			 := { cMens1, cMens2, cMens3, cMens4 }
            aItemNff 			 := { nItemNff }
            aInscMun 			 := { cInscMun }
            aIss					 := { nIss }
            oAmbiente:RelatorioCabec := cCabecIni
            
            oIni:WriteBool( 'sistema',   'editarquant',    IF( cEditarQuant   = "S", OK, FALSO ))
            oIni:WriteBool( 'sistema',   'autofecha',      IF( cAutoFecha     = "S", OK, FALSO ))
            oIni:WriteBool( 'sistema',   'autoliquido',    IF( cAutoLiquido   = "S", OK, FALSO ))
            oIni:WriteBool( 'sistema',   'autodesconto',   IF( cAutoDesconto  = "S", OK, FALSO ))
            oIni:WriteBool( 'sistema',   'autoemissao',    IF( cAutoEmissao   = "S", OK, FALSO ))
            oIni:WriteBool( 'sistema',   'autofatura',     IF( cAutoFatura     = "S", OK, FALSO ))
            oIni:WriteBool( 'sistema',   'autodocumento',  IF( cAutoDocumento  = "S", OK, FALSO ))
            oIni:WriteBool( 'sistema',   'alterardescricao', IF( cAltDescricao = "S", OK, FALSO ))
            oIni:WriteBool( 'sistema',   'precoticket',   IF( cPrecoTicket  = "S", OK, FALSO ))
            oIni:WriteBool( 'sistema',   'precoprevenda', IF( cPrecoprevenda  = "S", OK, FALSO ))
            oIni:WriteBool( 'sistema',   'serieproduto',  IF( cSerieProduto = "S", OK, FALSO ))
            oIni:WriteBool( 'sistema',   'duplicidade',   IF( cDuplicidade  = "S", OK, FALSO ))
            oIni:WriteBool( 'sistema',   'zerardesconto', IF( cZerarDesconto = "S", OK, FALSO ))
            oIni:WriteBool( 'sistema',   'minimomens',    IF( cMinimoMens = "S", OK, FALSO ))
            oIni:WriteInteger( 'sistema','orderticket',    nOrderTicket )
            oIni:WriteString('sistema',  'tipovenda',      cTipoVenda )
            oIni:WriteString('sistema',  'cabec',          cCabecIni )
            oIni:WriteString('sistema',  'relatoriocabec', cCabecIni )
            oIni:WriteString('sistema',  'ramo',           cRamo )
            oIni:WriteString('sistema',  'prilinpv',       cPvCabec )
            oIni:WriteString('sistema',  'seglinpv',       cPvRamo )
            oIni:WriteString('sistema',  'fantacodebar',   cFantaCodebar )
            Empresa->(Libera())
         EndIF
      EndIF
   EndDo   
endef

def ConfReceber()
*****************
   LOCAL cScreen          := SaveScreen()
   LOCAL GetList          := {}
   LOCAL nCarencia        := 0
   LOCAL nDesconto        := 0
   LOCAL nDescApos        := 0
   LOCAL nDiasApos        := 0
   LOCAL nJuroMesSimples  := 0
   LOCAL nJuroMesComposto := 0
   LOCAL cMens1           := Space(40)
   LOCAL cMens2           := Space(40)
   LOCAL cMens3           := Space(40)
   LOCAL cMens4           := Space(40)
   LOCAL cCodi            := Right( oAmbiente:xBaseDados, 4 )
   LOCAL xIndiceNtx       := "empresa1." + CEXT
   LOCAL xIndiceNsx       := "empresa." + CEXT
   LOCAL nSegundos        := 2
   LOCAL lFechado         := OK
   LOCAL cPath            := oAmbiente:xBaseDados
   LOCAL aLista           := {"Dinheiro","Nota Promissoria","Duplicata", "Cheque a Vista",;
                              "Requisicao","Bonus","Cheque Predatado","Diferenca Rec/Pag",;
                              "Direta Livre", "Cartao"}
   LOCAL aTipo            := {"DH    ", "NP    ","DM    ","CH    ","RQ    ", "BN    ", "CP    ", "DF    ", "DL    ", "CT    " }
   LOCAL cAutoTipo
   LOCAL nBloqueio
   LOCAL cInativo

   Set Defa To ( oAmbiente:xRoot )
   IF !NetUse("EMPRESA", MULTI, nSegundos, lFechado )
      Set Defa To ( cPath )
      ResTela( cScreen )
      Return
   EndIF
   #IFDEF FOXPRO
      DbSetIndex( xIndiceNsx )
   #ELSE
      DbSetIndex( xIndiceNtx )
   #ENDIF
   WHILE OK
      Area("Empresa")
      Empresa->(Order( EMPRESA_CODI ))
      Empresa->(DbSeek( cCodi ))
      oMenu:Limpa()
      nCarencia        := Empresa->Carencia
      nJuroMesSimples  := Empresa->Juro
      nJuroMesComposto := 0
      nDesconto        := Empresa->Desconto
      nDescApos        := Empresa->DescApos
      nDiasApos        := Empresa->DiasApos
      nMulta           := Empresa->Multa
      nDiaMulta        := Empresa->DiaMulta
      cInativo         := if( oIni:ReadBool('sistema','MostrarClientesInativos'), "S", "N" )
      cAutoTipo        := oIni:ReadString('sistema','autotipo', 'NP    ')
      nBloqueio        := oIni:ReadInteger('sistema','bloqueio', 0 )
      nJuroMesComposto := oIni:ReadInteger('financeiro', 'JuroMesComposto', 0 )
      nComissao1       := oIni:ReadInteger('comissaoperiodo1','comissao', 2.5 )
      nDiaIni1         := oIni:ReadInteger('comissaoperiodo1','diaini',   0   )
      nDiaFim1         := oIni:ReadInteger('comissaoperiodo1','diafim',   15  )
      nComissao2       := oIni:ReadInteger('comissaoperiodo2','comissao', 4.0 )
      nDiaIni2         := oIni:ReadInteger('comissaoperiodo2','diaini',   16  )
      nDiaFim2         := oIni:ReadInteger('comissaoperiodo2','diafim',   30  )
      nComissao3       := oIni:ReadInteger('comissaoperiodo3','comissao', 4.0 )
      nDiaIni3         := oIni:ReadInteger('comissaoperiodo3','diaini',   31  )
      nDiaFim3         := oIni:ReadInteger('comissaoperiodo3','diafim',   999 )

      oMenu:MaBox( 01, 01, 11, 78, "CONFIGURACAO - FINANCEIRO")
      @ 02,      02 Say "Carencia em dias......:" Get nCarencia        Pict "999"
      @ Row(),   33 Say "Perc Juros Composto.:"   Get nJuroMesComposto Pict "99.99"
      @ Row()+1, 02 Say "Perc Juros ao Mes.....:" Get nJuroMesSimples  Pict "99.99"
      @ Row(),   33 Say "Perc Desc ate Vcto..:"   Get nDesconto        Pict "99.99"
      @ Row()+1, 02 Say "Perc Desc apos Vcto...:" Get nDescApos        Pict "99.99"
      @ Row(),   33 Say "Dias apos Vencido...:"   Get nDiasApos        Pict "999"
      @ Row()+1, 02 Say "Perc Multa............:" Get nMulta           Pict "99.99"
      @ Row(),   33 Say "Dias de Vencido.....:"   Get nDiaMulta        Pict "999"
      @ Row()+1, 02 Say "Tipo Docto Automatico.:" Get cAutoTipo        Pict "@!"  Valid PickTam( aLista, aTipo, @cAutoTipo )
      @ Row(),   33 Say "Bloqueio em Dias....:"   Get nBloqueio        Pict "99"
      @ Row()+1, 02 Say "Comissao Cobrador.....:" Get nComissao1       Pict "99.99"
      @ Row(),   33 Say "Dia(s) de Vencido...:"   Get nDiaIni1         Pict "999"
      @ Row(),   60 Say "Ate dia(s).:"            Get nDiaFim1         Pict "999"
      @ Row()+1, 02 Say "Comissao Cobrador.....:" Get nComissao2       Pict "99.99"
      @ Row(),   33 Say "Dia(s) de Vencido...:"   Get nDiaIni2         Pict "999"
      @ Row(),   60 Say "Ate dia(s).:"            Get nDiaFim2         Pict "999"
      @ Row()+1, 02 Say "Comissao Cobrador.....:" Get nComissao3       Pict "99.99"
      @ Row(),   33 Say "Dia(s) de Vencido...:"   Get nDiaIni3         Pict "999"
      @ Row(),   60 Say "Ate dia(s).:"            Get nDiaFim3         Pict "999"
      @ Row()+1, 02 Say "Ver Clientes Inativos.:" Get cInativo         Pict "@!" Valid PickSimNao(@cInativo)
      Read
      IF LastKey() = ESC
         FechaTudo()
         Set Defa To ( cPath )
         ResTela( cScreen )
         Exit
      EndIF
      ErrorBeep()
      IF Conf("Pergunta: Confirma  ?")
         IF Empresa->(TravaReg())
            Empresa->Carencia  := nCarencia
            Empresa->Desconto  := nDesconto
            Empresa->DescApos  := nDescApos
            Empresa->DiasApos  := nDiasApos
            Empresa->Juro      := nJuroMesSimples
            Empresa->Multa 	 := nMulta
            Empresa->DiaMulta  := nDiaMulta
            Empresa->(Libera())
            oAmbiente:aSciArray[1,SCI_JUROMESSIMPLES]  := nJuroMesSimples
            oAmbiente:aSciArray[1,SCI_DIASAPOS]        := nDiasApos
            oAmbiente:aSciArray[1,SCI_DESCAPOS]        := nDescApos
            oAmbiente:aSciArray[1,SCI_MULTA]           := nMulta
            oAmbiente:aSciArray[1,SCI_DIAMULTA]        := nDiaMulta
            oAmbiente:aSciArray[1,SCI_CARENCIA]        := nCarencia
            oAmbiente:aSciArray[1,SCI_DESCONTO]        := nDesconto
            oAmbiente:aSciArray[1,SCI_JUROMESCOMPOSTO] := nJuroMesComposto

            oIni:WriteInteger( 'financeiro', 'juromes', nJuroMesSimples )
            oIni:WriteInteger( 'financeiro', 'JuroMesSimples', nJuroMesSimples )
            oIni:WriteInteger( 'financeiro', 'JuroMesComposto', nJuroMesComposto )
            oIni:WriteString( 'sistema', 'autotipo', cAutoTipo )
            oIni:WriteInteger('sistema', 'bloqueio', nBloqueio )
            oIni:WriteBool('sistema', 'MostrarClientesInativos', IF( cInativo = "S", OK, FALSO ))
            oIni:WriteInteger('comissaoperiodo1','comissao', nComissao1 )
            oIni:WriteInteger('comissaoperiodo1','diaini',   nDiaIni1 )
            oIni:WriteInteger('comissaoperiodo1','diafim',   nDiaFim1 )
            oIni:WriteInteger('comissaoperiodo2','comissao', nComissao2 )
            oIni:WriteInteger('comissaoperiodo2','diaini',   nDiaIni2 )
            oIni:WriteInteger('comissaoperiodo2','diafim',   nDiaFim2 )
            oIni:WriteInteger('comissaoperiodo3','comissao', nComissao3 )
            oIni:WriteInteger('comissaoperiodo3','diaini',   nDiaIni3 )
            oIni:WriteInteger('comissaoperiodo3','diafim',   nDiaFim3 )
         EndIF
      EndIF
   EndDo   
endef

Proc ConfEntradas()
*******************
LOCAL cScreen		:= SaveScreen()
LOCAL GetList		:= {}
LOCAL cAutoPreco
LOCAL cMedia
LOCAL cIndexador
LOCAL cIpi
LOCAL cAutoProducao

WHILE OK
	oMenu:Limpa()
	cAutoPreco		:= IF( oIni:ReadBool('sistema','autopreco',      OK    ), "S", "N")
	cMedia			:= IF( oIni:ReadBool('sistema','mediaponderada', FALSO ), "S", "N")
	cIndexador		:= IF( oIni:ReadBool('sistema','indexador',      FALSO ), "S", "N")
	cIpi				:= IF( oIni:ReadBool('sistema','ipi',            FALSO ), "S", "N")
	cAutoProducao	:= IF( oIni:ReadBool('sistema','autoproducao',   FALSO ), "S", "N")

	oMenu:MaBox( 01, 01, 05, 78, "CONFIGURACAO - ENTRADAS")
	@ 02, 	  02 Say "Calcular Pvenda.....: " Get cAutoPreco    Pict "!"  Valid PickSimNao( @cAutoPreco )
	@ Row(),   41 Say "Pcusto Ponderado....: " Get cMedia        Pict "!"  Valid PickSimNao( @cMedia )
	@ Row()+1, 02 Say "Usar Indexadores....: " Get cIndexador    Pict "!"  Valid PickSimNao( @cIndexador )
	@ Row(),   41 Say "Entrar com IPI/II...: " Get cIpi          Pict "!"  Valid PickSimNao( @cIpi )
	@ Row()+1, 02 Say "Producao Automatica.: " Get cAutoProducao Pict "!"  Valid PickSimNao( @cAutoProducao )
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Exit
	EndIF
	ErrorBeep()
	IF Conf("Pergunta: Confirma  ?")
		oIni:WriteBool( 'sistema',   'autopreco',      IF( cAutoPreco    = "S", OK, FALSO ))
		oIni:WriteBool( 'sistema',   'mediaponderada', IF( cMedia        = "S", OK, FALSO ))
		oIni:WriteBool( 'sistema',   'indexador',      IF( cIndexador    = "S", OK, FALSO ))
		oIni:WriteBool( 'sistema',   'ipi',            IF( cIpi          = "S", OK, FALSO ))
		oIni:WriteBool( 'sistema',   'autoproducao',   IF( cAutoProducao = "S", OK, FALSO ))
	EndIF
EndDo

Proc ConfNota()
***************
LOCAL cScreen		  := SaveScreen()
LOCAL GetList		  := {}
LOCAL cPath 		  := FCurdir()
LOCAL cObs1 		  := Space(50)
LOCAL cObs2 		  := Space(50)
LOCAL cObs3 		  := Space(50)
LOCAL cIsento		  := Space(1)
LOCAL cMinimoIndice := Space(1)

Set Defa To ( oAmbiente:xBase )
cObs1 		  := oIni:ReadString('notafiscal','obs1', 'ESTE DOCUMENTO NAO GERA DIREITO A CREDITO FISCAL  ')
cObs2 		  := oIni:ReadString('notafiscal','obs2', 'CONTRIBUINTE ENQUADRADO NO SIMPLES. LEI FEDERAL N§')
cObs3 		  := oIni:ReadString('notafiscal','obs3', '9317/96 E DECRETO ESTADUAL N§ 8570/98.            ')
cIsento		  := IF( oIni:ReadBool('notafiscal','isento', FALSO ), "S", "N")
cMinimoIndice := IF( oIni:ReadBool('notafiscal','minimoindice', FALSO ), "S", "N")
WHILE OK
	oMenu:Limpa()
	oMenu:MaBox( 01, 01, 07, 78, "CONFIGURACAO - NOTA FISCAL")
	@ 02, 	  02 Say "Observacao Linha 1..: " Get cObs1 Pict "@!"
	@ Row()+1, 02 Say "Observacao Linha 2..: " Get cObs2 Pict "@!"
	@ Row()+1, 02 Say "Observacao Linha 3..: " Get cObs3 Pict "@!"
	@ Row()+1, 02 Say "Emitir Nota Isenta..: " Get cIsento Pict "!"  Valid PickSimNao( @cIsento )
	@ Row()+1, 02 Say "Respeitar Indice....: " Get cMinimoIndice Pict "!"  Valid PickSimNao( @cMinimoIndice )
	Read
	IF LastKey() = ESC
		Set Defa To ( cPath )
		ResTela( cScreen )
		Exit
	EndIF
	ErrorBeep()
	IF Conf("Pergunta: Confirma  ?")
		oIni:WriteString('notafiscal', 'obs1', cObs1 )
		oIni:WriteString('notafiscal', 'obs2', cObs2 )
		oIni:WriteString('notafiscal', 'obs3', cObs3 )
		oIni:WriteBool( 'notafiscal',  'isento', IF( cIsento = "S", OK, FALSO ))
		oIni:WriteBool( 'notafiscal',  'minimoindice', IF( cMinimoIndice = "S", OK, FALSO ))
	EndIF
EndDo

Proc ConfGeral()
****************
LOCAL cScreen		:= SaveScreen()
LOCAL GetList		:= {}
LOCAL cPath 		:= FCurdir()
LOCAL cEmail
LOCAL cSmtp
LOCAL nScreenSaver
LOCAL nRecibo
LOCAL nAutenticar
LOCAL nNenhum
LOCAL cCampoDesconto
LOCAL nTipoBusca
LOCAL cNrMarcaTicket
LOCAL cPvMarcaTicket
LOCAL cTrocarVendedor
LOCAL cNomeEmpresa
LOCAL cFantasia
LOCAL cCgcEmpresa
LOCAL cNomeSocio
LOCAL cCpfSocio
LOCAL cManterPosicaoMenuV

Set Defa To ( oAmbiente:xBase )
WHILE OK
	oMenu:Limpa()
   nScreenSaver    := oIni:ReadInteger('sistema', 'screensaver', 60 )
   cEmail          := oIni:ReadString('sistema', 'email', Space(40) )
   cSmtp           := oIni:ReadString('sistema', 'smtp', 'SMTP.MICROBRAS.COM.BR' + Space(19))
   cNomeEmpresa    := oIni:ReadString('sistema', 'nomeempresa', XNOMEFIR + Space(40-Len(XNOMEFIR)))
   cFantasia       := oIni:ReadString('sistema', 'fantasia',    XFANTA   + Space(40-Len(XFANTA)))
   cCgcEmpresa     := oIni:ReadString('sistema', 'cgcempresa', XCGCFIR )
   cNomeSocio      := oIni:ReadString('sistema', 'nomesocio', XNOMESOCIO + Space(40-Len(XNOMESOCIO)))
   cCpfSocio       := oIni:ReadString('sistema', 'cpfsocio', XCPFSOCIO )
   nRecibo         := oIni:ReadInteger('baixasrece', 'recibo', 1 )
   nAutenticar     := oIni:ReadInteger('baixasrece', 'autenticar', 2 )
   nNenhum         := oIni:ReadInteger('baixasrece', 'nenhum', 3 )
   nTipoBusca      := oIni:ReadInteger('sistema', 'tipobusca', 1 )	
	cNrMarcaTicket  := IF( oIni:ReadBool('sistema','nrmarcaticket', FALSO ), "S", "N")
   cPvMarcaTicket  := IF( oIni:ReadBool('sistema','pvmarcaticket', FALSO ), "S", "N")
   cCampoDesconto  := IF( oIni:ReadBool('baixasrece','campodesconto', OK ), "S", "N")
   cTrocarVendedor := IF( oIni:ReadBool('sistema','trocarvendedor', OK ), "S", "N")
   cManterPosicaoMenuV := IF( oIni:ReadBool('sistema','manterposicaomenuvertical', OK ), "S", "N")

   MaBox( 01, 01, 19, 79, "CONFIGURACAO - GERAL")
	@ 02, 02 Say "Tempo Protetor Tela.: " Get nScreenSaver   Pict "9999"
	@ 03, 02 Say "Email...............: " Get cEmail         Pict "@!"
	@ 04, 02 Say "Servidor SMTP.......: " Get cSmtp          Pict "@!"
   @ 05, 02 Say "Nome Empresa........: " Get cNomeEmpresa   Pict "@!"
   @ 06, 02 Say "Nome Fantasia.......: " Get cFantasia      Pict "@!"
   @ 07, 02 Say "Cnpj/CPF Empresa....: " Get cCgcEmpresa    Pict "@!"
   @ 08, 02 Say "Nome Socio..........: " Get cNomeSocio     Pict "@!"
   @ 09, 02 Say "CPF Socio...........: " Get cCpfSocio      Pict "999.999.999-99"
   @ 10, 02 Say "Posicao Menu [Recibo] apos Recebimento.....:" Get nRecibo             Pict "9" Valid PickTam({'Primeiro','Segundo','Terceiro'}, {1,2,3}, @nRecibo)
   @ 11, 02 Say "Posicao Menu [Autenticar] apos Recebimento.:" Get nAutenticar         Pict "9" Valid PickTam({'Primeiro','Segundo','Terceiro'}, {1,2,3}, @nAutenticar)
   @ 12, 02 Say "Posicao Menu [Nenhum] apos Recebimento.....:" Get nNenhum             Pict "9" Valid PickTam({'Primeiro','Segundo','Terceiro'}, {1,2,3}, @nNenhum)
   @ 13, 02 Say "Mostrar Campo Desconto ao receber titulo...:" Get cCampoDesconto      Pict "!" Valid PickSimNao( @cCampoDesconto )
   @ 14, 02 Say "Tipo Menu de Procura Produto...............:" Get nTipoBusca          Pict "9" Valid PickTam({'Ordem Codigo','Ordem Fabricante'}, {1,2}, @nTipoBusca)
   @ 15, 02 Say "Imprimir Marca Produto Ticket Venda........:" Get cNrMarcaTicket      Pict "!" Valid PickSimNao( @cNrMarcaTicket )
   @ 16, 02 Say "Imprimir Marca Produto Ticket PreVenda.....:" Get cPvMarcaTicket      Pict "!" Valid PickSimNao( @cPvMarcaTicket )
   @ 17, 02 Say "Permitir faturar comissao outro vendedor...:" Get cTrocarVendedor     Pict "!" Valid PickSimNao( @cTrocarVendedor )
   @ 18, 02 Say "Manter posicao item menu vertical..........:" Get cManterPosicaoMenuV Pict "!" Valid PickSimNao( @cManterPosicaoMenuV )
   Read
	IF LastKey() = ESC
		Set Defa To ( cPath )		
		ResTela( cScreen )
		Exit
	EndIF
	ErrorBeep()
	IF Conf("Pergunta: Confirma  ?")
		oIni:WriteInteger('sistema', 'screensaver', nScreenSaver )
		oIni:WriteString('sistema', 'email', cEmail )
		oIni:WriteString('sistema', 'smtp', cSmtp )
      oIni:WriteString('sistema', 'nomeempresa', cNomeEmpresa )
      oIni:WriteString('sistema', 'fantasia', cFantasia )
      oIni:WriteString('sistema', 'cgcempresa', cCgcEmpresa )
      oIni:WriteString('sistema', 'tipobusca', nTipoBusca )
      oIni:WriteString('sistema', 'nomesocio', cNomeSocio )
      oIni:WriteString('sistema', 'cpfsocio',  cCpfSocio )
      oIni:WriteBool('sistema','nrmarcaticket', IF( cNrMarcaTicket = "S", OK, FALSO ))
      oIni:WriteBool('sistema','pvmarcaticket', IF( cPvMarcaTicket = "S", OK, FALSO ))
      oIni:WriteInteger('baixasrece', 'recibo', nRecibo )
		oIni:WriteInteger('baixasrece', 'autenticar', nAutenticar )
		oIni:WriteInteger('baixasrece', 'nenhum', nNenhum )
		oIni:WriteBool('baixasrece','campodesconto', IF( cCampoDesconto = "S", OK, FALSO ))
      oIni:WriteBool('sistema','trocarvendedor', IF( cTrocarVendedor = "S", OK, FALSO ))
      oIni:WriteBool('sistema','manterposicaomenuvertical', IF( cManterPosicaoMenuV = "S", OK, FALSO ))
      
      oAmbiente:xFanta   := cFantasia
      oAmbiente:xNomefir := cNomeEmpresa
      oAmbiente:lManterPosicaoMenuVertical := oIni:ReadBool('sistema','manterposicaomenuvertical')         
	EndIF
EndDo

Proc ConfRelatorios()
*********************
LOCAL cScreen				:= SaveScreen()
LOCAL GetList				:= {}
LOCAL cPath 				:= FCurdir()
LOCAL nRolVendas			:= 1
LOCAL nRolRecemov 		:= 1
LOCAL nRolCaixa			:= 1
LOCAL nRolRecebido		:= 1
LOCAL nRolContraPartida := 2
LOCAL nTipoCaixa			:= 2
LOCAL nTamPromissoria	:= 33

Set Defa To ( oAmbiente:xBase )
WHILE OK
	oMenu:Limpa()
	nRolVendas			:= oIni:ReadInteger('relatorios','rolvendas', 1)
	nRolRecemov 		:= oIni:ReadInteger('relatorios','rolrecemov', 1 )
	nRolCaixa			:= oIni:ReadInteger('relatorios','rolcaixa', 1 )
	nRolRecebido		:= oIni:ReadInteger('relatorios','rolrecebido', 1 )
	nRolContraPartida := oIni:ReadInteger('relatorios','rolcontrapartida', 2 )
	nTipoCaixa			:= oIni:ReadInteger('relatorios','tipocaixa', 2 )
	nTamPromissoria	:= oIni:ReadInteger('relatorios','tampromissoria', 33 )
	oMenu:MaBox( 01, 01, 09, 78, "CONFIGURACAO - RELATORIOS")
	@ 02, 02 Say "Tipo Relatorio Vendas...: " Get nRolVendas        Pict "9" Valid PickTam({"Normal", "Ecf"}, {1,2}, @nRolVendas )
	@ 03, 02 Say "Tipo Relatorio Receber..: " Get nRolRecemov       Pict "9" Valid PickTam({"Normal", "Ecf"}, {1,2}, @nRolRecemov )
	@ 04, 02 Say "Tipo Relatorio Caixa....: " Get nRolCaixa         Pict "9" Valid PickTam({"Normal", "Ecf"}, {1,2}, @nRolCaixa )
	@ 05, 02 Say "Tipo Relatorio Recebido.: " Get nRolRecebido      Pict "9" Valid PickTam({"Normal", "Ecf"}, {1,2}, @nRolRecebido )
	@ 06, 02 Say "Tipo Rol Contra Partida.: " Get nRolContraPartida Pict "9" Valid PickTam({"Sem Contra Partida", "Com Contra Partida"}, {1,2}, @nRolContraPartida )
	@ 07, 02 Say "Ordem Relatorio Caixa...: " Get nTipoCaixa        Pict "9" Valid PickTam({"Data Lancamento", "Data Baixa"}, {1,2}, @nTipoCaixa )
	@ 08, 02 Say "Tamanho Form Promissoria: " Get nTamPromissoria   Pict "99" Valid PickTam({"22 Linhas","33 Linhas","66 Linhas"}, {22,33,66}, @nTamPromissoria )
	Read
	IF LastKey() = ESC
		Set Defa To ( cPath )
		ResTela( cScreen )
		Exit
	EndIF
	ErrorBeep()
	IF Conf("Pergunta: Confirma  ?")
		oIni:WriteInteger('relatorios', 'rolvendas',        nRolVendas )
		oIni:WriteInteger('relatorios', 'rolrecemov',       nRolRecemov )
		oIni:WriteInteger('relatorios', 'rolcaixa',         nRolCaixa )
		oIni:WriteInteger('relatorios', 'rolrecebido',      nRolRecebido )
		oIni:WriteInteger('relatorios', 'rolcontrapartida', nRolContraPartida )
		oIni:WriteInteger('relatorios', 'tipocaixa',        nTipoCaixa )
		oIni:WriteInteger('relatorios', 'tampromissoria',   nTamPromissoria )
	EndIF
EndDo

Proc ConfPrevenda()
*******************
LOCAL cScreen				:= SaveScreen()
LOCAL GetList				:= {}
LOCAL cPath 				:= FCurdir()
LOCAL cAparelhoMarca
LOCAL cModeloSerie
LOCAL cAnoCor
LOCAL cPlacaEstado
LOCAL cObs2
LOCAL cObs3

Set Defa To ( oAmbiente:xBase )
WHILE OK
	oMenu:Limpa()
	cAparelhoMarca := IF( oIni:ReadBool('prevenda','aparelhomarca', FALSO ), "S", "N")
	cModeloSerie	:= IF( oIni:ReadBool('prevenda','modeloserie', FALSO ), "S", "N")
	cAnoCor			:= IF( oIni:ReadBool('prevenda','anocor', FALSO ), "S", "N")
	cPlacaEstado	:= IF( oIni:ReadBool('prevenda','placaestado', FALSO ), "S", "N")
	cObs2 			:= IF( oIni:ReadBool('prevenda','obs2', FALSO ), "S", "N")
	cObs3 			:= IF( oIni:ReadBool('prevenda','obs3', FALSO ), "S", "N")
	oMenu:MaBox( 01, 01, 08, 78, "CONFIGURACAO - PREVENDA")
	@ 02, 	  02 Say "Imprimir Linha Aparelho e Marca..: " Get cAparelhoMarca Pict '!' Valid PickSimNao( @cAparelhoMarca )
	@ Row()+1, 02 Say "Imprimir Linha Modelo e Serie....: " Get cModeloSerie   Pict '!' Valid PickSimNao( @cModeloSerie )
	@ Row()+1, 02 Say "Imprimir Linha Ano e Cor.........: " Get cAnoCor        Pict '!' Valid PickSimNao( @cAnoCor )
	@ Row()+1, 02 Say "Imprimir Placa e Estado..........: " Get cPlacaEstado   Pict '!' Valid PickSimNao( @cPlacaEstado )
	@ Row()+1, 02 Say "Imprimir Linha 2 de Observacoes..: " Get cObs2          Pict '!' Valid PickSimNao( @cObs2 )
	@ Row()+1, 02 Say "Imprimir Linha 3 de Observacoes..: " Get cObs3          Pict '!' Valid PickSimNao( @cObs3 )
	Read
	IF LastKey() = ESC
		Set Defa To ( cPath )
		ResTela( cScreen )
		Exit
	EndIF
	ErrorBeep()
	IF Conf("Pergunta: Confirma  ?")
		oIni:WriteBool( 'prevenda',  'aparelhomarca', IF( cAparelhoMarca = "S", OK, FALSO ))
		oIni:WriteBool( 'prevenda',  'modeloserie',   IF( cModeloSerie   = "S", OK, FALSO ))
		oIni:WriteBool( 'prevenda',  'anocor',        IF( cAnoCor        = "S", OK, FALSO ))
		oIni:WriteBool( 'prevenda',  'placaestado',   IF( cPlacaEstado   = "S", OK, FALSO ))
		oIni:WriteBool( 'prevenda',  'obs2',          IF( cObs2          = "S", OK, FALSO ))
		oIni:WriteBool( 'prevenda',  'obs3',          IF( cObs3          = "S", OK, FALSO ))
	EndIF
EndDo

Proc ConfEcf()
**************
LOCAL cScreen	 := SaveScreen()
LOCAL GetList	 := {}
LOCAL cPath 	 := FCurdir()
LOCAL nModelo	 := 1
LOCAL nPorta	 := 2
LOCAL nIndice	 := 1
LOCAL nUfIcms	 := 17
LOCAL nIss      := 5
LOCAL cPos1Icms := Space(02)
LOCAL cPos2Icms := Space(02)
LOCAL cPos3Icms := Space(02)
LOCAL cPos4Icms := Space(02)
LOCAL cPos5Icms := Space(02)
LOCAL cPos6Icms := Space(02)
LOCAL cPos7Icms := Space(02)
LOCAL cPos8Icms := Space(02)
LOCAL cPos9Icms := Space(02)
LOCAL cIcmsIss1 := Space(01)
LOCAL cIcmsIss2 := Space(01)
LOCAL cIcmsIss3 := Space(01)
LOCAL cIcmsIss4 := Space(01)
LOCAL cIcmsIss5 := Space(01)
LOCAL cIcmsIss6 := Space(01)
LOCAL cIcmsIss7 := Space(01)
LOCAL cIcmsIss8 := Space(01)
LOCAL cIcmsIss9 := Space(01)
LOCAL nSigLinha := 1
LOCAL cVista	 := 'S'
LOCAL cNomeEcf  := 'N'
LOCAL cAutoEcf  := 'N'
LOCAL cEcfRede  := 'N'
LOCAL nAtiva	 := 2
LOCAL cPathrede := Space(30)
LOCAL cDrive	 := oAmbiente:xBase
LOCAL cPathStr  := cDrive + '\CMD'
LOCAL aEcf      := {"Zanthus IZ-11", "Bematech MP-20 FI II", "Zanthus IZ-20", "Sigtron FS345", 'Sweda FS 7000I', 'Daruma FS 2000'}

Set Defa To ( oAmbiente:xBase )
WHILE OK
	oMenu:Limpa()
	cPathrede  := oIni:ReadString('ecf', 'pathrede', cPathStr )
	cPathRede  += Space(30-Len(cPathRede))
	nModelo	  := oIni:ReadInteger('ecf', 'modelo', 1 )
	nPorta	  := oIni:ReadInteger('ecf', 'porta', 2 )
	nIndice	  := oIni:ReadInteger('ecf', 'indice', 1.25 )
	nUfIcms	  := oIni:ReadInteger('ecf', 'uficms', 17 )
   nIss       := oIni:ReadInteger('ecf', 'iss', 5 )
	nAtiva	  := oIni:ReadString('ecf',  'ativa', 2 )
	nSigLinha  := oIni:ReadInteger('ecf',  'siglinha', 1 )

	cPos1Icms := oIni:ReadString('ecf', 'pos1icms', '07.00', 1 ) ; cPos1Icms += IF( Len( cPos1Icms ) = 2, '.00','')
	cPos2Icms := oIni:ReadString('ecf', 'pos2icms', '12.00', 1 ) ; cPos2Icms += IF( Len( cPos2Icms ) = 2, '.00','')
	cPos3Icms := oIni:ReadString('ecf', 'pos3icms', '17.00', 1 ) ; cPos3Icms += IF( Len( cPos3Icms ) = 2, '.00','')
	cPos4Icms := oIni:ReadString('ecf', 'pos4icms', '25.00', 1 ) ; cPos4Icms += IF( Len( cPos4Icms ) = 2, '.00','')
	cPos5Icms := oIni:ReadString('ecf', 'pos5icms', '05.00', 1 ) ; cPos5Icms += IF( Len( cPos5Icms ) = 2, '.00','')
	cPos6Icms := oIni:ReadString('ecf', 'pos6icms', '00.00', 1 ) ; cPos6Icms += IF( Len( cPos6Icms ) = 2, '.00','')
	cPos7Icms := oIni:ReadString('ecf', 'pos7icms', '00.00', 1 ) ; cPos7Icms += IF( Len( cPos7Icms ) = 2, '.00','')
	cPos8Icms := oIni:ReadString('ecf', 'pos8icms', '00.00', 1 ) ; cPos8Icms += IF( Len( cPos8Icms ) = 2, '.00','')
	cPos9Icms := oIni:ReadString('ecf', 'pos9icms', '00.00', 1 ) ; cPos9Icms += IF( Len( cPos9Icms ) = 2, '.00','')

	cIcmsIss1 := oIni:ReadString('ecf', 'pos1icms', '1', 2 )
	cIcmsIss2 := oIni:ReadString('ecf', 'pos2icms', '1', 2 )
	cIcmsIss3 := oIni:ReadString('ecf', 'pos3icms', '1', 2 )
	cIcmsIss4 := oIni:ReadString('ecf', 'pos4icms', '1', 2 )
	cIcmsIss5 := oIni:ReadString('ecf', 'pos5icms', '1', 2 )
	cIcmsIss6 := oIni:ReadString('ecf', 'pos6icms', '1', 2 )
	cIcmsIss7 := oIni:ReadString('ecf', 'pos7icms', '1', 2 )
	cIcmsIss8 := oIni:ReadString('ecf', 'pos8icms', '1', 2 )
	cIcmsIss9 := oIni:ReadString('ecf', 'pos9icms', '1', 2 )

	cVista	  := IF( oIni:ReadBool('ecf','vista', OK ), "S", "N")
	cNomeEcf   := IF( oIni:ReadBool('ecf','nomeecf', OK ), "S", "N")
	cAutoEcf   := IF( oIni:ReadBool('ecf','autoecf', FALSO ), "S", "N")
	cEcfRede   := IF( oIni:ReadBool('ecf','ecfrede', FALSO ), "S", "N")

   oMenu:MaBox( 00, 01, 18, 78, "ECF CUPOM FISCAL - CONFIGURACAO")
   @ 01, 02 Say "Impressora Ativa....... " Get nAtiva     Pict "9"    Valid PickSimNao( @nAtiva )
   @ 01, 40 Say "Modelo Impressora ECF.: " Get nModelo    Pict "9"    Valid PickTam( aEcf, {1,2,3,4,5,6}, @nModelo )
   @ 02, 02 Say "Porta de comunicacao..: " Get nPorta     Pict "9"    Valid PickTam({"Com1","Com2","Com3","Com4",'Com5','Com6','Com7','Com8','Com9'}, {1,2,3,4,5,6,7,8,9}, @nPorta )
   @ 02, 40 Say "ECF Monitorada/Rede...: " Get cEcfRede   Pict "!"    Valid PickSimNao( @cEcfRede ) When nModelo = 2 .OR. nModelo = 6
	@ 03, 02 Say "Diretorio Driver Rede.: " Get cPathRede  Pict "@!"
	@ 04, 02 Say "Indice................: " Get nIndice    Pict "9.99"
	@ 04, 40 Say "Icms Estadual.........: " Get nUfIcms    Pict "99.99"
   @ 05, 02 Say "Iss Municipal.........: " Get nIss       Pict "99.99"
	@ 05, 40 Say "Emitir Cupom a Vista..: " Get cVista     Pict "!"  Valid PickSimNao( @cVista )
	@ 06, 02 Say "Emitir Nome Cliente...: " Get cNomeEcf   Pict "!"  Valid PickSimNao( @cNomeEcf )
	@ 06, 40 Say "Auto Emitir Cupom.....: " Get cAutoEcf   Pict "!"  Valid PickSimNao( @cAutoEcf )
	@ 07, 02 Say "Imprimir CF em Linhas.: " Get nSigLinha  Pict "9"  Valid PickTam({'1 Linha', '2 Linhas'}, {1,2}, @nSigLinha )
//   Write( 08, 02, Repl("Ä",77))
   oMenu:MaBox( 08, 01, 18, 78, 'CONFIGURACAO ADICIONAL PARA: ' + aEcf[2])
   @ 09, 02 Say "Aliquota Posicao 01...: " Get cPos1Icms  Pict "99.99" when nModelo == 2
   @ 09, 40 Say "Icms/Iss..............: " Get cIcmsIss1  Pict "9" Valid PickTam({'Icms', 'Iss'}, {'1','2'}, @cIcmsIss1 ) when nModelo = 2
   @ 10, 02 Say "Aliquota Posicao 02...: " Get cPos2Icms  Pict "99.99" when nModelo == 2
   @ 10, 40 Say "Icms/Iss..............: " Get cIcmsIss2  Pict "9" Valid PickTam({'Icms', 'Iss'}, {'1','2'}, @cIcmsIss2 ) when nModelo == 2
   @ 11, 02 Say "Aliquota Posicao 03...: " Get cPos3Icms  Pict "99.99" when nModelo = 2
   @ 11, 40 Say "Icms/Iss..............: " Get cIcmsIss3  Pict "9" Valid PickTam({'Icms', 'Iss'}, {'1','2'}, @cIcmsIss3 ) when nModelo = 2
   @ 12, 02 Say "Aliquota Posicao 04...: " Get cPos4Icms  Pict "99.99" when nModelo = 2
   @ 12, 40 Say "Icms/Iss..............: " Get cIcmsIss4  Pict "9" Valid PickTam({'Icms', 'Iss'}, {'1','2'}, @cIcmsIss4 ) when nModelo = 2
   @ 13, 02 Say "Aliquota Posicao 05...: " Get cPos5Icms  Pict "99.99" when nModelo = 2
   @ 13, 40 Say "Icms/Iss..............: " Get cIcmsIss5  Pict "9" Valid PickTam({'Icms', 'Iss'}, {'1','2'}, @cIcmsIss5 ) when nModelo = 2
   @ 14, 02 Say "Aliquota Posicao 06...: " Get cPos6Icms  Pict "99.99" when nModelo = 2
   @ 14, 40 Say "Icms/Iss..............: " Get cIcmsIss6  Pict "9" Valid PickTam({'Icms', 'Iss'}, {'1','2'}, @cIcmsIss6 ) when nModelo = 2
   @ 15, 02 Say "Aliquota Posicao 07...: " Get cPos7Icms  Pict "99.99" when nModelo = 2
   @ 15, 40 Say "Icms/Iss..............: " Get cIcmsIss7  Pict "9" Valid PickTam({'Icms', 'Iss'}, {'1','2'}, @cIcmsIss7 ) when nModelo = 2
   @ 16, 02 Say "Aliquota Posicao 08...: " Get cPos8Icms  Pict "99.99" when nModelo = 2
   @ 16, 40 Say "Icms/Iss..............: " Get cIcmsIss8  Pict "9" Valid PickTam({'Icms', 'Iss'}, {'1','2'}, @cIcmsIss8 ) when nModelo = 2
   @ 17, 02 Say "Aliquota Posicao 09...: " Get cPos9Icms  Pict "99.99" when nModelo = 2
   @ 17, 40 Say "Icms/Iss..............: " Get cIcmsIss9  Pict "9" Valid PickTam({'Icms', 'Iss'}, {'1','2'}, @cIcmsIss9 ) when nModelo = 2
	Read
	IF LastKey() = ESC
		Set Defa To ( cPath )
		ResTela( cScreen )
		Exit
	EndIF
	ErrorBeep()
	IF Conf("Pergunta: Confirma  ?")
		oIni:WriteInteger('ecf', 'modelo', nModelo )
		oIni:WriteInteger('ecf', 'porta', nPorta )
		oIni:WriteInteger('ecf', 'indice', nIndice )
		oIni:WriteInteger('ecf', 'uficms', nUfIcms )
		oIni:WriteInteger('ecf', 'ativa', nAtiva )
      oIni:WriteInteger('ecf', 'iss', nIss )
		oIni:WriteString('ecf',  'pos1icms', cPos1Icms + ';' + cIcmsIss1 )
		oIni:WriteString('ecf',  'pos2icms', cPos2Icms + ';' + cIcmsIss2 )
		oIni:WriteString('ecf',  'pos3icms', cPos3Icms + ';' + cIcmsIss3 )
		oIni:WriteString('ecf',  'pos4icms', cPos4Icms + ';' + cIcmsIss4 )
		oIni:WriteString('ecf',  'pos5icms', cPos5Icms + ';' + cIcmsIss5 )
		oIni:WriteString('ecf',  'pos6icms', cPos6Icms + ';' + cIcmsIss6 )
		oIni:WriteString('ecf',  'pos7icms', cPos7Icms + ';' + cIcmsIss7 )
		oIni:WriteString('ecf',  'pos8icms', cPos8Icms + ';' + cIcmsIss8 )
		oIni:WriteString('ecf',  'pos9icms', cPos9Icms + ';' + cIcmsIss9 )
		oIni:WriteBool(  'ecf',  'vista',   IF( cVista   = "S", OK, FALSO ))
		oIni:WriteBool(  'ecf',  'nomeecf', IF( cNomeEcf = "S", OK, FALSO ))
		oIni:WriteBool(  'ecf',  'autoecf', IF( cAutoEcf = "S", OK, FALSO ))
		oIni:WriteBool(  'ecf',  'ecfrede', IF( cEcfRede = "S", OK, FALSO ))
		oIni:WriteString('ecf',  'pathrede', cPathRede )
		oIni:WriteInteger('ecf', 'siglinha', nSigLinha )
	EndIF
EndDo

def ConfServidorBcoDados()
*-------------------------*
	LOCAL oLeto		   := TIniNew( oAmbiente:xRoot + "\sci.ini")
	LOCAL cScreen		:= SaveScreen()
	LOCAL GetList		:= {}	
	LOCAL cPath 	   := FCurdir()
	
	Set Defa To ( oAmbiente:xBase )
	WHILE OK
		oMenu:Limpa()
		cLetoIP    := oLeto:ReadString('LETO', 'ip',    oAmbiente:LetoIP )
		cLetoPort  := oLeto:ReadString('LETO', 'port',  oAmbiente:LetoPort )
		cLetoPath  := oLeto:ReadString('LETO', 'path',  oAmbiente:LetoPath )
		
		MaBox( 01, 01, 05, 79, "CONFIGURACAO SERVIDOR LETO")
		@ 02, 02 Say "Ip Servidor.........: " Get cLetoIp        Pict "@!"
		@ 03, 02 Say "Porta Servidor......: " Get cLetoPort      Pict "9999"
		@ 04, 02 Say "Path Servidor.......: " Get cLetoPath      Pict "@!"
		Read
		IF LastKey() = K_ESC
			Set Defa To (cPath )		
			ResTela( cScreen )
			Exit
		EndIF
		ErrorBeep()
		IF Conf("Pergunta: Confirma  ?")
			oLeto:WriteString('LETO','ip',   cLetoIP)
			oLeto:WriteString('LETO','port', cLetoPort)
			oLeto:WriteString('LETO','path', cLetoPath)			
		EndIF
	EndDo
endef

Proc TermPrecos()
*****************
LOCAL GetList	:= {}
LOCAL cScreen	:= SaveScreen()
LOCAL xCodigo	:= 0
LOCAL nCol		:= LastRow()
LOCAL nTam		:= MaxCol()
LOCAL nPos		:= 0
LOCAL cString1 := "³ENTER=CONSULTA³ESC=SAIR"

SetKey( F5, NIL )
oMenu:Limpa()
WHILE OK
	xCodigo := 0
	aPrint( 00, 00,  Padc("TERMINAL DE CONSULTA DE PRECOS",MaxCol()), oMenu:CorCabec, MaxCol() )
	MaBox( 02, 01, 10, 78 )
	MaBox( 12, 01, 22, 78 )
	nPos := ( nTam - Len( cString1 ))
	aPrint( nCol, 00, "³CLIQUE COM O SCANNER OU DIGITE O CODIGO DO PRODUTO", oMenu:CorCabec, MaxCol() )
	aPrint( nCol, nPos, cString1, oMenu:CorCabec )
	Set Conf On
	@ 04, 10 Say "Codigo...: " Get xCodigo Pict "9999999999999" Valid TermProduto( @xCodigo )
	@ 06, 10 Say "Produto..: "
	Read
	Set Conf Off
	IF LastKey() = ESC
		SetKey( F5, {|| PrecosConsulta()})
		Return
	EndIF
	Inkey(5)
EndDo

Function TermProduto( xCodigo)
******************************
LOCAL aRotina			  := {{|| InclusaoProdutos() }}
LOCAL aRotinaAlteracao := {{|| InclusaoProdutos(OK) }}
LOCAL GetList			  := {}
LOCAL Arq_Ant			  := Alias()
LOCAL Ind_Ant			  := IndexOrd()
LOCAL nTam				  := 6
LOCAL cTemp
LOCAL cScreen

cTemp   := IF( ValType(xCodigo) = "N", Str(xCodigo, 13), xCodigo)
nTam	  := Len( AllTrim( cTemp ))
IF nTam <= 6
	nTam	  := 6
	xCodigo :=IF( ValType(xCodigo) = "N", StrZero(xCodigo, nTam), xCodigo)
ElseIF nTam = 8
	nTam	  := 8
	xCodigo := IF( ValType(xCodigo) = "N", StrZero(xCodigo, nTam), xCodigo)
 Else
	nTam	  := 13
	xCodigo := IF( ValType(xCodigo) = "N", StrZero(xCodigo, nTam), xCodigo)
EndIF
Area("Lista")
IF nTam = 6
	Lista->(Order( LISTA_CODIGO ))
ElseIF nTam = 13 .OR. nTam = 8
	Lista->(Order( LISTA_CODEBAR ))
EndIF
IF Lista->( !DbSeek( xCodigo ))
	Lista->(Order( LISTA_DESCRICAO ))
	Escolhe( 12, 01, 22, "Codigo + 'Ý' + Sigla + 'Ý' + Descricao + 'Ý' + Tran( Varejo, '@E 9999,999,999.99')","CODI  MARCA      DESCRICAO DO PRODUTO                      PRECO", aRotina, NIL, aRotinaAlteracao, NIl, FALSO)
EndIF
xCodigo := Lista->CodeBar
Write( 06, 22,  Lista->Descricao )
MaBox( 12, 01, 22, 78 )
Num( 14, Lista->Varejo)
AreaAnt( Arq_Ant, Ind_Ant )
Return( .T. )

Function Num( nRow, nValor )
****************************
LOCAL aNum := {{" ÛÛÛ " ,;
					 "Û  ÛÛ" ,;
					 "Û Û Û" ,;
					 "ÛÛ  Û" ,;
					 " ÛÛÛ "},;
					{"  ÛÛ" ,;
					 " Û Û" ,;
					 "Û  Û" ,;
					 "   Û" ,;
					 "ÛÛÛÛ"},;
					{"ÛÛÛÛÛ" ,;
					 "    Û" ,;
					 "ÛÛÛÛÛ" ,;
					 "Û    " ,;
					 "ÛÛÛÛÛ"},;
					{"ÛÛÛÛÛ" ,;
					 "    Û" ,;
					 " ÛÛÛÛ" ,;
					 "    Û" ,;
					 "ÛÛÛÛÛ"},;
					{"Û   Û" ,;
					 "Û   Û" ,;
					 "ÛÛÛÛÛ" ,;
					 "    Û" ,;
					 "    Û"},;
					{"ÛÛÛÛÛ" ,;
					 "Û    " ,;
					 "ÛÛÛÛÛ" ,;
					 "    Û" ,;
					 "ÛÛÛÛÛ"},;
					{"ÛÛÛÛÛ" ,;
					 "Û    " ,;
					 "ÛÛÛÛÛ" ,;
					 "Û   Û" ,;
					 "ÛÛÛÛÛ"},;
					{"ÛÛÛÛÛ" ,;
					 "   ÛÛ" ,;
					 "  ÛÛ " ,;
					 " ÛÛ  " ,;
					 "ÛÛ   "},;
					{"ÛÛÛÛÛ" ,;
					 "Û   Û" ,;
					 "ÛÛÛÛÛ" ,;
					 "Û   Û" ,;
					 "ÛÛÛÛÛ"},;
					{"ÛÛÛÛÛ" ,;
					 "Û   Û" ,;
					 "ÛÛÛÛÛ" ,;
					 "    Û" ,;
					 "ÛÛÛÛÛ"},;
					{"   " ,;
					 "   " ,;
					 "   " ,;
					 "   " ,;
					 "  "},;
					{"   " ,;
					 "   " ,;
					 "   " ,;
					 "   " ,;
					 "  "}}

LOCAL aDig	  := {"0","1","2","3","4","5","6","7","8","9",".",","}
LOCAL cNumero := AllTrim(Tran(nValor, "99,9999.99"))
LOCAL nTam	  := Len( cNumero )
LOCAL nX 	  := 0
LOCAL nY 	  := 0
LOCAL cDig	  := ""
LOCAL nPos	  := 0
LOCAL nConta  := 0

For nX := 1 To nTam
	cDig	 := SubStr( cNumero, nX, 1 )
	nPos	 := Ascan( aDig, cDig )
	nConta ++
	For nY := 1 To 5
		Write( nRow+nY, 5*nConta+nConta, aNum[nPos,nY])
	Next
Next

Proc ConfOpcoesFaturamento( cNome )
***********************************
LOCAL cScreen := SaveScreen()
LOCAL GetList := {}
LOCAL oVenlan	:= TIniNew( cNome + ".INI")
LOCAL c2_01
LOCAL c2_02
LOCAL c2_03
LOCAL c2_04
LOCAL c2_05
LOCAL c2_06

WHILE OK
	oMenu:Limpa()
	c2_01 := IF( oVenlan:ReadBool('opcoesfaturamento','#2.01', OK ), "S", "N")
	c2_02 := IF( oVenlan:ReadBool('opcoesfaturamento','#2.02', OK ), "S", "N")
	c2_03 := IF( oVenlan:ReadBool('opcoesfaturamento','#2.03', OK ), "S", "N")
	c2_04 := IF( oVenlan:ReadBool('opcoesfaturamento','#2.04', OK ), "S", "N")
	c2_05 := IF( oVenlan:ReadBool('opcoesfaturamento','#2.05', OK ), "S", "N")
	c2_06 := IF( oVenlan:ReadBool('opcoesfaturamento','#2.06', OK ), "S", "N")

	oMenu:MaBox( 00, 01, 07, 78, "CONFIGURACAO - OPCOES DE FATURAMENTO")
	@ 01, 		02 Say "Manualmente - Varejo..........: " Get c2_01 Pict "!"  Valid PickSimNao( @c2_01 )
	@ Row()+01, 02 Say "Manualmente - Atacado.........: " Get c2_02 Pict "!"  Valid PickSimNao( @c2_02 )
	@ Row()+01, 02 Say "Manualmente - Custo...........: " Get c2_03 Pict "!"  Valid PickSimNao( @c2_03 )
	@ Row()+01, 02 Say "Codigo Barra - Varejo.........: " Get c2_04 Pict "!"  Valid PickSimNao( @c2_04 )
	@ Row()+01, 02 Say "Codigo Barra - Atacado........: " Get c2_05 Pict "!"  Valid PickSimNao( @c2_05 )
	@ Row()+01, 02 Say "Codigo Barra - Custo..........: " Get c2_06 Pict "!"  Valid PickSimNao( @c2_06 )
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Exit
	EndIF
	ErrorBeep()
	IF Conf("Pergunta: Confirma  ?")
		oVenlan:WriteBool( 'opcoesfaturamento', '#2.01', IF( c2_01 = "S", OK, FALSO ))
		oVenlan:WriteBool( 'opcoesfaturamento', '#2.02', IF( c2_02 = "S", OK, FALSO ))
		oVenlan:WriteBool( 'opcoesfaturamento', '#2.03', IF( c2_03 = "S", OK, FALSO ))
		oVenlan:WriteBool( 'opcoesfaturamento', '#2.04', IF( c2_04 = "S", OK, FALSO ))
		oVenlan:WriteBool( 'opcoesfaturamento', '#2.05', IF( c2_05 = "S", OK, FALSO ))
		oVenlan:WriteBool( 'opcoesfaturamento', '#2.06', IF( c2_06 = "S", OK, FALSO ))
	EndIF
EndDo

Proc ConfFiscal( cNome )
************************
LOCAL cScreen := SaveScreen()
LOCAL GetList := {}
LOCAL oVenlan	:= TIniNew( cNome + ".INI")
LOCAL c2_01
LOCAL c2_02
LOCAL c2_03
LOCAL c2_04
LOCAL c2_05
LOCAL c2_06
LOCAL c2_07
LOCAL c2_08
LOCAL c2_09

WHILE OK
	oMenu:Limpa()
	c2_01 := IF( oVenlan:ReadBool('impressorasfiscais','#2.01', OK ), "S", "N")
	c2_02 := IF( oVenlan:ReadBool('impressorasfiscais','#2.02', OK ), "S", "N")
	c2_03 := IF( oVenlan:ReadBool('impressorasfiscais','#2.03', OK ), "S", "N")
	c2_04 := IF( oVenlan:ReadBool('impressorasfiscais','#2.04', OK ), "S", "N")
	c2_05 := IF( oVenlan:ReadBool('impressorasfiscais','#2.05', OK ), "S", "N")
	c2_06 := IF( oVenlan:ReadBool('impressorasfiscais','#2.06', OK ), "S", "N")
	c2_07 := IF( oVenlan:ReadBool('impressorasfiscais','#2.07', OK ), "S", "N")
	c2_08 := IF( oVenlan:ReadBool('impressorasfiscais','#2.08', OK ), "S", "N")
	c2_09 := IF( oVenlan:ReadBool('impressorasfiscais','#2.09', OK ), "S", "N")

	oMenu:MaBox( 00, 01, 10, 78, "CONFIGURACAO - IMPRESSORAS FISCAIS")
	@ 01, 		02 Say "Cadastrar Forma de Pagamento..: " Get c2_01 Pict "!"  Valid PickSimNao( @c2_01 )
	@ Row()+01, 02 Say "Emissao da Reducao Z - Fim Dia: " Get c2_02 Pict "!"  Valid PickSimNao( @c2_02 )
   @ Row()+01, 02 Say "Emissao da Leitura X..........: " Get c2_03 Pict "!"  Valid PickSimNao( @c2_03 )
	@ Row()+01, 02 Say "Leitura Memoria Fiscal - Data.: " Get c2_04 Pict "!"  Valid PickSimNao( @c2_04 )
	@ Row()+01, 02 Say "Leitura Memoria Fiscal - Redu.: " Get c2_05 Pict "!"  Valid PickSimNao( @c2_05 )
	@ Row()+01, 02 Say "Relatorio Gerencial...........: " Get c2_06 Pict "!"  Valid PickSimNao( @c2_06 )
	@ Row()+01, 02 Say "Inicio Dia Fiscal.............: " Get c2_07 Pict "!"  Valid PickSimNao( @c2_07 )
	@ Row()+01, 02 Say "Verificacao do Modulo Fiscal..: " Get c2_08 Pict "!"  Valid PickSimNao( @c2_08 )
	@ Row()+01, 02 Say "Verificacao Dia Livre.........: " Get c2_09 Pict "!"  Valid PickSimNao( @c2_09 )
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Exit
	EndIF
	ErrorBeep()
	IF Conf("Pergunta: Confirma  ?")
		oVenlan:WriteBool( 'impressorasfiscais', '#2.01', IF( c2_01 = "S", OK, FALSO ))
		oVenlan:WriteBool( 'impressorasfiscais', '#2.02', IF( c2_02 = "S", OK, FALSO ))
		oVenlan:WriteBool( 'impressorasfiscais', '#2.03', IF( c2_03 = "S", OK, FALSO ))
		oVenlan:WriteBool( 'impressorasfiscais', '#2.04', IF( c2_04 = "S", OK, FALSO ))
		oVenlan:WriteBool( 'impressorasfiscais', '#2.05', IF( c2_05 = "S", OK, FALSO ))
		oVenlan:WriteBool( 'impressorasfiscais', '#2.06', IF( c2_06 = "S", OK, FALSO ))
		oVenlan:WriteBool( 'impressorasfiscais', '#2.07', IF( c2_07 = "S", OK, FALSO ))
		oVenlan:WriteBool( 'impressorasfiscais', '#2.08', IF( c2_08 = "S", OK, FALSO ))
		oVenlan:WriteBool( 'impressorasfiscais', '#2.09', IF( c2_09 = "S", OK, FALSO ))
	EndIF
EndDo

Proc EcfComandos()
******************
LOCAL cScreen := SaveScreen()
LOCAL nChoice := 0
LOCAL aEcf    := {"Zanthus IZ-11", "Bematech MP-20 FI II", "Zanthus IZ-20", "Sigtron FS345", 'Sweda FS 7000I', 'Daruma FS 2000'}
LOCAL nIniEcf := oIni:ReadInteger('ecf','modelo', 1 )

WHILE OK
	oMenu:Limpa()
	M_Title("COMANDOS DE IMPRESSORA FISCAL")
   nChoice := FazMenu( 05, 10, aEcf )
	Do Case
	Case nChoice = 0
      Exit
   Otherwise
      IF nIniEcf != nChoice
         ErrorBeep()
         Alerta('Erro: ECF configurada na base de dados ‚: ' + aEcf[nIniEcf])
         Loop
      EndIF
      Ecf(nChoice, aEcf)
   EndCase
EndDO

Proc Ecf( nTipo, aEcf )
***********************
LOCAL cScreen		:= SaveScreen()
LOCAL nChoice		:= 0
LOCAL aEcfPermite := {}
LOCAL aMenu       := {"Cadastrar Forma de Pagto",;
                      "Cadastrar Aliquotas",;
                      "Emissao Reducao Z",;
                      "Emissao Leitura X",;
                      "Leitura Memoria Fiscal por Data",;
                      "Leitura Memoria Fiscal por Reducao",;
                      "Relatorio Gerencial",;
                      "Inicio Dia Fiscal",;
                      "Verificacao Modulo Fiscal",;
                      "Verificacao Dia Livre"}
oAmbiente:aFiscalIni := FiscalRegedit()
aEcfPermite          := { SnFiscal(2.01),SnFiscal(2.02),SnFiscal(2.03),;
                          SnFiscal(2.04),SnFiscal(2.05),SnFiscal(2.06),;
                          SnFiscal(2.07),SnFiscal(2.08),SnFiscal(2.09) }


// LOCAL aEcf    := {"Zanthus IZ-11", "Bematech MP-20 FI II", "Zanthus IZ-20", "Sigtron FS345", 'Sweda FS 7000I', 'Daruma FS 2000'}

WHILE OK
	M_Title("COMANDOS DE IMPRESSORA FISCAL")
   nChoice := FazMenu( 07, 12, aMenu, Cor(), aEcfPermite )
	Do Case
	Case nChoice = 0
		Return
	Case nChoice = 1
      IF nTipo = 2
         EcfForma_Bema()
      Else
			ErrorBeep()
         Alerta('Erro: Nao disponivel para: ' + aEcf[nTipo])
      EndIF
   Case nChoice = 2
      IF nTipo = 2
			Aliquota_Bema()
      ElseIF nTipo = 5
			Aliquota_Sigtron()
      Else
			ErrorBeep()
         Alerta('Erro: Nao disponivel para: ' + aEcf[nTipo])
      EndIF
	Case nChoice = 3
      ErrorBeep()
      IF Conf('Warning! Reducao Z encerra o dia. Abortar?')
         Loop
      EndIF
		IF nTipo = 1
			LeituraZ_Zanthus()
		ElseIF nTipo = 2
			LeituraZ_Bema()
      ElseIF nTipo = 3
			LeituraZ_Zanthus()
      ElseIF nTipo = 4
			LeituraZ_Sigtron()
      ElseIF nTipo = 5
         Z_Sweda()
      ElseIF nTipo = 6
         Z_Daruma()
		EndIF
	Case nChoice = 4
      ErrorBeep()
      IF Conf('Pergunta: Impressao de Leitura X. Abortar?')
         Loop
      EndIF
		IF nTipo = 1
			LeituraX_Zanthus()
		ElseIF nTipo = 2
			LeituraX_Bema()
      ElseIF nTipo = 3
			LeituraX_Zanthus()
      ElseIF nTipo = 4
			LeituraX_SigTron()
      ElseIF nTipo = 5
         X_Sweda()
      ElseIF nTipo = 6
         X_Daruma()
		EndIF
	Case nChoice = 5
		IF nTipo = 1
			MeFisDat_Zanthus()
		ElseIF nTipo = 2
			MeFisDat_Bema()
      ElseIF nTipo = 3
			MeFisDat_Zanthus()
      ElseIF nTipo = 4
			MeFisDat_Sigtron()
      Else
			ErrorBeep()
         Alerta('Erro: Nao disponivel para: ' + aEcf[nTipo])
      EndIF
	Case nChoice = 6
		IF nTipo = 1
			MeFisInt_Zanthus()
		ElseIF nTipo = 2
			MeFisInt_Bema()
      ElseIF nTipo = 3
			MeFisInt_Zanthus()
      ElseIF nTipo = 4
			MeFisInt_SigTron()
      Else
			ErrorBeep()
         Alerta('Erro: Nao disponivel para: ' + aEcf[nTipo])
      EndIF
	Case nChoice = 7
      IF nTipo = 2
			ReGerenc_Bema()
      ElseIF nTipo = 4
			ReGerenc_Sigtron()
      Else
			ErrorBeep()
         Alerta('Erro: Nao disponivel para: ' + aEcf[nTipo])
		EndIF
	Case nChoice = 8
      IF nTipo = 1 .OR. nTipo = 3
         DiaInicio_Zanthus()
      Else
			ErrorBeep()
         Alerta('Erro: Nao disponivel para: ' + aEcf[nTipo])
      EndIF
	Case nChoice = 9
      IF nTipo = 1 .OR. nTipo = 3
         VerModulo_Zanthus()
      Else
			ErrorBeep()
         Alerta('Erro: Nao disponivel para: ' + aEcf[nTipo])
      EndIF
   Case nChoice = 10
      IF nTipo = 1 .OR. nTipo = 3
         DiaLivre_Zanthus()
      Else
			ErrorBeep()
         Alerta('Erro: Nao disponivel para: ' + aEcf[nTipo])
      EndIF
   EndCase
EndDo

Proc EcfForma_Bema()
********************
LOCAL cScreen := SaveScreen()
LOCAL Arq_Ant	  := Alias()
LOCAL Ind_Ant	  := IndexOrd()
LOCAL nPorta	  := 0
LOCAL cIni		  := chr(27) + chr(251)
LOCAL cFim		  := "|"+ chr(27)
LOCAL cBuffer	  := ""
LOCAL Retorno	  := 0
LOCAL lEcfRede   := oIni:ReadBool('ecf','ecfrede', FALSO )


IF !UsaArquivo("FORMA")
	Return
EndIF
Forma->(Order( FORMA_FORMA ))
Forma->(DbGoTop())
nPorta := BemaIniciaDriver()
Mensagem("Aguarde, Registrando formas de Pgto")
WHILE Forma->(!Eof())
	 cForma		:= Forma->Forma
	 cDescForma := Left( Forma->Condicoes, 16 )
	 IF cForma = "01"
		 Forma->(DbSkip(1))
	EndIF
   IF lEcfRede
      cBuffer    := "148|" + cDescForma + '|1|'
   Else
      cBuffer    := cIni + "71|" + cDescForma + cFim
   EndIF
	Comunica_Com_Impressora( nPorta, cBuffer, Retorno )
	Forma->(DbSkip(1))
EndDo
FClose( nPorta )
ResTela( cScreen )
Return

Proc ReGerenc_Bema()
********************
LOCAL cScreen := SaveScreen()
LOCAL Arq_Ant	  := Alias()
LOCAL Ind_Ant	  := IndexOrd()
LOCAL nPorta	  := 0
LOCAL cIni		  := chr(27) + chr(251)
LOCAL cFim		  := "|"+ chr(27)
LOCAL cBuffer	  := ""
LOCAL Retorno	  := 0

nPorta := BemaIniciaDriver()
Mensagem("Aguarde, Emitindo Relatorio Gerencial")
cBuffer	:= cIni + "20|" + "ANTES DA IMPRESSAO DESTE RELATORIO, SERA IMPRESSO A LEITURA 'X'" + cFim
Comunica_Com_Impressora( nPorta, cBuffer, Retorno )
cBuffer	:= cIni + "21|" + cFim
Comunica_Com_Impressora( nPorta, cBuffer, Retorno )
FClose( nPorta )
ResTela( cScreen )
Return

Function SwedaOn()
******************
Set Cons Off
Set Devi To Print
Set Print To IfSweda
Set Print On
SetPrc(0,0)
Return Nil

Function SwedaOff()
******************
Set Devi To Screen
Set Prin Off
Set Cons On
Set Print to
CloseSpooler()
Return Nil

Proc X_Sweda()
**************
SwedaOn()
Write( Prow(), Pcol(), Chr(27) + ".13N}" )
SwedaOff()
Return

Proc Z_Sweda()
**************
SwedaOn()
Write( Prow(), Pcol(), Chr(27) + ".14N}" )
SwedaOff()
Return

Proc LeituraX_Bema()
********************
LOCAL cScreen	:= SaveScreen()
LOCAL nPorta	:= 0
LOCAL cIni		:= chr(27) + chr(251)
LOCAL cFim		:= "|"+ chr(27)
LOCAL cBuffer	:= ""
LOCAL Retorno	:= 0
LOCAL lEcfRede := oIni:ReadBool('ecf','ecfrede', FALSO )

nPorta := BemaIniciaDriver()
Mensagem("Aguarde, Emitindo Leitura X")
IF lEcfRede
   cBuffer := "045|"
Else
   cBuffer := cIni + "06" + cFim
EndIF
Comunica_Com_Impressora( nPorta, cBuffer, Retorno )
FClose( nPorta )
ResTela( cScreen )
Return

Proc LeituraZ_Bema()
********************
LOCAL cScreen	:= SaveScreen()
LOCAL nPorta	:= 0
LOCAL cIni		:= chr(27) + chr(251)
LOCAL cFim		:= "|"+ chr(27)
LOCAL cBuffer	:= ""
LOCAL Retorno	:= 0
LOCAL lEcfRede := oIni:ReadBool('ecf','ecfrede', FALSO )

oMenu:Limpa()
nPorta := BemaIniciaDriver()
Mensagem("Aguarde, Emitindo Reducao Z")
IF lEcfRede
   cBuffer := '071|'
Else
   cBuffer := cIni + "05" + cFim
EndIF
Comunica_Com_Impressora( nPorta, cBuffer, Retorno )
FClose( nPorta )
ResTela( cScreen )
Return

Proc MeFisDat_Bema()
********************
LOCAL cScreen	:= SaveScreen()
LOCAL nPorta	:= 0
LOCAL cIni		:= chr(27) + chr(251)
LOCAL cFim		:= "|"+ chr(27)
LOCAL cPipe 	:= "|"
LOCAL cBuffer	:= ""
LOCAL Retorno	:= 0
LOCAL dIni		:= Date()
LOCAL dFim		:= Date()
LOCAL cSaida	:= "I"
LOCAL cDataIni := ""
LOCAL cDataFim := ""

MaBox( 10, 10, 13, 40 )
@ 11, 11 Say "Data Inicial..:" Get dIni Pict "##/##/##"
@ 12, 11 Say "Data Final....:" Get dFim Pict "##/##/##"
Read
IF LastKey() = ESC
	ResTela( cScreen )
	Return
EndIF
cDataIni := StrTran( Dtoc( dIni ), "/")
cDataFim := StrTran( Dtoc( dFim ), "/")
cDiaIni	:= Left( cDataIni, 2)
cMesIni	:= SubStr( cDataIni, 3, 2 )
cAnoIni	:= Right( cDataIni, 2 )
cDiaFim	:= Left( cDataFim, 2)
cMesFim	:= SubStr( cDataFim, 3, 2 )
cAnoFim	:= Right( cDataFim, 2 )

nPorta := BemaIniciaDriver()
Mensagem("Aguarde, Emitindo Leitura Memoria Fiscal")
cBuffer := cIni + "08" + cPipe
cBuffer += cDiaIni + cPipe
cBuffer += cMesIni + cPipe
cBuffer += cAnoIni + cPipe
cBuffer += cDiaFim + cPipe
cBuffer += cMesFim + cPipe
cBuffer += cAnoFim + cPipe
cBuffer += cSaida + cPipe + cFim
Comunica_Com_Impressora( nPorta, cBuffer, Retorno )
FClose( nPorta )
Return

Proc MeFisInt_Bema()
********************
LOCAL cScreen	:= SaveScreen()
LOCAL nPorta	:= 0
LOCAL cIni		:= chr(27) + chr(251)
LOCAL cFim		:= "|"+ chr(27)
LOCAL cBuffer	:= ""
LOCAL Retorno	:= 0
LOCAL nIni		:= 0
LOCAL nFim		:= 0
LOCAL cSaida	:= "I"
LOCAL cPipe 	:= "|"

MaBox( 10, 10, 13, 40 )
@ 11, 11 Say "Reducao Inicial.:" Get nIni Pict "9999"
@ 12, 11 Say "Reducao Final...:" Get nFim Pict "9999"
Read
IF LastKey() = ESC
	ResTela( cScreen )
	Return
EndIF
nPorta := BemaIniciaDriver()
Mensagem("Aguarde, Emitindo Leitura Memoria Fiscal")
cBuffer := cIni + "08" + cPipe + "00" + cPipe + ;
			  StrZero( nIni, 4, 0 ) + cPipe + "00" + cPipe + ;
			  StrZero( nFim, 4, 0 ) + cPipe + cSaida + cPipe + cfim
Comunica_Com_Impressora( nPorta, cBuffer, Retorno )
FClose( nPorta )
Return

Proc LeituraZ_Zanthus()
***********************
LOCAL cScreen	:= SaveScreen()
LOCAL nPorta	:= 0
LOCAL cBuffer	:= Space(134)

nPorta := Fopen("ECF$ZANT", FO_READWRITE )
if ferror () != 0
	Alert("Zanthus : Problemas de comunicacao.")
	Return
EndIF

Mensagem("Aguarde, Emitindo Leitura Z")
FWrite( nPorta, "~1/4/",5 )
FRead( nPorta, @cBuffer, 134 )
Response_Zanthus( nPorta, cBuffer )
// Espacejamento
cBuffer := "~2/U/$08$"
FWrite( nPorta, @cBuffer, Len( cBuffer ))
FClose( nPorta )
ResTela( cScreen )
Return

Proc Z_Daruma()
***************
LOCAL cScreen	:= SaveScreen()
LOCAL nPorta	:= 0
LOCAL cBuffer  := '1100';

nPorta := DarumaIniciaDriver(cBuffer)
Mensagem("Aguarde, Emitindo Leitura X")
FWrite( nPorta, cBuffer, Len(cBuffer))
FClose( nPorta )
ResTela( cScreen )
Return

Proc X_Daruma()
***************
LOCAL cScreen	:= SaveScreen()
LOCAL nPorta	:= 0
LOCAL cBuffer  := '1101';

nPorta := DarumaIniciaDriver(cBuffer)
Mensagem("Aguarde, Emitindo Leitura Z")
FWrite( nPorta, cBuffer, Len(cBuffer))
FClose( nPorta )
ResTela( cScreen )
Return

Proc LeituraZ_Sigtron()
***********************
LOCAL cScreen	:= SaveScreen()
LOCAL nPorta	:= 0
LOCAL cBuffer	:= Chr(27) + Chr(208)

nPorta := Fopen("SIGFIS", FO_READWRITE )
if ferror () != 0
	Alert("Sigtron : Problemas de comunicacao.")
	Return
EndIF

Mensagem("Aguarde, Emitindo Leitura Z")
FWrite( nPorta, cBuffer, 2 )
FClose( nPorta )
ResTela( cScreen )
Return

Proc ReGerenc_Sigtron()
***********************
LOCAL cScreen	:= SaveScreen()
LOCAL nPorta	:= 0
LOCAL cBuffer	:= Chr(27) + Chr(211)

nPorta := Fopen("SIGFIS", FO_READWRITE )
if ferror () != 0
	Alert("Sigtron : Problemas de comunicacao.")
	Return
EndIF

Mensagem("Aguarde, Emitindo Relatorio Gerencial.")
FWrite( nPorta, @cBuffer, Len( cBuffer ))
FClose( nPorta )
ResTela( cScreen )
Return

Proc LeituraX_Sigtron()
***********************
LOCAL cScreen	:= SaveScreen()
LOCAL nPorta	:= 0
LOCAL cBuffer	:= Space(134)
LOCAL Esc207	:= Chr(27) + Chr(207)

nPorta := Fopen("SIGFIS", FO_READWRITE )
if ferror () != 0
	Alert("SigTron : Problemas de comunicacao.")
	Return
EndIF

Mensagem("Aguarde, Emitindo Leitura X")
FWrite( nPorta, Esc207, 2 )
FClose( nPorta )
ResTela( cScreen )
Return

Proc LeituraX_Zanthus()
***********************
LOCAL cScreen	:= SaveScreen()
LOCAL nPorta	:= 0
LOCAL cBuffer	:= Space(134)

nPorta := Fopen("ECF$ZANT", FO_READWRITE )
if ferror () != 0
	Alert("Zanthus : Problemas de comunicacao.")
	Return
EndIF

Mensagem("Aguarde, Emitindo Leitura X")
FWrite( nPorta, "~1/3/",5 )
FRead( nPorta, @cBuffer, 134 )
Response_Zanthus( nPorta, cBuffer )
// Espacejamento
cBuffer := "~2/U/$08$"
FWrite( nPorta, @cBuffer, Len( cBuffer ))
FClose( nPorta )
ResTela( cScreen )
Return

Proc DiaInicio_Zanthus()
************************
LOCAL cScreen	:= SaveScreen()
LOCAL nPorta	:= 0
LOCAL cBuffer	:= Space(134)

nPorta := Fopen("ECF$ZANT", FO_READWRITE )
if ferror () != 0
	Alert("Zanthus : Problemas de comunicacao.")
	Return
EndIF
Mensagem("Aguarde, Iniciando Dia Fiscal")
FWrite( nPorta, "~1/1/")
FRead( nPorta, @cBuffer, 134 )
// Espacejamento
cBuffer := "~2/U/$08$"
FWrite( nPorta, @cBuffer, Len( cBuffer ))
IF Response_Zanthus( nPorta, cBuffer )
	Alerta("OK")
EndIF
FClose( nPorta )
ResTela( cScreen )
Return

Proc DiaLivre_Zanthus()
************************
LOCAL cScreen	:= SaveScreen()
LOCAL nPorta	:= 0
LOCAL cBuffer	:= Space(134)

nPorta := Fopen("ECF$ZANT", FO_READWRITE )
if ferror () != 0
	Alert("Zanthus : Problemas de comunicacao.")
	Return
EndIF

Mensagem("Aguarde, Verificando Dia Livre")
FWrite( nPorta, "~1/K/")
FRead( nPorta, @cBuffer, 134 )
IF Response_Zanthus( nPorta, cBuffer )
	Alerta("OK")
EndIF
FClose( nPorta )
ResTela( cScreen )
Return

Proc VerModulo_Zanthus()
************************
LOCAL cScreen	:= SaveScreen()
LOCAL nPorta	:= 0
LOCAL cBuffer	:= Space(134)

nPorta := Fopen("ECF$ZANT", FO_READWRITE )
if ferror () != 0
	Alert("Zanthus : Problemas de comunicacao.")
	Return
EndIF

Mensagem("Aguarde, Verificando Modulo Fiscal")
FWrite( nPorta, "~1/5/")
FRead( nPorta, @cBuffer, 134 )
IF Response_Zanthus( nPorta, cBuffer )
	Alerta("OK")
EndIF
FClose( nPorta )
ResTela( cScreen )
Return

Proc MeFisDat_Zanthus()
***********************
LOCAL cScreen	:= SaveScreen()
LOCAL nPorta	:= 0
LOCAL cBuffer	:= Space(134)
LOCAL dIni		:= Date()
LOCAL dFim		:= Date()
LOCAL cSaida	:= "I"
LOCAL cDataIni := ""
LOCAL cDataFim := ""
LOCAL cString	:= ""

oMenu:Limpa()
MaBox( 10, 10, 13, 40 )
@ 11, 11 Say "Data Inicial..:" Get dIni Pict "##/##/##"
@ 12, 11 Say "Data Final....:" Get dFim Pict "##/##/##"
Read
IF LastKey() = ESC
	ResTela( cScreen )
	Return
EndIF
cDataIni := StrTran( Dtoc( dIni ), "/")
cDataFim := StrTran( Dtoc( dFim ), "/")

nPorta := Fopen("ECF$ZANT", FO_READWRITE )
if ferror () != 0
	Alert("Zanthus : Problemas de comunicacao.")
	Return
EndIF
Mensagem("Aguarde, Emitindo Relatorio Fiscal")
cString := "~2/G/$" + cDataIni + cDataFim + "$"
FWrite( nPorta, cString)
FRead( nPorta, @cBuffer, 134 )
Response_Zanthus( nPorta, cBuffer )
FClose( nPorta )
ResTela( cScreen )
Return

Proc MeFisDat_SigTron()
***********************
LOCAL cScreen	:= SaveScreen()
LOCAL nPorta	:= 0
LOCAL cBuffer	:= Space(134)
LOCAL dIni		:= Date()
LOCAL dFim		:= Date()
LOCAL cSaida	:= "I"
LOCAL cDataIni := ""
LOCAL cDataFim := ""
LOCAL cString	:= ""

oMenu:Limpa()
MaBox( 10, 10, 13, 40 )
@ 11, 11 Say "Data Inicial..:" Get dIni Pict "##/##/##"
@ 12, 11 Say "Data Final....:" Get dFim Pict "##/##/##"
Read
IF LastKey() = ESC
	ResTela( cScreen )
	Return
EndIF
cDataIni := StrTran( Dtoc( dIni ), "/")
cDataFim := StrTran( Dtoc( dFim ), "/")

nPorta := Fopen("SIGFIS", FO_READWRITE )
if ferror () != 0
	Alert("SigTron : Problemas de comunicacao.")
	Return
EndIF
Mensagem("Aguarde, Emitindo Relatorio Fiscal")
cString := Chr(27) + Chr(209) + 'x' + cDataIni + cDataFim
FWrite( nPorta, @cString, Len( cString ))
FClose( nPorta )
ResTela( cScreen )
Return

Proc MeFisInt_Zanthus()
***********************
LOCAL cScreen	:= SaveScreen()
LOCAL nPorta	:= 0
LOCAL nIni		:= 0
LOCAL nFim		:= 0
LOCAL cBuffer	:= Space(134)
LOCAL cString	:= ""

oMenu:Limpa()
MaBox( 10, 10, 13, 40 )
@ 11, 11 Say "Reducao Inicial.:" Get nIni Pict "9999"
@ 12, 11 Say "Reducao Final...:" Get nFim Pict "9999"
Read
IF LastKey() = ESC
	ResTela( cScreen )
	Return
EndIF
cIni := StrZero( nIni, 4 )
cFim := StrZero( nFim, 4 )

nPorta := Fopen("ECF$ZANT", FO_READWRITE )
if ferror () != 0
	Alert("Zanthus : Problemas de comunicacao.")
	Return
EndIF
Mensagem("Aguarde, Emitindo Relatorio Fiscal")
cString := "~2/G/$" + cIni + cFim + "$"
//cString := "~1/G/$" + cIni + cFim + " $"
FWrite( nPorta, cString)
FRead( nPorta, @cBuffer, 134 )
Response_Zanthus( nPorta, cBuffer )
FClose( nPorta )
ResTela( cScreen )
Return

Proc MeFisInt_SigTron()
***********************
LOCAL cScreen	:= SaveScreen()
LOCAL nPorta	:= 0
LOCAL nIni		:= 0
LOCAL nFim		:= 0
LOCAL cBuffer	:= Space(134)
LOCAL cString	:= ""

oMenu:Limpa()
MaBox( 10, 10, 13, 40 )
@ 11, 11 Say "Reducao Inicial.:" Get nIni Pict "999999"
@ 12, 11 Say "Reducao Final...:" Get nFim Pict "999999"
Read
IF LastKey() = ESC
	ResTela( cScreen )
	Return
EndIF
cIni := StrZero( nIni, 6 )
cFim := StrZero( nFim, 6 )

nPorta := Fopen("SIGFIS", FO_READWRITE )
if ferror () != 0
	Alert("SigTron : Problemas de comunicacao.")
	Return
EndIF
Mensagem("Aguarde, Emitindo Relatorio Fiscal")
cString := Chr(27) + Chr(29) + 'x' + cIni + cFim
FWrite( nPorta, @cString, Len(cString ))
FClose( nPorta )
ResTela( cScreen )
Return

Function TiraString( cBuffer )
******************************
Return( SubStr( cBuffer, 4, 1))

Function Response_Zanthus( nPorta, cBuffer )
********************************************
FWrite( nPorta, "~6/", 3)       // Retorno em ASCII da ultima resposta.
FRead( nPorta, @cBuffer, 134 )
Return( Erro_Zanthus( TiraString( cBuffer )))

Function Erro_Zanthus( nRetorno )
*********************************
nIniEcf	:= oIni:ReadInteger('ecf','modelo', 1 )
IF nIniEcf = 1
	Erro_Iz11( nRetorno )
ElseIF nIniEcf = 2
	Erro_Iz20( nRetorno )
EndIF
Return

Function Erro_Iz20( nRetorno )
******************************
LOCAL aResposta := {}
LOCAL nPos		 := 0

Aadd( aResposta, { "0", "Sucesso" })
Aadd( aResposta, { "1", "Comando nao pode ser executado no presente estado do Modulo Fiscal" })
Aadd( aResposta, { "2", "Argumento de Entrada sao inconsistente"})
Aadd( aResposta, { "3", "Comando nao executado porque o valor passado e muito elevado"})
Aadd( aResposta, { "4", "Configuracao do Modulo Fiscal nao permite a execucao do comando"})
Aadd( aResposta, { "5", "Memoria Fiscal Esgotada"})
Aadd( aResposta, { "6", "Memoria Fiscal ja inicializada"})
Aadd( aResposta, { "7", "Falha ao inicializar memoria fiscal"})
Aadd( aResposta, { "8", "Memoria Fiscal ja tem numero de serie"})
Aadd( aResposta, { "9", "Memoria Fiscal nao esta inicializada"})
Aadd( aResposta, { ":", "Falha ao gravar na Memoria Fiscal"})
Aadd( aResposta, { ";", "Papel no fim"})
Aadd( aResposta, { "<", "Falha na impressora Fiscal"})
Aadd( aResposta, { "=", "Memoria do Modulo Fiscal Violada"})
Aadd( aResposta, { ">", "Falta Memoria Fiscal"})
Aadd( aResposta, { "?", "Comando Inexistente"})
Aadd( aResposta, { "@", "Deve fazer Reducao"})
Aadd( aResposta, { "A", "Memoria do Modulo Fiscal desprotegida (lacre rompido)"})
Aadd( aResposta, { "B", "Data nao permite operacao"})
Aadd( aResposta, { "C", "Fim de Tabela (de CGC/IE ou de dias)"})
Aadd( aResposta, { "D", "Dados Fixos do Modulo Fiscal estao inconsistentes"})
Aadd( aResposta, { "E", "Falha ao configurar dimensoes de cheque para impressao"})
Aadd( aResposta, { "F", "Falha ao imprimir cheque"})
Aadd( aResposta, { "O", "Indica que a mensagem foi recebida com byte de verificacao incorreto"})
Aadd( aResposta, { "P", "Indica erro nos argumentos passados"})
Aadd( aResposta, { "Q", "Indica erro no numero de controle de passagem"})
Aadd( aResposta, { "R", "Indica que a resposta recebida nao e valida"})
Aadd( aResposta, { "S", "Indica que ultrapassou o maximo de tentativas de comunicacao com a impressora"})
Aadd( aResposta, { "T", "Indica falha na transmissao de dados para a impressora"})
Aadd( aResposta, { "U", "Indica que ultrapassou tempo maximo de espera de uma resposta da impressora"})
Aadd( aResposta, { "V", "Indica que o comando enviado nao foi reconhecido pela impressora"})
Aadd( aResposta, { "W", "Indica que a impressora deve estar desligada"})
Aadd( aResposta, { "X", "Indica que a serial detectou algum erro na recepcao (overrun, framing,etc)"})
Aadd( aResposta, { "Y", "Indica que a resposta recebida esta fora do protocolo"})
Aadd( aResposta, { "Z", "Indica que o comando foi enviado, mas a resposta foi perdida"})
Aadd( aResposta, { "[", "Indica que o comando foi enviado, mas os dados de retorno foram perdidos"})
Aadd( aResposta, { "m", "Indica que o a operacao solicitada nao e permitida no dispositivo ECF controlado"})
Aadd( aResposta, { "v", "Indica que os parametros enviados ao Device Drive estao incompletos"})
Aadd( aResposta, { "w", "Indica que os parametros passados ultrapassaram o tamanho maximo permitido"})
Aadd( aResposta, { "x", "Indica que os dados solicitados ultrapassaram o tamanho maximo permitido"})
Aadd( aResposta, { "y", "Indica que o banco passado como parametro nao esta na faixa de 1 a 999"})
Aadd( aResposta, { "z", "Indica que o banco cujos dados foram solicitados nao esta cadastrado"})

nPos := Ascan2( aResposta, nRetorno, 1 )
IF nPos = 0 .OR. nPos = 1
	Return( OK )
EndIF
Alerta( aResposta[nPos, 2])
Return( FALSO )

Function Erro_Iz11( nRetorno )
******************************
LOCAL aResposta := {}
LOCAL nPos		 := 0

Aadd( aResposta, { "0", "Sucesso" })
Aadd( aResposta, { "1", "Comando nao pode ser executado no presente estado do Modulo Fiscal" })
Aadd( aResposta, { "2", "Argumento de Entrada sao inconsistente"})
Aadd( aResposta, { "3", "Comando nao executado porque o valor passado e muito elevado"})
Aadd( aResposta, { "4", "Configuracao do Modulo Fiscal nao permite a execucao do comando"})
Aadd( aResposta, { "5", "Memoria Fiscal Esgotada"})
Aadd( aResposta, { "6", "Memoria Fiscal ja inicializada"})
Aadd( aResposta, { "7", "Falha ao inicializar memoria fiscal"})
Aadd( aResposta, { "8", "Memoria Fiscal ja tem numero de fabricacao"})
Aadd( aResposta, { "9", "Memoria Fiscal nao esta inicializada"})
Aadd( aResposta, { "10", "Falha ao gravar na Memoria Fiscal"})
Aadd( aResposta, { "11", "Papel no fim"})
Aadd( aResposta, { "12", "Falha na impressora Fiscal"})
Aadd( aResposta, { "13", "Memoria do Modulo Fiscal Violada"})
Aadd( aResposta, { "14", "Falta Memoria Fiscal"})
Aadd( aResposta, { "15", "Comando Inexistente"})
Aadd( aResposta, { "16", "Deve fazer Reducao"})
Aadd( aResposta, { "17", "Memoria do Modulo Fiscal desprotegida (lacre rompido)"})
Aadd( aResposta, { "18", "Data nao permite operacao"})
Aadd( aResposta, { "19", "Fim de Tabela (de CGC/IE ou de dias)"})
Aadd( aResposta, { "20", "Dados Fixos do Modulo Fiscal estao inconsistentes"})
Aadd( aResposta, { "21", "Falha ao configurar dimensoes de cheque para impressao"})
Aadd( aResposta, { "22", "Falha ao imprimir cheque"})
Aadd( aResposta, { "23", "Falha ao alterar relogio"})
Aadd( aResposta, { "24", "Linha nao pode ser impressa"})
Aadd( aResposta, { "25", "Item ja foi cancelado"})
Aadd( aResposta, { "26", "Item nao tem descritivo armazenado"})
Aadd( aResposta, { "27", "Tempo Excedido"})
Aadd( aResposta, { "28", "Modulo Fiscal sem Forma de Pgto Cadastrado"})
Aadd( aResposta, { "29", "Versao do Modulo Fiscal difere da gaveta"})

Pos := Ascan2( aResposta, nRetorno, 1 )
IF nPos = 0 .OR. nPos = 1
	Return( OK )
EndIF
Alerta( aResposta[nPos, 2])
Return( FALSO )

Proc FiscalRegedit()
********************
LOCAL cScreen	:= SaveScreen()
LOCAL aFiscal	:= {}
LOCAL oFiscal	:= AbreIniFiscal()

Mensagem("Aguarde, Verificando Direitos do Usuario.")
Aadd( aFiscal, { 2.01, oFiscal:ReadBool( 'impressorasfiscais', '#2.01', OK )})
Aadd( aFiscal, { 2.02, oFiscal:ReadBool( 'impressorasfiscais', '#2.02', OK )})
Aadd( aFiscal, { 2.03, oFiscal:ReadBool( 'impressorasfiscais', '#2.03', OK )})
Aadd( aFiscal, { 2.04, oFiscal:ReadBool( 'impressorasfiscais', '#2.04', OK )})
Aadd( aFiscal, { 2.05, oFiscal:ReadBool( 'impressorasfiscais', '#2.05', OK )})
Aadd( aFiscal, { 2.06, oFiscal:ReadBool( 'impressorasfiscais', '#2.06', OK )})
Aadd( aFiscal, { 2.07, oFiscal:ReadBool( 'impressorasfiscais', '#2.07', OK )})
Aadd( aFiscal, { 2.08, oFiscal:ReadBool( 'impressorasfiscais', '#2.08', OK )})
Aadd( aFiscal, { 2.09, oFiscal:ReadBool( 'impressorasfiscais', '#2.09', OK )})
Aadd( aFiscal, { 2.10, oFiscal:ReadBool( 'impressorasfiscais', '#2.10', OK )})
Aadd( aFiscal, { 2.11, oFiscal:ReadBool( 'impressorasfiscais', '#2.11', OK )})
ResTela( cScreen )
Return( aFiscal )

Function AbreIniFiscal()
*************************
	Return( oFiscal := TIniNew(oAmbiente:xUsuario + ".INI"))

Function SnFiscal( nChoice )
*****************************
LOCAL nPos := 0

nPos := Ascan2( oAmbiente:aFiscalIni, nChoice, 1 )
IF nPos = 0
	Return( FALSO )
EndIF
Return( oAmbiente:aFiscalIni[nPos, 2])

Proc Reindexar()
****************
LOCAL cScreen := SaveScreen()
LOCAL GetList := {}
LOCAL aMenu   := {"Limpar Marcacao de Arquivos", "Marcar Arquivos para reindexar"}
LOCAL nChoice := 0

WHILE OK
	oMenu:Limpa()
	M_Title("ESCOLHA SUA OPCAO")
	nChoice := FazMenu( 05, 10, aMenu )
	Do Case
	Case nChoice = 0
		ResTela( cScreen )
		Return
	Case nChoice = 1
		LimparMarcacao()
	Case nChoice = 2
		ReindParcial()
	EndCase
EndDo

Proc LimparMarcacao()
*********************
LOCAL cScreen		:= SaveScreen()
LOCAL aArquivos	:= ArrayArquivos()
LOCAL nTam			:= Len( aArquivos )
LOCAL nNx			:= 0

Mensagem("Aguarde, Limpando marcacao de Arquivos")
For nX := 1 To nTAm
	oIni:WriteString('indices', aArquivos[nX,1], '1' )
Next
Alerta("Informa: Limpeza efetudada com sucesso.")
ResTela( cScreen )
Return

Proc ReindParcial()
*******************
LOCAL cScreen		:= SaveScreen()
LOCAL aMenu 		:= {}
LOCAL aTemp 		:= {}
LOCAL aDisponivel := {}
LOCAL aEscolhido	:= {}
LOCAL aArquivos	:= ArrayArquivos()
LOCAL nTam			:= 0
LOCAL nNx			:= 0
LOCAL nPosicao 	:= 1
LOCAL nQuant		:= 0
LOCAL cBuffer		:= ''
LOCAL cUser 		:= ''
LOCAL cData 		:= ''
LOCAL cFim			:= ''

WHILE OK
	aEscolhido := {}
	nQuant	  := 0
	aTemp 	  := {}
	nTam		  := Len( aArquivos )
	WHILE OK
		aMenu 		:= {}
		aDisponivel := {}
		For nX := 1 To nTAm
			lOk	:= oIni:ReadString('indices', aArquivos[nX,1], '1', 1 )
			cUser := oIni:ReadString('indices', aArquivos[nX,1], space(10), 2 )
			cData := oIni:ReadString('indices', aArquivos[nX,1], Space(08), 3 )
			cTime := oIni:ReadString('indices', aArquivos[nX,1], Space(08), 4 )
			cFim	:= oIni:ReadString('indices', aArquivos[nX,1], Space(08), 5 )
			Aadd( aDisponivel, IF( lOk == '1', OK, FALSO ))
			Aadd( aMenu, aArquivos[nX,1] + Space(14-Len(AllTrim(aArquivos[nX,1]))) + '³' + AllTrim( cUser ) + Space(10-Len(AllTrim(cUser))) + '³' + cData + '³' + cTime  + '³' + cFim )
			Aadd( aTemp, aArquivos[nX,1])
		Next
		oMenu:Limpa()
		MaBox( 02, 09, 21, 66, 'ARQUIVO        USUARIO    DATA     INICIO   FIM     ' )
		nChoice := Achoice( 03, 10, 20, 65, aMenu, aDisponivel, nPosicao )
		IF nChoice = 0
			Exit
		EndIF
		lOk	:= oIni:ReadString('indices', aArquivos[nChoice,1], '1', 1 )
		cUser := oIni:ReadString('indices', aArquivos[nChoice,1], space(10), 2 )
		IF lOk = '0'
			Alerta('Erro: Marcado Por :' + cUser )
			Loop
		EndIF
		cBuffer := '0'
		cBuffer += ';'
		cBuffer += oAmbiente:xUsuario
		cBuffer += ';'
		cBuffer += Dtoc( Date())
		cBuffer += ';'
		cBuffer += 'MARCADO '
		oIni:WriteString('indices', aArquivos[nChoice,1], cBuffer )
		Aadd( aEscolhido, AllTrim(StrTran( aTemp[nChoice],'.DBF')))
		nQuant++
		aMenu[nChoice] 		 += " û "
		aDisponivel[nChoice]  := FALSO
		nPosicao 				 := nChoice + 1
	EndDo
	oMenu:Limpa()
	IF nQuant > 0
		nTam := Len( aEscolhido )
		IF Conf('Pergunta: Reindexar arquivos marcados ?')
			FechaTudo()
			For nX := 1 To nTam
				IF !NetUse( aEscolhido[nX], MONO ) ; ResTela( cScreen ); Return(FALSO) ; EndIF
				cTime := Time()
				oIni:WriteString('indices', aEscolhido[nX] + '.DBF', cBuffer )
				CriaIndice( aEscolhido[nX] )
				cBuffer	:= '0'
				cBuffer += ';'
				cBuffer += oAmbiente:xUsuario
				cBuffer += ';'
				cBuffer += Dtoc( Date())
				cBuffer += ';'
				cBuffer += cTime
				cBuffer += ';'
				cBuffer += Time()
				oIni:WriteString('indices', aEscolhido[nX] + '.DBF', cBuffer )
			Next
		Else
			For nX := 1 To nTam
				oIni:WriteString('indices', aEscolhido[nX] + '.DBF', '1' )
			Next
		EndIF
	Else
		Exit
	EndiF
EndDo
ResTela( cScreen )
Return

Proc Aliquota_Sigtron()
***********************
LOCAL cScreen	 := SaveScreen()
LOCAL GetList	 := {}
LOCAL cAliquota := Space(04)
LOCAL nTipo 	 := 0
LOCAL nPorta	 := 0
LOCAL cBuffer	 := ''
LOCAL cRetorno  := ''

oMenu:Limpa()
cAliquota := Space(04)
MaBox( 10, 10, 13, 40 )
@ 11, 11 Say "Aliquota..." Get cAliquota Pict "9999" Valid IF( Empty( cAliquota ), ( ErrorBeep(), Alerta("Erro: Entrada Invalida"), FALSO ), OK )
@ 12, 11 Say "Tipo......." Get nTipo     Pict "9"    Valid PickTam({"Icms", "Iss"}, {1,2}, @nTipo )
Read
IF LastKey() = ESC
	ResTela( cScreen )
	Return
EndIF
ErrorBeep()
IF Conf("Pergunta: Registrar Aliquota ?")
	nPorta  := SigtronIniciaDriver(cBuffer)
	cBuffer := Chr(27) + Chr(220)
	IF nTipo = 2
	  cBuffer += 'S'
	EndIF
	cBuffer += cAliquota
	FWrite( nPorta, @cBuffer, Len( cBuffer ))
	FClose( nPorta )
EndIF
Restela( cScreen )
Return

Proc Aliquota_Bema()
********************
LOCAL cScreen	 := SaveScreen()
LOCAL GetList	 := {}
LOCAL cAliquota := Space(04)
LOCAL nTipo 	 := 0
LOCAL nPorta	 := 0
LOCAL cBuffer	 := ''
LOCAL cIcms 	 := '0'
LOCAL cIss		 := '1'
LOCAL lEcfRede  := oIni:ReadBool('ecf','ecfrede', FALSO )
LOCAL Retorno

oMenu:Limpa()
cAliquota := Space(04)
MaBox( 10, 10, 13, 40 )
@ 11, 11 Say "Aliquota..." Get cAliquota Pict "9999" Valid !Empty( cAliquota ) //Bema_VerAliquota( cAliquota )
@ 12, 11 Say "Tipo......." Get nTipo     Pict "9"    Valid PickTam({"Icms", "Iss"}, {1,2}, @nTipo )
Read
IF LastKey() = ESC
	ResTela( cScreen )
	Return
EndIF
ErrorBeep()
IF Conf("Pergunta: Registrar Aliquota ?")
	nPorta := BemaIniciaDriver()
	IF Ferror () != 0
		Alerta("Bematech : Problemas de comunicacao.")
		Restela( cScreen )
		Return
	EndIF
   IF lEcfRede
      cBuffer    := '063|' + cAliquota + '|' + IF( nTipo = 1, '0', '1' ) + '|'
   Else
      cBuffer    := Chr(27) + Chr(251) + "07|" + cAliquota + IF( nTipo = 1, cIcms, cIss ) + '|' + Chr(27)
   EndIF
	Fwrite( nPorta, @cBuffer, Len( cBuffer ))
   Comunica_Com_Impressora( nPorta, cBuffer, Retorno )
	FClose( nPorta )
EndIF
Restela( cScreen )
Return

Function Bema_VerAliquota( cAliquota )
**************************************
	LOCAL aAliquota := {}
	LOCAL cBuffer	 := Chr(27) + Chr(251) + "26" + '|' + Chr(27)
	LOCAL cRetorno  := ''
	LOCAL cString	 := ''
	LOCAL nX 		 := 0
	LOCAL nPos		 := 0
	LOCAL nPorta	 := 0

	nPorta := BemaIniciaDriver()
	IF Ferror () != 0
		Alerta("BEMATECH: Problemas de comunicacao.")
		ResTela( cScreen )
		Return( FALSO )
	EndIF

	cRetorno := Comunica_Com_Impressora( nPorta, cBuffer, 66 )
	FClose( nPorta )
	For nX := 1 To 16
		 cString := SubStr( cRetorno,((nX*4)-3)+2,4)
		 Aadd( aAliquota, cString )
	Next
	nPos := Ascan( aAliquota, cAliquota )
	IF nPos <> 0
		ErrorBeep()
		IF Conf("Erro : Aliquota ja registrada. Posicao # " + StrZero(nPos, 2) + '. Continuar ?')
			Return( OK )
		Else
			Return( FALSO )
		EndIF
	EndIF
Return( OK )

Function LigaDisp()
*******************
	LOCAL aDisp := {}
	Aadd( aDisp,{ LIG,  LIG,  LIG,  LIG,  LIG ,	LIG,	LIG,	LIG,	LIG,	LIG, LIG,  LIG,  LIG,  LIG,  LIG,  LIG,  LIG,  LIG, LIG, LIG,	LIG,	LIG })
	Aadd( aDisp,{ LIG,  LIG,  LIG,  LIG,  LIG ,	LIG,	LIG,	LIG,	LIG,	LIG, LIG,  LIG,  LIG,  LIG,  LIG,  LIG,  LIG,  LIG, LIG, LIG,	LIG,	LIG })
	Aadd( aDisp,{ LIG,  LIG,  LIG,  LIG,  LIG ,	LIG,	LIG,	LIG,	LIG,	LIG, LIG,  LIG,  LIG,  LIG,  LIG,  LIG,  LIG,  LIG, LIG, LIG,	LIG,	LIG })
	Aadd( aDisp,{ LIG,  LIG,  LIG,  LIG,  LIG ,	LIG,	LIG,	LIG,	LIG,	LIG, LIG,  LIG,  LIG,  LIG,  LIG,  LIG,  LIG,  LIG, LIG, LIG,	LIG,	LIG })
	Aadd( aDisp,{ LIG,  LIG,  LIG,  LIG,  LIG ,	LIG,	LIG,	LIG,	LIG,	LIG, LIG,  LIG,  LIG,  LIG,  LIG,  LIG,  LIG,  LIG, LIG, LIG,	LIG,	LIG })
	Aadd( aDisp,{ LIG,  LIG,  LIG,  LIG,  LIG ,	LIG,	LIG,	LIG,	LIG,	LIG, LIG,  LIG,  LIG,  LIG,  LIG,  LIG,  LIG,  LIG, LIG, LIG,	LIG,	LIG })
	Aadd( aDisp,{ LIG,  LIG,  LIG,  LIG,  LIG ,	LIG,	LIG,	LIG,	LIG,	LIG, LIG,  LIG,  LIG,  LIG,  LIG,  LIG,  LIG,  LIG, LIG, LIG,	LIG,	LIG })
	Aadd( aDisp,{ LIG,  LIG,  LIG,  LIG,  LIG ,	LIG,	LIG,	LIG,	LIG,	LIG, LIG,  LIG,  LIG,  LIG,  LIG,  LIG,  LIG,  LIG, LIG, LIG,	LIG,	LIG })
	Aadd( aDisp,{ LIG,  LIG,  LIG,  LIG,  LIG ,	LIG,	LIG,	LIG,	LIG,	LIG, LIG,  LIG,  LIG,  LIG,  LIG,  LIG,  LIG,  LIG, LIG, LIG,	LIG,	LIG })
	Aadd( aDisp,{ LIG,  LIG,  LIG,  LIG,  LIG ,	LIG,	LIG,	LIG,	LIG,	LIG, LIG,  LIG,  LIG,  LIG,  LIG,  LIG,  LIG,  LIG, LIG, LIG,	LIG,	LIG })
	Aadd( aDisp,{ LIG,  LIG,  LIG,  LIG,  LIG ,	LIG,	LIG,	LIG,	LIG,	LIG, LIG,  LIG,  LIG,  LIG,  LIG,  LIG,  LIG,  LIG, LIG, LIG,	LIG,	LIG })
	Aadd( aDisp,{ LIG,  LIG,  LIG,  LIG,  LIG ,	LIG,	LIG,	LIG,	LIG,	LIG, LIG,  LIG,  LIG,  LIG,  LIG,  LIG,  LIG,  LIG, LIG, LIG,	LIG,	LIG })
	Aadd( aDisp,{ LIG,  LIG,  LIG,  LIG,  LIG ,	LIG,	LIG,	LIG,	LIG,	LIG, LIG,  LIG,  LIG,  LIG,  LIG,  LIG,  LIG,  LIG, LIG, LIG,	LIG,	LIG })
	Aadd( aDisp,{ LIG,  LIG,  LIG,  LIG,  LIG ,	LIG,	LIG,	LIG,	LIG,	LIG, LIG,  LIG,  LIG,  LIG,  LIG,  LIG,  LIG,  LIG, LIG, LIG,	LIG,	LIG })
Return( aDisp )

Proc ConfIniReceber( cNome )
****************************
LOCAL cScreen	:= SaveScreen()
LOCAL GetList	:= {}
LOCAL oRecelan := TIniNew( cNome + ".INI")
LOCAL oConf 	:= TAmbienteNew()
LOCAL aDisp 	:= aDispRecelan()
LOCAL nMaior	:= 1
LOCAL nMenor	:= 1
LOCAL cMaior	:= ''
LOCAL cMenor	:= ''
LOCAL cRegra	:= ''
LOCAL op 		:= 1

oConf:Disp		 := aDisp
oConf:Ativo 	 := 1
oConf:Menu		 := oMenuRecelan()
oConf:NomeFirma := oMenu:NomeFirma
oConf:CodiFirma := oMenu:CodiFirma
oConf:StatusSup := SISTEM_NA3 + " " + SISTEM_VERSAO
oConf:StatusInf := "USE A BARRA DE ESPACO PARA DESABILITAR OPCAO"
oConf:Alterando := OK
WHILE OK
	Op := oConf:Show()
	Do Case
	Case Op = 0.0 .OR. Op = 1.01
		ErrorBeep()
		IF Conf("Pergunta: Gravar Alteracoes ?")
			For i := 1 To 7
				For x := 1 To 22
               cMaior  := Strzero(i, 2)
               cMenor  := Strzero(x, 2)
					cRegra  := '#' + cMaior + '.' + cMenor
					oRecelan:WriteBool('recelan', cRegra, aDisp[i, x])
				Next
			Next
		EndIF
		Return
	OtherWise
		nMenor := Val(Right(Tran( Op, '99.99'),2))
		nMaior := Int( Op )
		aDisp[nMaior,nMenor] := If( aDisp[nMaior][nMenor] = OK, FALSO, OK )
	EndCase
EndDo

Proc ConfIniPagar( cNome )
**************************
LOCAL cScreen	:= SaveScreen()
LOCAL GetList	:= {}
LOCAL oPagalan := TIniNew( cNome + ".INI")
LOCAL oConf 	:= TAmbienteNew()
LOCAL aDisp 	:= aDispPagaLan()
LOCAL nMaior	:= 1
LOCAL nMenor	:= 1
LOCAL cMaior	:= ''
LOCAL cMenor	:= ''
LOCAL cRegra	:= ''
LOCAL op 		:= 1

oConf:Disp		 := aDisp
oConf:Ativo 	 := 1
oConf:Menu		 := oMenuPagalan()
oConf:NomeFirma := oMenu:NomeFirma
oConf:CodiFirma := oMenu:CodiFirma
oConf:StatusSup := SISTEM_NA4 + " " + SISTEM_VERSAO
oConf:StatusInf := "USE A BARRA DE ESPACO PARA DESABILITAR OPCAO"
oConf:Alterando := OK
WHILE OK
	Op := oConf:Show()
	Do Case
	Case Op = 0.0 .OR. Op = 1.01
		ErrorBeep()
		IF Conf("Pergunta: Gravar Alteracoes ?")
			For i := 1 To 7
				For x := 1 To 22
               cMaior  := StrZero(i,2)
               cMenor  := Strzero(x,2)
					cRegra  := '#' + cMaior + '.' + cMenor
					oPagalan:WriteBool('pagalan', cRegra, aDisp[i, x])
				Next
			Next
		EndIF
		Return
	OtherWise
		nMenor := Val(Right(Tran( Op, '99.99'),2))
		nMaior := Int( Op )
		aDisp[nMaior,nMenor] := If( aDisp[nMaior][nMenor] = OK, FALSO, OK )
	EndCase
EndDo

Proc ConfIniCorrentes( cNome )
******************************
LOCAL cScreen	:= SaveScreen()
LOCAL GetList	:= {}
LOCAL oPagalan := TIniNew( cNome + ".INI")
LOCAL oConf 	:= TAmbienteNew()
LOCAL aDisp 	:= aDispChelan()
LOCAL nMaior	:= 1
LOCAL nMenor	:= 1
LOCAL cMaior	:= ''
LOCAL cMenor	:= ''
LOCAL cRegra	:= ''
LOCAL op 		:= 1

oConf:Disp		 := aDisp
oConf:Ativo 	 := 1
oConf:Menu		 := oMenuChelan()
oConf:NomeFirma := oMenu:NomeFirma
oConf:CodiFirma := oMenu:CodiFirma
oConf:StatusSup := SISTEM_NA5 + " " + SISTEM_VERSAO
oConf:StatusInf := "USE A BARRA DE ESPACO PARA DESABILITAR OPCAO"
oConf:Alterando := OK
WHILE OK
	Op := oConf:Show()
	Do Case
	Case Op = 0.0 .OR. Op = 1.01
		ErrorBeep()
		IF Conf("Pergunta: Gravar Alteracoes ?")
			For i := 1 To 8
				For x := 1 To 22
               cMaior  := Strzero(i,2)
               cMenor  := Strzero(x,2)
					cRegra  := '#' + cMaior + '.' + cMenor
					oPagalan:WriteBool('chelan', cRegra, aDisp[i, x])
				Next
			Next
		EndIF
		Return
	OtherWise
		nMenor := Val(Right(Tran( Op, '99.99'),2))
		nMaior := Int( Op )
		aDisp[nMaior,nMenor] := If( aDisp[nMaior][nMenor] = OK, FALSO, OK )
	EndCase
EndDo

Proc ConfIniProducao( cNome )
*****************************
LOCAL cScreen	:= SaveScreen()
LOCAL GetList	:= {}
LOCAL oScpLan	:= TIniNew( cNome + ".INI")
LOCAL oConf 	:= TAmbienteNew()
LOCAL aDisp 	:= aDispScpLan()
LOCAL nMaior	:= 1
LOCAL nMenor	:= 1
LOCAL cMaior	:= ''
LOCAL cMenor	:= ''
LOCAL cRegra	:= ''
LOCAL op 		:= 1

oConf:Disp		 := aDisp
oConf:Ativo 	 := 1
oConf:Menu		 := oMenuScpLan()
oConf:NomeFirma := oMenu:NomeFirma
oConf:CodiFirma := oMenu:CodiFirma
oConf:StatusSup := SISTEM_NA7 + " " + SISTEM_VERSAO
oConf:StatusInf := "USE A BARRA DE ESPACO PARA DESABILITAR OPCAO"
oConf:Alterando := OK
WHILE OK
	Op := oConf:Show()
	Do Case
	Case Op = 0.0 .OR. Op = 1.01
		ErrorBeep()
		IF Conf("Pergunta: Gravar Alteracoes ?")
			For i := 1 To 9
				For x := 1 To 22
               cMaior  := Strzero(i,2)
               cMenor  := Strzero(x,2)
					cRegra  := '#' + cMaior + '.' + cMenor
					oScpLan:WriteBool('scplan', cRegra, aDisp[i, x])
				Next
			Next
		EndIF
		Return
	OtherWise
		nMenor := Val(Right(Tran( Op, '99.99'),2))
		nMaior := Int( Op )
		aDisp[nMaior,nMenor] := If( aDisp[nMaior][nMenor] = OK, FALSO, OK )
	EndCase
EndDo

Proc ConfIniEstoque( cNome )
****************************
LOCAL cScreen	 := SaveScreen()
LOCAL GetList	 := {}
LOCAL oTestelan := TIniNew( cNome + ".INI")
LOCAL oConf 	 := TAmbienteNew()
LOCAL aDisp 	 := aDispTestelan()
LOCAL nMaior	 := 1
LOCAL nMenor	 := 1
LOCAL cMaior	 := ''
LOCAL cMenor	 := ''
LOCAL cRegra	 := ''
LOCAL op 		 := 1

oConf:Disp		 := aDisp
oConf:Ativo 	 := 1
oConf:Menu		 := oMenuTestelan()
oConf:NomeFirma := oMenu:NomeFirma
oConf:CodiFirma := oMenu:CodiFirma
oConf:StatusSup := SISTEM_NA2 + " " + SISTEM_VERSAO
oConf:StatusInf := "USE A BARRA DE ESPACO PARA DESABILITAR OPCAO"
oConf:Alterando := OK
WHILE OK
	Op := oConf:Show()
	Do Case
	Case Op = 0.0 .OR. Op = 1.01
		ErrorBeep()
		IF Conf("Pergunta: Gravar Alteracoes ?")
			For i := 1 To 8
				For x := 1 To 22
               cMaior  := StrZero(i,2)
               cMenor  := Strzero(x,2)
					cRegra  := '#' + cMaior + '.' + cMenor
					oTestelan:WriteBool( 'testelan', cRegra, aDisp[i, x])
				Next
			Next
		EndIF
		Return
	OtherWise
		nMenor := Val(Right(Tran( Op, '99.99'),2))
		nMaior := Int( Op )
		aDisp[nMaior,nMenor] := If( aDisp[nMaior][nMenor] = OK, FALSO, OK )
	EndCase
EndDo

Proc ConfIniSci( cNome )
************************
LOCAL cScreen	 := SaveScreen()
LOCAL GetList	 := {}
LOCAL oConf 	 := TAmbienteNew() // TMenuNew()
LOCAL aDisp 	 := aDispSci()
LOCAL nMaior	 := 1
LOCAL nMenor	 := 1
LOCAL cMaior	 := ''
LOCAL cMenor	 := ''
LOCAL cRegra	 := ''
LOCAL op 		 := 1

oSci				 := TIniNew( cNome + ".INI")
oConf:Disp		 := aDisp
oConf:Ativo 	 := 1
oConf:Menu		 := oSciMenuSci()
oConf:NomeFirma := oMenu:NomeFirma
oConf:CodiFirma := oMenu:CodiFirma
oConf:StatusSup := SISTEM_NA1 + " " + SISTEM_VERSAO
oConf:StatusInf := "USE A BARRA DE ESPACO PARA DESABILITAR OPCAO"
oConf:Alterando := OK
WHILE OK
	Op := oConf:Show()
	Do Case
	Case Op = 0.0 .OR. Op = 1.01
		ErrorBeep()
		IF Conf("Pergunta: Gravar Alteracoes ?")
			For i := 1 To 10
				For x := 1 To 22
               cMaior  := Strzero(i,2)
               cMenor  := Strzero(x,2)
					cRegra  := '#' + cMaior + '.' + cMenor
					oSci:WriteBool( 'sci', cRegra, aDisp[i, x])
				Next
			Next
		EndIF
		Return
	OtherWise
		nMenor := Val(Right(Tran( Op, '99.99'),2))
		nMaior := Int( Op )
		aDisp[nMaior,nMenor] := If( aDisp[nMaior][nMenor] = OK, FALSO, OK )
	EndCase
EndDo

Function oSciMenuSci()
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
AADD( AtPrompt, {"E^ncerrar",    {"E^ncerrar Execucao do SCI","","T^rocar de Empresa","Trocar de U^suario","","C^opia de Seguranca","R^estaurar Copia de Seguranca"}})
AADD( AtPrompt, {"M^odulos",     {"Controle de E^stoque","Contas a R^eceber","Contas a P^agar","Contas C^orrentes","Controle de P^roducao","Controle de P^onto","Mala D^ireta","V^endedores"}})
AADD( AtPrompt, {"V^endas",      {"Terminal PDV","Terminal Consulta de Precos","Relatorio Vendas *","Relatorio Receber *","Relatorio Recebido *","Cadastra Senha Caixa","","Resumo Caixa Individual", "Detalhe Caixa Individual","Detalhe Diario Caixa Geral *","Detalhe Emissao Recibos em Carteira","Detalhe Emissao Recibos Banco", "Detalhe Emissao Recibos Outros","","Rol Debito C/C Cliente","Reajuste Debito C/C Cliente","Consulta Debito C/C","Baixar Debito C/C","","Comandos de Impressora Fiscal"}})
AADD( AtPrompt, {"B^ackup",      {"Copia de Seguranca","Restaurar Copia de Seguranca","Gerar Arquivo Batch de Copia Seguranca","", "Reindexar Normal", "Reindexar Verificando Duplicidade","Reindexar Parcialmente", "Eliminar Arquivos Temporarios"}})
AADD( AtPrompt, {"E^ditor",      {"Editar Arquivo","Imprimir Arquivo", "Teste Reindexar Thread","Gerar Arquivo PDF"}})
AADD( AtPrompt, {"A^mbiente",    {"Spooler de Impressao","Layout Janela","", "Cor Pano de Fundo","Cor de Menu","Cor Cabecalho","Cor Alerta","Cor Borda","Cor Item Desativado","Cor Box Mensagem", "Cor Light Bar", "Cor HotKey", "Cor LightBar HotKey", "Cor Barra Menu","", "Pano de Fundo","Frame", cStr_Sombra, cStr_Get, "Alterar Senha"}})
AADD( AtPrompt, {"ArQ^uivos",    {"Manutencao Diretorios","Arquivos da Base de Dados","","Reindexar Normal","Reindexar Verificando Duplicidade","","Eliminar Arquivos Temporarios","Cadastra e Altera Usuario","Configuracao de Base Dados","Retorno Acesso","Separar Movimento Anual","Caixa Automatico","Zerar Movimento de Conta","Cadastrar Impressora","Alterar Impressora", "Renovar Codigo de Acesso"}})
AADD( AtPrompt, {"R^econstruir", {"Base de Dados", "Arquivo Nota", "Arquivo Printer", "Arquivo EntNota","Arquivo Prevenda"}})
AADD( AtPrompt, {"S^hell",       {"Shell         ALT D","Comandos DOS  ALT X"}})
AADD( AtPrompt, {"H^elp",        {"Sobre o Sistema","Ultimas Alteracoes","Help"}})
Return( AtPrompt )


Proc ConfIniVendedores( cNome )
*******************************
LOCAL cScreen	:= SaveScreen()
LOCAL GetList	:= {}
LOCAL oVenlan	:= TIniNew( cNome + ".INI")
LOCAL oConf 	:= TAmbienteNew()
LOCAL aDisp 	:= aDispVenLan()
LOCAL nMaior	:= 1
LOCAL nMenor	:= 1
LOCAL cMaior	:= ''
LOCAL cMenor	:= ''
LOCAL cRegra	:= ''
LOCAL op 		:= 1

oConf:Disp		 := aDisp
oConf:Ativo 	 := 1
oConf:Menu		 := oMenuVenlan()
oConf:NomeFirma := oMenu:NomeFirma
oConf:CodiFirma := oMenu:CodiFirma
oConf:StatusSup := SISTEM_NA6 + " " + SISTEM_VERSAO
oConf:StatusInf := "USE A BARRA DE ESPACO PARA DESABILITAR OPCAO"
WHILE OK
	Op := oConf:Show()
	Do Case
	Case Op = 0.0 .OR. Op = 1.01
		ErrorBeep()
		IF Conf("Pergunta: Gravar Alteracoes ?")
			For i := 1 To 7
				For x := 1 To 22
               cMaior  := Strzero(i,2)
               cMenor  := Strzero(x,2)
					cRegra  := '#' + cMaior + '.' + cMenor
					oVenlan:WriteBool( 'venlan', cRegra, aDisp[i, x])
				Next
			Next
		EndIF
		Return
	OtherWise
		nMenor := Val(Right(Tran( Op, '99.99'),2))
		nMaior := Int( Op )
		aDisp[nMaior,nMenor] := If( aDisp[nMaior][nMenor] = OK, FALSO, OK )
	EndCase
EndDo

Proc ConfImpressao()
********************
LOCAL cScreen		:= SaveScreen()
LOCAL GetList		:= {}
LOCAL cPath 		:= FCurdir()
LOCAL cPro
LOCAL cDup
LOCAL cCob
LOCAL cDiv
LOCAL cNff

Set Defa To ( oAmbiente:xBase )
WHILE OK
	oMenu:Limpa()
	cPro := oIni:ReadString('impressao','pro', 'NOTA.PRO')    ; cPro += Space(38 - Len(cPro))
	cDup := oIni:ReadString('impressao','dup', 'DUP.DUP')     ; cDup += Space(38 - Len(cDup))
	cCob := oIni:ReadString('impressao','cob', 'BOLETO.COB')  ; cCob += Space(38 - Len(cCob))
	cDiv := oIni:ReadString('impressao','div', 'DIVERSO.DIV') ; cDiv += Space(38 - Len(cDiv))
	cNff := oIni:ReadString('impressao','nff', 'NOTA.NFF')    ; cNff += Space(38 - Len(cNff))

	oMenu:MaBox( 01, 01, 07, 78, "CONFIGURACAO - ARQUIVOS DE IMPRESSAO")
	@ 02, 	  02 Say "Arquivo Padrao Nota Promissoria....: " Get cPro Pict "@!" Valid PickArquivo( @cPro, '*.PRO' )
	@ Row()+1, 02 Say "Arquivo Padrao Duplicata Mercantil.: " Get cDup Pict "@!" Valid PickArquivo( @cDup, '*.DUP' )
	@ Row()+1, 02 Say "Arquivo Padrao Boleto Bancario.....: " Get cCob Pict "@!" Valid PickArquivo( @cCob, '*.COB' )
	@ Row()+1, 02 Say "Arquivo Padrao Documentos Diversos.: " Get cDiv Pict "@!" Valid PickArquivo( @cDiv, '*.DIV' )
	@ Row()+1, 02 Say "Arquivo Padrao Nota Fiscal.........: " Get cNff Pict "@!" Valid PickArquivo( @cNff, '*.NFF' )
	Read
	IF LastKey() = ESC
		Set Defa To ( cPath )
		ResTela( cScreen )
		Exit
	EndIF
	ErrorBeep()
	IF Conf("Pergunta: Confirma ?")
		oIni:WriteString('impressao', 'pro', AllTrim(cPro ))
		oIni:WriteString('impressao', 'dup', AllTrim(cDup ))
		oIni:WriteString('impressao', 'cob', AllTrim(cCob ))
		oIni:WriteString('impressao', 'div', AllTrim(cDiv ))
		oIni:WriteString('impressao', 'nff', AllTrim(cNff ))
	EndIF
EndDo

Function PickArquivo( cFile, cCuringa, lNovo )
**********************************************
	LOCAL cScreen := SaveScreen()
	LOCAL aProc   := {}
	LOCAL nPos	  := 0

	Aadd( aProc, {"*.PRO",  {||GravaPromissoria()}})
	Aadd( aProc, {"*.DUP",  {||GravaDuplicata()}})
	Aadd( aProc, {"*.COB",  {||GravaBoleto()}})
	Aadd( aProc, {"*.DIV",  {||GravaDiversos()}})
	Aadd( aProc, {"*.NFF",  {||GravaNota()}})

	FChDir( oAmbiente:xBaseDoc )
	Set Defa To ( oAmbiente:xBaseDoc )
	IF !File( cCuringa )
		nPos := Ascan( aProc, {| oBloco | oBloco[1] = cCuringa })
		IF nPos != 0
			Eval( aProc[ nPos, 2 ] )
		EndIF
	EndIF
	IF !File( Trim( cFile ))
		IF lNovo != NIL
			ErrorBeep()
			IF Conf('Pergunta: Arquivo digitado inexistente. Criar ?')
				FChDir( oAmbiente:xBaseDados )
				Set Defa To ( oAmbiente:xBaseDados )
				Return( OK )
			EndIF
		EndIF
		M_Title("ESCOLHA O ARQUIVO DE CONFIGURACAO")
		cFile := Mx_PopFile( 08, 01, 20, 78, cCuringa, Cor() )
	EndIF
	FChDir( oAmbiente:xBaseDados )
	Set Defa To ( oAmbiente:xBaseDados )
	ResTela( cScreen )
Return( OK )

Proc ConfIniPonto( cNome )
**************************
	LOCAL cScreen	 := SaveScreen()
	LOCAL GetList	 := {}
	LOCAL oPontoLan := TIniNew( cNome + ".INI")
	LOCAL oConf 	 := TAmbienteNew()
	LOCAL aDisp 	 := aDispPontoLan()
	LOCAL nMaior	 := 1
	LOCAL nMenor	 := 1
	LOCAL cMaior	 := ''
	LOCAL cMenor	 := ''
	LOCAL cRegra	 := ''
	LOCAL op 		 := 1
	LOCAL nMenuH	 := 7
	LOCAL aMenuV	 := {01,03,03,02,02,02,01}

	oConf:Ativo 	 := 1
	oConf:Menu		 := oMenuPontoLan()
	oConf:Disp		 := aDisp
	oConf:NomeFirma := oMenu:NomeFirma
	oConf:CodiFirma := oMenu:CodiFirma
	oConf:StatusSup := SISTEM_NA8 + " " + SISTEM_VERSAO
	oConf:StatusInf := "USE A BARRA DE ESPACO PARA DESABILITAR OPCAO"
	oConf:Alterando := OK
	WHILE OK
		Op := oConf:Show()
		Do Case
		Case Op = 0.0 .OR. Op = 1.01
			ErrorBeep()
			IF Conf("Pergunta: Gravar Alteracoes ?")
				For i := 1 To nMenuH
					For x := 1 To aMenuV[i]
						cMaior  := Strzero(i,2)
						cMenor  := Strzero(x,2)
						cRegra  := '#' + cMaior + '.' + cMenor
						oPontoLan:WriteBool('pontolan', cRegra, aDisp[i, x])
					Next
				Next
			EndIF
			Return
		OtherWise
			nMenor := Val(Right(Tran( Op, '99.99'),2))
			nMaior := Int( Op )
			aDisp[nMaior,nMenor] := If( aDisp[nMaior][nMenor] = OK, FALSO, OK )
		EndCase
	EndDo

Function aDispSci()
*******************
	LOCAL AtPrompt := oSciMenuSci()
	LOCAL nMenuH   := Len(AtPrompt)
	LOCAL aDisp    := Array(nMenuH, 22 )
	LOCAL aMenuV   := {}
			oSci     := TIniNew(oAmbiente:xUsuario + ".INI")

	Mensagem("Aguarde, Verificando Diretivas do Sistema DO MENU PRINCIPAL.")
	aDisp := ReadIni('sci', nMenuH, aMenuV, AtPrompt, aDisp, oSci)

	IF !aPermissao[SCI_CONTROLE_DE_ESTOQUE]
		aDisp[02,01] := FALSO
	EndIF

	IF !aPermissao[SCI_CONTAS_A_RECEBER]
		aDisp[02,02] := FALSO
	EndIF
	IF !aPermissao[SCI_CONTAS_A_PAGAR]
		aDisp[02,03] := FALSO
	EndIF
	IF !aPermissao[SCI_CONTAS_CORRENTES]
		aDisp[02,04] := FALSO
	EndIF
	IF !aPermissao[SCI_CONTROLE_DE_PRODUCAO]
		aDisp[02,05] := FALSO
	EndIF
	IF !aPermissao[SCI_VENDEDORES]
		aDisp[02,08] := FALSO
	EndIF
	IF !aPermissao[SCI_VENDAS_NO_VAREJO]
		aDisp[03,01] := FALSO
	EndIF
	IF !aPermissao[SCI_MANUTENCAO_DE_USUARIO]
		aDisp[07,08] := FALSO
	EndIF
	IF !oAmbiente:lGreenCard
		aDisp[02,05] := FALSO
		aDisp[01,07] := FALSO
		aDisp[04,02] := FALSO
		aDisp[04,06] := FALSO
		aDisp[07,01] := FALSO
		aDisp[07,02] := FALSO
		aDisp[07,05] := FALSO
		aDisp[08,01] := FALSO
		aDisp[09,01] := FALSO
	EndIF
Return( aDisp )

Function ReadIni( cSistema, nMenuH, aMenuV, AtPrompt, aDisp, xIni)
******************************************************************
	LOCAL cMaior
	LOCAL cMenor
	LOCAL cRegra
	LOCAL i
	LOCAL x

	For y := 1 To nMenuH
		Aadd(aMenuV, Len(AtPrompt[y][2]))
	Next

	For i := 1 To nMenuH
		For x := 1 To aMenuV[i]
			cMaior     := Strzero(i,2)
			cMenor     := Strzero(x,2)
			cRegra	  := '#' + cMaior + '.' + cMenor
			aDisp[i,x] := xIni:ReadBool(cSistema, cRegra, OK)
		Next
	Next
Return( aDisp )

function RealClock( nRow, nCol, nCor)
*************************************
	LOCAL pRow      := Row()
	LOCAL	pCol      := Col()
	LOCAL Color_Ant := SetColor()
	DEFAU nRow TO 00
	DEFAU nCol TO MaxCol()-16
	DEFAU nCor TO oMenu:CorCabec
		
   while OK
		pRow := Row()
		pCol := Col()
		print( nRow, nCol, Dtoc(Date()) + ' ' + (oAmbiente:Clock := Time()), nCor)
		DevPos( pRow, pCol)
      hb_idleSleep( 1 )
   end
	SetColor( Color_Ant)	
	DevPos( pRow, pCol)	
	return Dtoc(Date()) + ' ' + (oAmbiente:Clock := Time())		
	
def LogoTipo( aEnde_String )
****************************
LOCAL nMaxRow      := MaxRow()
LOCAL aNormal      := Array(11)
LOCAL aEncrypt     := Array(11)
LOCAL aEndeNormal  := Array(4)
LOCAL aEndeEncrypt := Array(4)
LOCAL nHandle
LOCAL nX

return nil


nHandle := Fopen("sci.cfg")
if Ferror() != 0 
	FClose( nHandle )
	SetColor("")
	Cls
   Alert( "Linha : " + strzero(procline(i), 6) + "    Proc : " + ProcName(i) +;
	       "Erro #3: Erro de Abertura do Arquivo SCI.CFG.")
	Quit
EndIF

nErro := FLocate( nHandle, "[ENDERECO_STRING]")
IF nErro < 0
	SetColor("")
	Cls
	Alert( "Erro #4: Configuracao de SCI.CFG nao localizada. [ENDERECO_STRING]")
	Quit
EndIF
FAdvance( nHandle )
For nX := 1 To 4
	aEndeNormal[nX] := MsReadLine( nHandle )
	FAdvance( nHandle )
Next
nErro 	  := FLocate( nHandle, "[ENDERECO_CODIGO]")
IF nErro < 0
	SetColor("")
	Cls
	Alert( "Erro #4: Configuracao de SCI.CFG nao localizada. [ENDERECO_CODIGO]")
	Quit
EndIF
FAdvance( nHandle )
For nX := 1 To 4
	aEndeEncrypt[nX]   := MsDecrypt( MsReadLine( nHandle ))
	IF aEndeNormal[nX] != aEndeEncrypt[nX]
		SetColor("")
		Cls
		Alert( "Erro #5: Configuracao de SCI.CFG alterada. [ENDERECO_CODIGO]")
		Quit
	EndIF
	FAdvance( nHandle )
Next
nErro := FLocate( nHandle, "[SCI_STRING]")
IF nErro < 0
	SetColor("")
	Cls
	Alert( "Erro #4: Configuracao de SCI.CFG nao localizada. [SCI_STRING]")
	Quit
EndIF
FAdvance( nHandle )
For nX := 1 To 11
	aNormal[nX] := MsReadLine( nHandle )
	FAdvance( nHandle )
Next
nErro 	  := FLocate( nHandle, "[SCI_CODIGO]")
IF nErro < 0
	SetColor("")
	Cls
	Alert( "Erro #4: Configuracao de SCI.CFG nao localizada. [SCI_CODIGO]")
	Quit
EndIF
FAdvance( nHandle )
For nX := 1 To 11
	aEncrypt[nX] := MsDecrypt( MsReadLine( nHandle ))
	IF aNormal[nX] != aEncrypt[nX]
		SetColor("")
		Cls
		Alert( "Erro #5: Configuracao de SCI.CFG alterada. [SCI_CODIGO]")
		Quit
	EndIF
	FAdvance( nHandle )
Next
FClose( nHandle )
	SetColor("")
	Cls
	MsBox( 00, 00, 05, MaxCol()-2, 9, OK )
	For nX := 1 To 4
		WriteBox( nX, 10, aEndeNormal[nX] )
	Next
	SetColor("")
	/*
	for nY := 0 to nMaxRow step 11
		if Row() >= nMaxRow-8
		   exit
		endif	
		For nX := 1 To 11		   
			Write( 05+nX+nY, 00, aEncrypt[nX] )
			if Row() >= nMaxRow-8
			   exit
			endif	
		Next
	Next	
	*/
	For nX := 1 To 11		   
		Write( (nMaxRow/2)-7+nX, 00, aEncrypt[nX] )
	Next
		
	SetColor("")
	For nY := 6 To nMaxRow-9
		SetColor( AttrToa( nY ))
		Write( nY, 25, XNOMEFIR, nY )
		
	Next
	SetColor("")
	
	MsBox( nMaxRow-8, 00, nMaxRow-3, MaxCol()-2, 9, FALSO )
	WriteBox( nMaxRow-7, 10, "Esta ‚ uma licen‡a de uso individual e  intransfer¡vel" )
	WriteBox( nMaxRow-6, 10, "para o usuario acima. C¢pia ilegais e n„o  autorizadas" )
	WriteBox( nMaxRow-5, 10, "‚ crime de PIRATARIA o qual ser„o processadas a m xima" )
	WriteBox( nMaxRow-4, 10, "extˆns„o da LEI.")
	SetColor("R")
	Write( nMaxRow-2,00, "TECLE ALGO PARA INICIARÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ")
	Inkey(2)	
	ScrollEsq()
Return

def Info(nRow, lInkey)
*----------------------*
	LOCAL cScreen	  := SaveScreen( )
	LOCAL Drive 	  := Curdrive()
	LOCAL cDiretorio := FCurdir()
	LOCAL nMaxRow	  := MaxRow()
	LOCAL nMaxCol	  := MaxCol()-3
	LOCAL cSistema   := StrTran( SISTEM_NA1 + SISTEM_VERSAO, "MENU PRINCIPAL-","")
	LOCAL nRamLivre  := Memory(0)
   LOCAL aPrinter   := cupsGetDests()   
   LOCAL aMenu      := {}
   LOCAL nPr
	LOCAL nColor
	LOCAL Handle
	LOCAL xMicrobras
	LOCAL xEndereco
	LOCAL xTelefone
	LOCAL xCidade

	IfNil(nRow, 2)
	FChDir( oAmbiente:xRoot )	
	Handle := Fopen("sci.cfg")
	
   if ( Ferror() != 0 )
		FClose( Handle )
		SetColor("")
		Cls
      Alert( "Linha : " + strzero(procline(), 6) + "    Proc : " + ProcName() + ;
	          ";Erro #3: Erro de Abertura do Arquivo SCI.CFG.")
		ResTela( cScreen )
		Return
	endif
   
	nErro := FLocate( Handle, "[ENDERECO_STRING]")
	IF nErro < 0
		FClose( Handle )
		SetColor("")
		Cls
		Alert( "Erro #4: Configuracao de SCI.CFG alterada. [ENDERECO_STRING]")
		ResTela( cScreen )
		Return
	EndIF
	FAdvance( Handle )
	xMicrobras := AllTrim( MsReadLine( Handle ))
	FAdvance( Handle )
	xEndereco  := AllTrim( MsReadLine( Handle ))
	FAdvance( Handle )
	xTelefone  := AllTrim( MsReadLine( Handle ))
	FAdvance( Handle )
	xCidade	  := AllTrim( MsReadLine( Handle ))
	FClose( Handle )
	CenturyOn()

   oMenu:Limpa()
	oAmbiente:xProgramador := xMicrobras
	nRow                   := (nMaxRow-20)/2
	nSetColor( oMenu:CorMenu )

	MaBox( nRow,	 02, nRow+24, (nMaxCol+1))   
	Print( nRow+01, 03, "") ; printf(Padc(cSistema,   nMaxCol-2), AscanCor(clBrightGreen))
	Print( nRow+02, 03, "") ; printf(Padc(xMicrobras, nMaxCol-2), AscanCor(clBrightRed))
	Print( nRow+03, 03, "") ; printf(Padc(xEndereco,  nMaxCol-2), AscanCor(clBrightBlue))
	Print( nRow+04, 03, "") ; printf(Padc(xTelefone,  nMaxCol-2), AscanCor(clBrightCyan))
	
	aHost := GetIp()
	Print( nRow+06, 03, "S. Operacional : ") ; printf(Os(), AscanCor(clBrightYellow))
	Print( nRow+07, 03, "  Data Sistema : ") ; printf(Date(), AscanCor(clBrightGreen))
	Print( nRow+08, 03, "     Diret¢rio : ") ; printf(AllTrim(oAmbiente:xRoot), AscanCor(clBrightGreen))      
	Print( nRow+09, 03, "  Espa‡o Total : ") ; printf(AllTrim(Tran( FT_DskSize(Drive)/1024/1024/1024, "999,999")), AscanCor(clBrightCyan)) ; printf( " GB", AscanCor(clBrightGreen))
	Print( nRow+10, 03, "   Mem¢ria RAM : ") ; printf(hb_ntos(Memory(HB_MEM_BLOCK)/1024), AscanCor(clBrightCyan)) ; printf( " GB", AscanCor(clBrightGreen))
	Print( nRow+11, 03, "   Mem Virtual : ") ; printf(hb_ntos(Memory(HB_MEM_VM)/1024),     AscanCor(clBrightCyan)) ; printf( " GB", AscanCor(clBrightGreen))
	Print( nRow+12, 03, "  Max Used Mem : ") ; printf(hb_ntos(Memory(HB_MEM_USEDMAX)/1024),     AscanCor(clBrightCyan)) ; printf( " KB", AscanCor(clBrightGreen))
	Print( nRow+13, 03, "  Arqs Abertos : ") //; printf(AllTrim(Str(NextHandle()-6,3)), AscanCor(clBrightGreen))
	Print( nRow+14, 03, "      Ano 2000 : ") ; printf(IF( oAmbiente:Ano2000, "Habilitado", "Desabilitado"), AscanCor(IF( oAmbiente:Ano2000,   clBrightGreen,clBrightRed)))
	Print( nRow+15, 03, "    Base Dados : ") ; printf(IF( oProtege:Protegido,"Protegida",  "DesProtegida"), AscanCor(IF( oProtege:Protegido, clBrightGreen,clBrightRed))) 
	//Print( nRow+16, 03, " Print Spooler : " /*+ IF( IsQueue(), "Sim","Nao")*/)
	Print( nRow+17, 03, "Versao Harbour : ") ; printf(hb_Version(HB_VERSION_HARBOUR ), AscanCor(clBrightCyan))
	Print( nRow+18, 03, "  Compiler C++ : ") ; printf(hb_Version(HB_VERSION_COMPILER), AscanCor(clBrightCyan))
	Print( nRow+19, 03, "   Versao Leto : ") ; printf(LETO_GETSERVERVERSION(), AscanCor(clBrightCyan))
	Print( nRow+20, 03, "       Leto IP : ") ; printf(LETO_GETCURRENTCONNECTION(), AscanCor(clBrightCyan))
	Print( nRow+21, 03, "      IP Local : ") ; printf(StrGetIp(), AscanCor(clBrightCyan))
	
	Print( nRow+06, ((nMaxCol/2)-2), "   Nome Esta‡„o : ") ; printf(AllTrim(Left(NetName(),20)), AscanCor(clBrightYellow))
	Print( nRow+07, ((nMaxCol/2)-2), "  Horas Sistema : " + Time())	
   Print( nRow+08, ((nMaxCol/2)-2), " Drive Corrente : ") ; printf(AllTrim(Drive), AscanCor(clBrightGreen))   	
	Print( nRow+09, ((nMaxCol/2)-2), "  Espa‡o Livre  : ") ; printf(AllTrim(Tran(ft_DskFree()/1024/1024/1024, "999,999")), AscanCor(clBrightCyan)) ; printf( " GB", AscanCor(clBrightGreen))
	Print( nRow+10, ((nMaxCol/2)-2), "  Mem RAM Livre : " + AllTrim(Str(nRamLivre/1024) + " GB"))
	IF nRamLivre < 100 // Pouca memoria
	Print( nRow+10, ((nMaxCol/2)-2), "  Mem RAM Livre : " + AllTrim(Str(nRamLivre/1024) + " GB"), Roloc(Cor()))
	EndIF
	Print( nRow+11, ((nMaxCol/2)-2), "  Memoria usada : " + hb_ntos(Memory(HB_MEM_USED)) + " KB")
	Print( nRow+12, ((nMaxCol/2)-2), "  Path Corrente : " + AllTrim( oAmbiente:xBase ))
	Print( nRow+13, ((nMaxCol/2)-2), "  Limite Acesso : ") ; printf( oAmbiente:xDataCodigo, AscanCor(clBrightRed))
	Print( nRow+14, ((nMaxCol/2)-2), "   MultiUsuario : ") ; printf(IF( MULTI, "Habilitado", "Desabilitado"), AscanCor(IF( MULTI, clBrightGreen,clBrightRed)))
	Print( nRow+15, ((nMaxCol/2)-2), "     Portas LPT : " + IF( FisPrinter("LPT1"), "#1 ","NIL,") + IF( FisPrinter("LPT2"), "#2 ","NIL,") + IF( FisPrinter("LPT3"), "#3 ","NIL,"))
	Print( nRow+16, ((nMaxCol/2)-2), "     Portas COM : " + IF( FisPrinter("COM1"), "#1 ","NIL,") + IF( FisPrinter("COM2"), "#2 ","NIL,") + IF( FisPrinter("COM3"), "#3 ","NIL,"))

   nRow1 := 16   
   FOR EACH nPr IN aPrinter
      nRow1++            
      Print( nRow+nRow1, ((nMaxCol/2)-2), "  Porta Cups #" + TrimStr(nPr:__enumIndex()) + " : " + nPr)
   NEXT                         
   
   
	IF oAmbiente:Visual
	  Print( nRow+22, 03, Padc( "Software Li‡enciado para", nMaxCol-7), AscanCor(clBrightGreen))
	  Print( nRow+23, 03, Padc( XNOMEFIR, nMaxCol-7 ), AscanCor(clBrightRed))
	Else
	  Print( nRow+22, 03, Padc( "Software Li‡enciado para" , nMaxCol-2), AscanCor(clBrightGreen))
	  Print( nRow+23, 03, Padc( XNOMEFIR, nMaxCol-2 ), AscanCor(clBrightRed))
	EndIF	
		
	Print( ++nRow, (nMaxCol-30), "< Memoria >", AscanCor(clBrightCyan))
	Print( ++nRow, (nMaxCol-30), "  MEM_CHAR       : ") ; printf(hb_ntos(Memory(HB_MEM_CHAR       )/1024) + " GB", AscanCor(clBrightRed))
	Print( ++nRow, (nMaxCol-30), "  MEM_BLOCK      : ") ; printf(hb_ntos(Memory(HB_MEM_BLOCK      )/1024) + " GB", AscanCor(clBrightRed))
	Print( ++nRow, (nMaxCol-30), "  MEM_RUN        : ") ; printf(hb_ntos(Memory(HB_MEM_RUN        )/1024) + " GB", AscanCor(clBrightRed))
	++nRow                                                                                 
	Print( ++nRow, (nMaxCol-30), "  MEM_VM         : ") ; printf(hb_ntos(Memory(HB_MEM_VM         )/1024) + " GB", AscanCor(clBrightCyan))
	Print( ++nRow, (nMaxCol-30), "  MEM_EMS        : ") ; printf(hb_ntos(Memory(HB_MEM_EMS        )/1024) + " GB", AscanCor(clBrightCyan))
	Print( ++nRow, (nMaxCol-30), "  MEM_FM         : ") ; printf(hb_ntos(Memory(HB_MEM_FM         )/1024) + " GB", AscanCor(clBrightCyan))
	Print( ++nRow, (nMaxCol-30), "  MEM_FMSEGS     : ") ; printf(hb_ntos(Memory(HB_MEM_FMSEGS     )/1024) + " GB", AscanCor(clBrightCyan))
	Print( ++nRow, (nMaxCol-30), "  MEM_SWAP       : ") ; printf(hb_ntos(Memory(HB_MEM_SWAP       )/1024) + " GB", AscanCor(clBrightCyan))
	Print( ++nRow, (nMaxCol-30), "  MEM_CONV       : ") ; printf(hb_ntos(Memory(HB_MEM_CONV       )/1024) + " GB", AscanCor(clBrightCyan))
	Print( ++nRow, (nMaxCol-30), "  MEM_EMSUSED    : ") ; printf(hb_ntos(Memory(HB_MEM_EMSUSED    )/1024) + " GB", AscanCor(clBrightCyan))
	++nRow
	Print( ++nRow, (nMaxCol-30), "  MEM_USED       : ") ; printf(hb_ntos(Memory(HB_MEM_USED       )) + " B", AscanCor(clBrightGreen))
	Print( ++nRow, (nMaxCol-30), "  MEM_USEDMAX    : ") ; printf(hb_ntos(Memory(HB_MEM_USEDMAX    )) + " B", AscanCor(clBrightGreen))
	Print( ++nRow, (nMaxCol-30), "  MEM_STACKITEMS : ") ; printf(hb_ntos(Memory(HB_MEM_STACKITEMS )) + " B", AscanCor(clBrightGreen))
	Print( ++nRow, (nMaxCol-30), "  MEM_STACK      : ") ; printf(hb_ntos(Memory(HB_MEM_STACK      )) + " B", AscanCor(clBrightGreen))
	Print( ++nRow, (nMaxCol-30), "  MEM_STACK_TOP  : ") ; printf(hb_ntos(Memory(HB_MEM_STACK_TOP  )) + " B", AscanCor(clBrightGreen))
	Print( ++nRow, (nMaxCol-30), "  MEM_BLOCKS     : ") ; printf(hb_ntos(Memory(HB_MEM_BLOCKS     )) + " B", AscanCor(clBrightGreen))
	Print( ++nRow, (nMaxCol-30), "  MEM_STATISTICS : ") ; printf(hb_ntos(Memory(HB_MEM_STATISTICS )) + " B", AscanCor(clBrightGreen))
	Print( ++nRow, (nMaxCol-30), "  MEM_CANLIMIT   : ") ; printf(hb_ntos(Memory(HB_MEM_CANLIMIT   )) + " B", AscanCor(clBrightGreen))
	CenturyOff()
	IF lInkey = NIL
		SetCursor(0)
		WaitKey(0)
		ResTela( cScreen )
	EndIF
	FChDir( cDiretorio )
	Return
endef

Def StrGetIp()
*--------------*
	LOCAL cString 	:= ""
	LOCAL aHost 	:= GetIp()
	LOCAL nLen     := Len(aHost)
	LOCAL c
	
	for each c IN aHost
		cString += c
		if nLen >= 2		
			cString += ', '
		endif
	next
	return cString
endef


Proc ErrorSys()
*--------------*
	Private ErrorSys := 9876543210
	ErrorBlock( {|Erro| MacroErro(Erro)} )
	return

Function MacroErro(e)
*********************
	LOCAL cScreen	 := SaveScreen()
	LOCAL cPrograma := ms_swap_extensao("sci", ".err")
   LOCAL cDbf
	LOCAL cmens
	LOCAL i
	LOCAL cmessage
	LOCAL aoptions
	LOCAL nchoice
	LOCAL errodos
	LOCAL ab
	LOCAL abdes
	LOCAL abexp
	LOCAL abacao
	LOCAL abacao1
	LOCAL adbf
	LOCAL adbfdes
	LOCAL adbfexp
	LOCAL adbfacao
	LOCAL adbfacao1

	cmens 	 := ""
	errodos	 := {}
	ab 		 := {}
	abdes 	 := {}
	abexp 	 := {}
	abacao	 := {}
	abacao1	 := {}
	adbf		 := {}
	adbfdes	 := {}
	adbfexp	 := {}
	adbfacao  := {}
	adbfacao1 := {}
   
	if (e:gencode() == 5)
		return 0
	endif
	if (e:gencode() == 21 .AND. e:oscode() == 32 .AND. e:candefault())
		neterr( true )
		return false
	EndIf
	if (e:gencode() == 40 .AND. e:candefault())
		neterr( true )
		return false
	endif

	AAdd(ab, 1002)
	AAdd(abdes, "ALIAS NAO EXISTE.")
	AAdd(abexp, "O ALIAS ESPECIFICADO NAO ASSOCIADO COM A AREA DE TRABALHO ATUAL.")
	AAdd(abacao, "ENTRE EM CONTATO COM O SUPORTE TECNICO.")
	AAdd(abacao1, "")
	AAdd(ab, 1003)
	AAdd(abdes, "VARIAVEL NAO EXISTE.")
	AAdd(abexp, "A VARIAVEL ESPECIFICADA NAO EXISTE OU NAO E VISIVEL.")
	AAdd(abacao, "ENTRE EM CONTATO COM O SUPORTE TECNICO.")
	AAdd(abacao1, "")
	AAdd(ab, 1004)
	AAdd(abdes, "VARIAVEL NAO EXISTE.")
	AAdd(abexp, "A VARIAVEL ESPECIFICADA NAO EXISTE OU NAO E VISIVEL.")
	AAdd(abacao, "ENTRE EM CONTATO COM O SUPORTE TECNICO.")
	AAdd(abacao1, "")
	AAdd(ab, 2006)
	AAdd(abdes,   "ERRO DE GRAVACAO/CRIACAO DE ARQUIVO.")
	AAdd(abexp,   "O ARQUIVO ESPECIFICADO NAO PODE SER GRAVADO/CRIADO.")
	AAdd(abacao,  "VERIFIQUE SEUS DIREITOS EM AMBIENTE DE REDE. ESPACO")
	AAdd(abacao1, "EM DISCO, OU SE O ARQUIVO ESTA ATRIBUIDO PARA SOMENTE LEITURA.")
	AAdd(ab, 5300)
	AAdd(abdes, "MEMORIA BAIXA.")
	AAdd(abexp, "MEMORIA DISPONIVEL INSUFICIENTE PARA RODAR O APLICATIVO.")
	AAdd(abacao, "LIBERE MAIS MEMORIA CONVENCIONAL VERIFICANDO OS ARQUIVOS")
	AAdd(abacao1, "CONFIG.SYS E AUTOEXEC.BAT.")

	AAdd(adbf, 1001)
	AAdd(adbfdes, "ERRO DE ABERTURA DO ARQUIVO ESPECIFICADO.")
	AAdd(adbfexp, "O ARQUIVO ESPECIFICADO NAO PODE SER ABERTO.")
	AAdd(adbfacao, "VERIFIQUE SEUS DIREITOS EM AMBIENTE DE REDE. ESPACO")
	AAdd(adbfacao1, "EM DISCO, OU SE O ARQUIVO ESTA ATRIBUIDO PARA SOMENTE LEITURA.")
	AAdd(adbf, 1003)
	AAdd(adbfdes, "ERRO DE ABERTURA DO ARQUIVO ESPECIFICADO.")
	AAdd(adbfexp, "O ARQUIVO ESPECIFICADO NAO PODE SER ABERTO.")
	AAdd(adbfacao, "VERIFIQUE SEUS DIREITOS EM AMBIENTE DE REDE. ESPACO")
	AAdd(adbfacao1, "EM DISCO, OU SE O ARQUIVO ESTA ATRIBUIDO PARA SOMENTE LEITURA.")
	AAdd(adbf, 1004)
	AAdd(adbfdes, "ERRO DE CRIACAO DE ARQUIVO.")
	AAdd(adbfexp, "O ARQUIVO ESPECIFICADO NAO PODE SER CRIADO.")
	AAdd(adbfacao, "VERIFIQUE SEUS DIREITOS EM AMBIENTE DE REDE. ESPACO")
	AAdd(adbfacao1, "EM DISCO, OU SE O ARQUIVO ESTA ATRIBUIDO PARA SOMENTE LEITURA.")
	AAdd(adbf, 1006)
	AAdd(adbfdes, "ERRO DE CRIACAO DE ARQUIVO.")
	AAdd(adbfexp, "O ARQUIVO ESPECIFICADO NAO PODE SER CRIADO.")
	AAdd(adbfacao, "VERIFIQUE SEUS DIREITOS EM AMBIENTE DE REDE. ESPACO")
	AAdd(adbfacao1,"EM DISCO, OU SE O ARQUIVO ESTA ATRIBUIDO PARA SOMENTE LEITURA.")
	AAdd(adbf, 1010)
	AAdd(adbfdes, "ERRO DE LEITURA DE ARQUIVO.")
	AAdd(adbfexp, "UM ERRO DE LEITURA OCORREU NO ARQUIVO ESPECIFICADO.")
	AAdd(adbfacao, "VERIFIQUE SEUS DIREITOS EM AMBIENTE DE REDE, OU SE")
	AAdd(adbfacao1, "O ARQUIVO NAO ESTA TRUNCADO.")
	AAdd(adbf, 1011)
	AAdd(adbfdes, "ERRO DE GRAVACAO DE ARQUIVO.")
	AAdd(adbfexp, "UM ERRO DE GRAVACAO OCORREU NO ARQUIVO ESPECIFICADO.")
	AAdd(adbfacao, "VERIFIQUE SEUS DIREITOS EM AMBIENTE DE REDE. ESPACO")
	AAdd(adbfacao1, "EM DISCO, OU SE O ARQUIVO ESTA ATRIBUIDO PARA SOMENTE LEITURA.")
	AAdd(adbf, 1012)
	AAdd(adbfdes, "CORRUPCAO DE ARQUIVOS DETECTADA.")
	AAdd(adbfexp, "OS ARQUIVOS DE DADOS .DBF E/OU INDICES .NTX ESTAO CORROMPIDOS.")
	AAdd(adbfacao, "APAGUE OS ARQUIVOS COM EXTENSAO .NTX E TENTE NOVAMENTE.")
	AAdd(adbfacao1, "")
	AAdd(adbf, 1020)
	AAdd(adbfdes, "ERRO DE TIPO DE DADO.")
	AAdd(adbfexp, "OS TIPOS DE DADOS SAO IMCOMPATIVEIS.")
	AAdd(adbfacao, "ENTRE EM CONTATO COM O SUPORTE TECNICO.")
	AAdd(adbfacao1, "")
	AAdd(adbf, 1021)
	AAdd(adbfdes, "ERRO DE TAMANHO DE DADO.")
	AAdd(adbfexp, "O TAMANHO DE DADO EH MAIOR QUE O CAMPO.")
	AAdd(adbfacao, "VERIFIQUE DATAS DE VCTO, EMISSAO E OU CALCULOS MUITO ")
	AAdd(adbfacao1, "GRANDES.")
	AAdd(adbf, 1022)
	AAdd(adbfdes, "TRAVAMENTO DE ARQUIVO REQUERIDO.")
	AAdd(adbfexp, "TENTATIVA DE ALTERAR UM REGISTRO SEM PRIMEIRO OBTER TRAVAMENTO.")
	AAdd(adbfacao, "ENTRE EM CONTATO COM O SUPORTE TECNICO.")
	AAdd(adbfacao1, "")
	AAdd(adbf, 1023)
	AAdd(adbfdes, "O ARQUIVO REQUER ABERTURA EXCLUSIVA")
	AAdd(adbfexp, "O INICIO DA OPERACAO REQUER ABERTURA DE ARQUIVO EXCLUSIVA.")
	AAdd(adbfacao, "ENTRE EM CONTATO COM O SUPORTE TECNICO.")
	AAdd(adbfacao1, "")
	AAdd(adbf, 1027)
	AAdd(adbfdes, "LIMITE EXCEDIDO.")
	AAdd(adbfexp, "MUITOS ARQUIVOS DE INDICES ESTAO ABERTOS NA AREA CORRENTE.")
	AAdd(adbfacao, "ENTRE EM CONTATO COM O SUPORTE TECNICO.")
	AAdd(adbfacao1, "")

	nsubcode    := e:subcode()
	csystem	   := e:subsystem()
	cexplanacao := ""
	cacao 	   := ""
	cacao1	   := ""
	nPos		   := 0

	If (csystem = "BASE")
		npos:= ascan(ab, nsubcode)
		If (npos != 0)
			e:description := abdes[npos]
			cExplanacao   := abexp[npos]
			cAcao 		  := abacao[npos]
			cAcao1		  := abacao1[npos]
		EndIf
	ElseIf (csystem = "DBFNTX")
		npos:= ascan(adbf, nsubcode)
		If (npos != 0)
			e:description := adbfdes[npos]
			cExplanacao   := adbfexp[npos]
			cAcao 		  := adbfacao[npos]
			cAcao1		  := adbfacao1[npos]
		EndIf
	ElseIf (csystem = "SIXNSX")
		npos:= ascan(adbf, nsubcode)
		If (npos != 0)
			e:description := adbfdes[npos]
			cExplanacao   := adbfexp[npos]
			cAcao 		  := adbfacao[npos]
			cAcao1		  := adbfacao1[npos]
		EndIf
   ElseIf (csystem = "SIXCDX")
		npos:= ascan(adbf, nsubcode)
		If (npos != 0)
			e:description := adbfdes[npos]
			cExplanacao   := adbfexp[npos]
			cAcao 		  := adbfacao[npos]
			cAcao1		  := adbfacao1[npos]
		EndIf            
	ElseIf ( csystem = "TERM")
		if e:oscode() != 3	
			IF LptOk()
				Return( OK )
			EndIF		
			Set Devi To Screen
			Set Prin Off
			Set Cons On
			Set Print to
			Break
		endif			
	EndIf

	If (e:oscode() = 4)
		e:description := "IMPOSSIVEL ABRIR MAIS ARQUIVOS."
		cExplanacao   := "O LIMITE DE ABERTURA DE ARQUIVOS FOI EXCEDIDO."
		cAcao 		  := "INCREMENTE FILES NO CONFIG.SYS OU FILE HANDLES"
		cAcao1		  := "NO ARQUIVO SHELL.CFG SE EM AMBIENTE DE REDE."
	EndIf
	IF nPos = 0
		cExplanacao := "ERRO NAO DOCUMENTADO."
		cAcao 	   := "IMPRIMA ESTA TELA. E ENTRE EM CONTATO COM O"
		cAcao1	   := "SUPORTE TECNICO ATRAVES DO TEL (69)3451.3085 ou SUPORTE@MACROSOFT.COM.BR"
	EndIF

   /*
	if nSubCode = 1003
		FChDir( oAmbiente:xRoot )
      
		Set Date British
		Set Console Off
		FClose( cPrograma )
      if !ms_swap_File( cPrograma )
			cHandle := Fcreate( cPrograma, FC_NORMAL )
			FClose( cHandle )
		endif
		cHandle := FOpen( cPrograma, FO_READWRITE + FO_SHARED )
		IF ( Ferror() != 0 )
			FClose( cHandle )
			SetColor("")
			Cls
			Alert( "Erro #3: Erro de Abertura " + cPrograma + ". Erro DOS " + Str( Ferror(),3))
			Break(e)
			//FlReset()
			Quit
		EndIF
		FBot( cHandle )
		FWriteLine( cHandle, Replicate("=", 80))
		FWriteLine( cHandle, "Usuario   : " + oAmbiente:xUsuario )
		FWriteLine( cHandle, "Data      : " + DToC(Date()))
		FWriteLine( cHandle, "Horas     : " + Time())
		FWriteLine( cHandle, "SubSystem : " + csystem )
		FWriteLine( cHandle, "SubCode   : " + Str(nsubcode, 4))
		FWriteLine( cHandle, "Variavel  : " + e:operation )
		FWriteLine( cHandle, "Arquivo   : " + e:filename )
		FWriteLine( cHandle, "Area      : " + Alias())
		FWriteLine( cHandle, "Indice    : " + IndexKey( IndexOrd()))
		FWriteLine( cHandle, "Descricao : " + e:description )
		FWriteLine( cHandle, "Explanacao: " + cexplanacao )
		FWriteLine( cHandle, "Acao      : " + cAcao )
		FWriteLine( cHandle, "Acao      : " + cAcao1 )
		FWriteLine( cHandle, Replicate("-", 80))
		FWriteLine( cHandle, "PILHA DE CARGA" )
		nCol := 0
		i	  := 2
		nX   := 0
		Do While (!Empty(ProcName(i)))
			nCol++
			nX++
			FWriteLine( cHandle, Space(16) + "Linha : " + strzero(procline(i), 6) + "    Proc : " + ProcName(i))
			i++
		EndDo
		FWriteLine( cHandle, Replicate("=", 80))
		Fclose( cHandle )
		Set Console On
		FChDir( oAmbiente:xRoot )
		// Break(e)
	EndIF
   */
   
	SetColor("")
	Cls
	if nSubCode = 1012
      cDbf := e:FileName() 
		if !Empty(cDbf)
			ErrorBeep()
			if Conf("O arquivo " + AllTrim(cDbf) + " corrompeu. Criar um novo ?")
				cTemp := StrTran( cDbf, ".dbf") + ".old"            
				Ferase( cTemp )
				if msrename(cDbf, cTemp) == 0            						
					if CriaArquivo(ms_remove_path(cDbf))
						Ferase(ms_remove_path(cDbf) + CEXT)
						Cls
						ErrorBeep()
						Mensagem("Informa: Arquivo " + cDbf + " criado com sucesso.;-; Encerrando... Execute novamente o Sistema.")
						FChDir( oAmbiente:xRoot )
                  SetColor("")
                  SetPos(maxrow(),0)
                  ? "Macrosoft for Linux terminate!"
						Break( e )
						Quit
					endif
				else
					AlertaPy("Erro: Impossivel consertar o arquivo.; Erro# " + StrTrim(Ferror()))
				endif
			else
            FChDir( oAmbiente:xRoot )				
            Encerra()
         endif
		endif
	endif

	Set Devi To Screen
	Set Prin Off
	Set Cons On
	Set Print to
	Set Color To Gr+/b
	@ 0, 0 Clear To  9, MaxCol()
	@ 0, 0 To	9, MaxCol() Color "Gr+/b"
	@ 1, 1  Say "SubSystem : "
	@ 1, 35 Say "SubCode : "
	@ 2, 1  Say "OsCode    : "
	@ 2, 35 Say "GenCode : "	
	@ 3, 1  Say "Variavel  : "
	@ 3, 35 Say "Arquivo : "
	@ 4, 1  Say "Area      : "
	@ 4, 35 Say "Indice  : "

	@ 5, 1 Say "Descri‡ao : "
	@ 6, 1 Say "Explana‡ao: "
	@ 7, 1 Say "A‡ao      : "
	
	@ 1, 14 Say csystem             				Color "W+/B"
	@ 1, 45 Say Str(nsubcode, 4)    				Color "W+/B"

	@ 2, 14 Say Alltrim(Str(e:oscode(), 4)) 	Color "W+/B"	
	@ 2, 45 Say AllTrim(Str(e:gencode(), 4)) 	Color "W+/B"	
	
	@ 3, 14 Say e:operation()       				Color "W+/B"
	@ 3, 45 Say Upper(e:filename()) 				Color "W+/B"

	@ 4, 14 Say Alias()             				Color "W+/B"
	@ 4, 45 Say Upper(IndexKey(IndexOrd())) 	Color "W+/B"

	@ 5, 14 Say e:description 						Color "W+/B"
	@ 6, 14 Say cexplanacao 						Color "W+/B"
	@ 7, 14 Say cacao 								Color "R/B"
	@ 8, 14 Say cacao1 								Color "R/B"

	ncol := 16
	Set Color To Gr+/b
	@ ncol, 0 Clear To 23, MaxCol()
	@ ncol, 0		 To 23, MaxCol() Color "Gr+/b"
	@ ncol, 12 Say "PILHA DE CARGA" Color "W+/B"

	i	:= 2
	nx := 0
	ncol ++
	nRow := 00
	Do While (!Empty( ProcName(i)))
		nx++
		@ ncol, nRow+01 Say "[" + StrZero( i, 2 )   + "]:"        Color "W+/B"
		@ ncol, nRow+06 Say "[" + strzero(procline(i), 6) + "]:"  Color "GR+/B"
		@ ncol, nRow+16 Say ProcName(i)								    Color "W+/B"
		i++
		nCol++
		IF nCol >= 23
			nCol := 17
			nRow += 40
		EndIF
	EndDo

	cmessage := "Escolha uma opcao abaixo."
	aoptions := {"Encerrar"}
	If (e:canretry())
		AAdd(aoptions, "Tentar")
	EndIf
	If (e:candefault())
		AAdd(aoptions, "Default")
	EndIf

	nchoice:= 0
	Do While (nchoice == 0)
		nchoice:= alert(cmessage, aoptions)
		If (!Empty(nchoice))
			If (aoptions[nchoice] == "Encerrar")
				nopcao:= alert("Pergunta: Imprimir resultado para ?", {"Nenhum", "Impressora"})
				if (nopcao == 2)
					If (instru80() .AND. lptok())
						printon()
						setprc(0, 0)
						Qout(Replicate("=", 80))
						@	02,  01 Say "SubSystem : " + csystem
						@	03,  01 Say "SubCode   : " + Str(nsubcode, 4)
						@	04,  01 Say "Variavel  : " + e:operation()
						@	05,  01 Say "Arquivo   : " + e:filename()
						@	06,  01 Say "Area      : " + Alias()
						@	07,  01 Say "Descricao : " + e:description
						@	08,  01 Say "Explanacao: " + cexplanacao
						@	09,  01 Say "Acao      : " + cacao
						@	10,  13 Say cacao1
						Qout( Replicate("-", 80))
						ncol := 12
						@ ncol,	6 Say "[Pilha de Carga]"
						i := 2
						nx := 0
						Do While (!Empty(ProcName(i)))
							nCol++
							nX++
							@ nCol, 01 Say StrZero(nX, 2) +")Proc:"
							@ nCol, 09 Say ProcName(i) Color "W+/B"
							@ nCol, 20 Say "Linha:"
							@ nCol, 26 Say strzero(procline(i), 6) Color "W+/B"
							i++
						EndDo
						Qout(Replicate("=", 80))
						Eject
						PrintOff()
					EndIf
				EndIF
				FChDir( oAmbiente:xRoot )
				Set Date British
				Set Console Off
				FClose( cPrograma )
            if !ms_swap_File( cPrograma )
					cHandle := Fcreate( cPrograma, FC_NORMAL )
					FClose( cHandle )
				EndIF
				cHandle := FOpen( cPrograma, FO_READWRITE + FO_SHARED )
				IF ( Ferror() != 0 )
					FClose( cHandle )
					SetColor("")
					Cls
					Alert( "Erro #3: Erro de Abertura " + cPrograma + ". Erro DOS " + Str( Ferror(),3))
					Break(e)
					//FlReset()
					Quit
				EndIF
				FBot( cHandle )
				FWriteLine( cHandle, Replicate("=", 80))
				FWriteLine( cHandle, "Usuario  1: " + oAmbiente:xUsuario )
				FWriteLine( cHandle, "Data      : " + DToC(Date()))
				FWriteLine( cHandle, "Horas     : " + Time())
				FWriteLine( cHandle, "SubSystem : " + csystem )
				FWriteLine( cHandle, "SubCode   : " + Str(nsubcode, 4))
				FWriteLine( cHandle, "Variavel  : " + e:operation )
				FWriteLine( cHandle, "Arquivo   : " + e:filename )
				FWriteLine( cHandle, "Area      : " + Alias())
				FWriteLine( cHandle, "Indice    : " + IndexKey( IndexOrd()))
				FWriteLine( cHandle, "Descricao : " + e:description )
				FWriteLine( cHandle, "Explanacao: " + cexplanacao )
				FWriteLine( cHandle, "Acao      : " + cAcao )
				FWriteLine( cHandle, "Acao      : " + cAcao1 )
				FWriteLine( cHandle, Replicate("-", 80))
				FWriteLine( cHandle, "PILHA DE CARGA" )
				i	:= 2
				nX := 0
				Do While (!Empty(ProcName(i)))
					nCol++
					nX++
					FWriteLine( cHandle, Space(16) + "Linha : " + strzero(procline(i), 6) + "    Proc : " + ProcName(i))
					i++
				EndDo
				FWriteLine( cHandle, Replicate("=", 80))
				Fclose( cHandle )
				Set Console On
				SetColor("")
				Cls
				FChDir( oAmbiente:xRoot )
				Break(e)
				//FlReset()
				Quit
			ElseIf (aoptions[nchoice] == "Tentar")
				ResTela( cScreen )
				Return .T.
			ElseIf (aoptions[nchoice] == "Default")
				ResTela( cScreen )
				Return .F.
			EndIf
		EndIf
	EndDo
	Set Device To Screen
	Set Printer Off
	Break
	Return .T.
endef
	
def ArrayArquivos()
	LOCAL aArquivos := {}
	Aadd( aArquivos, {"lista.dbf",{{ "ID",         "+", 04, 0 }, ; // Autoincremento
										 { "CODIGO",     "C", 06, 0 }, ; // Codigo do Produto
										 { "CODGRUPO",   "C", 03, 0 }, ;
										 { "CODSGRUPO",  "C", 06, 0 }, ;
										 { "DESCRICAO",  "C", 40, 0 }, ;
										 { "UN",         "C", 02, 0 }, ;
										 { "EMB",        "N", 03, 0 }, ;
										 { "QUANT",      "N", 09, 2 }, ;
										 { "VENDIDA",    "N", 09, 2 }, ;
										 { "PEDIDO",     "N", 09, 2 }, ; // Quant Mercadoria Pedida
										 { "ATACADO",    "N", 11, 2 }, ;
										 { "PCOMPRA",    "N", 11, 2 }, ;
										 { "CUSTODOLAR", "N", 11, 2 }, ;
										 { "PCUSTO",     "N", 11, 2 }, ;
										 { "DATA",       "D", 08, 0 }, ;
										 { "N_ORIGINAL", "C", 15, 0 }, ;
										 { "CODEBAR",    "C", 15, 0 }, ;
										 { "SIGLA",      "C", 10, 0 }, ;
										 { "QMAX",       "N", 09, 2 }, ;
										 { "QMIN",       "N", 09, 2 }, ;
										 { "CODI",       "C", 04, 0 }, ; // Codigo do Fabricante/Pagar
										 { "CODI1",      "C", 04, 0 }, ; // Codigo do Fornecedor/Pagar
										 { "CODI2",      "C", 04, 0 }, ; // Codigo do Fornecedor/Pagar
										 { "CODI3",      "C", 04, 0 }, ; // Codigo do Fornecedor/Pagar
										 { "REPRES",     "C", 04, 0 }, ; // Codigo do Representante
										 { "MARCUS",     "N", 06, 2 }, ; // Margem do Pcusto
										 { "MARVAR",     "N", 06, 2 }, ; // Margem do Varejo
										 { "MARATA",     "N", 06, 2 }, ; // Margem do Atacado
										 { "IMPOSTO",    "N", 06, 2 }, ; // Percentual de Imposto
										 { "FRETE",      "N", 06, 2 }, ; // Percentual de Frete
										 { "VAREJO",     "N", 11, 2 }, ;
										 { "BX_CON",     "L", 01, 0 }, ;
										 { "UFIR",       "N", 07, 2 }, ;
										 { "IPI",        "N", 05, 2 }, ;
										 { "II",         "N", 05, 2 }, ;
										 { "SITUACAO",   "C", 01, 0 }, ;
										 { "CLASSE",     "C", 02, 0 }, ;
										 { "TX_ICMS",    "N", 03, 0 }, ; // Aliquota Icms Substituicao
										 { "REDUCAO",    "N", 03, 0 }, ; // Reducao da Base de Calculo
										 { "LOCAL",      "C", 10, 0 }, ;
										 { "TAM",        "C", 06, 0 }, ;
										 { "DESCONTO",   "N", 06, 2 }, ;
										 { "ATUALIZADO", "D", 08, 0 }, ;
										 { "SERVICO",    "L", 01, 0 }, ;
										 { "RO",         "N", 06, 2 }, ;
										 { "AC",         "N", 06, 2 }, ;
										 { "MT",         "N", 06, 2 }, ;
										 { "AM",         "N", 06, 2 }, ;
										 { "RR",         "N", 06, 2 }, ;
										 { "USA",        "L", 01, 0 }, ;
										 { "PORC",       "N", 05, 2 }}})

Aadd( aArquivos, { "saidas.dbf", {{ "CODIGO",     "C", 06, 0 }, ; // Produto
											 { "DOCNR",      "C", 09, 0 }, ;
											 { "CODIVEN",    "C", 04, 0 }, ;
                                  { "TECNICO",    "C", 04, 0 }, ;
                                  { "CAIXA",      "C", 04, 0 }, ;
											 { "FORMA",      "C", 02, 0 }, ;
											 { "CODI",       "C", 05, 0 }, ; // Cliente
											 { "FATURA",     "C", 09, 0 }, ;
											 { "PEDIDO",     "C", 07, 0 }, ;
											 { "REGIAO",     "C", 02, 0 }, ;
											 { "PLACA",      "C", 08, 0 }, ;
											 { "TIPO",       "C", 06, 0 }, ;
											 { "EMIS",       "D", 08, 0 }, ;
											 { "DATA",       "D", 08, 0 }, ;
											 { "DESCONTO",   "N", 05, 2 }, ;
											 { "DIFERENCA",  "N", 11, 2 }, ;
											 { "PORC",       "N", 05, 2 }, ;
											 { "PVENDIDO",   "N", 11, 2 }, ;
											 { "SAIDA",      "N", 09, 2 }, ;
											 { "SAIDAPAGA",  "N", 09, 2 }, ;
											 { "QTD_D_FATU", "N", 02, 0 }, ;
											 { "ATACADO",    "N", 11, 2 }, ;
											 { "VAREJO",     "N", 11, 2 }, ;
											 { "PCUSTO",     "N", 11, 2 }, ;
											 { "PCOMPRA",    "N", 11, 2 }, ;
											 { "VLRFATURA",  "N", 13, 2 },;
											 { "ATUALIZADO", "D", 08, 0 },;
											 { "IMPRESSO",   "L", 01, 0 },;
											 { "SERIE",      "C", 10, 0 },;
											 { "EXPORTADO",  "L", 01, 0 },;
											 { "SITUACAO",   "C", 08, 0 },;
											 { "C_C",        "L", 01, 0 }}})

Aadd( aArquivos, { "entradas.dbf",  {{ "CODIGO",     "C", 06, 0 }, ; // Produto
												 { "PCUSTO",     "N", 11, 2 }, ;
												 { "CUSTOFINAL", "N", 11, 2 }, ;
												 { "DATA",       "D", 08, 0 }, ;
												 { "DENTRADA",   "D", 08, 0 }, ;
												 { "ENTRADA",    "N", 09, 2 }, ;
												 { "IMPOSTO",    "N", 06, 2 }, ; // Percentual de Imposto
												 { "FRETE",      "N", 06, 2 }, ; // Percentual de Frete
												 { "CONDICOES",  "C", 23, 0 }, ;
												 { "CODI",       "C", 04, 0 }, ; // Fornecedor
												 { "FATURA",     "C", 09, 0 }, ;
												 { "VLRFATURA",  "N", 13, 2 }, ;
												 { "ICMS",       "N", 02, 0 }, ;
												 { "ATUALIZADO", "D", 08, 0 },;
												 { "CFOP",       "C", 05, 0 },;
												 { "VLRNFF",     "N", 13, 2 }}})

Aadd( aArquivos, { "receber.dbf", {{ "CODI",      "C", 05, 0 }, ; // Cliente
											  { "NOME",      "C", 40, 0 }, ;
											  { "ENDE",      "C", 30, 0 }, ;
											  { "CIDA",      "C", 25, 0 }, ;
											  { "ESTA",      "C", 02, 0 }, ;
											  { "CEP",       "C", 09, 0 }, ;
											  { "PRACA",     "C", 09, 0 }, ;
											  { "CPF",       "C", 14, 0 }, ;
											  { "CGC",       "C", 18, 0 }, ;
											  { "INSC",      "C", 15, 0 }, ;
											  { "RG",        "C", 18, 0 }, ;
											  { "BAIR",      "C", 20, 0 }, ;
											  { "DATA",      "D", 08, 0 }, ;
											  { "FONE",      "C", 14, 0 }, ;
											  { "OBS",       "C", 60, 0 }, ;
											  { "OBS1",      "C", 60, 0 }, ;
											  { "OBS2",      "C", 60, 0 }, ;
											  { "OBS3",      "C", 60, 0 }, ;
											  { "OBS4",      "C", 60, 0 }, ;
											  { "OBS5",      "C", 60, 0 }, ;
											  { "OBS6",      "C", 60, 0 }, ;
											  { "OBS7",      "C", 60, 0 }, ;
											  { "OBS8",      "C", 60, 0 }, ;
											  { "OBS9",      "C", 60, 0 }, ;
											  { "OBS10",     "C", 60, 0 }, ;
											  { "OBS11",     "C", 60, 0 }, ;
											  { "OBS12",     "C", 60, 0 }, ;
											  { "OBS13",     "C", 60, 0 }, ;
											  { "FANTA",     "C", 40, 0 }, ;
											  { "FAX",       "C", 14, 0 }, ;
											  { "MEDIA",     "N", 11, 2 }, ;
											  { "REFBCO",    "C", 40, 0 }, ;
											  { "REFCOM",    "C", 40, 0 }, ;
											  { "IMOVEL",    "C", 40, 0 }, ;
											  { "REGIAO",    "C", 02, 0 }, ;
											  { "MATRASO",   "N", 03, 0 }, ;   // Maior Atraso
											  { "VLRCOMPRA", "N", 13, 2 }, ;   // Vlr da Ultima compra
											  { "EMIS",      "D", 08, 0 }, ;
											  { "CIVIL",     "C", 15, 0 }, ;
											  { "NATURAL",   "C", 30, 0 }, ;
											  { "NASC",      "D", 08, 0 }, ;
											  { "ESPOSA",    "C", 40, 0 }, ;
											  { "DEPE",      "N", 02, 0 }, ;
											  { "PAI",       "C", 40, 0 }, ;
											  { "MAE",       "C", 40, 0 }, ;
											  { "ENDE1",     "C", 30, 0 }, ;
											  { "FONE1",     "C", 14, 0 }, ;
											  { "FONE2",     "C", 14, 0 }, ;
											  { "PROFISSAO", "C", 30, 0 }, ;
											  { "CARGO",     "C", 20, 0 }, ;
											  { "TRABALHO",  "C", 30, 0 }, ;
											  { "TEMPO",     "C", 20, 0 }, ;
											  { "VEICULO",   "C", 40, 0 }, ;
											  { "CONHECIDA", "C", 40, 0 }, ;
											  { "ENDE3",     "C", 30, 0 }, ;
											  { "CIDAAVAL",  "C", 25, 0 }, ;
											  { "ESTAAVAL",  "C", 02, 0 }, ;
											  { "BAIRAVAL",  "C", 20, 0 }, ;
											  { "FONEAVAL",  "C", 14, 0 }, ;
											  { "FAXAVAL",   "C", 14, 0 }, ;
											  { "CPFAVAL",   "C", 14, 0 }, ;
											  { "RGAVAL",    "C", 18, 0 }, ;
											  { "SPC",       "L", 01, 0 }, ;
											  { "DATASPC",   "D", 08, 0 }, ;
											  { "BANCO",     "C", 30, 0 }, ;
											  { "LIMITE",    "N", 13, 2 }, ;  // Limite de Credito
											  { "CANCELADA",  "L", 01, 0 }, ;  // Ficha Cancelada
											  { "ATUALIZADO", "D", 08, 0 },;
											  { "FABRICANTE", "C", 40, 0 },;
											  { "PRODUTO",    "C", 40, 0 },;
											  { "MODELO",     "C", 30, 0 },;
											  { "VALOR",      "N", 13, 2 },;
											  { "LOCAL",      "C", 30, 0 },;
											  { "PRAZO",      "N", 03, 0 },;
											  { "DATAVCTO",   "N", 02, 0 },;
											  { "PRAZOEXT",   "N", 03, 0 },;
											  { "SCI",        "L", 01, 0 },;
											  { "SUPORTE",    "L", 01, 0 },;
											  { "AUTORIZACA", "L", 01, 0 },;
											  { "ASSAUTORIZ", "L", 01, 0 },;
											  { "PROXCOB",    "D", 08, 0 },;
											  { "EXPORTADO",  "L", 01, 0 },;
											  { "ROL",        "L", 01, 0 },;
											  { "CFOP",       "C", 05, 0 },;
											  { "TX_ICMS",    "N", 05, 2 },;
											  { "ULTCOMPRA",  "D",  8, 0 }}})  // Ultima Compra

Aadd( aArquivos, { "repres.dbf",;
											{{ "REPRES", "C",  4, 0 }, ;
											 { "NOME",   "C", 40, 0 }, ;
											 { "ENDE",   "C", 30, 0 }, ;
											 { "CIDA",   "C", 25, 0 }, ;
											 { "ESTA",   "C",  2, 0 }, ;
											 { "CEP",    "C",  9, 0 }, ;
											 { "CGC",    "C", 18, 0 }, ;
											 { "INSC",   "C", 15, 0 }, ;
											 { "BAIR",   "C", 20, 0 }, ;
											 { "FONE",   "C", 14, 0 }, ;
											 { "CON",    "C", 20, 0 }, ;
											 { "OBS",    "C", 60, 0 }, ;
											 { "FAX",    "C", 14, 0 }, ;
											 { "ATUALIZADO", "D", 08, 0 },;
											 { "CAIXA",  "C",  3, 0 }}})

Aadd( aArquivos, { "recemov.dbf", {{ "ID",         "+", 04, 0 },;
                                   { "CODI",       "C", 05, 0 }, ; // Cliente
											  { "CODIVEN",    "C", 04, 0 }, ;
											  { "CAIXA",      "C", 04, 0 }, ;
											  { "DOCNR",      "C", 09, 0 }, ;
											  { "FATURA",     "C", 09, 0 }, ;
											  { "PORT",       "C", 10, 0 }, ;
											  { "TIPO",       "C", 06, 0 }, ;
											  { "NOSSONR",    "C", 13, 0 }, ;
											  { "BORDERO",    "C", 09, 0 }, ;
											  { "FORMA",      "C", 02, 0 }, ;
											  { "COBRADOR",   "C", 04, 0 }, ;
											  { "REGIAO",     "C", 02, 0 }, ;
											  { "VLR",        "N", 13, 2 }, ;
											  { "VLRORIGINA", "N", 13, 2 }, ;
											  { "VLRPAG",     "N", 13, 2 }, ;											  
											  { "VLRDOLAR",   "N", 13, 2 }, ;
                                   { "JURODIA",    "N", 16, 5 }, ;
                                   { "JUROTOTAL",  "N", 16, 5 }, ;
                                   { "JURO",       "N", 09, 5 }, ;
											  { "QTD_D_FATU", "N", 02, 0 }, ;
											  { "VLRFATU",    "N", 13, 2 }, ;
											  { "PORC",       "N", 05, 2 }, ;
											  { "EMIS",       "D", 08, 0 }, ;
											  { "VCTO",       "D", 08, 0 }, ;
											  { "DATAPAG",    "D", 08, 0 }, ;											  
											  { "TITULO",     "L", 01, 0 }, ;
											  { "ATUALIZADO", "D", 08, 0 }, ;
											  { "STPAG",      "L", 01, 0 }, ;
											  { "CODGRUPO",   "C", 03, 0 }, ;
											  { "EXPORTADO",  "L", 01, 0 }, ; 
											  { "RELCOB",     "L", 01, 0 }, ;   // Relatorio Cobranca Emitido ?
                                   { "OBS",        "C", 80, 0 }, ;
                                   { "COMISSAO",   "L", 01, 0 }}})  // Lancar Comissao ?

Aadd( aArquivos, { "grupo.dbf",   {{ "CODGRUPO",   "C", 03, 0 },;
											  { "ATUALIZADO", "D", 08, 0 },;
											  { "SERVICO",    "L", 01, 0 },;
											  { "DESGRUPO",   "C", 40, 0 }}})

Aadd( aArquivos, { "subgrupo.dbf", {{ "CODSGRUPO",  "C", 06, 0 },;
												{ "ATUALIZADO", "D", 08, 0 },;
												{ "DESSGRUPO",  "C", 40, 0 }}})

Aadd( aArquivos, { "vendedor.dbf",;
											 {{ "CODIVEN",  "C",  4, 0 }, ;
											  { "NOME",     "C", 40, 0 }, ;
											  { "ENDE",     "C", 25, 0 }, ;
											  { "SENHA",    "C", 10, 0 }, ;
											  { "CIDA",     "C", 25, 0 }, ;
											  { "ESTA",     "C",  2, 0 }, ;
											  { "CEP",      "C",  9, 0 }, ;
											  { "CPF",      "C", 14, 0 }, ;
											  { "RG",       "C", 18, 0 }, ;
											  { "CT",       "C", 10, 0 }, ;
											  { "BAIR",     "C", 20, 0 }, ;
											  { "DATA",     "D",  8, 0 }, ;
                                   { "FONE",     "C", 14, 0 }, ;
											  { "CON",      "C", 20, 0 }, ;
											  { "OBS",      "C", 30, 0 }, ;
											  { "PORCCOB",  "N", 05, 2 }, ;
											  { "COMDISP",  "N", 13, 2 }, ;
											  { "COMBLOQ",  "N", 13, 2 }, ;
											  { "ATUALIZADO", "D", 08, 0 },;
											  { "ROL",        "L", 01, 0 },;
											  { "COMISSAOS", "N", 13, 3 },;
											  { "COMISSAO", "N", 13, 2 }}})

Aadd( aArquivos, { "vendemov.dbf",;
											 {{ "CODIVEN",    "C", 04, 0 }, ;
											  { "CODI",       "C", 05, 0 }, ; // Cliente
											  { "VLR",        "N", 13, 2 }, ;
											  { "DC",         "C", 01, 0 }, ;
											  { "DOCNR",      "C", 09, 0 }, ;
											  { "DATA",       "D", 08, 0 }, ;
											  { "VCTO",       "D", 08, 0 }, ;
											  { "PORC",       "N", 05, 2 }, ;
											  { "COMDISP",    "N", 13, 2 }, ;
											  { "COMBLOQ",    "N", 13, 2 }, ;
											  { "COMISSAO",   "N", 13, 2 }, ;
											  { "PEDIDO",     "C", 07, 0 }, ;
											  { "DATAPED",    "D", 08, 0 }, ;
											  { "FATURA",     "C", 09, 0 }, ;
											  { "FORMA",      "C", 02, 0 }, ;
											  { "DESCRICAO",  "C", 40, 0 },;
											  { "ATUALIZADO", "D", 08, 0 },;
											  { "REGIAO",     "C", 02, 0 }}})

Aadd( aArquivos, { "entnota.dbf",;
											{{ "ID",         "+", 04, 0 },;
                                  { "NUMERO",     "C", 07, 0 },;
											 { "CODI",       "C", 04, 0 },; // Fornecedor
											 { "VLRFATURA",  "N", 13, 2 },;
											 { "VLRNFF",     "N", 13, 2 },;
											 { "ICMS",       "N", 02, 0 },;
											 { "ENTRADA",    "D", 08, 0 },;
											 { "ATUALIZADO", "D", 08, 0 },;
											 { "CONDICOES",  "C", 23, 0 },;
											 { "DATA",       "D", 08, 0 }}})

Aadd( aArquivos, { "nota.dbf",;
											{{ "ID",         "+", 04, 0 },;
                                  { "NUMERO",     "C", 07, 0 },;
											 { "ATUALIZADO", "D", 08, 0 },;
											 { "DATA",       "D", 08, 0 },;  // Data Nota Fiscal
											 { "SITUACAO",   "C", 08, 0 },;
                                  { "CAIXA",      "C", 04, 0 },;
											 { "CODI",       "C", 05, 0 }}}) // Cliente

Aadd( aArquivos, { "pagamov.dbf",;
											 {{ "CODI",       "C", 04, 0 }, ; // Fornecedor
											  { "DESC",       "C", 04, 0 }, ;
											  { "VLR",        "N", 13, 2 }, ;
											  { "JURODIA",    "N", 13, 2 }, ;
											  { "DESCONTO",   "N", 06, 2 }, ;
											  { "JURO",       "N", 06, 2 }, ;
											  { "EMIS",       "D", 08, 0 }, ;
											  { "VCTO",       "D", 08, 0 }, ;
											  { "DOCNR",      "C", 09, 0 }, ;
											  { "PORT",       "C", 10, 0 }, ;
											  { "TIPO",       "C", 06, 0 }, ;
											  { "FATURA",     "C", 09, 0 }, ;
											  { "VLRFATU",    "N", 13, 2 }, ;
											  { "OBS1",       "C", 60, 0 }, ;
											  { "OBS2",       "C", 60, 0 }, ;
											  { "ATUALIZADO", "D", 08, 0 }}})

Aadd( aArquivos, { "pagar.dbf",;
											{{ "CODI",   "C",  4, 0 }, ; // Fornecedor
											 { "REPRES", "C",  4, 0 }, ; // Codigo do Representante
											 { "NOME",   "C", 40, 0 }, ;
											 { "SIGLA",  "C", 10, 0 }, ; // Sigla do Fornecedor
											 { "ENDE",   "C", 30, 0 }, ;
											 { "CIDA",   "C", 25, 0 }, ;
											 { "ESTA",   "C",  2, 0 }, ;
											 { "CEP",    "C",  9, 0 }, ;
											 { "CPF",    "C", 14, 0 }, ;
											 { "CGC",    "C", 18, 0 }, ;
											 { "INSC",   "C", 15, 0 }, ;
											 { "RG",     "C", 18, 0 }, ;
											 { "BAIR",   "C", 20, 0 }, ;
											 { "DATA",   "D",  8, 0 }, ;
											 { "FONE",   "C", 14, 0 }, ;
											 { "CON",    "C", 20, 0 }, ;
											 { "OBS",    "C", 30, 0 }, ;
											 { "TIPO",   "C",  6, 0 }, ;
											 { "FANTA",  "C", 40, 0 }, ;
											 { "FAX",    "C", 14, 0 }, ;
											 { "ATUALIZADO", "D", 08, 0 },;
											 { "CAIXA",  "C",  3, 0 }}})

Aadd( aArquivos, { "taxas.dbf",;
											 {{ "DINI",    "D", 08, 0 }, ;
											  { "DFIM",    "D", 08, 0 }, ;
											  { "TXATU",   "N", 06, 2 }, ;
											  { "JURATA",  "N", 06, 2 }, ;
											  { "UFIR",    "N", 07, 2 }, ;
											  { "JURVAR",  "N", 06, 2 }, ;
											  { "ATUALIZADO", "D", 08, 0 },;
											  { "COTACAO", "N", 11, 2 }}})

Aadd( aArquivos, { "pago.dbf",;
											 {{ "CODI",       "C", 04, 0 },; // Fornecedor
											  { "VLR",        "N", 13, 2 },;
											  { "EMIS",       "D", 08, 0 },;
											  { "VCTO",       "D", 08, 0 },;
											  { "DOCNR",      "C", 09, 0 },;
											  { "FATURA",     "C", 09, 0 }, ;
											  { "DATAPAG",    "D", 08, 0 },;
											  { "VLRPAG",     "N", 13, 2 },;
											  { "PORT",       "C", 10, 0 },;
											  { "TIPO",       "C", 06, 0 },;
											  { "JURO",       "N", 06, 2 },;
											  { "OBS1",       "C", 60, 0 }, ;
											  { "OBS2",       "C", 60, 0 }, ;
											  { "ATUALIZADO", "D", 08, 0 },;
											  { "NDEB",       "C", 03, 0 }}})

Aadd( aArquivos, { "recebido.dbf",;
                                  {{ "CODI" ,    "C",  05 , 0 },; // Cliente
                                   { "REGIAO",   "C",  02 , 0 },;
                                   { "CAIXA",    "C",  04 , 0 }, ;
											  { "CODIVEN",  "C" , 04 , 0 },;
											  { "DOCNR" ,   "C" , 09 , 0 },;
											  { "FATURA",   "C" , 09 , 0 },;
											  { "PORT" ,    "C" , 10 , 0 },;
											  { "TIPO" ,    "C" , 06 , 0 },;
											  { "NOSSONR" , "C" , 13 , 0 },;
											  { "BORDERO" , "C" , 09 , 0 },;
											  { "FORMA",    "C",  02 , 0 },;
											  { "OBS",      "C",  40 , 0 },;
											  { "DATAPAG" , "D" , 08 , 0 },;
											  { "BAIXA",    "D",  08 , 0 },;
											  { "EMIS" ,    "D" , 08 , 0 },;
											  { "VCTO" ,    "D" , 08 , 0 },;
											  { "VLR" ,     "N" , 13 , 2 },;
											  { "VLRPAG" ,  "N" , 13 , 2 },;
											  { "ATUALIZADO", "D", 08, 0 },;
                                   { "EXPORTADO","L", 01, 0 },;
											  { "PARCIAL",  "C",  01, 0 },;
											  { "JURO" ,    "N",  06, 2 }}})
Aadd( aArquivos, { "cheque.dbf",;
											 {{ "CODI",     "C", 04, 0 },; // Conta
											  { "BANCO",    "C", 10, 0 },;
											  { "TITULAR",  "C", 40, 0 },;
											  { "AG",       "C", 25, 0 },;
											  { "CGC",      "C", 18, 0 },;
											  { "CONTA",    "C",  8, 0 },;
											  { "DATA",     "D",  8, 0 },;
											  { "SALDO",    "N", 17, 2 },;
											  { "DEBITOS",  "N", 18, 2 },;
											  { "CREDITOS", "N", 18, 2 },;
                                   { "FONE",     "C", 14, 0 },;
											  { "MENS",     "L", 01, 0 },;
											  { "OBS",      "C", 40, 0 },;
											  { "CPF",      "C", 15, 0 },;
											  { "CPF1",     "C", 15, 0 },;
											  { "RG",       "C", 18, 0 },;
											  { "RG1",      "C", 18, 0 },;
											  { "NASCI",    "D", 08, 0 },;
											  { "ENDE",     "C", 35, 0 },;
											  { "ENDE1",    "C", 35, 0 },;
											  { "CIDA",     "C", 25, 0 },;
											  { "ESTA",     "C", 02, 0 },;
											  { "PROFISSAO","C", 15, 0 },;
											  { "TRABALHO", "C", 40, 0 },;
                                   { "FONE1",    "C", 14, 0 },;
                                   { "FONE2",    "C", 14, 0 },;
											  { "RESP",     "C", 40, 0 },;
											  { "HORARIO",  "C", 11, 0 },;
											  { "DIAS",     "C", 15, 0 },;
											  { "C_C",      "L", 01, 0 },;
											  { "EXTERNA",  "L", 01, 0 },;
											  { "ATIVO",    "L", 01, 0 },;
											  { "CURSO",    "C", 04, 0 },;
											  { "RENOVADO", "L", 01, 0 },;
											  { "POUPANCA", "L", 01, 0 },;
											  { "ATUALIZADO", "D", 08, 0 },;
											  { "DEB_DEB",    "C", 01, 0 },;
											  { "DEB_CRE",    "C", 01, 0 },;
											  { "CRE_DEB",    "C", 01, 0 },;
											  { "CRE_CRE",    "C", 01, 0 },;
											  { "DURACAO",    "N", 02, 0 }}})

Aadd( aArquivos, { "chemov.dbf",;
											{{ "CODI",   "C", 04, 0 } , ; // Conta
											 { "DATA",   "D", 08, 0 } , ;
											 { "EMIS",   "D", 08, 0 } , ;
											 { "BAIXA",  "D", 08, 0 } , ;
											 { "SALDO",  "N", 15, 2 } , ;
											 { "HIST",   "C", 40, 0 } , ;
											 { "DOCNR",  "C", 09, 0 } , ;
											 { "FATURA", "C", 09, 0 } , ;
											 { "CAIXA",  "C", 04, 0 } , ;
											 { "CRE",    "N", 15, 2 } , ;
											 { "DEB",    "N", 15, 2 } , ;
											 { "ATUALIZADO", "D", 08, 0 },;
											 { "CPARTIDA", "L", 01, 0 },;
											 { "TIPO",     "C", 06, 0 }}})

Aadd( aArquivos, { "chepre.dbf",;
											 {{ "CODI",       "C", 04, 0 } , ; // Conta
											  { "BANCO",      "C", 10, 0 } , ;
											  { "CONTA",      "C", 08, 0 } , ;
											  { "DATA",       "D", 08, 0 } , ;
											  { "VCTO",       "D", 08, 0 } , ;
											  { "SALDO",      "N", 15, 2 } , ;
											  { "HIST",       "C", 40, 0 } , ;
											  { "DOCNR",      "C", 09, 0 } , ;
											  { "VALOR",      "N", 15, 2 } , ;
											  { "PRACA",      "C", 20, 0 } , ;
											  { "AGENCIA",    "C", 10, 0 } , ;
											  { "CPFCGC",     "C", 14, 0 } , ;
											  { "DEBCRE",     "C", 01, 0 } , ;
											  { "ATUALIZADO", "D", 08, 0 },;
											  { "OBS",        "C", 40, 0 }}})

Aadd( aArquivos, { "regiao.dbf",;
											 {{ "REGIAO",  "C", 02, 0 },;
											  { "ATUALIZADO", "D", 08, 0 },;
											  { "NOME",    "C", 40, 0 }}})

Aadd( aArquivos, { "usuario.dbf",;
											 {{ "NOME",    "C", 10, 0 },;
											  { "SENHA",   "C", 10, 0 },;
											  { "NIVEL1",  "C", 01, 0 },;
											  { "NIVEL2",  "C", 01, 0 },;
											  { "NIVEL3",  "C", 01, 0 },;
											  { "NIVEL4",  "C", 01, 0 },;
											  { "NIVEL5",  "C", 01, 0 },;
											  { "NIVEL6",  "C", 01, 0 },;
											  { "NIVEL7",  "C", 01, 0 },;
											  { "NIVEL8",  "C", 01, 0 },;
											  { "NIVEL9",  "C", 01, 0 },;
											  { "NIVEL0",  "C", 01, 0 },;
											  { "NIVELA",  "C", 01, 0 },;
											  { "NIVELB",  "C", 01, 0 },;
											  { "NIVELC",  "C", 01, 0 },;
											  { "NIVELD",  "C", 01, 0 },;
											  { "NIVELE",  "C", 01, 0 },;
											  { "NIVELF",  "C", 01, 0 },;
											  { "NIVELG",  "C", 01, 0 },;
											  { "NIVELH",  "C", 01, 0 },;
											  { "NIVELI",  "C", 01, 0 },;
											  { "NIVELJ",  "C", 01, 0 },;
											  { "NIVELK",  "C", 01, 0 },;
											  { "NIVELL",  "C", 01, 0 },;
											  { "NIVELM",  "C", 01, 0 },;
											  { "NIVELN",  "C", 01, 0 },;
											  { "NIVELO",  "C", 01, 0 },;
											  { "NIVELP",  "C", 01, 0 },;
											  { "NIVELQ",  "C", 01, 0 },;
											  { "NIVELR",  "C", 01, 0 },;
											  { "NIVELS",  "C", 01, 0 },;
											  { "LPT1",    "C", 02, 0 },;
											  { "LPT2",    "C", 02, 0 },;
											  { "LPT3",    "C", 02, 0 },;
											  { "LPT4",    "C", 02, 0 },;
											  { "LPD1",    "C", 02, 0 },;
											  { "LPD2",    "C", 02, 0 },;
											  { "LPD3",    "C", 02, 0 },;
											  { "LPD4",    "C", 02, 0 },;
											  { "LPD5",    "C", 02, 0 },;
											  { "LPD6",    "C", 02, 0 },;
											  { "LPD7",    "C", 02, 0 },;
											  { "LPD8",    "C", 02, 0 },;
											  { "LPD9",    "C", 02, 0 },;
											  { "COM1",    "C", 02, 0 },;
											  { "COM2",    "C", 02, 0 },;
											  { "COM3",    "C", 02, 0 },;
											  { "ATUALIZADO", "D", 08, 0 },;
											  { "COM4",    "C", 02, 0 }}})

Aadd( aArquivos, { "cursos.dbf",;
											 {{ "CURSO",   "C", 04, 0 } , ;
											  { "OBS",     "C", 40, 0 } , ;
											  { "MENSAL",  "N", 13, 2 } , ;
											  { "RENOVA",  "N", 13, 2 } , ;
											  { "TAXA",    "N", 13, 2 } , ;
											  { "ATUALIZADO", "D", 08, 0 },;
											  { "DURACAO", "N", 03, 0 }}})
Aadd( aArquivos, { "cursado.dbf",;
											 {{ "CURSO",       "C", 04, 0 } , ;
											  { "CODI",        "C", 05, 0 } , ; // Cliente
											  { "FATURA",      "C", 09, 0 } , ;
											  { "MENSALIDAD",  "N", 13, 2 } , ;
											  { "MATRICULA",   "N", 13, 2 } , ;
											  { "INICIO",      "D", 08, 0 } , ;
											  { "ATUALIZADO", "D", 08, 0 },;
											  { "TERMINO",     "D", 08, 0 }}})

Aadd( aArquivos, { "forma.dbf",;
											 {{ "FORMA",      "C", 02, 0 },;
											  { "CONDICOES",  "C", 40, 0 },;
											  { "DESCRICAO",  "C", 40, 0 },;
											  { "COMISSAO",   "N", 05, 2 },;
											  { "IOF",        "N", 08, 4 },;
											  { "DESDOBRAR",  "L", 01, 0 },;
											  { "VISTA",      "L", 01, 0 },;
											  { "PARCELAS",   "N", 02, 0 },;
											  { "DIAS",       "N", 03, 0 },;
											  { "ATUALIZADO", "D", 08, 0 }}})

Aadd( aArquivos, { "cep.dbf",;
											 {{ "CEP",        "C", 09, 0 }, ;
											  { "CIDA",       "C", 25, 0 }, ;
											  { "ESTA",       "C", 02, 0 }, ;
											  { "ATUALIZADO", "D", 08, 0 }, ;
											  { "BAIR",       "C", 20, 0 }}})

Aadd( aArquivos, { "servidor.dbf",;
											 {{ "CODI",    "C", 04, 0 }, ;
											  { "NOME",    "C", 40, 0 }, ;
											  { "SENHA",   "C", 10, 0 },;
											  { "CARGO",   "C", 30, 0 }, ;
											  { "QUANT",   "N", 09, 2 }, ;
											  { "ATUALIZADO", "D", 08, 0 },;
											  { "CARGA",   "N", 09, 2 }}})

Aadd( aArquivos, { "ponto.dbf",;
											 {{ "CODI",    "C", 04, 0 }, ;
											  { "DATA",    "D", 08, 0 }, ;
											  { "QUANT",   "N", 09, 2 }, ;
											  { "MANHA1",  "C", 05, 0 }, ;
											  { "MANHA2",  "C", 05, 0 }, ;
											  { "TARDE1",  "C", 05, 0 }, ;
											  { "ATUALIZADO", "D", 08, 0 },;
											  { "TARDE2",  "C", 05, 0 }}})

Aadd( aArquivos, { "printer.dbf",;
											 {{ "CODI",      "C", 02, 0 },;
											  { "NOME",      "C", 40, 0 },;
											  { "_CPI10",    "C", 40, 0 },;
											  { "_CPI12",    "C", 40, 0 },;
											  { "GD",        "C", 40, 0 },;
											  { "PQ",        "C", 40, 0 },;
											  { "NG",        "C", 40, 0 },;
											  { "NR",        "C", 40, 0 },;
											  { "CA",        "C", 40, 0 },;
											  { "C18",       "C", 40, 0 },;
											  { "LIGSUB",    "C", 40, 0 },;
											  { "DESSUB",    "C", 40, 0 },;
											  { "_SALTOOFF", "C", 40, 0 },;
											  { "_SPACO1_8", "C", 40, 0 },;
											  { "_SPACO1_6", "C", 40, 0 },;
											  { "RESETA",    "C", 40, 0 },;
											  { "LIGITALIC", "C", 40, 0 },;
											  { "DESITALIC", "C", 40, 0 },;											  
											  { "ATUALIZADO", "D", 08, 0 }}})
Aadd( aArquivos, { "conta.dbf",;
											 {{ "CODI",       "C", 02, 0 },;
											  { "HIST",       "C", 40, 0 },;
											  { "ATUALIZADO", "D", 08, 0 }}})
Aadd( aArquivos, { "subconta.dbf",;
											 {{ "CODI",       "C", 02, 0 },;
											  { "SUBCODI",    "C", 04, 0 },;
											  { "DEBCRE",     "C", 01, 0 },;
											  { "ATUALIZADO", "D", 08, 0 }}})

Aadd( aArquivos, { "retorno.dbf",;
											  {{"ID",         "N", 07, 0 },;
												{"CODI",       "C", 05, 0 },; // Cliente
												{"EMPRESA",    "C", 40, 0 },;
												{"INTERNO",    "C", 12, 0 },;
												{"CODIGO",     "C", 13, 0 },;
												{"HORA",       "C", 08, 0 },;
												{"VERSAO",     "N", 01, 0 },;
												{"LIMITE",     "D", 08, 0 },;
												{"DATA",       "D", 08, 0 },;
												{"NOME",       "C", 10, 0 },;
												{"ATUALIZADO", "D", 08, 0 }}})

Aadd( aArquivos, { "prevenda.dbf",{{ "CODIGO",     "C", 06, 0 }, ; // Codigo do Produto
											  { "CODIVEN",    "C", 04, 0 }, ;
											  { "CODI",       "C", 05, 0 }, ;
											  { "NOME",       "C", 40, 0 }, ;
											  { "FATURA",     "C", 07, 0 }, ;
											  { "EMIS",       "D", 08, 0 }, ;
											  { "PVENDIDO",   "N", 11, 2 }, ;
											  { "UNITARIO",   "N", 11, 2 }, ;
											  { "DESCONTO",   "N", 05, 2 }, ;
											  { "DESCMAX",    "N", 06, 2 }, ;
											  { "SAIDA",      "N", 09, 2 }, ;
											  { "QUANT",      "N", 09, 2 }, ;
											  { "ATACADO",    "N", 11, 2 }, ;
											  { "VAREJO",     "N", 11, 2 }, ;
											  { "PCUSTO",     "N", 11, 2 }, ;
											  { "VLRFATURA",  "N", 13, 2 },;
											  { "DESCRICAO",  "C", 40, 0 },;
											  { "UN",         "C", 02, 0 },;
											  { "TAM",        "C", 06, 0 },;
                                   { "SIGLA",      "C", 10, 0 },;
											  { "PORC",       "N", 05, 2 },;
											  { "TOTAL",      "N", 13, 2 },;
											  { "SERIE",      "C", 10, 0 },;
											  { "FORMA",      "C", 02, 0 },;
											  { "APARELHO",   "C", 20, 0 },;
											  { "MARCA",      "C", 20, 0 },;
											  { "MODELO",     "C", 20, 0 },;
											  { "NRSERIE",    "C", 20, 0 },;
											  { "OBS",        "C", 40, 0 },;
											  { "OBS1",       "C", 40, 0 },;
											  { "OBS2",       "C", 40, 0 },;
											  { "ENDE",       "C", 25, 0 },;
                                   { "FONE",       "C", 14, 0 },;
											  { "REGIAO",     "C", 02, 0 },;
											  { "ANO",        "C", 04, 0 },;
											  { "COR",        "C", 20, 0 },;
											  { "PLACA",      "C", 08, 0 },;
											  { "ESTADO",     "C", 20, 0 },;
											  { "ATUALIZADO", "D", 08, 0 }}})

Aadd( aArquivos, { "grpser.dbf",;
			  {{ "GRUPO",      "C", 03, 0 }, ;
				{ "DESGRUPO",   "C", 40, 0 }, ;
				{ "ATUALIZADO", "D", 08, 0 }}})

Aadd( aArquivos, { "servico.dbf",;
			  {{ "CODISER",    "C", 03, 0 }, ;
				{ "NOME",       "C", 40, 0 }, ;
				{ "GRUPO",      "C", 03, 0 }, ;
				{ "ATUALIZADO", "D", 08, 0 },;
				{ "VALOR",      "N", 13, 4 }}})

Aadd( aArquivos, { "cortes.dbf",;
			  {{ "TABELA",     "C", 08, 0 }, ;
				{ "QTD",        "N", 05, 0 }, ;
				{ "SOBRA",      "N", 05, 0 }, ;
				{ "CODISER",    "C", 03, 0 }, ;
				{ "CODIGO",     "C", 06, 0 }, ;
				{ "ATUALIZADO", "D", 08, 0 },;
				{ "DATA",       "D", 08, 0 }}})

Aadd( aArquivos, { "movi.dbf",;
			  {{ "TABELA",     "C", 08, 0 },;
				{ "QTD",        "N", 05, 0 },;
				{ "CODIVEN",    "C", 04, 0 },;
				{ "CODISER",    "C", 03, 0 },;
				{ "CODIGO",     "C", 06, 0 },;
				{ "BAIXADO",    "L", 01, 0 },;
				{ "ATUALIZADO", "D", 08, 0 },;
				{ "DATA",       "D", 08, 0 }}})

Aadd( aArquivos, { "funcimov.dbf",;
			  {{ "CODIVEN",   "C", 04, 0 }, ;
				{ "CODI",      "C", 04, 0 }, ;
				{ "CRE",       "N", 11, 4 }, ;
				{ "DEB",       "N", 11, 4 }, ;
				{ "VLR",       "N", 11, 4 }, ;
				{ "DOCNR",     "C", 09, 0 }, ;
				{ "DATA",      "D", 08, 0 }, ;
				{ "DESCRICAO", "C", 40, 0 }, ;
				{ "ATUALIZADO","D", 08, 0 },;
				{ "COMISSAO",  "N", 13, 4 }}})

Aadd( aArquivos, { "recibo.dbf",;
           {{ "ID",         "+", 04, 0 }, ;
			   { "TIPO",       "C", 06, 0 }, ;
            { "CODI",       "C", 05, 0 }, ;
            { "NOME",       "C", 40, 0 }, ;
            { "VLR",        "N", 13, 2 }, ;
            { "FATURA",     "C", 09, 0 }, ;
            { "DOCNR",      "C", 09, 0 }, ;
            { "DOCNRANT",   "C", 09, 0 }, ;
            { "VCTO",       "D", 08, 0 }, ;
            { "DATA",       "D", 08, 0 }, ;
            { "HORA",       "C", 08, 0 }, ;
            { "USUARIO",    "C", 10, 0 }, ;
            { "CAIXA",      "C", 04, 0 }, ;
            { "ATUALIZADO", "D", 08, 0 }, ;
            { "HIST",       "C", 120, 0 }}})

Aadd( aArquivos, { "agenda.dbf",;
           {{ "ID",         "+", 04, 0 }, ;
				{ "CODI",       "C", 05, 0 }, ;
            { "HIST",       "C", 132, 0 }, ;
            { "DATA",       "D", 08, 0 }, ;
            { "HORA",       "C", 08, 0 }, ;
            { "USUARIO",    "C", 10, 0 }, ;
            { "CAIXA",      "C", 04, 0 }, ;
            { "ULTIMO",     "L", 01, 0 }, ;
            { "ATUALIZADO", "D", 08, 0 }}})

Aadd( aArquivos, { "cm.dbf",;
           {{ "CODI",       "C", 05, 0 }, ;
            { "INICIO",     "D", 08, 0 }, ;
            { "FIM",        "D", 08, 0 },;
            { "INDICE",     "N", 09, 4 }, ;
            { "OBS",        "C", 40, 0 }, ;
            { "ULTIMO",     "L", 01, 0 }, ;
            { "ATUALIZADO", "D", 08, 0 }}})

Return( aArquivos )

*==================================================================================================*	

def Configuracao( lMicrobras, lNaoMostrarConfig)
*-----------------------------------------------*
	LOCAL nX 		:= 1
	LOCAL nChoice	:= 1
	LOCAL cString	:= ""
	LOCAL cUnidade 	:= ""
	LOCAL cCurDir  	:= FCurdir()
	LOCAL cPath    	:= FCurdir()
	LOCAL cTemp 	:= StrTran( Time(),":")
	LOCAL cDbf		:= "sci.dbf"
	LOCAL cCfg
	LOCAL cBase
	LOCAL cDia
	LOCAL cMes
	LOCAL cAno
	LOCAL lPiracy
	LOCAL i
	LOCAL dDate
	LOCAL nHandle
	LOCAL nErro
	LOCAL Handle
	LOCAL xMicrobras
	LOCAL xEndereco
	LOCAL xTelefone
	LOCAL xCidade
	LOCAL aEnde_String := {}
	LOCAL aEnde_Codigo := {}
	LOCAL aMensagem	 := Array(2,5)
			aMensagem[1,1] := "[Limite de Codigo de Acesso Vencido]"
			aMensagem[1,2] := "1 - A data do Sistema Operacional esta correta ?"
			aMensagem[1,3] := "2 - O arquivo SCI.EXE esta com data diferente do DOS ?"
			aMensagem[1,4] := "3 - Caso Negativo, solicite novo Codigo de Acesso."
			aMensagem[1,5] := ""

			aMensagem[2,1] := "[Verificacao de Copia Original]"
			aMensagem[2,2] := "1 - O SCI esta sendo instalado pela 1?vez ?"
			aMensagem[2,3] := "2 - Esta atualizando a versao do SCI ?"
			aMensagem[2,4] := "3 - Esta instalando um novo terminal ?"
			aMensagem[2,5] := "4 - Caso Afirmativo, solicite Codigo de Acesso."


	IfNil( lMicrobras, false )
	IfNil( lNaoMostrarConfig, false )
	PUBLIC XNOMEFIR
	PUBLIC SISTEM_NA1
	PUBLIC SISTEM_NA2
	PUBLIC SISTEM_NA3
	PUBLIC SISTEM_NA4
	PUBLIC SISTEM_NA5
	PUBLIC SISTEM_NA6
	PUBLIC SISTEM_NA7
	PUBLIC SISTEM_NA8
	PUBLIC SISTEM_VERSAO
	PUBLIC XNOME_EXE

	cBase := oAmbiente:xroot
	//alert(cbase)
	CenturyOn()	
	fchdir(cbase)		
	Set Defa To (cBase)
	
	if !lNaoMostrarConfig
		Qout("þ Localizando Arquivo SCI.DBF.")
	endif

	if !file(cDbf)
		SetColor("")
		Cls
		AlertaPy('ERRO #0:' + StrTrim(ProcLine(0)) + ' Verifique os parametros abaixo: ;-;;' + ;
					'     Tipo de Erro : ' + 'SCI.DBF nao foi localizado                               ' + ';' + ;
					' Endereco IP:port : ' + cBase + ';-;;' + ;
					'             Acao : ' + 'Verifique se o servidor LETO esta ativo ou modo LOCKED,ou' + ';' + ;
					'                  : ' + 'parametros passados estao corretos                       ' + ';' + ;
					'         Parametro: ' + trimStr(oAmbiente:argv(1)), 31, false, true, {" Encerrar "})		
		Quit
	endif	
	
	QQout("þ OK")
	Set Defa To (cBase)
	//Qout("þ Abrindo Arquivo SCI.DBF em " + cPath)
	Qout("þ Abrindo Arquivo SCI.DBF em " + cBase)
	
	if !NetUse(cDbf, true )
		Quit
	endif
	
	QQout("þ OK")
	Qout("þ Lendo Arquivo SCI.DBF em " + cBase)
	For x := 1 To Sci->(FCount())
		IF Sci->(FieldName( x )) != "TIME"
			IF Sci->(Empty( FieldGet( x )))
				EncerraDbf( FieldName( x ), Procname(), ProcLine())
			End
		End
	Next
	
	IF ( XNOMEFIR				 := Sci->( AllTrim( Nome	  ))) != Sci->( MsDecrypt( AllTrim( Empresa  ))) .OR. Empty( XNOMEFIR   ) 	; EncerraDbf(, ProcName(1), ProcLine(1)) ; EndIF
	IF ( SISTEM_NA1			 := Sci->( AllTrim( Nome_Sci ))) != Sci->( MsDecrypt( AllTrim( Codi_Sci ))) .OR. Empty( SISTEM_NA1 ) 	; EncerraDbf(, ProcName(1), ProcLine(1)) ; EndIF
	IF ( SISTEM_NA2			 := Sci->( AllTrim( Nome_Est ))) != Sci->( MsDecrypt( AllTrim( Codi_Est ))) .OR. Empty( SISTEM_NA2 ) 	; EncerraDbf(, ProcName(1), ProcLine(1)) ; EndIF
	IF ( SISTEM_NA3			 := Sci->( AllTrim( Nome_Rec ))) != Sci->( MsDecrypt( AllTrim( Codi_Rec ))) .OR. Empty( SISTEM_NA3 ) 	; EncerraDbf(, ProcName(1), ProcLine(1)) ; EndIF
	IF ( SISTEM_NA4			 := Sci->( AllTrim( Nome_Pag ))) != Sci->( MsDecrypt( AllTrim( Codi_Pag ))) .OR. Empty( SISTEM_NA4 ) 	; EncerraDbf(, ProcName(1), ProcLine(1)) ; EndIF
	IF ( SISTEM_NA5			 := Sci->( AllTrim( Nome_Che ))) != Sci->( MsDecrypt( AllTrim( Codi_Che ))) .OR. Empty( SISTEM_NA5 ) 	; EncerraDbf(, ProcName(1), ProcLine(1)) ; EndIF
	IF ( SISTEM_NA6			 := Sci->( AllTrim( Nome_Ven ))) != Sci->( MsDecrypt( AllTrim( Codi_Ven ))) .OR. Empty( SISTEM_NA6 ) 	; EncerraDbf(, ProcName(1), ProcLine(1)) ; EndIF
	IF ( SISTEM_NA7			 := Sci->( AllTrim( Nome_Pro ))) != Sci->( MsDecrypt( AllTrim( Codi_Pro ))) .OR. Empty( SISTEM_NA7 ) 	; EncerraDbf(, ProcName(1), ProcLine(1)) ; EndIF
	IF ( SISTEM_NA8			 := Sci->( AllTrim( Nome_Pon ))) != Sci->( MsDecrypt( AllTrim( Codi_Pon ))) .OR. Empty( SISTEM_NA8 ) 	; EncerraDbf(, ProcName(1), ProcLine(1)) ; EndIF
	IF ( SISTEM_VERSAO		 := Sci->( AllTrim( Nome_Ver ))) != Sci->( MsDecrypt( AllTrim( Codi_Ver ))) .OR. Empty( SISTEM_VERSAO ) ; EncerraDbf(, ProcName(1), ProcLine(1)) ; EndIF
	IF Empty(( XNOME_EXE 	 := Sci->(MsDecrypt( AllTrim( NomeExe ))))) ; EncerraDbf(, ProcName(), ProcLine()) ; EndIF
		oAmbiente:XLIMITE     := Sci->Limite
	lPiracy := AllTrim( XCFGPIRACY ) != Sci->( AllTrim( Empresa  ))
	Sci->(DbCloseArea())
	IF lPiracy
		SetColor("")
		Cls
		ErrorBeep()
		Alert( "Erro #0: Favor instalar arquivo SCI.DBF original.")
		Quit
	EndIF
	QQout("þ OK")

	** SCI.CFG *******************************************************
	IF !lNaoMostrarConfig
		Qout("þ Localizando Arquivo SCI.CFG.")
	EndIF

	cPath := cCurDir
	//cCfg  := cPath + '\SCI.CFG'
	cCfg  := cBase + '/sci.cfg'
	FChdir( cPath )
	Set Defa To (cPath)
	
	/*
	IF !File(cCfg)
		cPath := oAmbiente:xBase 
		cCfg  := cPath + '\sci.cfg'
		IF !File( cCfg )
			SetColor("")
			Cls
			Alert( "Erro #1: Arquivo SCI.CFG" + ;
					 ";Nao localizado em: " + cCurdir + Space(Len(cCurdir+cPath)-Len(cCurdir)) + ;
					 ";Nao localizado em: " + cPath   + Space(Len(cCurdir+cPath)-Len(cPath)))
			Quit
		EndIF
		cPath := oAmbiente:xBase
	EndIF
	QQout("þ OK")
	Qout("þ Abrindo Arquivo SCI.CFG em " + cPath)
	Handle := FOpen(cCfg)
	IF ( Ferror() != 0 )
		FClose( Handle )
		SetColor("") 
		Cls
		Alert( "Erro #3: Erro de Abertura do Arquivo SCI.CFG.")
		Quit
	EndIF
	Qout("þ Lendo Arquivo SCI.CFG em " + cPath)
	QQout("þ OK")

	nErro := FLocate( Handle, "[ENDERECO_STRING]")
	IF nErro < 0
		SetColor("")
		Cls
		Alert( "Erro #4: Configuracao de SCI.CFG alterada. [ENDERECO_STRING]")
		Quit
	EndIF
	FAdvance( Handle )
	For nX := 1 To 4
		Aadd( aEnde_String, AllTrim( MsReadLine( Handle )))
	Next

	nErro := FLocate( Handle, "[ENDERECO_CODIGO]")
	IF nErro < 0
		SetColor("")
		Cls
		Alert( "Erro #5: Configuracao de SCI.CFG alterada. [ENDERECO_CODIGO]")
		Quit
	EndIF
	FAdvance( Handle )
	For nX := 1 To 4
		Aadd( aEnde_Codigo, MsDecrypt( AllTrim( MsReadLine( Handle ))))
	Next
	For nX := 1 To 4
		IF aEnde_Codigo[nX] != aEnde_String[nX]
			SetColor("")
			Cls
			Alert("Erro #6: Configuracao de SCI.CFG alterada. [ENDERECO_CODIGO]")
			Quit
		EndiF
	Next
	*/
	
	FClose( Handle )	
	//VerExe()
	IF !lNaoMostrarConfig
		Qout("þ Verificando Aplicativo.")
	EndIF
	*:*******************************************************************************
	oAmbiente:xDataCodigo 	:= MsDecrypt( oAmbiente:XLIMITE )
	cDia				 	:= SubStr( oAmbiente:xDataCodigo, 4, 2 )
	cMes					:= Left(  oAmbiente:xDataCodigo, 2 )
	cAno					:= Right( oAmbiente:xDataCodigo, 4 )
	oAmbiente:xDataCodigo 	:= cDia + "/" + cMes + "/" + cAno
	if !lMicrobras
		*:*******************************************************************************
		Set Date To USA
		cLimite     := MsDecrypt( oAmbiente:XLIMITE )
		cDataDos 	:= Dtoc( Date())
		cTela 		:= SaveScreen()
		
      if Ctod( cDataDos ) > Ctod( cLimite )
			Hard( 1, ProcName(), ProcLine() )
		endif
      
		Set Date Brit
		ResTela( cTela )
      
		if !lNaoMostrarConfig
			Qout("Verificando Sistema Instalado.")
		endif
      
		cUnidade := Left( Getenv( _SHELLENV_ ), 2 )
		if !CopyOk()
			Hard( 2, ProcName(), ProcLine() )
			CopyCria()
		endif
	endif
	// IF !lNaoMostrarConfig
		// LogoTipo( aEnde_String )
	// EndIF
	CenturyOff()
	FChdir( oAmbiente:xBaseDados )
	Set Defa To ( oAmbiente:xBaseDados )
	return
endef


*==================================================================================================*	

def ms_swap_use(cBcoDados, lModo, cAlias)   	
	LOCAL cExt       := GetFileExtension(cBcoDados)
	LOCAL cBcoSemExt := StrTran( cBcoDados, cExt)	
	
	hb_default(@lModo, MONO)
	hb_default(@cAlias, cBcoDados)	
	cBcoDados := Upper(cBcoDados)     // para compatibilidade em linux 
	cAlias    := Iif( cAlias = NIL, cBcoSemExt, cAlias )
	
	if (oAmbiente:Letoativo)
		cBcoDados := oAmbiente:LetoPath + cBcoDados		
	endif
	
	if lModo
		Use (cBcoDados) Shared Alias (cAlias) New	
	else
		Use (cBcoDados) Exclusive Alias (cAlias) New	
	endif	
	
endef

*==================================================================================================*	

*==================================================================================================*	

def ms_swap_dbcreate(cFile, aStru)
	LOCAL cLocalFile := ms_swap_sep(cFile)
	return DbCreate(cLocalFile, aStru)		
endef

*==================================================================================================*	

def ms_swap_ferase(cFile)   	
	LOCAL cLocalFile := ms_swap_sep(cFile)
	
	if (oAmbiente:Letoativo)
		return leto_ferase(cLocalFile)		
	else
		return Ferase(cLocalFile)
	endif	

endef

*==================================================================================================*	

def ms_swap_rename(cFile, cNewFile)   	
	LOCAL cLocalFile := ms_swap_sep(cFile)
	LOCAL cLocalNew  := ms_swap_sep(cNewFile)
	
	if (oAmbiente:Letoativo)
		return (leto_frename(cLocalFile, cLocalNew) == 0)		
	else
		return msrename(cLocalFile, cLocalNew)
	endif	

endef

*==================================================================================================*	

def ms_swap_sep(cFile)
	LOCAL cOldFile := cFile
	
	if right(TrimStr(oAmbiente:xBase),1) == "/" .OR. ;
	   right(TrimStr(oAmbiente:xBase),1) == "\"
		cBase := left(oAmbiente:xBase, len(oAmbiente:xBase)-1)
	else
		cBase := oAmbiente:xBase	
	endif		
	if (oAmbiente:Letoativo)
		_SEP_ := '/'
	else
		_SEP_ := DEF_SEP
	endif
	cFile := cBase + _SEP_ + cFile
	
/*
	alert(;
				oAmbiente:xBase + " : " + cBase + ";" + ;
				cOldfile + ";" + ;
				cfile    + ";" + ;
				"SWAP_SEP : " + Procname(1) + '(' + strzero(procline(1),4) + ');' +	;
				"SWAP_SEP : " + Procname(2) + '(' + strzero(procline(2),4) + ');' + ;	
				"SWAP_SEP : " + Procname(3) + '(' + strzero(procline(3),4) + ');' + ;	
				"SWAP_SEP : " + Procname(4) + '(' + strzero(procline(4),4) + ');' + ;	
				"SWAP_SEP : " + Procname(5) + '(' + strzero(procline(5),4) + ');' + ;	
				"SWAP_SEP : " + Procname(6) + '(' + strzero(procline(6),4) + ');' + ;	
				"SWAP_SEP : " + Procname(7) + '(' + strzero(procline(7),4) + ')';
			)	
*/

	return(cFile)
endef

*==================================================================================================*	

def ms_swap_dir(cFile)
	LOCAL cBase := alltrim(oAmbiente:xRoot)
	
	if right(cBase, 1) == "/" .OR. right(cBase, 1) == "\" 
		cBase := left(cBase, len(cBase)-1)		
	endif	
	cBase += DEF_SEP					
	return(cBase)	
endef

*==================================================================================================*	

def ms_swap_file(cFile)
	LOCAL cLocalFile := ms_swap_sep(cFile)

	//alert(cLocalFile)
	
	if (oAmbiente:LetoAtivo)			
		return Leto_File(cLocalFile)
	endif
	return File(cLocalFile)
endef

*==================================================================================================*	

def ms_swap_fopen(cFile, modo)   	
	LOCAL cLocalFile := ms_swap_sep(cFile)
	LOCAL Handle
	
	if (oAmbiente:Letoativo)		
		handle := leto_fopen(cLocalFile, Modo)
/*	
		alert(cLocalFile + ';' +;
				"handle: " + str(handle) + ';' +;
				"ferror: " + str(leto_ferror()) + ';' +;
				"Exist : " + formatavar(ms_swap_file(cFile)) + ';' +;
				"FOPEN : " + Procname(1) + '(' + strzero(procline(1),4) + ');' +	;
				"FOPEN : " + Procname(2) + '(' + strzero(procline(2),4) + ');' + ;	
				"FOPEN : " + Procname(3) + '(' + strzero(procline(3),4) + ');' + ;	
				"FOPEN : " + Procname(4) + '(' + strzero(procline(4),4) + ');' + ;	
				"FOPEN : " + Procname(5) + '(' + strzero(procline(5),4) + ');' + ;	
				"FOPEN : " + Procname(6) + '(' + strzero(procline(6),4) + ');' + ;	
				"FOPEN : " + Procname(7) + '(' + strzero(procline(7),4) + ')')	
*/	
		return handle
	else
		return Fopen(cFile, Modo)
	endif	
endef

*==================================================================================================*	

def ms_swap_fcreate(cFile, modo)   	
	LOCAL cLocalFile := ms_swap_sep(cFile)
	LOCAL handle
	
	if (oAmbiente:Letoativo)		
		handle := leto_fcreate(cLocalFile, modo)		

/*		
		alert(cLocalFile + ';' +;
			"handle: " + str(handle) + ';' +;
			"ferror: " + str(leto_ferror()) + ';' +;
			"Exist : " + formatavar(ms_swap_file(cFile)) + ';' +;
			"FCREATE : " + Procname(1) + '(' + strzero(procline(1),4) + ');' + ;
			"FCREATE : " + Procname(2) + '(' + strzero(procline(2),4) + ');' + ;	
			"FCREATE : " + Procname(3) + '(' + strzero(procline(3),4) + ');' + ;	
			"FCREATE : " + Procname(4) + '(' + strzero(procline(4),4) + ');' + ;	
			"FCREATE : " + Procname(5) + '(' + strzero(procline(5),4) + ');' + ;	
			"FCREATE : " + Procname(6) + '(' + strzero(procline(6),4) + ');' + ;	
			"FCREATE : " + Procname(7) + '(' + strzero(procline(7),4) + ')')	
*/	
		return handle
	else
		return Fcreate(cLocalFile, modo)
	endif	
endef

*==================================================================================================*	

def ms_swap_ferror()   	
   LOCAL nError
	
	if (oAmbiente:Letoativo)
		return leto_ferror()
	else
		return Ferror()
	endif	
endef

*==================================================================================================*	

def ms_swap_fclose(handle)   	
	
	if (oAmbiente:Letoativo)
		return leto_fclose(handle)		
	else
		return Fclose(handle)
	endif	
endef

*==================================================================================================*	

def ms_swap_fseek(handle, n, modo)   	
	
	if (oAmbiente:Letoativo)
		return leto_fseek(handle, n, modo)
	else
		return fseek(handle, n, modo)
	endif	
endef

*==================================================================================================*	

def ms_swap_fwrite(handle, cbuffer)

	if (oAmbiente:Letoativo)
		return(leto_fwrite(handle, cbuffer))
	else
		return(fwrite(handle, cbuffer))
	endif	
endef

*==================================================================================================*	

def ms_swap_fread(Handle, cBuffer, nFileLen)   	
	
	if (oAmbiente:Letoativo)
		return leto_fread(Handle, @cBuffer, nFileLen)
	else
		return fread(Handle, @cBuffer, nFileLen)
	endif	
endef

*==================================================================================================*	

def ms_swap_extensao(cFile, cNewExt)   	  	
	LOCAL cOldExt  := GetFileExtension(cFile)
	LOCAL cNewFile   
   LOCAL nAt      := AT( ".", cFile )
   
   if nAt != 0
      nAt--
   else
      nAt := Len(cFile)
   endif
   
	cNewFile := Left(cFile, nAt)   
   cNewFile += cNewExt	
	return cNewFile
endef	

*==================================================================================================*	

def ms_remove_extensao(cFile)   	  	
	LOCAL cOldExt  := GetFileExtension(cFile)
	LOCAL cNewFile   
   LOCAL nAt      := Rat( ".", cFile)
   
   if nAt != 0
      nAt--
   else
      nAt := Len(cFile)
   endif
   
	cNewFile := Left(cFile, nAt)   
	return cNewFile
endef	

*==================================================================================================*	

def ms_remove_path(cFile)	
	LOCAL cNewFile := ""   
   LOCAL nPos
   
   cFile := ms_remove_extensao(cFile)
   if (nPos := RAT( _SLASH_, cFile)) != 0
      cNewFile = SUBSTR(cFile, ++nPos, Len(cFile))
   endif
	return cNewFile
endef	

*==================================================================================================*	

def GetRoot(cstring)	
	LOCAL nLen    := len(cstring)
	LOCAL sep     := DEF_SEP
	LOCAL npos    := 0
	
	if (npos := rat( sep, cString)) > 0	
	  //alert(hb_strFormat("%s : %d", cstring, npos))
	  return(left(cstring, --npos))
	endif
	return ""

*==================================================================================================*	

def ms_mem_dbCreate(cFile, aStru, cAlias, _rddname)
	 /*
	DBCREATE( <cDatabase>, <aStruct>, [<cDriver>], [<lOpen>], [<cAlias>] )
	<cDatabase> Name of database to be create
	<aStruct> Name of a multidimensional array that contains the database structure
	<cDriver> Name of the RDD
	<lOpenNew> 3-way toggle to Open the file in New or Current workarea:
								  NIL     The file is not opened.
								  True    It is opened in a New area.
								  False   It is opened in the current area.
	<cAlias> Name of database Alias
	*/
	
	/*
	//  usando normal pelo nome do alias	
	xAlias  := FaturaNew(FTempMemory(), "XALIAS")
	nHandle := FTempMemory()	 
	xAlias  := FaturaNew(nHandle, "XALIAS")	
	xNtx	  := FTempMemory()		
	? 1, xALias
	? 2, (xalias)
	
	Area("XALIAS"))
	? alias()
	Inde On Codigo To mem:(xNtx)	
	? xalias->(Recno())
	? xAlias->Codigo 	
	ms_mem_dbclosearea(nHandle)
	
	// usando macro
	xTemp  := FaturaNew(FTempMemory(),)
	xTemp  := FaturaNew(FTempMemory(),"XTEMP")
	xTemp  := FaturaNew(,"XTEMP")
	xTemp  := FaturaNew()
	Area((xTemp))
	? (xTemp)->(Recno())
	? (xTemp)->Codigo 	
	*/
	
	REQUEST HB_MEMIO
	hb_default(@cFile, FTempMemory())	
	hb_default(@cAlias, cFile)	
	hb_default(@_rddname, nil)	// default sistema		
	dbCreate( "mem:" + (cFile), aStru, _rddname, true, cAlias)	
	return Alias()
endef

*==================================================================================================*	

def ms_mem_dbclosearea(cFile)
	(cFile)->(DbCloseArea())
   dbDrop( "mem:" + (cFile))
	return nil 	
endef	

*==================================================================================================*	

def truefalse(xvar)
	if xvar
		return "true"
	else		
		return "false"
	endif	
endef	

*==================================================================================================*	

def formatavar(xvar)	
	switch valtype(xvar)
		case "C" 
			return(trimstr(xvar))
		case "N" 
			return(trimstr(xvar))
		case "L"
			return(truefalse(xvar))
		case "D"	
			return(dtoc(xvar))				
	endswitch
endef

*==================================================================================================*	

def ValueAndTypeVar(xvar)	
	switch valtype(xvar)
		case "C" 
			AlertaPy("Tipo : C ; Valor : " + trimstr(xvar))
         exit
		case "N" 
         AlertaPy("Tipo : N ; Valor : " + trimstr(xvar))
         exit
		case "L"
         AlertaPy("Tipo : L ; Valor : " + truefalse(xvar))
         exit
		case "D"	
         AlertaPy("Tipo : D ; Valor : " + dtoc(xvar))
         exit
      case "U"	
         AlertaPy("Tipo : U ; Valor : NIL") 
         exit         
	endswitch
endef

*==================================================================================================*	

def Acesso( lNaoMostrarConfig )
*------------------------------*
	RddSetDefault(RDDALTERNATIVO)
	IfNil( lNaoMostrarConfig, FALSO )
	#IFDEF ANO2000
		oAmbiente:Ano2000On()
	#ELSE
		oAmbiente:Ano2000Off()
	#ENDIF
	oAmbiente:lComCodigoAcesso := FALSO
	#IFDEF MICROBRAS
		Configuracao( OK, lNaoMostrarConfig )
		AcessoLeto()
		LogoTipo()
		Return nil
	#ENDIF
	#IFDEF AGROMATEC
		Configuracao( OK, lNaoMostrarConfig )
		AcessoLeto()
		Return nil
	#ENDIF
	oAmbiente:lComCodigoAcesso := OK
	Configuracao(NIL, lNaoMostrarConfig )
	AcessoLeto()	
	LogoTipo()
	return nil
endef
	
*==================================================================================================*		

def acessoLeto()
	#ifdef LETO		
		SetaIniLeto()	
		if (oAmbiente:LetoAtivo)	
			if !LoginLeto()	
            Terminate()
         endif 
		endif	
	#else
		RddSetDefault(RDDNAME)
	#endif	   	
endef

*==================================================================================================*	

def CriarDiretorios()
	MkDir( ms_swap_dir() + "spooler") 	
	MkDir( ms_swap_dir() + "tmp" )	
	return nil
endef

*==================================================================================================*	

def SetaIniLeto()
*----------------* 
	//LOCAL cPathLocal := FCurdir()
	LOCAL cPathLocal := oAmbiente:xRoot
	LOCAL cPath      := oAmbiente:xBase
	LOCAL cPort      := "2812"
	LOCAL cHost      := "127.0.0.1"
	LOCAL cString    := ""
   LOCAL aCor
   LOCAL aCentralizar
	LOCAL cTela
	LOCAL nChoice
	LOCAL aPrompt    := {" 1. Continuar a conexao local",;
								" 2. Conectar ao servidor LETO configurado", ;
								" 3. Encerrar Execucao do Sistema";
                        }
	
	CriarDiretorios()
	Qout("þ Iniciando Conexao com Servidor LETO.")	
	cTela := SaveScreen()
	if oAmbiente:argc    	== 0	
		cLetoIP             := oIni:ReadString('LETO', 'ip', cHost)
		cLetoPort           := oIni:ReadString('LETO', 'port', cPort)	

      oIni:WriteString('LETO', 'ip', cLetoIP)
		oIni:WriteString('LETO', 'port', cLetoPort)	      
     
		oAmbiente:LetoIp    := cLetoIP
		oAmbiente:LetoPort  := cLetoPort		
		cPath               := oAmbiente:GetLetoPath()				
		oAmbiente:LetoPath  := cPath
		oAmbiente:LetoAtivo := false		
		
		//RddSetDefault(RDDNAME)		
		//if leto_Connect(cPath,,,20000) != F_ERROR
			oAmbiente:LetoAtivo := true
			cString             := oAmbiente:ShowVarLeto(nil, nil, false)
         cSistema            := StrTran( SISTEM_NA1 + SISTEM_VERSAO, "MENU PRINCIPAL-","")
         cSistema            += ';' + hb_Version(HB_VERSION_HARBOUR)
         cSistema            += ';' + hb_Version(HB_VERSION_COMPILER)
         aCor                := Afill(Array(30), oAmbiente:Cormenu)
         aCentralizar        := Afill(Array(30), false)
         aCor[1]             := AscanCor(clBrightYellow)
         aCor[2]             := AscanCor(clBrightCyan)
         aCor[3]             := AscanCor(clBrightCyan)
         aCor[10]            := AscanCor(clBrightRed)
         aCor[13]            := AscanCor(clBrightCyan)
         aCor[20]            := AscanCor(clBrightGreen)
         aCentralizar[1]     := true
         aCentralizar[2]     := true
         aCentralizar[3]     := true
         aCentralizar[10]    := true
         aCentralizar[13]    := true
         aCentralizar[20]    := true
         
			ErrorBeep()			
			nChoice := AlertaPy(;
                     cSistema + ;
                     + ';-;-' + ;
                     + ';'   + "Conectado a Esta‡„o   : " + AllTrim(Left(NetName(),20)) + ;
							+ ';'   + "IP da Esta‡„o Remota  : " + StrGetIp() + ;
							+ ';'   + "Diretorio de trabalho : " + oAmbiente:xRoot + ;
							+ ";-;AVISO: SERVIDOR TCP/IP LETO CONFIGURADO EM: " + ;
                     + ";Arquivo: " + cPathLocal + "/sci.ini" + ;							                     
							+ ';-;' + cString + ;
							+ ';-;' + "ESCOLHA UMA DAS OP€™ES ABAIXO;-;", aCor, aCentralizar, lOk := true, aPrompt;
							)
			if     nchoice == 0 .OR. nChoice == 3
				Terminate()
			elseif nChoice == 1
				leto_DisConnect()					
				oAmbiente:LetoAtivo := false
				RddSetDefault(RDDALTERNATIVO)
				return false
			elseif nChoice == 2
				RddSetDefault(RDDNAME)		
				//LETO_DBDRIVER(RDDALTERNATIVO)   /* to choose your DBF driver independent of the server default */ 
				LETO_TOGGLEZIP( 1 )               /* switch compressed network traffic */
				oAmbiente:xBase    := cPath				
				oAmbiente:LetoPath := cPath
				return true
			endif			
		//endif			
		RddSetDefault(RDDALTERNATIVO)
		return false
   else
		cPath := argv(1)
   
      oAmbiente:xBase := cPath        // Linux
		RddSetDefault(RDDALTERNATIVO)   // Linux
		return false		              // Linux
     
		if !":\" $ cPath 		
			if !"//" $ cPath 		
				cPath := "//" + cPath 
			endif		
			if !":" $ cPath 
				cPath := cPath + iiF( ":" $ cPath, "", ":" + TrimStr(cPort))			
			endif	
			cPath += iif( right(cPath,1) == "/", "", "/" )		
			oAmbiente:ShowVarLeto(false, ";-;Aguarde... Tentando conexao com servidor Leto em:;-;;" + cPath)
			RddSetDefault(RDDNAME)
		else
			if !hb_vfDirExists(cPath )
				AlertaPy("ERRO #2:" + StrTrim(ProcLine(0)) + " Verifique os parametros abaixo: ;-;;" + ;
					"     Tipo de Erro : " + "Diretorio de trabalho inexistente passado como parametro" + ';' + ;
					"        Parametro : " + trimStr(argv(1)) + ";-;;" + ;
					"             Acao : " + "Crie o diretorio de trabalho ou altere o parametro passado" + ';' + ;		
					"           Teclas : " + "ESC encerrar, ENTER continuar", 31, false, true, {" Iniciar modo local "})		
		
      		oAmbiente:LetoAtivo := false		
            oAmbiente:xBase := oAmbiente:xRoot            
            RddSetDefault(RDDALTERNATIVO)
            return false				
			endif			
			oAmbiente:xBase := cPath
			RddSetDefault(RDDALTERNATIVO)
			return false		
		endif
	endif		
	
	oAmbiente:LetoAtivo := true
	oAmbiente:xBase     := cPath
   Leto_DisConnect()
	if leto_Connect(cPath,,,20000) == F_ERROR
      leto_DisConnect()
	   restela(cTela)				
		AlertaPy('ERRO #1:' + StrTrim(ProcLine(0)) + ' Verifique os parametros abaixo: ;-;;' + ;
					'     Tipo de Erro : ' + 'Servidor Leto nao localizado                             ' + ';' + ;
					' Endereco IP:port : ' + cPath + ';-;;' + ;
					'             Acao : ' + 'Verifique se o servidor LETO esta ativo ou modo LOCKED,ou' + ';' + ;
					'                  : ' + 'parametros passados estao corretos                       ' + ';' + ;
					'         Parametro: ' + trimStr(argv(1)), 31, false, true, {" Iniciar modo local ", " Teste "})				
		oAmbiente:LetoAtivo := false		
      oAmbiente:xBase := oAmbiente:xRoot		
		RddSetDefault(RDDALTERNATIVO)
		return false
	endif
	Leto_disconnect()	
endef

*==================================================================================================*	

def GetIp()
*-----------*
	LOCAL aHosts
	LOCAL cEstacao := NETNAME(.F.)

	HB_InetInit()
	aHosts := HB_InetGetHosts( cEstacao )
	IF aHosts == NIL
		aHosts := HB_InetGetAlias( cEstacao )
	END
	IF EMPTY(aHosts)
		aHosts := HB_InetGetAlias( cEstacao )
	END
	HB_InetCleanup()
	return aHosts
endef


*==================================================================================================*	

def LoginLeto()
	if leto_Connect( oAmbiente:xBase) == F_ERROR
		if leto_Connect( oAmbiente:LetoPath ) == F_ERROR
			nRes := leto_Connect_Err()
			if nRes == LETO_ERR_LOGIN
				//MSG('Falha de login (LETO_ERR_LOGIN)', "Macrosoft SCI")
				Alerta('Falha de login (LETO_ERR_LOGIN)')
			elseif nRes == LETO_ERR_RECV
				//MSG('Erro de Recepcao (LETO_ERR_RECV)', "Macrosoft SCI")
				Alerta('Erro de Recepcao (LETO_ERR_RECV)')
			elseif nRes == LETO_ERR_SEND
				//MSG('Erro de Transmissao (LETO_ERR_SEND)', "Macrosoft SCI")
				Alerta('Erro de Transmissao (LETO_ERR_SEND)')
			else
				//MSG('Sem conexao', "Macrosoft SCI")
            Cls
            AlertaPy('ERRO #1:(' + StrTrim(ProcName(0))+ ":"+StrTrim(ProcLine(0)) + ') Verifique os parametros abaixo: ;-;;' + ;
					'      Tipo de Erro : ' + 'Servidor Leto nao localizado                             ' + ';' + ;
					'  Endereco IP:port : ' + oAmbiente:LetoPath + ';-;;' + ;
					'              Acao : ' + 'Verifique se o servidor LETO esta ativo ou modo LOCKED,ou' + ';' + ;
					'                   : ' + 'parametros passados estao corretos                       ' + ';' + ;
					'          Parametro: ' + trimStr(argv(1)), 31, false, true, {" Encerrar "})		            
			endif
			return false
		endif
		//MSG('Servidor escutando em:' + oAmbiente:LetoPath, "Macrosoft SCI")
		oAmbiente:xBase := oAmbiente:LetoPath
		return true
	endif
	//MSG('Servidor LETO ouvindo em:' + oAmbiente:xBase, "Macrosoft SCI")
	oAmbiente:LetoPath := oAmbiente:xBase
	return true
endef	

*==================================================================================================*	

STATIC FUNCTION Example_Text()
#pragma __cstream | RETURN %s
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec a diam
lectus. Sed sit amet ipsum mauris. Maecenas congue ligula ac quam
viverra nec consectetur ante hendrerit. Donec et mollis dolor. Praesent
et diam eget libero egestas mattis sit amet vitae augue. Nam tincidunt
congue enim, ut porta lorem lacinia consectetur. Donec ut libero sed
arcu vehicula ultricies a non tortor. Lorem ipsum dolor sit amet,
consectetur adipiscing elit. Aenean ut gravida lorem. Ut turpis felis,
pulvinar a semper sed, adipiscing id dolor. Pellentesque auctor nisi
id magna consequat sagittis. Curabitur dapibus enim sit amet elit
pharetra tincidunt feugiat nisl imperdiet. Ut convallis libero in urna
ultrices accumsan. Donec sed odio eros. Donec viverra mi quis quam
pulvinar at malesuada arcu rhoncus. Cum sociis natoque penatibus et
magnis dis parturient montes, nascetur ridiculus mus. In rutrum accumsan
ultricies. Mauris vitae nisi at sem facilisis semper ac in est.
#pragma __endtext

*==================================================================================================*	

def PrinterErrada( cCodi )
*******************************
   LOCAL aRotina := {{|| CadastroImpressoras() }}
   LOCAL Arq_Ant := Alias()
   LOCAL Ind_Ant := IndexOrd()
   LOCAL lRetVal := OK

   Area("Printer")
   Printer->(Order( PRINTER_CODI ))
   if Printer->(!DbSeek( cCodi ))
      Printer->(Order( PRINTER_NOME ))
      Printer->(Escolhe( 02, 00, LastRow()-2, "Codi + ' ' + Nome", "ID NOME DA IMPRESSORA", aRotina ))
      cCodi := Printer->Codi
   endif
   AreaAnt( Arq_Ant, Ind_Ant )
   return( lRetVal )
endef

*==================================================================================================*	
   
def PrinterDbedit()
************************
   LOCAL Arq_Ant	:= Alias()
   LOCAL Ind_Ant	:= IndexOrd()
   LOCAL cScreen	:= SaveScreen()
   LOCAL oBrowse	:= MsBrowse():New()
   LOCAL nField
   Set Key -8 To

   if !UsaArquivo("Printer")
      return( nil )
   endif

   oMenu:Limpa()
   Area("Printer")
   Printer->(Order( PRINTER_CODI ))
   Printer->(DbGoBottom())

   for nField := 1 To Printer->(FCount())
      cName := Printer->(FieldName( nField ))
      oBrowse:Add( cName, cName, NIL, "PRINTER")
   next

   //oBrowse:Add( "INICIO",     "inicio", PIC_DATA )
   //oBrowse:Add( "FIM",        "fim",    PIC_DATA )
   //oBrowse:Add( "INDICE",     "indice", '9999.9999')
   //oBrowse:Add( "OBSERVACAO", "obs",   '@!')
   oBrowse:Titulo   := "CONSULTA/ALTERACAO DE IMPRESSORAS"
   oBrowse:PreDoGet := {|| PodeAlterar() }
   oBrowse:PreDoDel := {|| PodeExcluir() }
   oBrowse:Show()
   oBrowse:Processa()
   ResTela( cScreen )
   return( nil )
endef   

*==================================================================================================*	
def Crontab(pH1)
******************
   LOCAL ph         := {}
   LOCAL cEmpresa   := oAmbiente:_EMPRESA
   LOCAL nTarefas   := oIni:ReadInteger('crontab','tarefas', 0 )
   LOCAL aHoraCerta := {}
   LOCAL nY         := 0    
   LOCAL pRow
   LOCAL pCol
   LOCAL cComando
   LOCAL oBloco
   LOCAL cMinutos   
   LOCAL cHoras     
   LOCAL cDiaMes    
   LOCAL cMes       
   LOCAL cDiaSemana 
   LOCAL cUsuario   
   LOCAL aHora
   LOCAL lAtivo
   STATIC nConta           := 0
   STATIC lTarefaConcluida := FALSO

   /*
         SCI0001.INI

         [crontab]
         tarefas=03

         [01-crontab]
         horaultimatarefa=04:30:00
         dataultimatarefa=10/02/17
         ativo=1
         minutos=20
         horas=12
         diames=*
         mes=*
         diasemana=*
         usuario=ADMIN
         comando=CriaIndice

         [02-crontab]
         horaultimatarefa=18:42:00
         dataultimatarefa=22/02/17
         ativo=1
         minutos=1
         horas=*
         diames=*
         mes=*
         diasemana=*
         usuario=ADMIN
         comando=ExcluirTemporarios

         [03-crontab]
         horaultimatarefa=23:49:00
         dataultimatarefa=09/02/17
         ativo=1
         minutos=30
         horas=12
         diames=*
         mes=*
         diasemana=*
         usuario=ADMIN
         comando=CriaNewNota
   */

   hb_gcAll() // This def releases all memory blocks that are considered as the garbage.

   aHora          := ft_elapsed(,, oAmbiente:Clock, Time())
   nRetval        := aHora[4 , 2] // segundos

   if nRetval >= 1
      pRow := Row()
      pCol := Col()
      write( 00 , MaxCol()-17, Dtoc(Date()) + ' ' + (oAmbiente:Clock := Time()), omenu:corcabec)
      DevPos( pRow, pCol)
      //SetCursor( iif( Upper( "on" ) == "ON", 1, 0 )) 
   endif	
      
   if nTarefas <= 0	
      return nil
   endif

   if lTarefaConcluida
      return nil
   endif
   hb_idleState()

   for nY := 1 to nTarefas
      lAtivo := oIni:ReadBool(StrZero(nY,2) + '-crontab','ativo', true )
      if !lAtivo
         loop
      endif
      
      cComando   := oIni:ReadString(StrZero(nY,2) + '-crontab','comando', NIL)
      cMinutos   := oIni:ReadString(StrZero(nY,2) + '-crontab','minutos', "0" )
      cHoras     := oIni:ReadString(StrZero(nY,2) + '-crontab','horas', "*" )
      cDiaMes    := oIni:ReadString(StrZero(nY,2) + '-crontab','diames', "*" )
      cMes       := oIni:ReadString(StrZero(nY,2) + '-crontab','mes', "*" )
      cDiaSemana := oIni:ReadString(StrZero(nY,2) + '-crontab','diasemana', "*" )
      if cComando != NIL
         if cDiaSemana != "*"
            nDiaSemanaAtual := Dow(Date())
            if StrZero(nDiaSemanaAtual,1) != cDiaSemana // Nada a Fazer neste dia da semana
               Loop
            endif		   
         endif
         
         if cMes != "*"
            nMesAtual := Month(Date())
            if StrZero(nMesAtual,2) != StrZero(Val(cMes),2) // Nada a Fazer neste mes
               Loop
            endif
         endif
               
         if cDiaMes != "*"
            nDiaMesAtual := Day(Date())
            if StrZero(nDiaMesAtual,2) != StrZero(Val(cDiaMes),2) // Nada a Fazer neste dia do mes
               Loop
            endif
         endif
         
         if cHoras != "*"
            cHorasAtual := SUBSTR(TIME(), 1, 2)
            if cHorasAtual != cHoras // Nada a Fazer nesta hora
               Loop
            endif
         endif
         if !cMinutos == "*"
            if Left(cMinutos, 2) == "*/"  // cada tantos minutos
               cFracaoMinutos := SubStr(AllTrim(cMinutos), 3, 2)
               cTimeNow       := Time()
               aHora          := ft_elapsed(,, oAmbiente:HoraCerta[nY], cTimeNow)
               nRetval        := aHora[3 , 1]
               if nRetval < val(cFracaoMinutos)
                  loop
               endif
               oAmbiente:TarefaConcluida[nY] := FALSO
               oAmbiente:HoraCerta[nY]       := Time()
            else
               cMinutoAtual := SUBSTR(TIME(), 4,5)
               if !cMinutoAtual == cMinutos + ':00' // Nada a Fazer neste minuto
                  Loop
               endif
               //if oAmbiente:TarefaConcluida[nY] 
               //   loop
               //endif
               //oAmbiente:TarefaConcluida[nY] := OK
            endif	
         endif	
         //oBloco := {|x| ph1 := hb_idleAdd( {|x| Do(x), hb_idleDel()})}
         //Aadd(ph,   {|| nHandle := hb_idleAdd( {|nHandle| IdleCriaIndice(nHandle), hb_idleDel(nHandle) })})
         //Aadd(ph,   {|| hb_idleAdd( {|x| Do(x), hb_idleDel()})})		
         //Aeval(ph,  {|cComando|Eval(cComando)})
         
         oMenu:ContaReg( "CRONTAB # " + Strzero(++nConta,7))		
         oIni:WriteString(StrZero(nY,2) + '-crontab','ativo', lAtivo)
         oIni:WriteString(StrZero(nY,2) + '-crontab','dataultimatarefa', Tran(Date(), "@D"))
         oIni:WriteString(StrZero(nY,2) + '-crontab','horaultimatarefa', Time())
         Do(cComando, OK)		
      endif
   next
   SetCursor(1)
   return nil
endef   

def IdleCriaIndice(nHandle)
********************************
   LOCAL ph1
   oIndice:Compactar    := FALSO
   oIndice:ProgressoNtx := FALSO
   CriaIndice()
   //pH1 := hb_idleAdd( {|| CriaIndice()})
   hb_idleDel( nHandle ) 
   return NIL
endef   

def IdleDeletaArquivosTemporarios()
***************************************
LOCAL ph1
pH1 := hb_idleAdd( {|| ExcluirTemporarios()})
hb_idleDel( pH1 ) 
return NIL

def F_Fim( Texto )
***********************
	LOCAL cMicrobras := oAmbiente:xProgramador
				  Texto := Iif( Texto = NIL, "MICROBRAS", Texto )

	SetColor("")
	Cls
	Alert( Texto + ";;Copyright (C)1992," + Str(Year(Date()),4) + ";" + cMicrobras + ";;Todos Direitos;Reservados", "W+/G")
	return
endef

def Altc( cTexto )
******************
   LOCAL cScreen := SaveScreen()
   LOCAL cCor	  := SetColor()
   SetColor("")
   Cls
   ErrorBeep()
   if Conf("Encerrar a Execucao do Aplicativo ?")
      DbCommitAll()
      DbCloseAll()
      FChDir( oAmbiente:xBase )
      Cls
      F_Fim( cTexto )
      lOk := FALSO
      Quit
   endif
   SetColor( cCor )
   ResTela( cScreen )
   return
endef

def AcionaSpooler()
   SetKey( F8, 		  nil )
   SetKey( K_CTRL_P,   nil )
	Spooler()
   SetKey( F8, 		  {|| AcionaSpooler() })
   SetKey( K_CTRL_P,   {|| AcionaSpooler() })
	return( nil )
endef

*==================================================================================================*

def Hard( nPos, ProcName, ProcLine )
*****************************************
LOCAL cScreen := SaveScreen()
LOCAL cCodigo
LOCAL cSenha
LOCAL nCrc
LOCAL cCrc
LOCAL cData
LOCAL dData
LOCAL nSpaco
LOCAL nTemp
LOCAL cMens 			:= "Foi detectado um problema, Verifique as opcoes:"
LOCAL aMensagem		:= Array(3,5)
		aMensagem[1,1] := "[Limite de Codigo de Acesso Vencido]"
		aMensagem[1,2] := "1 - A data do Sistema Operacional esta correta ?"
		aMensagem[1,3] := "2 - Caso Positivo, solicite novo Codigo de Acesso."
		aMensagem[1,4] := ""
		aMensagem[1,5] := ""

		aMensagem[2,1] := "[Verificacao de Copia Original]"
		aMensagem[2,2] := "1 - O SCI esta sendo instalado pela 1¦ vez ?"
		aMensagem[2,3] := "2 - Esta atualizando a versao do SCI ?"
		aMensagem[2,4] := "3 - Esta instalando um novo terminal ?"
		aMensagem[2,5] := "4 - Caso Positivo, solicite Codigo de Acesso."

		aMensagem[3,1] := "[Renovacao de Codigo de Acesso]"
		aMensagem[3,2] := "1 - Informe ao nosso suporte tecnico que est  sendo"
		aMensagem[3,3] := "    um pedido antecipado de codigo de acesso, e que"
		aMensagem[3,4] := "    o mesmo ‚ de seu conhecimento.                 "
		aMensagem[3,5] := ""

if ProcName != NIL
	cMens := ProcName + "(" + StrZero( ProcLine, 5 ) + "): " + cMens
endif
Set Conf On
oMenu:Limpa()
MaBox( 00, 05, 24, 75 )
CenturyOn()
WHILE OK
	nTemp := Val( StrTran( Time(), ":"))
	//Seed( nTemp )
	cCodigo := ""
	For nX := 1 To 5
		nNumero := Random()
		nNumero := Alltrim( Str( nNumero ))
		cCodigo += Left( nNumero, 2)
	Next
	ErrorBeep()
	//SetColor("R/W")
	Write( 01, 06, cMens )
	//SetColor("B/W")
	Write( 03, 06, aMensagem[nPos,1])
	//SetColor("GR+/W")
	Write( 04, 06, aMensagem[nPos,2])
	Write( 05, 06, aMensagem[nPos,3])
	Write( 06, 06, aMensagem[nPos,4])
	Write( 07, 06, aMensagem[nPos,5])
	//SetColor("N/W")
	Write( 09, 06, "Sr. Usuario, ligue para o Depto. de Suporte ao Usuario atraves do" )
	Write( 10, 06, "Tel (69)3451-3085 e informe os dados apresentados abaixo:")
	cInterno := Left( cCodigo,3 ) + "." + SubStr( cCodigo, 4, 3 ) + "." + Right( cCodigo, 4 )
	Write( 12, 06, "Nome do Registro....: " + XNOMEFIR )
	Write( 13, 06, "Nome do Aplicativo..: " + SISTEM_NA1 )
	Write( 14, 06, "Versao..............: " + SISTEM_VERSAO )
	Write( 15, 06, "Codigo Interno......: " )
	@		 15, 28 Say cInterno Color "R/W"

	Write( 17, 06, "O Depto. de Suporte ira lhe informar um codigo de acesso para libe-")
	Write( 18, 06, "racao imediata do sistema, o qual devera ser digitado abaixo:")

	//SetKey( 309, {||Cod_Acesso( cCodigo, GetList ) } )
	@ 22, 06 Say "IMPORTANTE: Nao tecle ENTER ou saia antes de ter o codigo de acesso," Color "R/W"
	@ 23, 06 Say "pois o codigo interno se modificara novamente." Color "R/W"

	Set Date Brit
	dDatados := Date()
	cSenha	:= Space(13)
	@ 20, 06 Say "Codigo de Acesso...:" Get cSenha   Pict "@R 999.999.999.999.9" Valid Right( cSenha, 3) != "000"
	@ 20, 45 Say "Data Atual..:"        Get dDatados Pict "##/##/##"
	Read
	//SetKey( 309, NIL )
	if LastKey() = ESC
		if nPos <> 3
			Cls
			Quit
		else
			CenturyOff()
			return
		endif
	endif
	nCrc := 0
	For nX := 1 To 10
		nCrc += Val( SubStr( cSenha, nX,1)) * Val( SubStr( cSenha, nX, 1)) + Val( SubStr( cCodigo, nX,1))
	Next
	cCrc := Right(StrZero( nCrc, 10),3)
	if cCrc != Right( cSenha, 3 )
		ErrorBeep()
		Alert("Erro : O Codigo de Acesso inv lido. Solicite Novamente.")
		Loop
	endif
	Set Date To USA // mm/dd/yy
	cDataDos := Dtoc( dDataDos )
	cData 	:= SubStr( cSenha, 3, 2 ) + "/" + Left( cSenha, 2) + "/" + SubStr( cSenha, 5, 2 )
	dData 	:= Dtoc( Ctod( cData ))
	SET DEFA TO ( oAmbiente:xBase )
	if !File( 'SCI.DBF' )
		SetColor("")
		Cls
		ErrorBeep()
		Alert( oAmbiente:xBase )
		Alert( "Erro: Arquivo SCI.DBF nao localizado.")
		Quit
	endif
	if !NetUse( 'SCI.DBF', true )
		SetColor("")
		Cls
		ErrorBeep()
		Alert("Erro: Impossivel abrir SCI.DBF.")
		Quit
	endif
	
	oAmbiente:xDataCodigo := dData
	cDia := SubStr( oAmbiente:xDataCodigo, 4, 2 )
	cMes := Left(	oAmbiente:xDataCodigo, 2 )
	cAno := Right( oAmbiente:xDataCodigo, 4 )
	oAmbiente:xDataCodigo := cDia + "/" + cMes + "/" + cAno
	CopyCria()
	if Sci->(TravaArq())
		Sci->Limite   := MsEncrypt( dData )
		Sci->(Libera())
		Sci->(DbCloseArea())
	else
		if nPos <> 3
			Cls
			Quit
		endif
	endif
	Set Defa To ( oAmbiente:xBaseDados )
	ResTela( cScreen )
	Exit
EndDo
CenturyOff()
Set Conf Off
return

*----------------------------------------------------------------------------------------------------------------------*   

def Cod_Acesso( cCodigo, GetList )
   LOCAL Data_Limite
   LOCAL cExecucoes

	CenturyOff()
	// Monte a Senha Para calculo
	cExecucoes	 := Right( StrTran( Time(), ":"),2)
	cExecucoes	 += Right( StrTran( Time(), ":"),2)
	cData_Limite := StrTran( Dtoc( Date()+15), "/" )
	cSenha		 := cData_Limite + cExecucoes

	// Calcula o Crc
	nCrc := 0
	nX   := 0
	For nX := 1 To 10
		nCrc += Val( SubStr( cSenha,	nX, 1 )) * ;
				  Val( SubStr( cSenha,	nX, 1 )) + ;
				  Val( SubStr( cCodigo, nX, 1 ))
	Next
	cCrc	 := Right( StrZero( nCrc, 10),3)
	cSenha += cCrc
	cSenha := Tran( cSenha, "@R 999.999.999.999.9")
	Getlist[1]:buffer  := cSenha
	Getlist[1]:Changed := OK
	Getlist[1]:Assign()
	Getlist[1]:Reset()
	Getlist[1]:Display()
	Getlist[1]:ExitState := GE_ENTER
	CenturyOn()
	return nil
endef   
   
*----------------------------------------------------------------------------------------------------------------------*   

def HoraSaida( HR_ENTRADA, HR_SAIDA )
   LOCAL cStartTime := HR_ENTRADA
   LOCAL cTempo	  := StrTran( TimeDiff( cStartTime, Time()), ":")

   if !NetUse("SCI", true )
      EncerraDbf(, ProcName(), ProcLine())
   endif
   if Sci->(TravaReg())
      Sci->Time += Val( cTempo )
      Sci->(Libera())
      Sci->(DbCloseArea())
   else
      Cls
      Quit
   endif
endef   

*----------------------------------------------------------------------------------------------------------------------*   
