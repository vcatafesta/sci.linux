#include <sci.ch>
#include <sci.ch>

class TAmbiente	
	EXPORTED:
		DATA aLpt1 		INIT {}
		DATA aLpt2 		INIT {}
		DATA aLpt3 		INIT {}
      DATA aLpd1     INIT {} 
      DATA aLpd2     INIT {} 
      DATA aLpd3     INIT {} 
      DATA aLpd4     INIT {} 
      DATA aLpd5     INIT {} 
      DATA aLpd6     INIT {} 
      DATA aLpd7     INIT {} 
      DATA aLpd8     INIT {} 
      DATA aLpd9     INIT {}
      DATA CupsPrinter INIT ""
      DATA lVisSpooler INIT FALSO
      DATA Sendmail    INIT FALSO
      
		DATA nMenuH 	INIT 1
		DATA nMenuV 	INIT 1
		DATA LetoIP 	INIT '127.0.0.1'
	   DATA LetoPort 	INIT '2812'
		DATA LetoI 		INIT '//'
		DATA LetoM 		INIT ':'
		DATA LetoF 		INIT '/'
		DATA LetoPath  INIT '//127.0.0.1:2812/'
		DATA LetoAtivo INIT false
		DATA ShowVarLetoString INIT ""
		DATA ShowVarString 	  INIT ""
		
	PUBLIC:
		VAR Ano2000
		VAR Frame         INIT "ÕÍ¸³¾ÍÔ³"
		VAR Visual
		VAR CorMenu
      VAR CorBarraMenu  INIT 15
		VAR CorLightBar
		VAR CorHotKey
		VAR CorHKLightBar
		VAR CorDesativada
		VAR CorAntiga
		VAR CorCabec
		VAR CorBorda
		VAR CorAlerta
		VAR CorBox
		VAR CorCima
		VAR CorFundo
		VAR CorMsg
		VAR HoraCerta
		VAR TarefaConcluida
		VAR Clock 		   INIT Time()
		VAR Fonte 		   INIT 2
      VAR lSombra       INIT .T.
		VAR Selecionado		
		VAR Panos
		VAR ModeMenu
		VAR PanoFundo
		VAR Isprinter
		VAR aPermissao
		VAR xBaseDados
		VAR xBaseDoc
		VAR xBaseTxt
		VAR xBaseHtm
		VAR xBaseTmp
		VAR xImpressora
		VAR Get_Ativo
		VAR Acento
		VAR xDataCodigo
		VAR Spooler
		VAR Externo
		VAR cArquivo
		VAR TabelaFonte
		VAR Argumentos
		VAR argc		
		VAR argv init {}
		VAR Drive	INIT "" 
		VAR xBase	INIT ""
		VAR xRoot	INIT ""
		VAR Normal

		//TReceposi		  
		VAR Mostrar_Desativados
		VAR Mostrar_Recibo
		VAR PosiAgeInd
		VAR PosiAgeAll
		VAR RecePosi
		VAR lReceber		  
		VAR lRecepago   INIT FALSO
		VAR cTipoRecibo
		VAR Color_pFore INIT {}
		VAR Color_pBack INIT {}
		VAR Color_pUns  INIT {}		  
		VAR aAtivo      INIT {}		  
		VAR aAtivoSwap  INIT {}		  
				  
		VAR lGreenCard
		VAR lComCodigoAcesso
		VAR aFiscalIni
		VAR xLimite
		VAR _Empresa	INIT ""				
		VAR xFanta		INIT ""
		VAR xNomefir	INIT ""
		VAR xEmpresa	INIT ""
		VAR xJuroMesComposto
		VAR xJuroMesSimples
		VAR aSciArray
		VAR lContinuarAchoice        
		VAR Menu 
		VAR Disp 
		VAR Usuario       
		VAR nRegistrosImpressos 			INIT 0
		VAR StatusSup    						INIT "Macrosoft SCI for Linux"
		VAR StatusInf    						INIT ""     
		VAR xUsuario  	  						INIT "ADMIN"
		VAR NomeFirma 	  						INIT "VCATAFESTA@GMAIL.COM"
		VAR Codifirma 	  						INIT '0001'
		VAR xProgramador 						INIT "Vilmar Catafesta"
		VAR Alterando 	  						INIT FALSO
		VAR nPos      	  						INIT 1
		VAR Ativo     	  						INIT 1
		VAR FonteManualAltura          	INIT MS_MaxRow() // 25
		VAR FonteManualLargura         	INIT MS_MaxCol() // 80
		VAR AlturaFonteDefaultWindows  	INIT MS_MaxRow()
		VAR LarguraFonteDefaultWindows 	INIT MS_MaxCol()
		VAR RelatorioCabec             	INIT ""
		VAR MaxCol	                   	INIT MaxCol()+1
		VAR lK_Ctrl_Ins                	INIT FALSO
		VAR lK_Ctrl_Del                	INIT OK
		VAR lK_Insert                  	INIT FALSO
		VAR lk_Insert_Plus             	INIT FALSO
		VAR ZebrarAmostragem           	INIT FALSO
		VAR lMostrarSoma               	INIT OK		  
		VAR StSupArray
		VAR StInfArray
		VAR MenuArray
		VAR DispArray
      VAR lManterPosicaoMenuVertical   INIT OK
		DATA hESCP  							INIT {=>}

  
	public:
		ACCESS cor_menu         METHOD getcormenu()
		ASSIGN cor_menu         METHOD setcormenu( cormenu )
      METHOD Sombra(lSombra)  SETGET
      
		METHOD new CONSTRUCTOR
		METHOD Destroy 
		METHOD ConfAmbiente
		METHOD Ano2000On
		METHOD Ano2000Of
		METHOD SetVar
		METHOD SetSet
		METHOD SetPano
		METHOD SetModeMenu
		METHOD xDisp
		METHOD xMenu
		METHOD Show
		METHOD SetaCor
		METHOD SetaFrame
		METHOD SetaSombra
		METHOD SetaPano
		METHOD StatReg
      METHOD ResetReg()
		METHOD StatInf
		METHOD StatSup
		METHOD Limpa
		METHOD MaBox
		METHOD MSMenuCabecalho
		METHOD MSProcessa
		METHOD MSMenu
		METHOD SetaFonte
		METHOD SetVar
		METHOD Refresh
		METHOD Destroy
		METHOD AumentaEspacoMenu
		METHOD SetaFonteManual
		METHOD PreVisFonte
		METHOD ContaReg
		METHOD MostraPosicaoMenuNoCabecalho
		METHOD HelpCor(xColor)
		METHOD EscapeCode()
		METHOD GetLetoPath()
		METHOD ShowVar(lPause, cMsgAdicional, lMostrar)
		METHOD ShowVarLeto(lPause, cMsgAdicional, lMostrar)
		
		MESSAGE Create            method New
		MESSAGE SetaCorAlerta     method SetaCor(8) 
		MESSAGE SetaCorMsg		  method SetaCor(9) 
		MESSAGE SetaCorLightBar   method SetaCor
		MESSAGE SetaCorHotKey     method SetaCor
		MESSAGE SetaCorHKLightBar method SetaCor
		MESSAGE SetaCorBorda      method SetaCor(10)
endclass

METHOD ShowVar(lPause, cMsgAdicional, lMostrar)
	hb_default(@lPause, false)
	hb_default(@cMsgAdicional, "")
	hb_default(@lMostrar, true)
	
	::ShowVarString := 	"Principais Variaveis TAMBIENTE (acrescente se precisar :-);-;" + ;
					"::xroot     # " + formatavar(self:xroot)	   + ';' + ;	
					"::xbase     # " + formatavar(self:xbase)	   + ';' + ;		
					"::xusuario  # " + formatavar(self:xusuario)	+ ';' + ;		
					"::_Empresa  # " + formatavar(self:_Empresa)	+ ';' + ;		
					"::xEmpresa  # " + formatavar(self:xEmpresa)	+ ';' + ;
					"::xFanta    # " + formatavar(self:xFanta)	+ ';' + ;		
					"::xNomefir  # " + formatavar(self:xNomefir)	+ ';' + ;		
					"::Drive     # " + formatavar(self:Drive)    + cMsgAdicional
	if lMostrar
		AlertaPy(::ShowVarString, 31, false, lPause)
	endif	
	return ::ShowVarString

endef

METHOD ShowVarLeto(lPause, cMsgAdicional, lMostrar)
	hb_default(@lPause, false)
	hb_default(@cMsgAdicional, "")
	hb_default(@lMostrar, true)
	::ShowVarLetoString :=  "Variaveis do AMBIENTE Leto :-);-;" + ;
									"::LetoIp    # " + formatavar(::LetoIP)	   + ';' + ;	
									"::LetoPort  # " + formatavar(::LetoPort)	   + ';' + ;		
									"::LetoPath  # " + formatavar(::LetoPath)  	+ ';' + ;		
									"::LetoAtivo # " + formatavar(::LetoAtivo)   + cMsgAdicional
	
	if lMostrar
		AlertaPy(::ShowVarLetoString, 31, false, lPause)
	endif	
	return(::ShowVarLetoString)	
endef

method GetLetoPath()
	LOCAL cHost := ''
	cHost := ::LetoI
	cHost += ::LetoIP
	cHost += ::LetoM
	cHost += ::LetoPort
	cHost += ::LetoF	
	::LetoPath := cHost
	return ::LetoPath

method New()
	::hESCP               := ::EscapeCode()
	::Argumentos          := argc()          
	::argc                := argc()          
	::xRoot               := GetRoot(argv(0))
	::Drive               := if(::argumentos  = 0 , nil , argv(1))
	::Normal              := if(::argumentos <= 2 , nil , argv(3))
	::Visual              := if(::argumentos <= 1 , false , true )  
	::Panos               := ::SetPano()    
	::ModeMenu		 	    := ::SetModeMenu()
	::Selecionado         := 10     // Pano de Fundo Selecionado
	::PanoFundo           := ::Panos[10]
	::Frame               := "ÚÄ¿³ÙÄÀ³"
	::Cormenu             := 31
	::CorDesativada       := 8
	::CorLightBar         := 124
	::CorHotKey           := 10
	::CorHKLightBar       := 14
	::Ano2000             := DISABLE
	::Menu                := ::xMenu()
	::Disp                := ::xDisp()
	::nPos                := 1
   ::SetPano()
	::GetLetoPath()	
	
	M_Frame( ::Frame )
	setColor("")
	Cls	

	Qout("þ Macrosoft Sci, Copyrigh(c), 1991-2018, Vilmar Catafesta.")
	Qout("þ Carregando Configuracao.")
   
	if ::Drive = nil		
      ::Drive := GetRoot(argv(0))
	else
      ::Drive := AllTrim(Upper(::Drive))
		if Left(::Drive, 2) == "\\"      // Drive Mapeado
         if Len(::Drive) > 2
            if Right(::Drive, 1) == "\"   // Drive Mapeado em Diretorio
               ::Drive := Left(::Drive,Len(::Drive)-1)
            endif
         endif
      endif

      if Len(::Drive) = 3
         if SubStr(::Drive, 2,2) == ":\"
            ::Drive := Left(::Drive,Len(::Drive)-1)
			endif
		endif
	endif	
		
	aadd(::argv, argv(1))
	aadd(::argv, argv(2))
	aadd(::argv, argv(3))

	if ::Normal = NIL .OR. ::Drive = NIL
      //Visual()
	endif

   ::SetVar()
   ::Isprinter     := 1
   ::aPermissao    := {}
   ::xBase         := ( ::Drive )   
   ::xBaseDados    := ( ::Drive )
   ::xBaseDoc      := ( ::Drive )
   ::xBaseTxt      := ( ::Drive )
	::xBaseTmp      := ( ::Drive )
	::xBaseHtm      := ( ::Drive )
   ::xImpressora   := 1
   ::Get_Ativo     := OK
   ::Acento        := FALSO
   ::xDataCodigo   := "  /  /  "
   ::Spooler       := FALSO
   ::Externo       := FALSO
   ::cArquivo      := ""
   ::ConfAmbiente()   
   
   if "-V" $ Upper(Argv(1)) .or. "--version" $ Upper(Argv(1))     
      ms_version()        
      __quit()
	endif   
	return self  
endef

method getcormenu()
	return ::CorMenu
endef	
	
method setcormenu(cormenu)
	return iif( cormenu != NIL, ::cormenu := cormenu, cormenu)	
endef	

method Destroy()
	self := nil
	return nil
endef	

method Ano2000On()
   Set Epoch To 1950
   ::Ano2000 := OK
	return( Self )
endef	

method Ano2000Of()
   Set Epoch To 1900
   ::Ano2000 := FALSO
	return( Self )
endef	

method SetaFonteManual()
	LOCAL nLargura  := ::FonteManualLargura 
	LOCAL nAltura   := ::FonteManualAltura

	::Limpa()
	MaBox( 10, 10, 16, 50, "LAYOUT: Tamanho do buffer da tela" )
	@ 12, 11 Say "Altura:  " Get nAltura  Pict "999"
	@ 14, 11 Say "Largura: " Get nLargura Pict "999"
	Read
	if LastKey() = ESC
		return NIL
	endif
	::FonteManualLargura := nLargura
	::FonteManualAltura  := nAltura
	::MaxCol             := nLargura 
	//SetMode(::FonteManualAltura, ::FonteManualLargura)
	//Cls( ::CorFundo, ::PanoFundo, OK )
	return( self )
endef	

method PreVisFonte()
	LOCAL nFonte
	LOCAL Selecionado  := 1
	LOCAL nKey			 := 0
	LOCAL cScreen      := SaveScreen()
	LOCAL oTemp

	nFonte         := Len( ::TabelaFonte )
	nPos           := Ascan( ::TabelaFonte, ::Fonte )
	Selecionado 	:= if( nPos = 0, 1, nPos )
	cPanoFundo		:= ::PanoFundo
	cCormenu 		:= ::Cormenu
	cCorCabec      := ::CorCabec
	cCorFundo		:= ::CorFundo

	oTemp           := TAmbienteNew()
	oTemp:PanoFundo := cPanoFundo
	oTemp:Cormenu	 := cCormenu
	oTemp:CorCabec	 := cCorCabec
	oTemp:CorFundo	 := cCorFundo

	while( true )
		Keyb( Chr( 27 ))
		oTemp:Show()
		oTemp:contareg("#" + StrZero(Selecionado,3) + "# {" + ::ModeMenu[Selecionado] + "}")
		M_Frame( ::Frame )
		M_Message("UP/DOWN, ENTER, ESC. #" + StrZero(Selecionado,3), ::Cormenu )
		nKey := Inkey(0)
		if nKey == 27
			return Self 
		elseif nKey == 13
			exit
		elseif nKey == 5
			Selecionado := Iif( Selecionado == 1, nFonte, --Selecionado  )	
		elseif nKey == 24
			Selecionado := Iif( Selecionado == nFonte, 1, ++Selecionado  )
		endif	
		Eval( ::TabelaFonte[ Selecionado ])	
		Cls( ::CorFundo, ::PanoFundo, OK )
	EndDo
	::Fonte := Selecionado
	return Self
endef

method SetaFonte()
	LOCAL nLargura     := ::FonteManualLargura
	LOCAL nAltura      := ::FonteManualAltura 
	LOCAL nChoice      := 1

	M_Title("SELECIONE MODO DE VIDEO")
	nChoice := FazMenu( 03, 10, ::ModeMenu)
	if nChoice = 0
		return
		
	elseif nChoice = 21 // Definir Modo Manual
		::SetaFonteManual()
	elseif nChoice = 22 // Visualiza pre-escolha
		::PreVisFonte()	
		nChoice := ::Fonte	
		//return(Self)
	endif	
	Eval( ::TabelaFonte[ nChoice ])	
	Cls( ::CorFundo, ::PanoFundo, OK )	
	if Alert("LAYOUT;" + "Tamanho do buffer da tela;;" + "Largura:     " + Str( MS_MaxCol()) + ";Altura:      " + Str( MS_MaxRow()), {"Ok","Cancelar"}) == 1
		::Fonte := nChoice
	else
		::FonteManualLargura  := nLargura
		::FonteManualAltura   := nAltura
		Eval( ::TabelaFonte[ ::Fonte])	
		Cls( ::CorFundo, ::PanoFundo, OK )	
	endif		   
	return(Self)
endef

method ConfAmbiente()
	if ::Argumentos = 0
		::Frame := "ÉÐËÇÊÌÈ¶"
	elseif ::Argumentos = 1
		::Frame := "ÉÐËÇÊÌÈ¶"
	elseif ::Argumentos = 2
		::Frame := "ÉÐËÇÊÌÈ¶"
	elseif ::Argumentos = 3
		::Frame := "ÚÄ¿³ÙÄÀ³"
	endif
	::Frame := "ÚÄ¿³ÙÄÀ³"

	M_Frame( ::Frame )
	::xBase           := ( ::Drive )
	::TabelaFonte     := Array(21)
	::TabelaFonte[01] := {|| SetMode(28, 132)}
	::TabelaFonte[02] := {|| SetMode(::AlturaFonteDefaultWindows, ::LarguraFonteDefaultWindows)}
	::TabelaFonte[03] := {|| SetMode(25 , 80)}
	::TabelaFonte[04] := {|| SetMode(28 , 80)}
	::TabelaFonte[05] := {|| SetMode(33 , 80)}
	::TabelaFonte[06] := {|| SetMode(40 , 80)}
	::TabelaFonte[07] := {|| SetMode(43 , 80)}
	::TabelaFonte[08] := {|| SetMode(50 , 80)}
	::TabelaFonte[09] := {|| SetMode(25 , 132)}
	::TabelaFonte[10] := {|| SetMode(28 , 132)}
	::TabelaFonte[11] := {|| SetMode(33 , 132)}
	::TabelaFonte[12] := {|| SetMode(40 , 132)}
	::TabelaFonte[13] := {|| SetMode(43 , 132)}
	::TabelaFonte[14] := {|| SetMode(50 , 132)}
	::TabelaFonte[15] := {|| SetMode(25 , 160)}
	::TabelaFonte[16] := {|| SetMode(28 , 160)}
	::TabelaFonte[17] := {|| SetMode(33 , 160)}
	::TabelaFonte[18] := {|| SetMode(40 , 160)}
	::TabelaFonte[19] := {|| SetMode(43 , 160)}
	::TabelaFonte[20] := {|| SetMode(50 , 160)}
	::TabelaFonte[21] := {|| SetMode(::FonteManualAltura, ::FonteManualLargura)}
	::SetSet()

	if ::fonte > 1
		eval( ::TabelaFonte[ ::Fonte ] )
	endif
	//FT_Shadow( ::lSombra )
	return( Self )
endef	

method SetSet()
	Set Conf Off
	Set Bell On
	Set Scor Off
	Set Wrap On
	Set Mess To 22	
	Leto_Set( 11, "on" ) //Set Dele On
	Set( 11, "on" ) 		//Set Dele On
	Set Date Brit
	Set Deci To 2
	Set Print To
	Set Fixed On
	SetCancel( .F. )
	return( self )
endef	

method SetVar()
	if ::Visual != NIL
		::Frame  := "ÉÐËÇÊÌÈ¶"
	else
		::Frame  := "ÚÄ¿³ÙÄÀ³"
	endif	
	::Mostrar_Desativados := OK
	::Mostrar_Recibo      := OK
	::PosiAgeInd          := FALSO
	::PosiAgeAll          := FALSO
	::Receposi            := FALSO
	::lReceber            := FALSO
	::cTipoRecibo         := "RECCAR"
	::lGreenCard          := FALSO
	::lComCodigoAcesso    := FALSO
	::aFiscalIni          := NIL
	::xLimite             := NIL
	::_Empresa            := ""
	::xNomefir            := ""
	::xEmpresa            := ""
	::xJuroMesSimples     := 0
	::xJuroMesComposto    := 1
	::xFanta              := ""
	::aSciArray           := Array(1,8)
	::aAtivo              := {}
	::aAtivoSwap          := {}		  
	::lContinuarAchoice   := FALSO
	::lK_Insert           := FALSO
	::lK_Insert_Plus      := FALSO
	::ZebrarAmostragem    := FALSO		  
	::lMostrarSoma        := OK
	
	::CorMsg        := 47
	::CorAlerta     := 75     // Cor do menu Alerta
	::Fonte         := 1      // FlReset()
	::CorBorda      := 16     // Cor da Borda
	::CorAntiga     := 05
	::CorCima       := 128
	::CorBox        := 9
	::CorCabec      := 59    // Cor do Cabecalho
	::CorFundo      := 31    // Cor Pano de Fundo
	::Selecionado   := 10    // Pano de Fundo Selecionado
	::Ano2000       := DISABLE
	::xUsuario      := "ADMIN"
	//::PanoFundo     := ::Panos[ ::Selecionado ]			 
	return( self )
endef	

method SetModeMenu()
	::ModeMenu	 := { "Resetar Para Default Sistema",;
							"Tamanho Padrao da Janela do Windows",;
					      "25 x  80 - CGA EGA VGA Somente",;
							"28 x  80 - EGA VGA Somente",;
							"33 x  80 - EGA VGA Somente",;
							"40 x  80 - EGA VGA Somente",;
							"43 x  80 - EGA VGA Somente",;
							"50 x  80 - EGA VGA Somente",;								
							"25 x 132 - EGA VGA Somente",;
							"28 x 132 - EGA VGA Somente",;
							"33 x 132 - EGA VGA Somente",;
							"40 x 132 - EGA VGA Somente",;
							"43 x 132 - EGA VGA Somente",;
							"50 x 132 - EGA VGA Somente",;								
							"25 x 160 - EGA VGA Somente",;					
							"28 x 160 - EGA VGA Somente",;
							"33 x 160 - EGA VGA Somente",;
							"40 x 160 - EGA VGA Somente",;
							"43 x 160 - EGA VGA Somente",;						      
							"50 x 160 - EGA VGA Somente",;
							"Definir Layout Modo Manualmente",;
							"Testar Layout pre-definidos"}								
	return( self:modemenu )
endef	

method SetPano()
	::Panos         := ;
	{"°Ä",;
	"*#*#*°V±I²LÛM°A±R²:;*#*#*",;
	"°E±V²IÛL¹I",;
	"°±²²±°°±²³±Ä",;
	" Macrosoft ", ;
	"Û²°±MacrosoftÛ±²°",;
	"°°°°°°°°°°±±±±±±±±±²²²²²²²²²²±±±±±±±±±±", ;
	"°°°°°°°°°±±±±±±±±²²²²²²²²²±±±±±±±±±", ;
	"±±°±²±²°±°±°°²°²±²±²²±±²Û²±±²°²²", ;
	"±±°±²±²°±°±°°²°²±²±²²±±²Û²", ;
	"±±°±²±²°±°±°°²°²±²±²²", ;
	"°²±²±²°±²±°²°±²°²°²±", ;
	"±±°±²±²°±°±°°²°²±²±²²±±²Û²°", ;
	"±±±±±±±°°°°°°°°", ;
	"²²²²²²²±±±±±±", ;
	"²²²²²²²±±±±±", ;
	"°±²Û²±°",;
	" °±²Û²±°", ;
	"  °°±±²²±±°°", ;
	" °±²Û", ;
	"°±²", ;
	"Û", ;
	"²", ;
	"±", ;
	"°", ;
	"ÅÅ", ;
	" ",;
	"þþþþþþþþþþþþþþ",;
	"ß", "Ý", "?", "÷", "þ", "?", "?","?", "", "", "?", "?",;
	"", "", "?", "?", "", "?", "	", "?", "?", "",;
	"ú.ù,ú'ù.';ùþùú    ",;
	"ú.ù.'ú.'ù.ù'", ;
	"Macrosoft Informatica                                       ", ;
	"Macrosoft Informatica                                      ", ;
	"Macrosoft Informatica                                     ", ;
	"Macrosoft Informatica                                    ", ;
	"Macrosoft Informatica                                   ", ;
	"Macrosoft Informatica                                  ", ;
	"Macrosoft Informatica                                 ", ;
	"Macrosoft                                            ", ;
	"Macrosoft                                           ", ;
	"Macrosoft                                          ", ;
	"Macrosoft                                         ", ;
	"Macrosoft                                        ", ;
	"Macrosoft                                       ", ;
	"Macrosoft                                      ", ;
	"Macrosoft                                     ", ;
	"Macrosoft                                    ", ;
	"Macrosoft                                   ", ;
	"Macrosoft                                  ", ;
	"Macrosoft                                 ", ;
	"Macrosoft                                ", ;
	"Macrosoft                               ", ;
	"Macrosoft                              ", ;
	"Macrosoft                             ", ;
	"Macrosoft                            ", ;
	"Macrosoft                           ", ;
	"Macrosoft                          ", ;
	"Macrosoft                         ", ;
	"Macrosoft                        ", ;
	"Macrosoft                       ", ;
	"Macrosoft                      ", ;
	"Macrosoft                     ", ;
	"Macrosoft                    ", ;
	"Macrosoft                   ", ;
	"Macrosoft                  ", ;
	"Macrosoft                 ", ;
	"Macrosoft                ", ;
	"Macrosoft               ", ;
	"Macrosoft              ", ;
	"Macrosoft             ", ;
	"Macrosoft            ", ;
	"Macrosoft           ", ;
	"Macrosoft          ", ;
	"Macrosoft         ", ;
	"Macrosoft        ", ;
	"Macrosoft       ", ;
	"Macrosoft      ", ;
	"Macrosoft     ", ;
	"Macrosoft    ", ;
	"Macrosoft   ", ;
	"Macrosoft  ", ;
	"Macrosoft ", ;
	"Macrosoft","ÄÁÂ", "°±²Û", "²", "±", "Û", "°", "Î", " À¿", " É¼", "ÄÁÂ", " ", "ú.ù.'ú.'ù.ù'",;
	"À¿À¿",;
	"ÊËËÊ",;
	"ÁÂÂÁ",;
	"Ã´´Ã",;
	"¹ÌÌ¹",;
	"°°°°°±±±±±°°°°°²²²²²",;
	"ÍÊÍËÍËÍÊ",;
	"ÄÁÄÂÄÂÄÁ",;
	"=-",;
	":-",;
	"%%",;
	"##",;
	"@@"}			
	return( self:panos )
endef	
		
method SetaFrame()
	LOCAL cScreen := SaveScreen()
	LOCAL nChoice := 1
	LOCAL aFrames := {"        ",;
							B_SINGLE,;
							B_DOUBLE,;
							B_SINGLE_DOUBLE,;
							B_DOUBLE_SINGLE,;
							HB_B_SINGLE_UNI,;
							HB_B_DOUBLE_UNI,;
							HB_B_SINGLE_DOUBLE_UNI,;
							HB_B_DOUBLE_SINGLE_UNI,;
							"ßßßÞÜÜÜÝ",;
							"ÛÛÛÛÛÛÛÛÛ",;
							"ÉÐËÇÊÌÈ¶"}
							
	M_Title("ESCOLHA O TIPO DE BORDA/FRAME")						
	nChoice := Fazmenu( 03, 10, aFrames, ::Cormenu )
	ResTela( cScreen )
	if nChoice = 0
		return
	endif
	::Frame := aFrames[nChoice]
	M_Frame( ::Frame )
	return Self
endef
	
method xMenu()
	LOCAL AtPrompt := {}
	AADD( AtPrompt, {"I^nclusao",  {"S^ubMenu A","SubMenu B^","","Item D^esativado","Sub^Menu D"}})
	AADD( AtPrompt, {"A^lteraro",  {"SubMenu 1","SubMenu 2","SubMenu 3","SubMenu 4"}})
	AADD( AtPrompt, {"I^mpressao", {"SubMenu 1","SubMenu 2","SubMenu 3","SubMenu 4"}})
	AADD( AtPrompt, {"C^onsulta",  {"SubMenu 1","SubMenu 2","SubMenu 3","SubMenu 4"}})
	AADD( AtPrompt, {"H^elp",      {"SubMenu 1","SubMenu 2","SubMenu 3","SubMenu 4"}})
	return( AtPrompt )
endef	

method xDisp() 
	LOCAL aDisp := {}
	Aadd( aDisp, { LIG, LIG, .F., .F., LIG, LIG , LIG})
	Aadd( aDisp, { LIG, LIG, LIG, LIG, LIG, LIG , LIG})
	Aadd( aDisp, { LIG, LIG, LIG, LIG, LIG, LIG , LIG})
	Aadd( aDisp, { LIG, LIG, LIG, LIG, LIG, LIG , LIG})
	Aadd( aDisp, { LIG, LIG, LIG, LIG, LIG, LIG , LIG})
	Aadd( aDisp, { LIG, LIG, LIG, LIG, LIG, LIG , LIG})
	Aadd( aDisp, { LIG, LIG, LIG, LIG, LIG, LIG , LIG})
	return( aDisp )
endef	

method Limpa()
   Cls( ::CorFundo, ::PanoFundo )
	::StatSup()
	::StatInf()
	return self
endef
	
method StatSup( cCabecalho )
	LOCAL nTam  := MaxCol()+1
	LOCAL nPos  := ( nTam - Len( ::StatusSup ))
	
	aPrint( 00 , 00 , "", nTam )
   aPrint( 00 , 00 , Padc( if( cCabecalho = NIL, ::StatusSup, cCabecalho), nTam ),  ::CorCabec, nTam )   
	aPrint( 00 , ::MaxCol-18, Dtoc(Date()) + ' ' + (oAmbiente:Clock := Time()), omenu:corcabec)
	//aPrint( 00 , ( nTam-17),  Clock( 00, (nTam-17), ::CorCabec ), ::CorCabec )
	return Self
endef	
	
method StatInf( cMensagem )
	LOCAL nTam  := MaxCol()+1
	LOCAL nCol  := MaxRow()
   LOCAL nPos  := ( nTam - Len(::Codifirma + ':' + ::xUsuario + '/' + ::NomeFirma ))
	
	aPrint( nCol, 00 , "", nTam )
   aPrint( nCol, 00 , if( cMensagem = NIL, ::StatusInf, cMensagem), ::CorCabec, nTam )
   aPrint( nCol, nPos,  ::Codifirma + ':' + ::xUsuario + '/' + ::NomeFirma, ::CorCabec )
	return self
endef

method ResetReg()
   ::nRegistrosImpressos := 0
   ::ContaReg(0)
endef

method ContaReg( cMensagem, nCor)
   LOCAL nLen := 0
   LOCAL cMsg
   
	if cMensagem != NIL 
		if valtype( cMensagem ) != "N"
			::StatReg(cMensagem, nCor)	
         return true
		endif
      ::nRegistrosImpressos := cMensagem
	endif
	cMsg := "REGISTRO# " + TrimStr( ++oAmbiente:nRegistrosImpressos)
   nLen := Len(cMsg)
	::StatReg(cMsg + Space(16 - nLen), nCor)
	return true
endef	
	
method StatReg( cMensagem, nCor )
	LOCAL nTam  := ::MaxCol	
	LOCAL nCol  := MaxRow()
	LOCAL nPos  := ( nTam - Len(::Codifirma + ':' + ::xUsuario + '/' + ::NomeFirma ))
	DEFAU nCor TO ::CorCabec
	
	// ::StatInf("")		
	Print( nCol, 00 , if( cMensagem = NIL, ::StatusInf, cMensagem), nCor, iif(nCor <> ::CorCabec, MaxCol()+1, nil))   
	//write( nCol, 00 , if( cMensagem = NIL, ::StatusInf, cMensagem), ::CorCabec ) 
	return Self	
endef	
	
method Sombra(lSombra)
   if pcount() == 1 .and. HB_ISLOGICAL( lSombra )
      ::lSombra := lSombra
   endif
   return ::lSombra
      
method SetaSombra()
	FT_Shadow( ::lSombra )
	return Self	
endef	

method SetaCor( nTipo )
	LOCAL aTipo      := { ::CorMenu,;
								 ::CorCabec,;
								 ::CorFundo,;
								 ::CorDesativada,;
								 ::CorLightBar,;
								 ::CorHotKey,;
								 ::CorHKLightBar,;
								 ::CorAlerta,;
								 ::CorMsg,;
								 ::CorBorda,;
								 ::CorBarraMenu,;
	}

	LOCAL    cPanoFundo 	:= ::PanoFundo
	LOCAL       cScreen	:= SaveScreen()
	LOCAL         xTipo  := if( nTipo = NIL, 1, nTipo )
	LOCAL        xColor	:= aTipo[ xTipo ]
	LOCAL        CorAnt	:= aTipo[ xTipo ]
	LOCAL lManterScreen 	:= FALSO
	LOCAL         oTemp 	:= TAmbienteNew()  // Cria nova instancia do Objeto
	LOCAL     nLenAtipo  := Len( aTipo )
	LOCAL          ikey

	while( true )	
		oTemp:CorMenu           := aTipo[01]
		oTemp:CorCabec          := aTipo[02]
		oTemp:CorFundo		      := aTipo[03]
		oTemp:CorDesativada     := aTipo[04]
		oTemp:CorLightBar       := aTipo[05]
		oTemp:CorHotKey         := aTipo[06]
		oTemp:CorHKLightBar     := aTipo[07]
		oTemp:CorAlerta         := aTipo[08]
		oTemp:CorMsg            := aTipo[09]
		oTemp:CorBorda          := aTipo[10]
		oTemp:CorBarraMenu      := aTipo[11]
		
		oTemp:PanoFundo 	      := cPanoFundo
		oTemp:StatusSup 	      := "TESTE DE COR - Cabecalho"
		oTemp:StatusInf         := "TESTE DE COR - Rodape"

		Keyb( Chr(27))
		oTemp:Show(lManterScreen := OK)
		M_Frame( ::Frame )
		::HelpCor(xColor)
		ikey := inkey(0)
		
		switch iKey		
		case 24
			aTipo[ xTipo ] := ( XColor  := Iif( xColor  == 0, 255, --xColor  ))
			exit
		case 5		
			( aTipo[ xTipo ] ) :=  ( xColor	:= Iif( xColor  == 255, 0, ++xColor  ))
			exit
		case K_PGUP
			( aTipo[ xTipo ] ) :=  ( xColor	:= Iif( xColor  == 255, 0, xColor + 16  ))
			if(xColor >= 255 )
				   xColor := 255
				endif	
			exit					
		case K_PGDN
			( aTipo[ xTipo ] ) :=  ( xColor	:= Iif( xColor  == 255, 0, xColor - 16  ))
				if(xColor <= 0 )
				   xColor := 0
				endif				
			exit						
		case K_CTRL_PGDN
			( aTipo[ xTipo ] ) := ( xColor := 0)
			exit									
		case K_CTRL_HOME
			( aTipo[ xTipo ] ) := ( xColor := CorAnt )
			exit												
		case K_CTRL_PGUP
			( aTipo[ xTipo ] ) := ( xColor := 255)
			exit	
		case K_ENTER
		   exit		
		case K_ESC
			resTela( cScreen )		
			return self
		otherwise
		   putkey(lastkey())
			@ 28, 78 get xColor Pict "999" valid (xcolor >= 0 .and. xColor <= 255)
			read
			if lastkey() != K_ESC
				( aTipo[ xTipo ] ) := xColor
			endif	
			hb_keySetLast(0)
			exit
		endswitch
		if lastkey() == K_ENTER
		   exit
		endif
		Do case
		Case nTipo = 1 // cormenu
			aTipo[ 4 ] := AscanCorDesativada(aTipo[1])	
			aTipo[ 5 ] := Roloc(aTipo[1])
			aTipo[ 6 ] := AscanCorHotKey( aTipo[1])	
			aTipo[ 7 ] := AscanCorHKLightBar( aTipo[5])		
		Case nTIpo = 5 // CorLightBar
			aTipo[ 6 ] := AscanCorHotKey(aTipo[1])	
			aTipo[ 7 ] := AscanCorHKLightBar( aTipo[5])
		EndCase
	enddo
	::CorMenu           := aTipo[01]
	::CorCabec          := aTipo[02]
	::CorFundo	        := aTipo[03]
	::CorDesativada     := aTipo[04]
	::CorLightBar       := aTipo[05]
	::CorHotKey         := aTipo[06]
	::CorHKLightBar     := aTipo[07]	
	::CorAlerta         := aTipo[08]	
	::CorMsg            := aTipo[09]	
	::CorBorda          := aTipo[10]	
	::CorBarraMenu      := aTipo[11]	   
	//restela( cScreen )
	return SeLF
endef
	
method HelpCor(xColor)
	linhaembranco   := ';'
	linhahorizontal := '-'
	AlertaPy(   '  COR ATUAL : ' + StrZero( xColor, 3 )  + ';' + ;
					linhahorizontal + ';;' + ;					
					'      ENTER : ACEITAR ESCOLHA           ' + ';' + ;				
					'        ESC : CANCELAR                  ' + ';' + ;								
					'  CTRL+HOME : VOLTA PARA COR ANTERIOR   ' + ';' + ;
					'  CTRL+PGDN : PRIMEIRA COR              ' + ';' + ;				
					'  CTRL+PGUP : ULTIMA COR                ' + ';' + ;				
               '       PGUP : PULAR 16 CORES PARA CIMA  ' + ';' + ;
               '       PGDN : PULAR 16 CORES PARA BAIXO ' + ';' + ;
				   ' SETA ACIMA : MUDA COR                  ' + ';' + ;
				   ' SETA ABAIXO: MUDA COR                  ', xColor, true, false)
	return nil
	
method SetaPano()
*****************
	LOCAL nPano
	LOCAL Selecionado  := 1
	LOCAL nKey			 := 0
	LOCAL cScreen      := SaveScreen()
	LOCAL oTemp

	Aadd( ::Panos, TokenUpper(::xUsuario))
	nPano          := Len( ::Panos )
	nPos           := Ascan( ::Panos, ::Panofundo )
	Selecionado 	:= if( nPos = 0, 1, nPos )
	cPanoFundo		:= ::PanoFundo
	cCormenu 		:= ::Cormenu
	cCorCabec      := ::CorCabec
	cCorFundo		:= ::CorFundo

	oTemp           := TAmbienteNew()
	oTemp:PanoFundo := cPanoFundo
	oTemp:Cormenu	 := cCormenu
	oTemp:CorCabec	 := cCorCabec
	oTemp:CorFundo	 := cCorFundo

	while( true )
		Keyb( Chr( 27 ))
		oTemp:Show(lManterScreen := FALSO)
		M_Frame( ::Frame )
      Mensagem("Use as setas CIMA e BAIXO para trocar, ENTER para aceitar, ESC Cancelar.;-; N§ " + StrZero( Selecionado, 3 ) + ' ' + ::Panos[Selecionado], Selecionado)
		nKey := Inkey(0)
		if ( nKey == 27 .OR. nKey = 13 )
			Exit
		elseif nKey == 24
			Selecionado := Iif( Selecionado == 1, nPano, --Selecionado  )
		elseif nKey == 5
			Selecionado := Iif( Selecionado == nPano, 1, ++Selecionado  )
		endif
		oTemp:PanoFundo := ::Panos[ Selecionado ]
	EndDo
	::PanoFundo := ::Panos[ Selecionado ]
	return Self
endef	

method MaBox( nTopo, nEsq, nFundo, nDireita, Cabecalho, Rodape, lInverterCor )
   LOCAL cPanoFundo := " " 
   LOCAL nCor       := if( lInverterCor = NIL, ::Cormenu,  lInverterCor )
   LOCAL pback
   
   //DispWHILE OK()
   if nDireita = 79
   	nDireita = ::MaxCol
   endif
   ColorSet( @nCor, @pback )
   Box( nTopo, nEsq, nFundo, nDireita, ::Frame + cPanoFundo, nCor )
   if Cabecalho != Nil
   	aPrint( nTopo, nEsq+1, "Û", Roloc( nCor ), (nDireita-nEsq)-1)
   	aPrint( nTopo, nEsq+1, Padc( Cabecalho, ( nDireita-nEsq)-1), Roloc( nCor ))
   endif
   if Rodape != Nil
   	aPrint( nFundo, nEsq+1, "Û", Roloc( nCor ), (nDireita-nEsq)-1)
   	aPrint( nFundo, nEsq+1, Padc( Rodape, ( nDireita-nEsq)-1), Roloc( nCor ))
   endif
   cSetColor( SetColor())
   nSetColor( nCor, Roloc( nCor ))
   //DispEnd()
	return
endef	

method AumentaEspacoMenu(nSp)
	LOCAL nTam    := Len(::menu)
	LOCAL cSpMais := Space(if(nSp == nil, nSp := 1, nSp))
	LOCAL nX
	
	for nX := 1 To nTam
	   ::menu[nX,1] := AllTrim(::menu[nX,1])
	   ::menu[nX,1] := cSpMais + ::menu[nX,1] + cSpMais
	next
	return( self )
endef

method Show(lManterScreen)
   LOCAL MenuClone := aClone( ::menu )
	LOCAL nSpMais   := 0
   LOCAL nChoice
	
	::Limpa()
	::StatSup()
   ::StatInf()
	if( lManterScreen == nil , lManterScreen := FALSO , lManterScreen)
   M_Frame( ::Frame )
   //::nPos := 2
	if nSpMais > 1
		::AumentaEspacoMenu(nSpMais)
	endif	
   nChoice := ::MsMenu( 1, lManterScreen )
	::menu  := Aclone( MenuClone)
	::StatSup()
   ::StatInf()
	return (nChoice )
endef	
	
method MsMenu( nLinha, lManterScreen )
	LOCAL cScreen	 := SaveScreen() // nLinha+1, 00, MaxRow(), MaxCol())
	LOCAL nMaxCol   := ::MaxCol
	LOCAL xScreen
	LOCAL nSoma 	 := 0
	LOCAL nX 		 := 0
	LOCAL nDireita  := 0
	LOCAL nVal		 := 1
	LOCAL nMaior	 := 1
	LOCAL nRetorno  := 0.0
	LOCAL cmenu 	 := ""
	LOCAL cPrinc	 := ""
	LOCAL nKey		 := 0
	LOCAL nMax		 := 0
	LOCAL nBaixo	 := 0
	LOCAL nTam      := 0
	LOCAL nTamSt	 := 0
	LOCAL nCorrente := 1
	LOCAL aNew		 := {}
	LOCAL aSelecao  := {}
	LOCAL oP 		 := 0
	LOCAL cJanela
	LOCAL nScr1
	LOCAL nScr2
	LOCAL nScr3
	LOCAL nScr4

	nLinha := if( nLinha = NIL, 0, nLinha )
	WHILE OK
		nSoma 	 := 0
		nX 		 := 0
		nDireita  := 0
		nVal		 := 1
		nMaior	 := 1
		nRetorno  := 0.0
		cmenu 	 := ""
		cPrinc	 := ""
		nKey		 := 0
		nMax		 := 0
		oP 		 := 0
		nBaixo	 := 0
		nTamSt	 := 0
		nCorrente := 1
		aNew		 := {}
		aSelecao  := {}
		nTam      := 0
      ::MaxCol  := MaxCol() + 1 
		//::Limpa()
		::MSmenuCabecalho( nLinha, ::nPos )
		FOR nX := 2 To ::nPos
			//nSoma += Len( ::menu[nX-1 , 1]) + 1 
			nSoma += Len( ::menu[nX-1 , 1]) 
		Next
		nX := 0
		
		FOR nX := 1 To Len( ::menu[ ::nPos, 2])
			if Empty( ::menu[::nPos, 2 , nX ])
				Aadd( aNew, "")
				Aadd( aSelecao, ENABLE )
			else
				Aadd( aNew, "  " + ::menu[::nPos,2, nX ] + "  " )
				Aadd( aSelecao, ::Disp[::nPos, nX ])
			endif
			nTamSt := Len( ::menu[::nPos,2, nX ]) + 2
			if nTamSt > nVal
				nVal	 := nTamSt
				nMaior := nX
			endif
		Next
		
		nDireita  := Len( ::menu[::nPos, 2 , nMaior])+5
		nBaixo    := Len( ::menu[::nPos, 2])
		nTam		 := nDireita + nSoma
		nMax		 := if( nTam > nMaxCol, nMaxCol, nTam )
		nSoma 	 := if( nTam > nMaxCol, (nSoma-( nTam-nMaxCol)) , nSoma )
		nSoma 	 := if( nSoma < 0, 0, nSoma )
		nScr1 	 := 01+nLinha
		nScr2 	 := 00
		nScr3 	 := MaxRow()-1
		nScr4 	 := ::MaxCol
		xScreen	 := SaveScreen( nScr1, nScr2, nScr3, nScr4 )
		Box( 01+nLinha, nSoma, 02+nBaixo+nLinha, nMax, ::Frame, ::CorMenu )
		oP 		  := ::MsProcessa( 02+nLinha, nSoma+1, 02+nBaixo+nLinha, nMax-1, aNew, aSelecao )
		if !lManterScreen
			RestScreen( nScr1, nScr2, nScr3, nScr4, xScreen )
		endif	
		cPrinc   := Str( ::nPos, 2 )
		cMenu 	:= StrZero( oP, 2 )
		nMax     := Len( ::Menu )
		nKey		:= LastKey()
		nRetorno := Val( cPrinc + "." + cmenu )   
		
		DO Case
			Case nKey = 13 .OR. nKey = K_SPACE
				if aSelecao[oP] // Item Ativo?
					return( nRetorno )
				else
					Alerta("ERRO: Item Desativado")
				endif
			Case nKey = 27 .OR. nKey = TECLA_ALT_F4
				return( 0 )
			Case nKey = SETA_DIREITA
				::nPos++
			Case nKey = SETA_ESQUERDA
				::nPos--
			Case nKey = K_HOME .OR. nKey = K_CTRL_PGUP .OR. nKey = K_PGUP
				::nPos := 1
			Case nKey = K_END .OR. nKey = K_CTRL_PGDN .OR. nKey = K_PGDN
				::nPos := nMax
			OtherWise
				Eval( SetKey( nKey ))
		EndCase
		::nPos := if( ::nPos > nMax, 1,    ::nPos )
		::nPos := if( ::nPos < 1,    nMax, ::nPos )
	EndDo
	return 
endef

method MSMenuCabecalho( nLinha, nPos )
   LOCAL nMax    := ::MaxCol
	LOCAL nSoma   := 0
	LOCAL nSoma1  := 0
   LOCAL nX 	  := 0
   LOCAL nTam    := Len(::menu)
	LOCAL aHotKey := Array(nTam)
	LOCAL aRow    := Array(nTam)
	LOCAL aCol    := Array(nTam)
	LOCAL cHotKey := Space(0)
	LOCAL nLen
	LOCAL cMenu
	LOCAL nConta
	LOCAL cStr
	LOCAL cNew
	
   //altd()
	aPrint( nLinha, 00, " ", ::CorBarraMenu, nMax )
	FOR nX := 1 To nTam
		cMenu   := ::menu[nX,1]
     	cHotKey := Space(0)
		nSoma1  := 0
		StrHotKey(@cMenu, @cHotKey, 1)
		if (nSoma1 := Len(cHotKey)) > 1 
		   cHotKey := Right(cHotKey,1)
		endif
		nSoma1--		
		//::menu[nX,1]:= cMenu
		aHotKey[nX] := cHotKey
		//nLen        := Len( ::menu[nX,1])
		nLen        := Len( cMenu )
		aRow[nX]    := nLinha	
		aCol[nX]    := nSoma	+ nSoma1
		aPrint( nLinha,   nSoma,    cMenu,       if( nPos = nX, ::CorLightBar,   ::CorBarraMenu ))		
		aPrint( aRow[nX], aCol[nX], aHotKey[nX], if( nPos = nX, ::CorHKLightBar, ::CorHotKey ))				
	   nSoma    += nLen + 1
		nSoma1   += nLen + 1
   Next
	return self
endef	

Function StrHotKey(cMenu, cHotKey, nMenuOuSubMenu)
   LOCAL cChar   := "^"
	LOCAL cSwap   := Space(0)
	LOCAL nDel    := 0
	LOCAL nPos    := 3
	LOCAL nConta
	LOCAL cStr
	LOCAL cNew

   //altd()
	if( nMenuOuSubMenu == 1, nPos := 3, nPos := 4)
	nConta := StrCount( cChar, cMenu )
	if nConta <= 0  // sem cChar ?
	   cMenu  := Stuff( cMenu, nPos, nDel, cChar )
      nConta := StrCount( cChar, cMenu )
	endif		      
	if nConta >0
	   cHotKey := StrExtract(cMenu, cChar, 1 )
	   cMenu   := StrSwap(cMenu, cChar, 1 , cSwap)
   endif
	return	
endef	

method MSProcessa( nCima, nEsquerda, nBaixo, nDireita, aNew, aSelecionado )
	LOCAL nX 	  := 1
	LOCAL nTam	  := Len( aNew )
	LOCAL aHotKey := Array(nTam)
	LOCAL aRow    := Array(nTam)
	LOCAL aCol    := Array(nTam)
	LOCAL nRow	  := nCima-1
	LOCAL nMax	  := nTam
	LOCAL nTamSt  := ( nDireita - nEsquerda ) + 1
	LOCAL nKey	  := 1
	LOCAL nConta  := 0
	LOCAL cSep
   LOCAL cMenu
	LOCAL cStr
	LOCAL cNew
	STATI nItem   
	
	nItem := ::ativo
	if ::Visual != NIL
		if ::Frame == B_SINGLE
			cSep := 'Ã' + Repl( 'Ä', nTamSt ) + '´'
		else	
			cSep := SubStr(::Frame, 4, 1) + Repl( "Ä", nTamSt ) + SubStr(::Frame, 8,1)
		endif	
	else
		cSep := Chr(195) + Repl( "Ä", nTamSt ) + Chr(180)
	endif          
	SetCursor(0)
	FOR nX := 1 To nTam
	   cMenu       := aNew[nX]
	   cHotKey     := Space(0)
		StrHotKey(@cMenu, @cHotKey, 2)
		aNew[nX]    := cMenu
		nLen        := (nTamSt-Len(cMenu))
		nSoma1      := 0
		if (nSoma1  := Len(cHotKey)) > 1 
		   cHotKey  := Right(cHotKey,1)
		endif
		nSoma1--		
		aHotKey[nX] := cHotKey
		aRow[nX]    := nRow+nX
		aCol[nX]    := nEsquerda + nSoma1
		
		if Empty( cMenu )
			aPrint( nRow+nX, nEsquerda-1, cSep, ::CorMenu, nTamSt ) // Separador
			Loop
		endif
		
		if aSelecionado[ nX ]                              //Item dipsonivel
			aPrint( nRow+nX, nEsquerda, cMenu + Space(nLen), ::Cormenu )
		else
			nConta++
			aPrint( nRow+nX, nEsquerda, cMenu + Space(nLen), ::CorDesativada )
		endif
	Next
				
	if nItem > nMax
		nItem = nMax
	endif
	
	WHILE OK
	   cMenu := aNew[nItem]
	   nLen  := (nTamSt-Len(cMenu))
	  
		if nConta != nMax
			if aSelecionado[ nItem ] .AND. !Empty( cMenu)
				 aPrint( nRow+nItem, nEsquerda, Upper(cMenu)   + Space(nLen), ::CorLightBar )
			endif
			if aSelecionado[ nItem ] .AND. Empty(cMenu)
				aPrint( nRow+nItem, nEsquerda-1, cSep, ::CorMenu )
				if LastKey() = K_UP
					nItem--
				else
					nItem++
				endif
				nItem := if( nItem > nMax, 1, 	nItem )
				nItem := if( nItem < 1, 	nMax, nItem )
				Loop
			endif
			if !::alterando
				if !aSelecionado[ nItem ]
					aPrint( nRow+nItem, nEsquerda, cMenu + Space(nLen), ::CorDesativada )
					if LastKey() = K_UP
						nItem--
					else
						nItem++
					endif
					nItem := if( nItem > nMax, 1,    nItem )
					nItem := if( nItem < 1,    nMax, nItem )
					Loop
				endif
			endif
		endif
		
		FOR nX := 1 To nTam
			aPrint( aRow[nX], aCol[nX], aHotKey[nX], if(nItem == nX, ::CorHKLightBar, ::CorHotKey ))
	   Next
		
		::nMenuH := ::nPos
		::nMenuV := nItem
		::MostraPosicaoMenuNoCabecalho()
		
		nKey := Inkey(0)
		if ::Alterando
			aPrint( nRow+nItem, nEsquerda, aNew[nItem] + Space(nLen), if( aSelecionado[nItem], ::CorMenu, ::Cordesativada-1 ))
		else
			aPrint( nRow+nItem, nEsquerda, aNew[nItem] + Space(nLen), if( aSelecionado[nItem], ::Cormenu, ::Cordesativada ))
		endif
		
      ::Ativo := nItem      
		Do Case				
		Case nKey = 27 .OR. nKey = TECLA_ALT_F4
			return( 0 )

		Case nKey = 13 .OR. nKey = TECLA_SPACO
			return( nItem )
		
		Case nKey = K_HOME .OR. nKey = K_CTRL_PGUP .OR. nKey = K_PGUP
		   if nItem == 1
			   nItem := nMax
			else	
				nItem := 1
			endif	

		Case nKey = K_END .OR. nKey = K_CTRL_PGDN .OR. nKey = K_PGDN
		   if nItem == nMax
			   nItem := 1
			else	
			   nItem := nMax
			endif	

		Case nKey = SETA_DIREITA
         if !(oAmbiente:lManterPosicaoMenuVertical)
            ::Ativo := 1
         endif   
			return( SETA_DIREITA )

		Case nKey = SETA_ESQUERDA
         if !(oAmbiente:lManterPosicaoMenuVertical)
            ::Ativo := 1
         endif            
			return( SETA_ESQUERDA )

		Case nKey = K_UP
			nItem--

		Case nKey = K_DOWN
			nItem++

		Case ( bAction := SetKey( nKey )) != NIL
			Eval( bAction, ProcName(), ProcLine(), ReadVar())

		EndCase
		nItem   := if( nItem > nMax, 1,    nItem )
		nItem   := if( nItem < 1,    nMax, nItem )
		::Ativo := nItem
	EndDo
	return( NIL )
endef	

method MostraPosicaoMenuNoCabecalho()
	//MS_SetConsoleTitle("MENU# " + TrimStr(::nMenuH) + '.' + TrimStr(::nMenuV))		
	return self
endef	

method Refresh(nItem)
	::menu := Eval({|nItem|::menuarray[nItem]}, nItem )
	//LOCAL oBloco := {|nItem|::menuarray[nItem]}
	//::menu := Eval(oBloco, nItem)
	return
endef	

method EscapeCode()
	LOCAL hESCP    := {=>}	
	HSetCaseMatch( hESCP, .F. )                 // desabilita o case-sensitive
	
	// Printer Operation
	hESCP['reset'            ] := '#27#64'      // Inicializa impressora
	hESCP['halfon'           ] := '#27#115#49'  // Lig/Des Half-Speed mode 0-desliga 1-liga
	hESCP['halfoff'          ] := '#27#115#48'  // Lig/Des Half-Speed mode 0-desliga 1-liga
	hESCP['unidirecionalonly'] := '#27#60'      // Select Unidirecional Mode (one line)
	hESCP['unidirecionalon'  ] := '#27#85#49'   // Turn Unidirecional Mode on
	hESCP['unidirecionalonff'] := '#27#85#48'   // Turn Unidirecional Mode off
	hESCP['paperdisable'     ] := '#27#56'      // Disable paper-out detection
	hESCP['paperenable'      ] := '#27#57'      // Enable paper-out detection
	hESCP['beeper'           ] := '#7'          // Beeper

	//Data Control
	hESCP['CR'               ] := '#13'         // Carriage return - enter
	hESCP['CAN'              ] := '#24'         // Cancel line
	hESCP['DEL'              ] := '#127'        // Delete Character
	
	// Vertical Motion
	hESCP['LF'               ] := '#10'           // Line feed
	hESCP['FF'               ] := '#12'           // Form feed
	hESCP['PageLenghtInLines'] := '#27#67#66'     // Set page lenght in Lines  n=number of lines  - default 66
	hESCP['PageLenghtInInche'] := '#27#67#48#11'  // Set page lenght in Inches n=number of inches - default 11
	hESCP['SaltoPicoteLig'   ] := '#27#78#66'     // Set Skip-Over preforation n=number of lines  - default 66
	hESCP['SaltoPicoteDes'   ] := '#27#79'        // Cancel Skip-Over preforation
	hESCP['_Spaco1_8'        ] := '#27#48'        // Select 1/8-inch Line spacing
	hESCP['_Spaco7_72'       ] := '#27#49'        // Select 7/72-inch Line spacing
	hESCP['_Spaco1_6'        ] := '#27#50'        // Select 1/6-inch Line spacing
	hESCP['_SpacoN_216'      ] := '#27#51#66'     // Select n/216-inch Line spacing
	hESCP['_SpacoN_72'       ] := '#27#51#66'     // Select n/72-inch Line spacing
	hESCP['ESCJn'            ] := '#27#51#66'     // Perform n/216-inch Line Feed
	hESCP['VT'               ] := '#11'           // Tab Verticalmente
	
	//Overall printing style
	hESCP['draft'            ] := '#27#120#48'    // Select Draft mode
	hESCP['nlq'              ] := '#27#120#49'    // Select NLQ mode
	hESCP['nlqroman'         ] := '#27#107#48'    // Select NLQ font roman	
	hESCP['nlqserif'         ] := '#27#107#49'    // Select NLQ font sans serif
	
	// Print enhancement
	hESCP['EmphasizedOn'     ] := '#27#69'       // Select Emphasized Mode
	hESCP['EmphasizedOff'    ] := '#27#70'       // Cancel Emphasized Mode
	hESCP['DoubleStrikeOn'   ] := '#27#71'       // Select Double-Strike mode
	hESCP['DoubleStrikeOff'  ] := '#27#72'       // Cancel Double-Strike mode
	hESCP['SuperScriptOn'    ] := '#27#83'       // Select Superscript mode
	hESCP['SuperScriptOff'   ] := '#27#84'       // Cancel Superscript mode
	hESCP['ItalictOn'        ] := '#27#52'       // Select Italic mode
	hESCP['ItalictOff'       ] := '#27#53'       // Cancel Italic mode
	hESCP['UnderlineOn'      ] := '#27#45#49'    // Turno Underline On
	hESCP['UnderlineOff'     ] := '#27#45#48'    // Turno Underline Off
	
	//Word procesing
	hESCP['nlqleft'          ] := '#27#97#48'    // NLQ justification left
	hESCP['nlqcenter'        ] := '#27#97#49'    // NLQ justification center
	hESCP['nlqright'         ] := '#27#97#50'    // NLQ justification right
	hESCP['nlqfull'          ] := '#27#97#51'    // NLQ justification full
	return hESCP
endef	

def TAmbienteNew()
	return( TAmbiente():New())
endef	

def ms_maxrow()
	return maxrow()
def ms_maxcol()
	return maxcol()

