/*
⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
 ›≥																								 ≥
 ›≥	Programa.....: FUNCOES.PRG 														 ≥
 ›≥	Aplicacaoo...: MODULO DE FUNCOES DE APOIO AO SCI							 ≥
 ›≥	Versao.......: 19.50 																 ≥
 ›≥	Programador..: Vilmar Catafesta													 ≥
 ›≥	Empresa......: Microbras Com de Prod de Informatica Ltda 				 ≥
 ›≥	Inicio.......: 12 de Novembro de 1991. 										 ≥
 ›≥	Ult.Atual....: 06 de Dezembro de 1998. 										 ≥
 ›≥	Compilacao...: Clipper 5.2e														 ≥
 ›≥	Linker.......: Blinker 7.0													   	 ≥
 ›≥	Bibliotecas..: Clipper/Funcoes/Mouse/Funcky15/Funcky50/Classe/Classic ≥
 ›¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
 ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/
#include <sci.ch>

STATIC static13
STATIC static14
STATIC static1 := "’Õ∏≥æÕ‘≥"
STATIC static2 := ""
STATIC static3 := {1, 1, 0, 0, 0, 0, 0, 0, 0, 24, 79, 1, 0, 0, 0, 1, 8, 1, 0, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, -999, 0, 0, Nil}

*==================================================================================================*

def AlertPy(string, cor, centralizar, nOK, cOk)
*----------------------------------------------*
	AlertaPy(string, cor, centralizar, nOK, cOk)
	return nil
endef
	
def AlertaPy(string, Cor, Centralizar, lOK, aPrompt)
*--------------------------------------------------*
	LOCAL nlinhas := 0
	LOCAL aString := ""
	LOCAL nLen    := 0
	LOCAL nPv     := 0
	LOCAL nSep    := 0
	LOCAL nRow
	LOCAL nCol
	LOCAL nRow1
	LOCAL nCol1
   LOCAL nMax
   LOCAL xTemp	 
    
   hb_default(@string, "AlertaPy")    
   //hb_default(@cor, 31)    
	hb_default(@centralizar, false)    
	hb_default(@lOk, true) 
   hb_default(@aPrompt, {" Ok "}) 
   
   nlinhas := strcount(';', string)
	aString := StrSplit( string, ';', -1)  
	nLen    := amaxstrlen( aString)   
   nMax    := Len(aString)	     		   
     
   if aPrompt == nil .or. len(aPrompt) == 0 .or. !IsArray(aPrompt)
		aPrompt := {" Ok "}
	endif
	
	// verifica se a string contem separador de linhas ;-; 
	for x := 1 To nMax
		switch aString[x] 
			case ';'; nPv++ ;	exit
			case '-'; nSep++;	exit
		endswitch
	next
	 
	if nSep == 0 // Sem linha horizontal
		string  += ';-;'
		nlinhas := strcount(';', string)
		aString := StrSplit( string, ';', -1)  
		nLen    := amaxstrlen( aString)	
	endif		

   nMax    := Len(aString)	     		   
   
   if !IsArray(Cor)
      xTemp := Cor
      Cor   := Array(nMax)      
      Afill( Cor, xTemp)
   endif   
   
   if !IsArray(Centralizar)
      xTemp       := Centralizar 
      Centralizar := Array(nMax)
      Afill(Centralizar, xTemp )
   endif    
   
   if nLen < 6
		nLen = 6
	endif	 
   
	row     := (maxrow() / 2) - (nlinhas / 2) - 4
	col     := (maxcol() - nLen) / 2	 
	cScreen := SaveScreen()	 
	nrow    := row
	ncol    := (col-2)
	nrow1   := (row+4+nlinhas)
	ncol1   := (col+nLen+1)	 	 
	 
	nTamPrompt := 0
	nLenaPrompt := Len(aPrompt)	
	for k := 1 to nLenaPrompt
		nTamPrompt += Len(aPrompt[k])
	next	
	 
	center  := (maxcol()/2) - (nTamPrompt/2)
	 
//==================== 20/2 = 10
       //center
	 
    setcursor(0)    
    box(nrow, ncol, nrow1, ncol1, "’Õ∏≥æÕ‘≥", Cor[1])
    for x := 1 To Len(aString)	     
	     cString := aString[x]
        if centralizar[x]
            ncol := (maxcol() - len(cString)) / 2
        else
            ncol := col
		  endif		
		  if cString == '-'
			  LinhaHorizontal(row + 1, Col - 2, Col + nlen, cor[x])
		  else	  
				aprint(row + 1, ncol, cString, cor[x])
		  endif		
        row := row + 1
	 next	  
	 if lOk
		if nLenaPrompt = 1
			aprint(row + 2, center, aPrompt[1], roloc(cor[1]))
			inkey(0)
			restela(cScreen) 	 
			return(cScreen) 	 
		else			
			//nSetColor(cor)
			return( nRetval := aChoice( row, Col, row + 4, Col + nLen, aPrompt))
		endif
	 endif
	 return(cScreen) 	 
endef	 

*==================================================================================================*    
    
static def MaxDrawBox(Arg1)
   Arg1[18]:= untrim(m_title(), Arg1[11] - Arg1[22]) + right(Arg1[28], Arg1[11])
   mabox(Arg1[1], Arg1[2], Arg1[3], Arg1[4], m_frame(), Arg1[5])
   if (Arg1[10] > -1)
      print( Arg1[3] - 2, Arg1[2] + 1, Replicate(SubStr(m_frame(), 6, 1), Arg1[11]), Arg1[5])
   endif
   if (Arg1[10] > -2)
      print( Arg1[3] - 1, Arg1[2] + 1, Arg1[18], Arg1[6], Arg1[11])
   endif
   return Nil
endef	

*==================================================================================================*

def m_frame( cFrame )
   LOCAL pFrame := static1 
	
	if ISNIL( cFrame )      
      //pFrame  := Static1 := oAmbiente:Frame
      pFrame  := Static1 := "’Õ∏≥æÕ‘≥"
   else
      pFrame := Static1 := cFrame
   endif
   return( pFrame )   
endef
	
*==================================================================================================*

def m_title( cTitulo )
   LOCAL pTitulo := Static2
	
   if (IsNil( cTitulo ))
      return Static2
   else
      Static2 := cTitulo
   endif
   return( pTitulo )
endef

*==================================================================================================*

def m_data( Arg1, Arg2 )
   local Local1 := Nil
	
   if (ISNIL(Arg1) .AND. ISNIL(Arg2))
      return Static3
   endif
   if (Arg1 < 1 .OR. Arg1 > 32)
      return -1
   endif
   if (ISNIL(Arg2))
      Local1:= Static3[Arg1]
   else
      Local1:= Static3[Arg1]
      Static3[Arg1]:= Arg2
   endif
   return Local1
endef

*==================================================================================================*

def m_datasave()
   return Static3
endef

*==================================================================================================*
	
def m_datarest( Arg1 )
   Static3 := aclone(Arg1)
   return Nil
endef

*==================================================================================================*

def BoxConf( nRow, nCol, nRow1, nCol1 )
	LOCAL PBack
	LOCAL Exceto	 := .F.
	LOCAL Ativo 	 :=  1
	LOCAL cCor		 := 112
	LOCAL nComp 	 := ( nCol1 - nCol )-1

	Box( nRow, nCol, nRow1, nCol1, M_Frame() + " ", 112, 1, 8 ) // Funcky
	Print( nRow, nCol, '⁄', 127, 1 )
	Print( nRow, nCol+1, Repl('ƒ',nComp), 127 )
	For x := nRow+1 To nRow1
		Print( x, nCol, '≥', 127, 1 )
	Next
	Print( nRow1, nCol, '¿',  127,1 )
	SetColor("N/W,W+/R")
	return NIL
endef	

*==================================================================================================*

def SaidaParaRedeCups()   
	LOCAL cDir     := oAmbiente:xBaseTxt	
   LOCAL xArquivo := ""
	
   xArquivo           := TrimStr(FTempPorExt('txt', cDir))
	oAmbiente:cArquivo := xArquivo
   oAmbiente:Spooler  := true
	Set Print To (xArquivo)	   	
	return true
endef

*==================================================================================================*
def PickAviso(cvar, cmsg)
   return if(Empty(cvar), ( ErrorBeep(), Alerta(cMsg ), false ), true )
endef

*==================================================================================================*

def MsMemoEdit( cString, cTitulo, nTop, nLeft, nBottom, nRight )
   LOCAL cScreen := SaveScreen()
           
   Mabox(nTop, nLeft, nBottom, nRight, cTitulo)
   cString = MemoEdit(cString, nTop+1, nLeft+1, nBottom-1, nRight-1)
   Restela(cScreen)
   return true
endef   

*==================================================================================================*

def SaidaParaEmail()
	LOCAL GetList	:= {}
   LOCAL cScreen	:= SaveScreen()
	LOCAL cDir     := oAmbiente:xBaseTxt
	LOCAL xArquivo := ""
	
	oMenu:Limpa()	
   xArquivo           := TrimStr(FTempPorExt('txt', cDir))	
   oAmbiente:SendMail := true
   oAmbiente:cArquivo := xArquivo
	oAmbiente:Spooler  := true   
	Set Print To (xArquivo)	
	ResTela( cScreen )
	return true
endef

def SendMail()
	LOCAL cScreen	:= SaveScreen()
	LOCAL GetList	:= {}
	LOCAL cDir     := oAmbiente:xBaseTxt
	LOCAL xArquivo := oAmbiente:cArquivo
	LOCAL cTo		:= "vcatafesta@sybernet.com.br" + Space(40)
	LOCAL cFrom 	:= oIni:ReadString('sistema', 'email', "vcatafesta@gmail.com" + Space(40))
	LOCAL cSubject := 'Arquivo em Anexo:' + xArquivo
	LOCAL xServer	:= oIni:ReadString('sistema','smtp', 'SMTP.MICROBRAS.COM.BR' + Space(19))
	LOCAL xString
   LOCAL cString
	LOCAL i

	oMenu:Limpa()		
	MaBox( 15, 00, 21, 79, "NOVA MENSAGEM")
	@ 16, 01 Say "Para     : " Get cTo      Valid PickAviso(cTo, "Ooops!: Vai enviar para quem ?")
	@ 17, 01 Say "De       : " Get cFrom    Valid if(Empty(cFrom),    ( ErrorBeep(), Alerta("Ooops!: Nao vai dizer o email de quem enviou ?"), false ), true )
	@ 18, 01 Say "Anexo    : " Get xArquivo Valid PickTemp( @xArquivo)
	@ 19, 01 Say "Assunto  : " Get cSubject Valid if(Empty(cSubject), ( ErrorBeep(), Alerta("Ooops!: Entre com o Assunto!"), false ), true )
	@ 20, 01 Say "Servidor : " Get xServer  Valid if(Empty(xServer),  ( ErrorBeep(), Alerta("Ooops!: Entre com o servidor!"), false ), true )
	@ 23, 01                   Get cString  Valid MsMemoEdit( @cString, "CORPO DA MENSAGEM - CTRL+W GRAVAR", 22, 00, 30, 79, true, false)
	Read
	
	if LastKey() = K_ESC
      oAmbiente:SendMail := false     
      oAmbiente:Spooler  := false         
		oAmbiente:cArquivo := ""
      ResTela(cScreen)
      return false      
	endif
   
	cFrom 				 := AllTrim( cFrom )
	cTo					 := AllTrim( cTo )
	cSubject           := AllTrim( cSubject )
	xServer				 := AllTrim( xServer )
	
	Mensagem('Aguarde, Enviando Email.')
	/*
	xString := 'mail.bat'
	xString += ' -a ' + xArquivo
	xString += '  ' + xServer
	xString += '  ' + cFrom
	xString += '  ' + cTo
	*/
   
   #ifdef __PLATFORM__WINDOWS
      xstring := 'mail.bat'      
      i = SWPVIDMDE(OK)
      i = SWPDISMSG(OK)
      i = SWPFREEMS(640)
      i = SWPFREXMS(640)
      i = SWPSETENV(32000)
      i = SWPADDENV(2048)
      i := SWPRUNCMD( xString , 100, "", "")
   #else
      #if defined( __PLATFORM__UNIX )         
         xString := 'echo "' + (cSubject) + '"'
         xString += ' | mutt -s ' + '"' + (cSubJect) + '"'
         xString += ' -a '      + oAmbiente:cArquivo
         xString += ' -- '      + cTo         
         alert(xstring)
         ms_system( xString)
      #endif   
   #endif	
   oAmbiente:SendMail := false     
   oAmbiente:Spooler  := false         
	ResTela(cScreen)
   return true
endef

*==================================================================================================*

def SaidaParaArquivo()
	LOCAL GetList	:= {}
   LOCAL cScreen	:= SaveScreen()
	LOCAL cDir     := oAmbiente:xBaseTxt
	LOCAL xArquivo := ""
	
	oMenu:Limpa()
	xArquivo := FTempPorExt('txt', cDir) + Space(10)	
	MaBox( 15, 00, 17, MaxCol()-1 )
	@ 16, 01 Say "Visualizar no Arquivo: " Get xArquivo Pict "@!"
	Read
	
	if LastKey() = K_ESC
		if Conf("Pergunta: Cancelar Impressao ?")
			oAmbiente:cArquivo := ""
			ResTela( cScreen )
			return false
		endif	
	endif
	xArquivo           := StrTrim(xArquivo)
   oAmbiente:cArquivo := xArquivo
	oAmbiente:Spooler  := true
   oAmbiente:externo  := true
	Set Print To (xArquivo)	
	ResTela( cScreen )
	return true
endef

*==================================================================================================*	

def SaidaParaSpooler()
   LOCAL GetList	:= {}
	LOCAL cScreen	:= SaveScreen()	
	LOCAL cDir     := oAmbiente:xBaseTxt
   LOCAL xArquivo := ""

	oMenu:Limpa()
	xArquivo := FTempPorExt('txt', cDir) + Space(10)
	MaBox( 15, 00, 17, MaxCol()-1 )
	@ 16, 01 Say "Visualizar no Arquivo: " Get xArquivo Pict "@!"
	Read
	
	if LastKey() = K_ESC
		oAmbiente:cArquivo := ""
		ResTela( cScreen )
      return false
	endif
   
	xArquivo           := StrTrim(xArquivo)
   oAmbiente:cArquivo := xArquivo
	oAmbiente:Spooler  := true	
	Set Print To (xArquivo)	
	ResTela( cScreen )
   return true
endef

*==================================================================================================*
	
def SaidaParaHtml()
   LOCAL GetList	:= {}
	LOCAL cScreen	:= SaveScreen()		
	LOCAL cDir     := oAmbiente:xBaseHtm 
   LOCAL xArquivo := ""

	oMenu:Limpa()
	xArquivo := FTempPorExt('htm', cDir) + Space(10)
   MaBox( 15, 00, 17, MaxCol()-1 )
	@ 16, 01 Say "Visualizar no Arquivo: " Get xArquivo Pict "@!"
	Read
   
	if LastKey() = K_ESC
		oAmbiente:cArquivo := ""
		ResTela( cScreen )
      return false
	endif
   
   xArquivo           := StrTrim(xArquivo)
   oAmbiente:cArquivo := xArquivo
	oAmbiente:Spooler  := true	
	oAmbiente:externo  := true
	Set Print To ( xArquivo )
	ResTela( cScreen )
   return true
endef

*==================================================================================================*

def SaidaParaUsb()
	LOCAL cScreen	:= SaveScreen()
	LOCAL GetList	:= {}
	LOCAL xArquivo := ""
	LOCAL cDir     := oAmbiente:xBaseTmp
	LOCAL i

	oMenu:Limpa()	
	xArquivo           := StrTrim(FTempPorExt('txt', cDir))
	oAmbiente:Spooler  := FALSO
	oAmbiente:cArquivo := xArquivo
	xArquivo           := AllTrim(xArquivo)
	Set Print To (xArquivo)
	i = SWPUSEEMS(OK)
	i = SWPUSEXMS(OK)
	i = SWPUSEUMB(OK)
	i = SWPVIDMDE(OK)
	i = SWPCURDIR(OK)
	i = SWPDISMSG(FALSO) // Mostrar Mensagem
	i = SWPGETKEY(FALSO) // Aguardar Tecla
	xString := "COPY /B " + xArquivo + " PRN"
	i		  := SWPRUNCMD( xString, 0, "", "" )
	ResTela( cScreen )
	return true
endef	

*==================================================================================================*

def Alerta( cString, aArray, Color )
*----------------------------------*
	__DefaultNIL(@cString, '(Pressione qualquer tecla)')	
	__DefaultNIL(@Color, oAmbiente:CorAlerta)
	__DefaultNIL(@aArray, ' Ok ')		
	return( alert( cString, aArray, ColorIntToStr(Color)))
endef	

*==================================================================================================*	

def LinhaHorizontal(nrow, ncol, nlen, ncor)	 
	LOCAL nComp  := (nLen - nCol)
	LOCAL cFrame := m_Frame()

	aprint(nRow, nCol, chr(195), nCor, 1)
	//aprint(nRow, nCol + 1, replicate(substr(cFrame, 2, 1), nComp), nCor, 1)
	aprint(nRow, nCol + 1, replicate(chr(196), nComp), nCor, 1)
	aprint(nRow, nCol + nComp + 1, chr(180), nCor, 1)
	return NIL	
endef

*==================================================================================================*
	
def boxpy(nRow, nCol, nRow1, nCol1, cFrame, nCor, titulo)
    nComp = (nCol1 - nCol)
    center = maxcol() / 2

    for x := nRow TO nRow1
        aprint(x, nCol, space(nComp), nCor, nComp)
    next		  

    aprint(nRow, nCol, left(cFrame, 1), nCor, 1)
    aprint(nRow, nCol + 1, replicate(substr(cFrame, 5, 1), nComp), nCor, 1)
    aprint(nRow, nCol1, substr(cFrame, 2, 1), nCor, 1)

    for x := nRow + 1 TO nRow1
        aprint(x, nCol, substr(cFrame, 6, 1), nCor, 1)
        aprint(x, nCol1, substr(cFrame, 6, 1), nCor, 1)
	 next
    aprint(nRow1, nCol, substr(cFrame, 3, 1), nCor, 1)
    aprint(nRow1, nCol + 1, replicate(substr(cFrame, 5, 1), nComp), nCor, 1)
    aprint(nRow1, nCol1, substr(cFrame, 4, 1), nCor, 1)
    if titulo != NIL
        aprint(nRow, nCol + 1, '', roloc(nCor), nComp)
        aprint(nRow, center, titulo, roloc(nCor), 1)
	endif
	return nil
endef

*==================================================================================================*	

def Nada(cString, lLimpaTela)
	LOCAL cScreen := SaveScreen()

	ifNil( cString, "INFO: Nada consta nos parametros informados.")
	if lLimpaTela = NIL
		oMenu:Limpa()
	endif
	ErrorBeep()
	Alerta( cString )
	return(ResTela( cScreen ))
endef	
	
*==================================================================================================*	

def AreaAnt( Arq_Ant, Ind_Ant )
	if !Empty( Arq_Ant )
		Select( Arq_Ant )
		Order( Ind_Ant )
	endif
	return nil
endef

*==================================================================================================*	

def Rep_Ok()
	LOCAL cScreen := SaveScreen()
	LOCAL cCor	  := SetColor()

	if Inkey() = 27
		Set Devi To Screen
		if Conf("Pergunta: Deseja Interromper a Tarefa ?")
			return( false )
		endif
		SetColor( cCor )
		ResTela( cScreen )
	endif
	return( true )
endef

*==================================================================================================*

def Old_Rel_Ok(cMensagem)
	LOCAL cScreen    := SaveScreen()
	LOCAL nChoice    := 2
	LOCAL nRow	     := Prow()
	LOCAL nCol	     := PCol()
   LOCAL lPrinter   := SET(_SET_PRINTER)
   LOCAL cDevice    := SET(_SET_DEVICE)
   LOCAL lConsole   := SET(_SET_CONSOLE)
   LOCAL cPrintFile := SET(_SET_PRINTFILE)
   
	if inkey() == K_ESC
      SET(_SET_PRINTER, false)
      SET(_SET_DEVICE, "SCREEN")
      SET(_SET_CONSOLE, true)
		ErrorBeep()
		if Conf("Pergunta: Deseja cancelar a impressao ?") .or. !LptOk()         			
         SET(_SET_PRINTFILE, "")
			restela( cScreen )
			break
			return false
		endif		
		restela( cScreen )
      if lPrinter
         SET(_SET_PRINTER, lPrinter)
         
         
         Set Devi To Print
         SetPrc( nRow, nCol )
      endif   
	else
		Set Print Off
		Set Devi To Scre
		if cMensagem != Nil
			oMenu:StatReg(cMensagem)
		else	
			oMenu:StatReg("REG# " + StrTrim( ++oAmbiente:nRegistrosImpressos))
		endif	
		Set Print On
		Set Devi To Print
		SetPrc( nRow, nCol )
	endif
	return( true )
endef

*==================================================================================================*

def Rel_Ok(cMensagem)
	LOCAL cScreen    := SaveScreen()
	LOCAL nChoice    := 2
	LOCAL nRow	     := Prow()
	LOCAL nCol	     := PCol()
   LOCAL lPrinter   := SET(_SET_PRINTER)
   LOCAL cDevice    := SET(_SET_DEVICE)
   LOCAL lConsole   := SET(_SET_CONSOLE)   

   if lPrinter
      SET(_SET_PRINTER, false)
      SET(_SET_DEVICE, "SCREEN")
      SET(_SET_CONSOLE, true)   
   endif   
	if inkey() == K_ESC   
		ErrorBeep()
		if Conf("Pergunta: Deseja cancelar a impressao ?") .or. !LptOk()
         CloseSpooler()
			restela( cScreen )
			break
			return false
		endif		
		restela( cScreen )      
	endif   
	if cMensagem != Nil
      oMenu:StatReg(cMensagem)
	else	
      oMenu:StatReg("REG# " + StrTrim(++oAmbiente:nRegistrosImpressos))
	endif   
   if lPrinter
      SET(_SET_PRINTER, lPrinter)
      SET(_SET_DEVICE, cDevice)
      SET(_SET_CONSOLE, lConsole)
      SetPrc( nRow, nCol )
   endif
	return true
endef

*==================================================================================================*

def LptOk()
	LOCAL cScreen
	LOCAL nComPort := 1
	LOCAL nStatus
	LOCAL lRetorno := OK
	STATI lMaluco  := FALSO
	LOCAL aAction	:= { "ERRO: IMPRESSORA FORA DE LINHA. ",;
							  "ERRO: IMPRESSORA DESLIGADA.     ",;
							  "ERRO: IMPRESSORA SEM PAPEL.     ",;
							  "ERRO: IMPRESSORA NAO CONECTADA. ",;
							  "ERRO: IMPRESSORA NAO PRONTA.    ",;
							  "OK: IMPRESSORA ONLINE NOVAMENTE."}
	LOCAL cMsg := ";;1)Verifique a impressora se ligada, cabeamento, conexoes "
			cMsg += "  e mapeamentos de rede, etc. Lembre-se que impressoras  "
			cMsg += "  mapeadas sempre estarao com status de PRONTA devido ao "
			cMsg += "  SPOOL de impressao da rede.                            "
			
			cMsg += ";2)Voce pode verificar status de online novamente. Escolha"
			cMsg += " (TENTAR).                                               "
			cMsg += ";3)Ao escolher a opcao (IMPRIMIR ASSIM MESMO) podera haver"
			cMsg += "   um travamento completo do sistema.                    "
			cMsg += ";4)Escolha (RETORNAR) para cancelar a impressÑo.          "
			
	if lMaluco 
		return( lMaluco)
	endif
   
   switch oAmbiente:Isprinter 
   case 1
   case 2
   case 3   
		nStatus := PrnStatus( oAmbiente:Isprinter )
		if !oAmbiente:Spooler
			cScreen := SaveScreen()
			oMenu:Limpa()
			WHILE !IsPrinter( oAmbiente:Isprinter )
				nStatus := PrnStatus( oAmbiente:IsPrinter )
				if nStatus = 0 // Windows sempre retorna 0
					nStatus := Iif( IsPrinter(oAmbiente:Isprinter), 6, 1)
				else
					if nStatus = -1
						nStatus := 5
					endif
				endif	
				ErrorBeep()
				nDecisao := Alerta( aAction[ nStatus] + cMsg, {"TENTAR", "IMPRIMIR ASSIM MESMO", "CANCELAR", "MAPEAR"} )
				if nDecisao = 3 .OR. nDecisao = 0
					lMaluco  := FALSO
					lRetorno := FALSO
					exit
				endif
				if nDecisao = 2
					lMaluco  := OK
					lRetorno := OK
					exit
				endif
				if nDecisao = 4
					Cls
					DosShell("CMD net")
					lMaluco  := FALSO
					lRetorno := FALSO
					exit
				endif				
			EndDo
			ResTela( cScreen )         
		endif
      exit
	case 4
	case 5
	case 6   
		nComPort := ( oAmbiente:IsPrinter - 4 )
		lRetorno := ( nStatus := FIsPrinter( nComPort ))
      exit
   otherwise
      lRetorno := true
      exit      
   endswitch
	return( lRetorno )
endef

*==================================================================================================*
	
def AbreSpooler()
*----------------*
	iif( oAmbiente:Spooler, Set( _SET_PRINTFILE, oAmbiente:cArquivo, false ), Set( _SET_PRINTFILE, "" ))
	return NULL
endef

*==================================================================================================*	

def CloseSpooler()
******************
   LOCAL cScreen	   := SaveScreen()
   LOCAL lSpooler	   := oAmbiente:Spooler
   LOCAL cTemp 	   := oAmbiente:cArquivo
   LOCAL lexterno    := oAmbiente:externo
   LOCAL lVisualizar := oAmbiente:lVisSpooler
   LOCAL cComando
   LOCAL i

   Set(_SET_PRINTFILE, "" )
   Set Print To
   
   if oAmbiente:SendMail
      oAmbiente:externo     := false
      oAmbiente:Spooler     := false
      oAmbiente:lVisSpooler := false
      SendMail()
      return nil   
   endif
   
   if lexterno
      #if defined( __PLATFORM__UNIX )
         //ms_system("gnome-terminal --command '/opt/shell.sh'");
         ms_system("nano " + cTemp)
      #else
         cComando := 'firefox.exe ' + cTemp
         cComando := "C:\Program Files\Mozilla Firefox\firefox.exe " + cTemp
         cComando := "chrome.exe " + cTemp		
         ShellRun("NOTEPAD " + cTemp )
         //ShellRun( cComando )
         /*
         i = SWPUSEEMS(OK)
         i = SWPUSEXMS(OK)
         i = SWPUSEUMB(OK)
         i = SWPCURDIR(OK)
         i = SWPVIDMDE(OK)
         //i = SWPDISMSG(OK)
         i = SWPRUNCMD( cComando, 0, "", "")
         */         
      #endif
      oAmbiente:externo := false
   else
      if lSpooler
         if lVisualizar
            oMenu:Limpa()
            oMenu:StatInf()
            oMenu:StatReg("IMPRESSO #" + StrZero( oAmbiente:nRegistrosImpressos, 7))
            M_Title( "ESC - Retorna ≥Setas CIMA/BAIXO Move")
            M_View( 00, 00, MaxRow()-1, MaxCol(), cTemp, Cor())
            //ShellRun("NOTEPAD " + cTemp )
            ResTela( cScreen )
         else
            cupsPrintFile( oAmbiente:CupsPrinter, oAmbiente:cArquivo, "Macrosoft SCI for Linux")
         endif
      endif
   endif
   //oAmbiente:cArquivo := ""
   oAmbiente:Spooler     := false
   oAmbiente:lVisSpooler := false
   return nil
endef   
	
Proc GravaDisco()
*---------------*
	LOCAL cScreen := SaveScreen()

	oMenu:Limpa()
	Mensagem("Aguarde, Gravando em Disco." )
	DbCommitAll()
	ResTela( cScreen )
	return

def Area( cArea)
*********************
	DbSelectArea( cArea )
	return NIl
endef	


   
Proc VerRelato()
****************
LOCAL cScreen := SaveScreen()
LOCAL Files := "*.*"
LOCAL Arquivo

M_Title( "Setas CIMA/BAIXO Move")
while( true )
	//Arquivo := M_PopFile( 06, 10, 22, 57, Files, Cor())
	ShellRun("NOTEPAD " + Arquivo )
	if Empty( Arquivo )
		Beep( 1 )
		ResTela( cScreen )
		Exit

	else
		cScreen1 := SaveScreen()
      M_View( 00, 00, MaxRow(), MaxCol, Arquivo, Cor())
		ShellRun("NOTEPAD " + Arquivo )
		ResTela( cScreen1 )
  endif
EndDO
return



def PickTemp(cFile)
   LOCAL cScreen := SaveScreen()
   LOCAL cDir    := oAmbiente:xBaseTxt + _SLASH_
   LOCAL Files   := cDir + '*.txt'   
   
   if !file(cFile)
      oMenu:Limpa()      
      M_Title( "Setas CIMA/BAIXO Move")			
      cFile := cDir + Mx_PopFile( 03, 10, 15, 61, Files, Cor())
      if Empty( cFile )         
         ErrorBeep()
         Alerta("Erro: O Arquivo Nao Existe. ")
         ResTela(cScreen)
         return false
      endif
      ResTela(cScreen)
   endif
   return true
endef


def Refresh()
*+-----------------------------------+*
	DbSkip(0)
	return Nil
endef	

def TravaReg( nTentativa, aRegistros )
*+-----------------------------------+*
	LOCAL cScreen := SaveScreen()
	LOCAL Restart := OK
	LOCAL lContinua
	
	hb_default(@nTentativa, 2)
	lContinua  := ( nTentativa == 0 )

	while Restart
		while (!RLock() .AND. ( nTentativa > 0 .OR. lContinua ))
			Mensagem(" Travando Registro " + AllTrim(Str( Recno())) + " no Arquivo " + Alias(), CorBox())
			if inKey(1) = K_ESC
				exit
			endif
			nTentativa--
		enddo
		if !RLock()
			if !Conf("Registro em uso. Tentar Novamente ?" )				
				ResTela( cScreen )				    
				return( false )
			endif
			ResTart    := OK
			nTentativa := 2
		else
			ResTela( cScreen )
			return( true )
		endif
	EndDo
endef	

def TravaArq()
*+-----------------------------------+*
	if Flock()
		return( true )
	endif
	while !FLock()
		ErrorBeep()
		if !Conf("Arquivo em uso em outra Estaáao. Tentar Novamente ?" )
			return( false )
		endif
		if FLock()
			return( true )
		endif
	enddo
	return( true )

def Incluiu()
*+-----------------------------------+*
	DbAppend()
	if !NetErr()
		return( true )
	endif	
	while NetErr()
		ErrorBeep()
		if !Conf("Registro em uso em outra Estaáao. Tentar Novamente ?")
			return( false )
		endif
		DbAppend()
		if !NetErr()
			return( true )
		endif
	EndDo
	return( true )

def Libera()
*+-----------------------------------+*
	//DbCommit()		   // Atualiza Buffers
	DbSkip(0)				// Refresh
	DbGoto( Recno())		// Refresh		
	DbUnLock()				// Libera Registros / Arquivos
	return Nil

def Cor( nTipo, nTemp )
****************************
	DEFAU nTipo TO 1 

	if nTemp != NIL   // Cor temporaria
		return( nTemp )
	endif	
	
	Switch nTipo
	Case 1
		return( oAmbiente:CorMenu	)
	Case 2
		return( oAmbiente:CorCabec )
	Case 3 	
		return( oAmbiente:Corfundo )
	Case 4 	
		return( oAmbiente:CorDesativada )		
	Case 5 	
		return( oAmbiente:CorLightBar )				
	Case 6 	
		return( oAmbiente:CorHotKey )				
	Case 7 	
		return( oAmbiente:CorHKLightBar )				
	Case 8 	
		return( oAmbiente:CorAlerta )				
	Case 9 	
		return( oAmbiente:CorMsg )				
	EndSwitch
	
def CorAlerta( nTipo )
***************************
ifNil( nTipo, 1 )
return( oAmbiente:CorAlerta )
	
def CorBox( nTipo )
************************
ifNil( nTipo, 1 )
return( oAmbiente:CorAlerta )

def CorBoxCima( nTipo )
***************************
ifNil( nTipo, 1 )
return( oAmbiente:CorCima )

def SetaCor( nCor, nTipo )
*******************************
LOCAL ikey
LOCAL cScreen
LOCAL CorAnt
STATIC XColor
ifNil( nTipo, 1 )
XColor := Cor( nTipo )
CorAnt := Cor( nTipo )
//M_CsrOff()
//cScreen := SaveVideo( 01, 00, LastRow()-1, LastCol())
cScreen := SaveScreen()

//M_CsrOn()
while( true )
	M_Message("Cor Atual ØØ "+ Str( XColor ) + " - Enter Para Setar ou ESCape", Cor(nTipo))
	Ikey := WaitKey( ZERO )
	if ( Ikey == 24)
		 XColor	:= Iif( XColor  == 0, 255, --XColor  )

	 elseif ( Ikey == 5)
		 XColor	:= Iif( XColor  == 255, 0, ++XColor  )

	 elseif ( Ikey == 27)
		 nCor := CorAnt
		 Exit

	 elseif ( Ikey == 13)
		  Exit

	 endif
	 nCor := XColor

ENDDO
//SetAttrib("y", nCor - 1 )
//M_CsrOff()
cScreen := SaveVideo( 01, 00, LastRow()-1, LastCol())
ResTela( cScreen )
//M_CsrOn()
return VOID

def Calc( cProc, nLine, cVar )
***********************************
LOCAL cScreen := SaveScreen()
LOCAL cColor  := Setcolor()
LOCAL GetList := {}
LOCAL cCalc   := Chr(77)+Chr(97)+Chr(99)+Chr(114)+Chr(111)+Chr(115)+Chr(111)+Chr(102)+Chr(116)+Chr(32)+Chr(67)+Chr(65)+Chr(76)+Chr(67)
LOCAL entry
LOCAL fcode
LOCAL mcode
LOCAL calcdec
LOCAL dec
LOCAL accum
LOCAL enter
LOCAL deccnt
LOCAL calcscr
LOCAL pcount
LOCAL inkey
LOCAL code
LOCAL calcclr
LOCAL rowsave
LOCAL colsave
LOCAL procname
LOCAL cFita := Space(0)
LOCAL nPos  := 3

Mabox(nPos, 45, nPos + 19, 70 )
SetColor('BG+')
StatusInf("x = *≥ˆ = /≥", "ESC-RETORNA")
MaBox( nPos+00, 45, nPos+06, 70 )
//MaBox( nPos+04, 45, nPos+06, 70 )
MaBox( nPos+19, 45, nPos+21, 70 )
Write( nPos+20, 46, "MEM")
Row := nPos + 07
WHILE Row < 17 + nPos
  @ Row, 45 TO Row + 02, 48
  @ Row, 50 TO Row + 02, 53
  @ Row, 54 TO Row + 02, 57
  @ Row, 58 TO Row + 02, 61
  @ Row, 63 TO Row + 02, 66
  @ Row, 67 TO Row + 02, 70
  Row += 03
EndDo
SetColor("GR+")
@ nPos + 08, 46 SAY "AC"
@ nPos + 08, 51 SAY " 7"
@ nPos + 08, 55 SAY " 8"
@ nPos + 08, 59 SAY " 9"
@ nPos + 08, 64 SAY " /"
@ nPos + 08, 68 SAY " R"
@ nPos + 11, 46 SAY "MR"
@ nPos + 11, 51 SAY " 4"
@ nPos + 11, 55 SAY " 5"
@ nPos + 11, 59 SAY " 6"
@ nPos + 11, 64 SAY " *"
@ nPos + 11, 68 SAY " %"
@ nPos + 14, 46 SAY "M-"
@ nPos + 14, 51 SAY " 1"
@ nPos + 14, 55 SAY " 2"
@ nPos + 14, 59 SAY " 3"
@ nPos + 14, 64 SAY " -"
@ nPos + 14, 68 SAY "CE"
@ nPos + 17, 46 SAY "M+"
@ nPos + 17, 51 SAY " 0"
@ nPos + 17, 55 SAY " ."
@ nPos + 17, 59 SAY " ="
@ nPos + 17, 64 SAY " +"
@ nPos + 17, 68 SAY "C "
entry   := 0
calcdec := 0
calcacc := 0
calcmem := 0
dec     := .F.
fcode   := "+"
code    := " "
accum   := .T.
enter   := .T.
inkey   := 13
mcode   := " "
Set Deci To 4
while( true )
  SetColor("GR+/RB,gr+/rb")
  @ nPos + 20, 40 + 11 SAY calcmem PICT "99999999999999.9999"
  SetColor("GR+/R,N/W+")
  
  if accum
	 @ nPos + 05, 40 + 07 SAY "T"
	 @ nPos + 05, 40 + 11 SAY calcacc PICT "99999999999999.9999"
	 
  else
	 @ nPos + 05, 40 + 07 SAY fcode
	 @ nPos + 05, 40 + 11 SAY entry+calcdec PICT "99999999999999.9999"
  endif
  
  inkey := InKey(0)
  code  := Chr(inkey)
  Do Case
   Case code >= "0" .AND. code <= "9"
		if enter .OR. fcode = " "
		  calcacc := 0
		  entry   := 0
		  calcdec := 0
		  fcode   := "+"
		endif
		accum := .F.
		if !dec
		  entry := entry*10+VAL(code)
		else
		  if deccnt<1000
			 calcdec=calcdec+VAL(code)/deccnt
			 deccnt=deccnt*10
		  endif
		endif
	 Case code = '.' .OR. code = ','
		accum=.F.
		dec=.T.
		deccnt=10
	 Case (code="+" .OR. code="-" .OR. code="/" .OR. code="*";
		.OR. code="R" .OR. code="%" .OR. inkey=13) .AND. mcode=" "
		accum=.T.
		nSetColor(oAmbiente:CorMenu)
		@ nPos+ 04, 51 say (entry+calcdec) PICT "99999999999999.9999"
		@ nPos+ 04, 69 say iif( inkey = 13, '=', code)
		Scroll( nPos + 01, 46, nPos + 04, 69, 1 )
				
		if inkey#13 .AND. enter
		   
		else
		  Do Case
			 Case fcode="+"
				if code="%"
				  calcacc=calcacc+calcacc*.01*(entry+calcdec)
				else
				  calcacc=calcacc+(entry+calcdec)
				endif
			 Case fcode="-"
				if code="%"
				  calcacc=calcacc-calcacc*.01*(entry+calcdec)
				else
				  calcacc=calcacc-(entry+calcdec)
				endif
			 Case fcode="*"
				calcacc=calcacc*(entry+calcdec)
			 Case fcode="/"
					if (entry+calcdec) = 0
						Accum := .F.
						CalcAcc := CalcDec := Entry := 0
						CalcMem := 0.00
						Mcode=" "
						Fcode=" "

					else
						Calcacc=calcacc/(entry+calcdec)

					endif
			 Case Upper( fcode ) = "R"
				calcacc = SQRT( calcacc )

		 EndCase
		
		if inkey = 13
		   nSetColor(oAmbiente:CorMenu)
		   @ nPos + 04, 51 say calcacc PICT "99999999999999.9999"
			@ nPos + 04, 69 say iif( inkey = 13, 'T', code)
			Scroll( nPos + 01, 46, nPos + 04, 69, 1 )
		endif
		 
		endif
		dec=.F.
		if code="%"
		  fcode=" "
		endif
		if inkey#13
		  fcode=code
		  entry=0
		  calcdec=0
		endif
	 Case Upper( code ) ="A"
		mcode="A"
	 Case Upper( code ) ="M"
		mcode="M"
	 Case Upper( code ) ="C" .AND. mcode = " "
		mcode="C"
	 Case Upper( code ) ="C" .AND. mcode="A"
		accum=.T.
		calcacc=0
		calcdec=0
		entry=0
		calcmem=0.00
		mcode=" "
		fcode=" "
	 Case Upper ( code ) ="C" .AND. Upper( mcode ) ="M"
		calcmem=0.00
		mcode=" "
	 Case Upper( code ) = "E" .AND. Upper( mcode ) ="C"
		entry=0
		calcdec=0
		dec=.F.
		mcode=" "
		accum=.F.
		fcode=" "
	 Case Upper( mcode ) ="C" .AND. inkey=13
		entry=0
		calcdec=0
		calcacc=0
		dec=.F.
		mcode=" "
		fcode=" "
		accum=.T.
	 Case Upper( code ) ="R" .AND. Upper( mcode ) ="M"
		entry=calcmem
		accum=.F.
		dec=.F.
		mcode=" "
	 Case code="-" .AND. Upper( mcode ) = "M"
		calcmem=calcmem-calcacc
		mcode=" "
		calcdec=0
		entry=0
		fcode=" "
		accum=.T.
	 Case code="+" .AND. Upper( mcode ) ="M"
		calcmem=calcmem+calcacc
		mcode=" "
		calcdec=0
		entry=0
		fcode=" "
		accum=.T.
	 Case Upper( code ) = "X"
		 Set Deci To 2
		 SetColor( cColor )
		 ResTela( cScreen )
		 Keyb Chr( K_CTRL_Y ) + AllTrim(Str( CalcAcc )) + Chr( K_UP ) + Chr( K_DOWN )
		 return
	 Case inkey = 27
		 Set Deci To 2
		 SetColor( cColor )
		 ResTela( cScreen )
		 return
	 OtherWise
		ErrorBeep()
  EndCase
  enter=.f.
  if inkey=13
	  enter=.T.
  endif
  
  
EndDo
Set Deci To 2
SetColor( cColor )
ResTela( cScreen )
return Nil

def Abre( nRow1, nCol1, nRow2, nCol2 )
********************************************
LOCAL nMeio1 := Round(( nCol2 - nCol1 )  / 2,0)
LOCAL nMeio2 := Round(( nCol2 - nCol1 )  / 2,0)
SetColor("W+/B")
For _X := nMeio2 To nCol2
	Scroll( nRow1+1, nMeio1+1, nRow2-1, nMeio2, 0 )
	@ nRow1, nMeio1 To nRow2, nMeio2
	nMeio1 := Iif( nMeio1 = nCol1, nMeio1, --nMeio1 )
	nMeio2 := Iif( nMeio2 = nCol2, nMeio1, ++nMeio2 )

Next
return Nil


def CabecRel( cNomefir, nTam, nPagina, cSistema, cRelatorio, cCabecalho )
******************************************************************************
Write(01 , 00, Padr( "Pagina Nß " + StrZero( nPagina, 3 ), ( nTam/2 ) ) + Padl( Time(), ( nTam/2 ) ) )
Write(02 , 00, Date() )
Write(03 , 00, Padc( cNomefir, nTam ) )
Write(04 , 00, Padc( cSistema, nTam ) )
Write(05 , 00, Padc( cRelatorio, nTam ) )
Write(06 , 00, Repl( SEP, nTam ) )
Write(07 , 00, cCabecalho )
Write(08 , 00, Repl( SEP, nTam ) )
return Nil

def Ascii()
*****************
LOCAL cScreen := SaveScreen()
Scroll(	01, 64, LastRow()-4, 79 ) ; SetPos( 01, 64 )
DispBox( 01, 64, LastRow()-4, 79, 2 )
DevPos(	01, 73 ) ; DevOut( CHR(209) )
DevPos(	02, 66 ) ; DevOut( "Numero "+CHR(179)+" Chr" )
DevPos(	03, 64 ) ; DevOut( CHR(204)+Repl(CHR(205),8)+CHR(216)+Repl(CHR(205),5)+CHR(185) )
DispBox( 04, 73, LastRow()-5, 73, CHR(179) )
DevPos(	20, 73 ) ; DevOut( CHR(207) )
StatusInf("USE AS SETAS PARA MUDAR A TABELA ASCII", "ESC-RETORNA")
SetColor( "W,G+" )
H_T := " "
H_L := 4
H_C := 0
while H_T <> CHR(27)
	SetColor( "G+" )
	H_TEMP := H_C
	FOR H_L=4 TO 19
		DevPos( H_L, 68 ) ; DevOutPict( H_TEMP, "###" )
		DevPos( H_L, 76 ) ; DevOut( CHR(H_TEMP) )
		H_TEMP := H_TEMP+1

	NEXT
	H_L := 4
	SetColor( "W,G+" )
	H_T := " "
	WHILE AT(H_T,CHR(5)+CHR(24)+CHR(27))=0
		H_T := CHR(INKEY())

	EndDO
	Do Case
		Case H_T=CHR(05)
			  H_C := H_C-16
			  if H_C<0
				  H_C := 240
			  endif
		Case H_T=CHR(24)
			  H_C := H_C+16
			  if H_C>240
				  H_C := 0
			  endif
	ENDCase
ENDDO
RestScreen( cScreen )

def Calendario()
*********************
LOCAL cScreen := SaveScreen()
LOCAL Meses := {"JANEIRO","FEVEREIRO","MARÄO","ABRIL","MAIO","JUNHO",;
					 "JULHO","AGOSTO","SETEMBRO","OUTUBRO","NOVEMBRO","DEZEMBRO"}
Set Date Brit
Scroll( 01, 51, 17, 79 ) ; SetPos( 01, 51 )
MaBox( 01, 51, 17, 79 )
Write( 03, 51, Chr( 195 ) + Repl( Chr( 196 ), 27 ) + Chr( 180 ) )
Write( 04, 52, "Dom Seg Ter Qua Qui Sex Sab" )
Write( 05, 51, Chr( 195 ) + Repl( Chr( 196 ), 27 ) + Chr( 180 ) )
StatusInf("USE AS SETAS PARA MUDAR O MES E ANO", "ESC-RETORNA")
SetColor( "W,G+" )
H_D := H_W := Date()
H_F := Chr( InKey())
WHILE H_F <> Chr( 27 )
	  H_DIA := "1"
	  H_NME := Month(H_D)
	  H_ANO := Year(H_D)
	  H_MESEX := MESES[H_NME]
	  H_MESEX := H_MESEX+Space(9-Len( H_MESEX))
	  DevPos( 02, 54 ) ; DevOutPict( H_DIA, "##" )
	  DevPos( 02, 61 ) ; DevOut( H_MESEX )
	  DevPos( 02, 74 ) ; DevOutPict( H_ANO, "####" )
	  H_D := "01/"+LTRIM(STR(H_NME,2))+"/"+LTRIM(STR(H_ANO,4))
	  H_D := CTOD(H_D)
	  H_NSE := DOW(H_D)
	  H_D := H_D-(H_NSE-1)
	  H_L := 6
	  H_C := 52
	  FOR H_X=1 TO 42
		  if Month(H_D)<>H_NME
			  SetColor( "G+" )

			else
				SetColor( "W" )

			endif
			if H_D=H_W
				SetColor( "W+*" )

			endif
			DevPos( H_L, H_C ) ; DevOutPict( DAY(H_D), "###" )
			H_D := H_D+1
			H_C := H_C+4
			if H_C>78
				H_C := 52
				H_L := H_L+2

			endif
	  NEXT
	  H_D := "01/"+LTRIM(STR(H_NME,2))+"/"+LTRIM(STR(H_ANO,4))
	  H_D := CTOD(H_D)
	  SetColor( "W,G+" )
	  H_F := " "
	  while AT(H_F,Chr(5)+Chr(24)+Chr(19)+Chr(4)+Chr(27))=0
		  H_F := Chr(INKEY())

	  ENDDO
	  if H_F=Chr(27)
		  LOOP

	  endif
	  DO CASE
	  CASE H_F=Chr(5)
		  H_NME := H_NME+1
		  if H_NME>12
			  H_NME := 1
			  H_ANO := H_ANO+1

		  endif
		  CASE H_F=Chr(24)
			  H_NME := H_NME-1
			  if H_NME<=0
				  H_NME := 12
				  H_ANO := H_ANO-1

			  endif

		  CASE H_F=Chr(19)
			  H_ANO := H_ANO+1

		  CASE H_F=Chr(4)
			  H_ANO := H_ANO-1

		  ENDCASE
		  H_D := "01/"+LTRIM(STR(H_NME,2))+"/"+LTRIM(STR(H_ANO,4))
		  H_D := CTOD(H_D)

	  ENDDO
	  RestScreen( cScreen )
	  return Nil

def Ascan2( aArray, Variavel, PosElem )
********************************************
/* aArray := { { "01.00.0001", "FECHADURA METAL COM CHAVE", 125.00 } }
	cCodigo := "01.00.0001"
	nPos := Ascan2( aArray, cCodigo, 1 )
	if nPos = 0
		Alerta(' Produto Nao Encontrado ' )

	endif
*/

_Tam := Len( aArray )
ifNil( PosElem, 1 )
For i := 1 To _Tam
	if aArray[ i, PosElem ] == Variavel
		return( i )
	endif
Next
return( 0 )

def Confirma( cString )
****************************
return( Alerta( cString , { " Sim ", " Nao " } ) )

def ErrorBeep(lOK)
***********************
DEFAU lOk TO FALSO

//return Nil // aff, sem som
if lOk   // Good Sound
   Tone(  500, 1 )
   //Tone( 4000, 1 )
   //Tone( 2500, 1 )
else     // Bad Sound
   Tone(  300, 1 )
   //Tone(  499, 5 )
   //Tone(  700, 5 )
endif

//TONE(87.3,1)
//TONE(40,3.5)
return Nil

def Escolhe
************************************************************************************************************************
   Param Col1, Lin1, Col2, Nome_Campo, Cabecalho, aRotina, lExcecao, aRotinaAlteracao, aRotinaExclusao, lLimpaTela, lDbSeek
   LOCAL GetList := {}
   LOCAL _Atela  := SaveScreen()
   LOCAL _corant := SetColor()
   LOCAL Arq_Ant := Alias()
   LOCAL Ind_Ant := IndexOrd()
   LOCAL nMaxCol := MaxCol()
   LOCAL _Tam
   LOCAL Lin2
   LOCAL nRecno
         cCampo  := Nome_Campo
         Col1    := if( Col1 == 00, 1, Col1)   
         Col2    := if( Col2 >= 22, (MaxRow()-2), Col2)         
         nCol    := Col2
         nLin	  := Lin1+1
   PRIVA aScroll

   if ValType( Nome_Campo ) != "A"
      Cabecalho := Iif( Cabecalho = Nil, "", Cabecalho )
      if ValType( &Nome_Campo ) = "D"
         Lin2 := Lin1 + 9
      else
         nTam := Len( &Nome_Campo. )
         nCab := Len( Cabecalho )
         Lin2 := Iif( nTam >= nCab, nTam + ( Lin1 + 1 ), nCab + ( Lin1 + 1 ) )
      endif
      _Vetor1 := { Nome_Campo }
      _Vetor2 := { if ( Cabecalho = Nil, Cabecalho := .T. , Cabecalho := Upper( Cabecalho ) ) }
      if Lin2 >= nMaxCol
         Lin2 := nMaxCol
      endif
   else
      _Vetor1 := Nome_Campo
      _Vetor2 := Cabecalho
      Lin2	  := 70
   endif
   if lLimpaTela = NIL .OR. lLimpatela = OK
      oMenu:Limpa()
   endif
   MaBox( Col1, Lin1,	Col2, Lin2+2, /*Cabecalho*/ )
   MaBox( Col1, Lin1+2, Col2, Lin2+2, /*Cabecalho*/ )
   Print( Col1, Lin1+2, SubStr( oAmbiente:Frame, 1, 1 ), Cor())
   Print( Col2, Lin1+2, SubStr( oAmbiente:Frame, 5, 1 ), Cor())

   if aRotina != NIL
      if Alias() = "LISTA"
         if aRotinaAlteracao != NIL
            Print( Col2, Lin1+3, "INS _Incluir≥DEL _Excluir≥F2 _Cod Fabr≥CTRL/ALT+ENTER _Alterar", Cor( 5 ), Lin2 - (Lin1+1))
         else
            Print( Col2, Lin1+3, "INS _Incluir≥DEL _Excluir≥F2 _Cod Fabr", Cor( 5 ), Lin2 - (Lin1+1))
         endif
      else
         if aRotinaAlteracao != NIL
            Print( Col2, Lin1+3, "INS _Incluir≥DEL _Excluir≥F2 _Filtro≥CTRL/ALT+ENTER _Alterar", Cor( 5 ), Lin2 - (Lin1+1))
         else
            Print( Col2, Lin1+3, "INS _Incluir≥DEL _Excluir≥F2 _Filtro≥", Cor( 5 ), Lin2 - (Lin1+1))
         endif
      endif
   endif
   if lDbSeek != NIL
      nRecno := Recno()
   endif
   DbGoTop()
   if Eof()
      if aRotina != NIL
         if Conf("Arquivo Vazio. Deseja Incluir Registros ?")
            Eval( aRotina[1])
            AreaAnt( Arq_Ant, Ind_Ant )
         endif
      endif
   endif
   if lDbSeek != NIL
      DbGoto( nRecno )
   endif
   ScrollBarDisplay( aScroll := ScrollBarNew( Col1+1, Lin1+1, Col2-1, Roloc(Cor()),1))
   DbEdit((Col1+1), (Lin1+3), (Col2-1), (Lin2+1), _Vetor1, "MS_DbUser", OK, _Vetor2 )
   ResTela( _Atela )
   SetColor(_corant )
   return( true )
endef   

def Order( Ordem )
***********************
   Iif( Ordem = Nil , Ordem := 0,  Ordem )
   DbSetOrder( Ordem )
   DbGoTo( Recno())			 // Fixar Bug
   return( IndexOrd())
endef   

def FPrint( cString )
**************************
   return( DevOut( cString ) )
endef   

def WriteBox( Linha, Col, xString, nCor )
******************************************
   Iif( Linha	 = Nil, Linha	 := Row(), Linha )
   Iif( Col 	 = Nil, Col 	 := Col(), Col )
   Iif( xString = Nil, xString := "",    xString )
   Iif( nCor	 = Nil, nCor	 := CorBoxCima(), nCor )
   Print( Linha, Col, xString, nCor )
   return nil
endef

def TestaCgc( Var )
************************
LOCAL Matriz[12]
LOCAL i
LOCAL Df1
LOCAL Df2
LOCAL Df3
LOCAL nTam := 0

if ValType( Var ) = "N"
	Var := CpfCgcIntToStr( Var )
	nTam := Len( Var )
	if nTam <= 14
		return( TestaCpf( Var ) )
	endif
endif

/*
	cTira := StrTran( Var,	".")
	cTira := StrTran( cTira, "/")
	cTira := StrTran( cTira, "-")
	nComp := Len( AllTrim( cTira ))
	if nComp >= 14 // Cgc
		Var := Tran( Var, "99.999.999/9999-99")
	else
		Var := Tran( Var, "999.999.999-99" )
		return( TestaCpf( Var ) )
	endif
*/

if !Empty( Var ) .AND. Len( Var ) < 18
	 ErrorBeep()
	 Alerta("CGC Incorreto... Verifique." )
	 return(.F.)
endif
Var1 := StrTran( Var,  ".")
Var1 := StrTran( Var1, "/")
Var1 := StrTran( Var1, "-")
For I = 1 To 12
	Matriz[i] := Val( SubStr( Var1, I, 1))
Next

** Teste do Primeiro digito (unidade)
Df1 := 5 * Matriz[1] + 4 * Matriz[2] + 3 * Matriz[3] + 2 * Matriz[4] + 9 * Matriz[5] + ;
		 8 * Matriz[6] + 7 * Matriz[7] + 6 * Matriz[8] + 5 * Matriz[9] + 4 * Matriz[10] + ;
		 3 * Matriz[11] + 2 * Matriz[12]
Df2 := Df1 / 11
Df3 = Int( Df2 ) * 11
Resto1 := ( Df1- df3 )
if Resto1 = 0 .OR. Resto1 = 1
  Pridig := 0
else
  Pridig := ( 11 - Resto1 )
endif

** Teste do segundo digito (dezena)
DF1 := 6 * Matriz[1] + 5 * Matriz[2] + 4 * Matriz[3] + 3 * Matriz[4] + 2 * Matriz[5] + ;
		 9 * Matriz[6] + 8 * Matriz[7] + 7 * Matriz[8] + 6 * Matriz[9] + 5 * Matriz[10] + ;
		 4 * Matriz[11] + 3 * Matriz[12] + 2 * Pridig
Df2 := ( Df1/11 )
Df3 := Int( Df2 ) * 11
Resto2 := ( Df1 - Df3)
if Resto2 = 0 .OR. Resto2 = 1
  SegDig := 0
else
  SegDig := (11 - Resto2)
endif
if Pridig <> Val( SubStr( Var1,13,1)) .OR. SegDig <> Val( SubStr( Var1,14,1))
	 ErrorBeep()
	 Alerta("CGC Incorreto... Verifique." )
	 return(.F.)
else
	return(.T.)
endif

def DataExtenso( dData )
*****************************
LOCAL cString := ""
LOCAL nMes
LOCAL aMes
LOCAL aDia
LOCAL nDia
LOCAL aDecada
LOCAL nDecada
LOCAL aAno
LOCAL nAno
LOCAL aSeculo
LOCAL nSeculo
LOCAL nMenor
LOCAL nMaior
LOCAL aDecimal
LOCAL cAno
LOCAL cDia
LOCAL cMes
LOCAL cDecada
LOCAL cSeculo

aMes		:= {"janeiro","fevereiro","marco","abril","maio","junho",;
				 "julho","agosto","setembro","outubro","novembro","dezembro" }
aDia		:= {"primeiro", "segundo", "terceiro", "quarto", "quinto", "sexto", "setimo",;
				 "oitavo", "nono", "decimo"}
aDecimal := {"decimo", "vigesimo", "trigesimo" }
aSeculo	:= {"um mil novecentos ", "dois mil " }
aDecada	:= {"dez ","vinte ","trinta ","quarenta ","cinquenta ","sescenta ","setenta ","oitenta ","noventa "}
aAno		:= {"um","dois","tres","quatro","cinco","seis","sete","oito","nove" }

nSeculo	:= Val( Left( StrZero( Year( dData ), 4),1))
nDecada	:= Val( SubStr( StrZero( Year( dData ), 4), 3,1))
nAno		:= Val( Right( StrZero( Year( dData ), 4),1))
nDia		:= Day( dData )
nMes		:= Month( dData)
cAno		:= StrZero( nAno, 4)
cDia		:= StrZero( nDia, 2 )
nMenor	:= Val( Left( cDia, 1 ))
nMaior	:= Val( Right( cDia, 1 ))
cMes		:= aMes[ nMes ]

if nMenor > 0
	cString := aDecimal[nMenor] + " "
endif
if nDecada = 0
	cDecada := ""
else
	cDecada := "e " + aDecada[nDecada]
endif
if nAno = 0
	cAno := ""
else
	cAno := "e " + aAno[nAno]
endif
cSeculo := aSeculo[nSeculo]
cString += Iif( nMaior = 0, "", aDia[nMaior] + " " )
cString += "dia do mes de "
cString += cMes
cString += " do ano "
cString += cSeculo
cString += cDecada
cString += cAno
return( cString )


def DataExt1( dData )
*************************
LOCAL Mes
LOCAL MesExt

if dData = NIL .OR. ValType( dData ) != "D"
	dData := Date()
endif
Mes	 := Month( dData)
MesExt := {"Janeiro","Fevereiro","Marco","Abril","Maio","Junho",;
			  "Julho","Agosto","Setembro","Outubro","Novembro","Dezembro" }
return( StrZero( Day( dData ), 2 ) + " de "+ MesExt[ Mes ] +" de "+ Str(Year( dData ),4 ))

def Mes( dData )
*********************
LOCAL Mes
LOCAL MesExt

if dData = NIL
	dData := Date()
	Mes	:= Month( dData)
elseif ValType( dData ) = "D"
	Mes := Month( dData)
elseif ValType( dData ) = 'N'
	Mes := dData
else
	dData := Date()
	Mes	:= Month( dData)
endif
MesExt := { "Janeiro","Fevereiro","Marco","Abril","Maio","Junho",;
				"Julho","Agosto","Setembro","Outubro","Novembro","Dezembro" }
return( MesExt[ Mes ] )

def DataExt2( dData )
**************************
LOCAL Mes, MesExt, Dia

if dData = NIL .OR. ValType( dData ) != "D"
	dData := Date()
endif
Mes	 := Month( dData)
MesExt := { { "Janeiro"  , 07 },;
				{ "Fevereiro", 05 },;
				{ "Maráo"    , 09 },;
				{ "Abril"    , 09 },;
				{ "Maio"     , 10 },;
				{ "Junho"    , 09 },;
				{ "Julho"    , 09 },;
				{ "Agosto"   , 08 },;
				{ "Setembro" , 06 },;
				{ "Outubro"  , 07 },;
				{ "Novembro" , 06 },;
				{ "Dezembro" , 06 }}

Dia	 := { "Primeiro ",;
			  "Dois "    ,;
			  "Tràs "    ,;
			  "Quatro "  ,;
			  "Cinco "   ,;
			  "Seis "    ,;
			  "Sete "    ,;
			  "Oito "    ,;
			  "Nove "    ,;
			  "Dez "     ,;
			  "Onze "    ,;
			  "Doze "    ,;
			  "Trez "    ,;
			  "Quatorze "    ,;
			  "Quinze "    ,;
			  "Dezesseis "    ,;
			  "Dezessete "    ,;
			  "Dezoito "    ,;
			  "Dezenove "    ,;
			  "Vinte "    ,;
			  "Vinte e um "    ,;
			  "Vinte e dois "    ,;
			  "Vinte e tràs "    ,;
			  "Vinte e quatro "    ,;
			  "Vinte e cinco "    ,;
			  "Vinte e seis "    ,;
			  "Vinte e sete "    ,;
			  "Vinte e oito "    ,;
			  "Vinte e nove "    ,;
			  "Trinta "    ,;
			  "Trinta e um "}

return( Dia[ Day( dData ) ] + "de " + MesExt[ Mes,1 ] + " de " + Str( Year( dData ),4))


def Seta1( Row, Col )
	LOCAL cString := "Use as Setas " + Chr( 27 ) + Chr( 24 ) + Chr( 25 ) + Chr( 26 )
	LOCAL nLen	  := Len( cString )

	Row := Iif( Row = NIL, MaxRow()-5, Row )
	Col := Iif( Col = NIL, ((MaxCol()-nLen)/2), Col )
	Write( Row, Col,	cString )
	return( nil )
endef
	
def Ponto(cCampo, nTamanho)
	//  cDescricao := Space(40)
	//  @ 10, 10 Say "Descricao..." GET cDescricao Pict "@!"
	//  Read
	//  cVarPonto := Ponto( cDescricao, 40 ) // 40 eh o tamanho to CAMPO
	//  DbAppend()
	//  _Field->Descricao := cVarPonto
	return(alltrim(cCampo) + replicate(".", nTamanho - Len(alltrim(cCampo))))
endef
	
def MsgOK( String, nOK)
   __DefaultNIL(@String, "Tecle algo")
   __DefaultNIL(@nOk, true)
   return(mensagem( String, nil , nil , nil , nil, nOk ))
endef   

def Mensagem( String, Color, nLine, nCol, centralizar, nOk )
	LOCAL cScreen := SaveScreen()
	LOCAL pstrlen := len(string) + 6
	LOCAL nlinhas := strcount(';', string)
	LOCAL cFundo  := 112
	LOCAL pBack
	LOCAL Row
	LOCAL Col
	LOCAL Col2
	
	__DefaultNIL(@centralizar, true)    
	__DefaultNIL(@color, oAmbiente:CorMsg)    
   __DefaultNIL(@nOk, false)    
	Do case
		case nLine == nil .and. nLinhas = 0	
			String := SISTEM_NA1 + ";-;" + String
			AlertaPy(string, Color, centralizar, nOK)
			return(cScreen)
		case nLine == nil .and. nLinhas > 0
			String := SISTEM_NA1 + ";-;" + String
			AlertaPy(string, Color, centralizar, nOK)		
			return( cScreen )
		case nLine != nil .and. nLinhas > 0			
			AlertaPy(string, Color, centralizar, nOK)
			return(cScreen)
	endcase
	
	if oAmbiente:Visual
		MsgBox3D( String )
		return( cScreen )
	endif
	if nLine == Nil
		Row	 := ((  LastRow() + 1 ) / 2 ) - 2
		Col	 := ((( LastCol() + 1 ) - PstrLen ) ) / 2
		Col2	 := ((( LastCol() + 1 ) / 2 ) - 10 )
	else
		Row	 := nLine
		if nCol == NIL
			Col	 := ((( LastCol() + 1 ) - PstrLen ) ) / 2
			Col2	 := ((( LastCol() + 1 ) / 2 ) - 10 )
		else
			Col	 := nCol
			Col2	 := ((( LastCol() + 1 ) / 2 ) - 10 )
		endif	
	endif
	hb_default( @color, CorAlerta())

	/*
	MsBox( Row, Col, Row+4, Col+ PstrLen, Color, false )
	WriteBox( Row + 2, Col + 4, String )
	*/

	ColorSet( @cFundo, @PBack )
	Box( Row, Col, Row+4, Col+PstrLen, M_Frame() + " ", Color )
	Print( Row + 2, Col + 4, String, Color)
	return( cScreen )
endef	
    
def Mens( String, Color, nLine )
*********************************
	LOCAL cScreen := SaveScreen()
	LOCAL pstrlen := len(string) + 6
	LOCAL Row
	LOCAL Col
	LOCAL Col2

	if nLine = Nil
		Row	 := ((  LastRow() + 1 ) / 2 ) - 2
		Col	 := ((( LastCol() + 1 ) - PstrLen ) ) / 2
		Col2	 := ((( LastCol() + 1 ) / 2 ) - 10 )
	else
		Row	 := nLine
		Col	 := ((( LastCol() + 1 ) - PstrLen ) ) / 2
		Col2	 := ((( LastCol() + 1 ) / 2 ) - 10 )
	endif
	MsBox( Row, Col, Row+4, Col+ PstrLen, Color, false )
	WriteBox( Row + 2, Col + 4, String )
	return cScreen

def Senha( _Col, _Linha, _Tpalavra )
*****************************************
LOCAL GetList := {}
LOCAL Letras  := Array( _Tpalavra )
LOCAL Pass
LOCAL nTecla
LOCAL T
LOCAL P

Afill( Letras, Space( 1 ) )
DevPos( _col, _linha ) ; DevOut( Space(_Tpalavra ) )
P := 1
while( true )
	DevPos( _Col, ( (_Linha -1 ) + P ) ) ; DevOut( "" )
	nTecla := Inkey(0)
	if nTecla = 0						  // Nenhuma Tecla Pressionada
		Loop

	elseif nTecla = 8 .AND. P > 1   //	Tecla Backspace
		P--
		Letras[ P ] := Space( 1 )
		DevPos( _Col, ( ( _Linha - 1 ) + P ) ) ; DevOut( " " )
		Loop

	elseif nTecla = 13				 // Enter
		Exit

	elseif nTecla = 27				 // Esc ?
		Exit

	else
		Letras[ P ] := Upper( Chr( nTecla ) )
		DevPos( _Col,( ( _Linha -1 ) + P ) ) ; DevOut( "˛" )
		P++
		if P = _Tpalavra					// Todos os caracteres digitados ?
			Exit

		endif

	endif
EndDo
Pass := ""
For T := 1 To _Tpalavra
  Pass := Pass + Letras[ T ]
Next
return pass

def Dc_Explode( _Srow, _Scol, _Erow, _Ecol, _Title, _Rodape, lInverterCor, _Slider, _Tone )
************************************************************************************************
LOCAL _TsRow, _TsCol, _TeRow,  _TeCol, _xscrn, _a, _row, _step, _ccol,  _crow,  _buffer, _col

hb_default(@_Srow, 0)
hb_default(@_Scol, 0)
hb_default(@_Erow, MaxRow())
hb_default(@_ECol, MaxCol())
hb_default(@_Title, "")
hb_default(@_Rodape, "")
hb_default(@lInverterCor, false)
hb_default(@_Slider, 5)
hb_default(@_Tone, false)

_TsRow := _Srow + (_Erow-_Srow ) / 2
_TsCol := _Scol + (_Ecol-_Scol ) / 2
_TeRow := _TsRow
_TeCol := _TsCol

// Inicio sliding box
// ******************
if _Slider > 0
  _Crow := Row()
  _Ccol := Col()
  _Step := Iif(_Crow > _TsRow, -1, 1 )
  For _Row := _Crow To _TsRow Step _Step
	 _xScrn := SaveScreen()
	 MaBox( _Row, _Ccol, _Row + 1, _Ccol + 3,,,lInverterCor )
	 For _a := 1 To _Slider
	 Next
	 RestScreen(,,,, _xScrn)

  Next
  _Step := Iif( _Ccol > _TsCol, -5, 5 )
  For _Col := _Ccol To _TsCol STEP _Step
	  _xScrn := SaveScreen()
	  MaBox( _Row, _Col, _Row+1, _Col+3,,, lInverterCor )
	 For _a := 1 TO _Slider * 2
	 Next
	 RestScreen(,,,, _xScrn )

  Next
endif
				/*** FIM sliding box **/
				************************

if _Erow < 24 .AND. _Scol > 1
  _xScrn := SaveScreen( _Srow, _Scol-2, _Erow+1, _Ecol )

else
  _xScrn := SaveScreen( _sRow,_sCol, _eRow, _eCol )

endif
if _Tone
  ErrorBeep()

endif
WHILE _TsCol > _Scol
  MaBox( _TsRow,_TsCol, _TeRow, _TeCol,,, lInverterCor )
  _TsCol -= 4
  _TeCol += 4
  _TsRow--
  _TeRow++
  if _TsRow < _Srow
	 _TsRow := _Srow
	 _TeRow := _Erow

  endif
  if _TsCol < _Scol
	 _TsCol := _Scol
	 _TeCol := _Ecol

  endif
EndDo
if _Tone
  ErrorBeep()

endif
if !Empty(_Title )
	MaBox( _Srow, _Scol, _Erow, _Ecol, _Title, _Rodape, lInverterCor )
else
  MaBox( _Srow, _Scol, _Erow, _Ecol,,, lInverterCor )
endif
return NIl

def TestaCpf( cCpf )
*************************
LOCAL cDig
LOCAL nNumero
LOCAL nMult
LOCAL nSoma
LOCAL nProd
LOCAL nNum
LOCAL nDig
LOCAL Digito
LOCAL Var1
LOCAL Var2
LOCAL Numero
LOCAL d1
LOCAL Dig
LOCAL Soma
LOCAL Num
LOCAL Mult
LOCAL Prod
LOCAL Conta

if !Empty( cCpf ) .AND. Len( cCpf ) < 14
	 ErrorBeep()
	 Alerta("Erro: CPF incorreto." )
	 return(.F.)
endif
cCpf	  := AllTrim( cCpf )
Digito  := Right( cCpf, 2 )
Var1	  := StrTran( cCpf, "." )
Var2	  := StrTran( Var1, "-" )
Numero  := Left( Var2, 9 )

Mult	 := 1
Soma	 := 0
Prod	 := 0
Num	 := 0
Dig	 := 0
cDig	 := ""
For Conta := Len( Numero ) To 1 Step -1
	Num := Val( SubStr( Numero, Conta, 1 ) )
	Mult++
	Soma += ( Num * Mult )
Next Conta
Dig := Mod( ( Soma * 10), 11 )
if Dig >= 10
	Dig := 0
endif
d1 := Dig
Numero = Left( Var2, 10 )
Mult	 := 1
Soma	 := 0
Dig	 := 0
Prod	 := 0
Num	 := 0
For Conta := Len( Numero ) To 1 Step -1
	Num := Val( SubStr( Numero, Conta, 1 ) )
	Mult++
	Soma += ( Num * Mult )
Next Conta
Dig := Mod( ( Soma * 10), 11 )
if Dig >= 10
	Dig := 0
endif
// cDig := Left(Str( d1 ), 1 ) + Left( Str( Dig ), 1 )
if Val( Left( Digito, 1 ) ) != d1 .OR. Val( Right( Digito, 1 ) ) != Dig
	ErrorBeep()
	Alerta( "Erro: CPF invalido.")
	return(.F.)
endif
return(.T.)

def TamPagina( nTamanho )
******************************
	if XIMPRESSORA = 9 .OR. XIMPRESSORA = 10 .OR. XIMPRESSORA = 11
		return( Chr(ESC) + "&l" + StrZero( nTamanho, 3) + "P" )
	else
		return( Chr( ESC ) + "C" + Chr( nTamanho ) )
	endif
endef

def EncerraDbf( cCampo, cName, nLine )
*------------------------------------*
	SetColor("")
	Cls
	ErrorBeep()
	if cCampo = NIL
		Alert( "Erro #11: Configuracao de SCI.DBF alterada.;" + cName + ":" + StrZero( nLine, 6 ))
	else
		Alert( "Erro #11: Configuracao de SCI.DBF alterada.; Campo : " + cCampo )
	endif
	Quit
	return nil
endef

def VerExe()
*-----------*
	LOCAL cExe := Upper(NomePrograma())

	if !( XNOME_EXE $ cExe)
		if (cExe == 'SCI64.EXE')
			return nil
		endif
		SetColor("")
		Cls
		ErrorBeep()
		alert( "Erro #9: Favor renomear este aplicativo para : " + XNOME_EXE )
		Quit
	endif
	return nil
endef	

def NomePrograma()
***********************
	LOCAL cPrograma := Program()
	LOCAL nPos      := Rat("\", cPrograma)
	LOCAL nLen      := Len( cPrograma)-nPos
	LOCAL cStr      := SubStr(cPrograma, nPos+1)
return(cStr)



/*
def TimeDiff( cStartTime, cEndTime )
*****************************************
   return TimeAsString(Iif(cEndTime < cStartTime, 86400 , 0) +;
          TimeAsSeconds(cEndTime) - TimeAsSeconds(cStartTime))
endef
          
def TimeAsSeconds( cTime )
*******************************
   return VAL(cTime) * 3600 + VAL(SUBSTR(cTime, 4)) * 60 +;
          VAL(SUBSTR(cTime, 7))
endef          

def TimeAsString( nSeconds )
*********************************
   return StrZero(INT(Mod(nSeconds / 3600, 24)), 2, 0) + ":" +;
                  StrZero(INT(Mod(nSeconds / 60, 60)), 2, 0) + ":" +;
                  StrZero(INT(Mod(nSeconds, 60)), 2, 0)
endef                  
*/

def ScrollBarNew( nTopRow, nTopColumn, nBottomRow, cColorString, nInitPosition )
*************************************************************************************
	LOCAL aScrollBar := ARRAY( TB_ELEMENTS )

	aScrollBar[ TB_ROWTOP ] 	:= nTopRow
	aScrollBar[ TB_COLTOP ] 	:= nTopColumn
	aScrollBar[ TB_ROWBOTTOM ] := nBottomRow
	aScrollBar[ TB_COLBOTTOM ] := nTopColumn

	if cColorString == NIL
		cColorString := "W/N"
	endif
	aScrollBar[ TB_COLOR ] := cColorString

	if nInitPosition == NIL
		nInitPosition := 1
	endif
	aScrollBar[ TB_POSITION ] := nInitPosition
	return ( aScrollBar )
endef   

def ScrollBarDisplay( aScrollBar )
***************************************
   LOCAL cOldColor
   LOCAL nRow

   cOldColor := SETCOLOR( aScrollBar[ TB_COLOR ] )
   @ aScrollBar[ TB_ROWTOP ], aScrollBar[ TB_COLTOP ] SAY TB_UPARROW
   @ aScrollBar[ TB_ROWBOTTOM ], aScrollBar[ TB_COLBOTTOM ] SAY TB_DNARROW

   FOR nRow := (aScrollBar[ TB_ROWTOP ] + 1) TO (aScrollBar[ TB_ROWBOTTOM ] - 1)
      @ nRow, aScrollBar[ TB_COLTOP ] SAY TB_BACKGROUND
   NEXT
   SETCOLOR( cOldColor )
   return ( aScrollBar )
endef   

def ScrollBarUpdate( aScrollBar, nCurrent, nTotal, lForceUpdate )
*******************************************************************
   LOCAL cOldColor
   LOCAL nNewPosition
   LOCAL nScrollHeight := ( aScrollBar[TB_ROWBOTTOM] - 1 ) - ( aScrollBar[TB_ROWTOP] )

   if nTotal < 1
      nTotal := 1
   endif

   if nCurrent < 1
      nCurrent := 1
   endif

   if nCurrent > nTotal
      nCurrent := nTotal
   endif

   if lForceUpdate == NIL
      lForceUpdate := .F.
   endif

   cOldColor := SETCOLOR( aScrollBar[ TB_COLOR ] )

   nNewPosition := ROUND( (nCurrent / nTotal) * nScrollHeight, 0 )

   nNewPosition := Iif( nNewPosition < 1, 1, nNewPosition )
   nNewPosition := Iif( nCurrent == 1, 1, nNewPosition )
   nNewPosition := Iif( nCurrent >= nTotal, nScrollHeight, nNewPosition )

   if nNewPosition <> aScrollBar[ TB_POSITION ] .OR. lForceUpdate
      @ (aScrollBar[ TB_POSITION ] + aScrollBar[ TB_ROWTOP ]), aScrollBar[ TB_COLTOP ] SAY TB_BACKGROUND
      @ (nNewPosition + aScrollBar[ TB_ROWTOP ]), aScrollBar[ TB_COLTOP ] SAY TB_HIGHLIGHT
      aScrollBar[ TB_POSITION ] := nNewPosition
   endif
   SETCOLOR( cOldColor )
   return ( aScrollBar )
endef   

def Criptar( Pal )
***********************
   LOCAL Fra, X, L

   Fra := ""
   Tam := Len( Pal )
   FOR X := 1 TO Tam
       L := SubStr(Pal, X, 1)
       Fra += Chr(Asc(L) + 61 - 2 * X + 3 * x )
   NEXT
   return Fra
endef   

def DCriptar( Pal )
************************
   LOCAL Fra, X, L, Tam
   Fra := ""
   Tam := Len( Pal )
   FOR X := 1 TO Tam
       L := SubStr(Pal, X, 1)
       Fra += Chr(Asc(L) - 61 + 2 * X - 3 * x )
   NEXT
   return Fra
endef   

def M_Menu( ativo, Arg2, Arg3, Arg4, aMensagem )
****************************************************
LOCAL Local1[Len(Arg2)]
LOCAL Local2[Len(Arg2)]
LOCAL Local3[Len(Arg2)]
LOCAL Local4  := {}
LOCAL Local5  := {}
LOCAL Local6  := {}
LOCAL Local7  := 1
LOCAL Local8  := 1
LOCAL Local9  := 2
LOCAL Local10 := .F.
LOCAL Local11 := M_Frame()
LOCAL x 
LOCAL nLenArray
LOCAL Local14
LOCAL Local15
LOCAL Local16
LOCAL Local17
LOCAL Local18

Arg4	    := Iif( Arg4 = Nil, 0, Arg4 )
Local17   := Int(ativo)
Local18   := Iif( Arg3 == Nil, Standard(), Arg3 )
nLenArray := Len(Arg2)
Afill(Local2, Arg4)
Local3[ 1 ] := 1
//M_Csron()
//M_Csroff()
Aprint(Arg4, 0, "", Local18, Lastcol() + 1)
Local1[ 1 ] := Strextract(Arg2[ 1 ], ":", 1)
Aprint(Arg4, 1, Local1[ 1 ], Local18)
FOR x := 2 TO nLenArray
	 Local1[ x ] := Strextract(Arg2[ x ], ":", 1)
	 Local3[ x ] := Local3[ x - 1 ] + ( Aprintlen(Local1[ x - 1 ]) + 1 )
	 Aprint(Arg4, Local3[ x ], Local1[ x ], Local18)
NEXT
Local9 := Aprintlen(Local1[ x - 1 ])
//M_Csron()
WHILE ( .T. )
	 Local7 := M_Aprompt(.F., Local17, Local2, Local3, Local1, Local18, aMensagem)
	 if ( Local7 = 0 )
		  return 0.0
	 endif
	 //M_Wait(1)
	 Local14 := Chrcount(":", Arg2[ Local7 ])
	 Local17 := Local7
	 if ( Local14 < 1 )
		  if ( !Local10 )
				return Local7 + 0.0
		  else
				Local10 := .F.
				LOOP
		  endif
	 endif
	 if ( Local14 > Lastrow() - 1 )
		  Local14 := Lastrow() - 1
	 endif
	 Asize(Local4, Local14)
	 Asize(Local5, Local14)
	 Asize(Local6, Local14)
	 FOR Local12 := 1 TO Local14
		  Local4[ x ] := "  " + Strextract(Arg2[ Local7 ], ":", x + 1)
		  Local5[ x ] := x + 1 + Arg4
	 NEXT
	 Local9 := Amaxstrlen(Local4) + 2
	 if ( Local3[ Local7 ] + Local9 + 3 > Lastcol() + 1 )
		  Local15 := Lastcol() + 1 - ( Local9 + 3 )
	 else
		  Local15 := Local3[ Local7 ] + 1
	 endif
	 Afill(Local6, Local15)
	 FOR x := 1 TO Local14
		  Local4[ x ] := Untrim(Local4[ x ], Local9)
	 NEXT
	 //M_Csroff()
	 //Local16 := Savevideo(Arg4 + 1, Local15 - 3, Local14 + 3 + Arg4, Local15 + Local9 + 2)
	 Local16 := SaveScreen()
	 Box(Arg4 + 1, Local15 - 1, Local14 + 2 + Arg4, Local15 + Local9, Local11 + " ", Local18)
	 //M_Csron()
	 if ( Local8 <= 0 )
		  Local8 := 1
	 endif
	 Local8 := M_Aprompt(.T., Local8, Local5, Local6, Local4, Local18, aMensagem )
	 //M_Wait(1)
	 //M_Csroff()
	 //Restvideo(Arg4 + 1, Local15 - 3, Local14 + 3 + Arg4, Local15 + Local9 + 2, Local16)
	 ResTela( Local16 )
	 //M_Csron()
	 if ( Local8 < -1 )
		  if ( Local8 = -3 )
				Local17 := Iif( Local17 = Local13, 1, Local17 + 1 )
				//Nstuff(13)
				PutKey(13)
		  endif
		  if ( Local8 = -2 )
				Local17 := Iif( Local17 = 1, Local13, Local17 - 1 )
				//Nstuff(13)
			   PutKey(13)
		  endif
		  Local10 := .T.
		  LOOP
	 elseif ( Local8 > 0 )
		  return Local7 + Local8 / 100
	 endif
	 Local10 := .F.
END

def M_Aprompt( Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, aMensagem )
*******************************************************************************
LOCAL Local1 := .F.
LOCAL Local2 := 0
LOCAL Local3 := 0
LOCAL Local4 := {}
LOCAL Local5 := .F.
LOCAL Local6 := Lastcol() + 1
LOCAL Local7
LOCAL Local8 := Len( Arg5 )
LOCAL Local9
LOCAL Local10
LOCAL Local11 := Arg6
LOCAL x
LOCAL Local13

Colorset(@Local11, @Local7)
if ( Arg2 < 0 )
	 Local10 := 1
elseif ( Arg2 > Local8 )
	 Local10 := Local8
else
	 Local10 := Arg2
endif
Local9 := Local10
Local7 := Local7 + 256
Local4 := Array(Local8)
//M_Csroff()
FOR x := 1 TO Local8
	 Aprint(Arg3[ x ], Arg4[ x ], Arg5[ x ], Local11)
	 Local4[ x ] := Aprintlen(Arg5[ x ]) + Arg4[ x ] - 1
NEXT
Aprint(Arg3[ Local10 ], Arg4[ Local10 ], Arg5[ Local10 ], Local7)
if ( Arg7 != Nil )
	 Aprint(Arg8, 0, "", Local11, Local6)
	 Aprint(Arg8, Shr(Local6 - Aprintlen(Arg7[ Local10 ]), 1), Arg7[ Local10 ], Local11)
endif
//M_Csron()
WHILE ( .T. )
	 WHILE ( .T. )
		  WHILE ( .T. )
				Local2 := InKey()
				//if ( Local5 := _Isbutton(1) )
			   //	 EXIT
				//endif
				if ( Local2 != 0 )
					 Local13 := SetKey(Local2)
					 if ( Local13 != Nil )
						  Eval(Local13, Procname(2), Procline(2))
						  LOOP
					 else
						  EXIT
					 endif
				endif
		  END
		  Local9 := Local10
		  if ( Local5 )
				//Local3 := M_Aregion(Arg3, Arg4, Arg3, Local4)
				if ( Local3 > 0 )
					/*
					 WHILE ( _Isbutton(1) )
						  if ( Local3 > 0 )
								Local10 := Local3
						  endif
						  if ( Local9 != Local10 )
								//M_Csroff()
								Aprint(Arg3[ Local9 ], Arg4[ Local9 ], Arg5[ Local9 ], Local11)
								Aprint(Arg3[ Local10 ], Arg4[ Local10 ], Arg5[ Local10 ], Local7)
								if ( Arg7 != Nil )
									 Aprint(Arg8, 0, "", Local11, Local6)
									 Aprint(Arg8, Shr(Local6 - Aprintlen(Arg7[ Local10 ]), 1), Arg7[ Local10 ], Local11)
								endif
								//M_Csron()
								Local9 := Local10
						  endif
						  Local3 := M_Aregion(Arg3, Arg4, Arg3, Local4)
					 END
					 if ( Local3 == M_Aregion(Arg3, Arg4, Arg3, Local4) .AND. Local3 > 0 )
						  Local10 := Local3
						  Local1 := .T.
						  EXIT
					 endif
					 */
				elseif ( Arg1 .AND. !Local1 .AND. Local5 )
					 return -1
				else
					 LOOP
				endif
		  endif
		  DO CASE
		  CASE ( Local2 == 27 )
				return 0
		  CASE ( Local2 == 5 .OR. Local2 == 19 )
				Local10 := Iif( Local10 == 1, Local8, Local10 - 1 )
				EXIT
		  CASE ( Local2 == 4 .OR. Local2 == 24 )
				Local10 := Iif( Local10 == Local8, 1, Local10 + 1 )
				EXIT
		  CASE ( Local2 == 1 )
				Local10 := 1
				EXIT
		  CASE ( Local2 == 6 )
				Local10 := Local8
				EXIT
		  CASE ( Local2 < 128 .AND. Local2 > 32 )
				Local3 := Achartest(Chr(Local2), "", Arg5)
				if ( Local3 > 0 )
					 Local10 := Local3
					 Local1 := .T.
					 EXIT
				endif
		  CASE ( Local2 == 13 .OR. Local2 == 18 .OR. Local2 == 3  .OR. Local2 == 32)
				return Local10
		  OTHERWISE
				LOOP
		  ENDCASE
	 END
	 if ( Local9 != Local10 )
		  //M_Csroff()
		  Aprint(Arg3[ Local9 ], Arg4[ Local9 ], Arg5[ Local9 ], Local11)
		  Aprint(Arg3[ Local10 ], Arg4[ Local10 ], Arg5[ Local10 ], Local7)
		  if ( Arg7 != Nil )
				Aprint(Arg8, 0, "", Local11, Local6)
				Aprint(Arg8, Shr(Local6 - Aprintlen(Arg7[ Local10 ]), 1), Arg7[ Local10 ], Local11)
		  endif
		  //M_Csron()
	 endif
	 if ( Arg1 .AND. Local2 == 19 )
		  return -2
	 endif
	 if ( Arg1 .AND. Local2 == 4 )
		  return -3
	 endif
	 if ( Local1 )
		  return Local10
	 endif
END

def ColorSet( pfore, pback, pUns )
***************************************
	if pfore == nil 
		 pfore := Standard()
		 pback := Enhanced()
		 puns  := ColorUnselected()
		 
	elseif pfore < 0 
		 pfore := Standard()
		 pback := Enhanced()
		 puns  := ColorUnselected()
	else
		 pback := Roloc(pfore)
	endif
	return( nil )

def CTBA( Lin, Col )
*************************
STATIC nColor := 31
       nColor++
		
if nColor >= 256
   nColor := 31
endif	
//FT_CLS(00,00,MaxRow(),MaxCol(),nColor)

Print( Lin,	   Col, " ⁄ƒƒƒƒƒø    ⁄ƒƒƒƒƒø  ⁄ƒø",nColor)
Print( Lin+01, Col, " ﬂﬂﬂﬂﬂﬂ¿ø   ﬂﬂﬂﬂﬂﬂ¿ø ﬂﬂ≥",nColor)
Print( Lin+02, Col, "ﬂﬂﬂﬂﬂﬂﬂﬂ≥  ﬂﬂﬂﬂﬂﬂﬂﬂ≥ ﬂﬂ≥",nColor)
Print( Lin+03, Col, "ﬂﬂ≥   ﬂﬂŸ  ﬂﬂ≥   ﬂﬂŸ ﬂﬂ≥",nColor)
Print( Lin+04, Col, "ﬂﬂ¿ƒƒƒƒø   ﬂﬂ≥       ﬂﬂ≥",nColor)
Print( Lin+05, Col, "ﬂﬂﬂﬂﬂﬂﬂ¿ø  ﬂﬂ≥       ﬂﬂ≥",nColor)
Print( Lin+06, Col, " ﬂﬂﬂﬂﬂﬂﬂ≥  ﬂﬂ≥       ﬂﬂ≥",nColor)
Print( Lin+07, Col, "      ﬂﬂ≥  ﬂﬂ≥       ﬂﬂ≥",nColor)
Print( Lin+08, Col, "ﬂﬂƒƒƒƒﬂﬂ≥  ﬂﬂ¿ƒƒƒﬂﬂ≥ ﬂﬂ≥",nColor)
Print( Lin+09, Col, "ﬂﬂﬂﬂﬂﬂﬂﬂŸ  ﬂﬂﬂﬂﬂﬂﬂﬂŸ ﬂﬂ≥",nColor)
Print( Lin+10, Col, " ﬂﬂﬂﬂﬂﬂŸ    ﬂﬂﬂﬂﬂﬂŸ  ﬂﬂŸ",nColor)
if ( InKey(0.05) != 0 )
	return(OK)
endif
return(FALSO)

def Protela()
******************
LOCAL nY
LOCAL nX
LOCAL LOCAL5  := Setcursor()
LOCAL row     := Row()
LOCAL col     := Col()
LOCAL cScreen := SaveScreen()
LOCAL nMaxCol := MaxCol()-24
LOCAL nMaxRow := MaxRow()-11
LOCAL nColor  := 31
LOCAL cNewScreen

 
nSetColor( nColor, Roloc(nColor))
cSetColor( SetColor())
Cls
cNewScreen := SaveScreen()
Setcursor(0)

WHILE OK
   For nX := 0 To nMaxCol
		  //ResTela(cNewScreen)
		if Ctba(0, nX)
		   ResTela(cScreen)
			DevPos(row,col)
			SetCursor(1)
			return nil
      endif
	 Next
	 For nY := 0 To nMaxRow
	     //ResTela(cNewScreen)
		  if Ctba(nY, nMaxCol )
   	     ResTela(cScreen)
	  		  SetCursor(1)
			  DevPos(row,col)
			  return nil
		  endif
	 Next
	 For nX := nMaxCol To 0 Step -1
		  //ResTela(cNewScreen)
		  if Ctba(nMaxRow, nX)
   		   ResTela(cScreen)
				SetCursor(1)
				DevPos(row,col)
				return nil
		  endif
	 Next
	 For nY := nMaxRow To 0 Step -1
	     //ResTela(cNewScreen)
		  if ctba(nY, 0)
				ResTela(cScreen)
				SetCursor(1)
				DevPos(row,col)
				return nil
		  endif
	 Next
End
ResTela(cScreen)
SetCursor(1)
DevPos(row,col)
return nil

def MsBox( nCol, nRow, nCol1, nRow1, nCor, lRelevo, cTexto )
*+----------------------------------------------------------*
	LOCAL cFrame  := oAmbiente:Frame
	LOCAL nRetVal
	LOCAL PBack
	LOCAL aCor
	LOCAL aFundo
	LOCAL aCima
	LOCAL cCor
	if lRelevo // Alto Relevo
	  aCor	  := { 16,32,48,64,64,80,096,112,128,144,160,176,192,208,224 }
	  aFundo   := { 16,32,48,64,64,80,096,112,128,144,160,176,192,208,224 }
	  aCima	  := { 25,47,53,76,64,86,101,117,143,149,165,181,207,213,239 }
	else
	  aCor	  := { 25,47,53,76,64,86,101,117,143,149,165,181,207,213,239 }
	  aFundo   := { 25,47,53,76,64,86,101,117,143,149,165,181,207,213,239 }
	  aCima	  := { 16,32,48,64,64,80,096,112,128,144,160,176,192,208,224 }
	endif
	if nCor = NIL
		nCor	 := CorBox()
	endif
	cCor					:= aCor[nCor]
	oAmbiente:CorCima := aCima[ nCor ]
	nComp 				:= ( nRow1 - nRow )-1
	ColorSet( @cCor, @PBack )
	M_Frame( cFrame )
	Box( nCol, nRow, nCol1, nRow1, M_Frame() + " ", aFundo[ nCor], 1, 8 )
	cFrame1 := Left( cFrame, 1 )
	cFrame2 := SubStr( cFrame, 2, 1 )
	cFrame8 := SubStr( cFrame, 8, 1 )
	cFrame7 := SubStr( cFrame, 7, 1 )
	Print( nCol, nRow, cFrame1, aCima[nCor], 1 )
	Print( nCol, nRow+1, Repl( cFrame2, nComp), aCima[nCor] )
	For x := nCol+1 To nCol1-1
		Print( x, nRow, cFrame8, aCima[nCor], 1 )
	Next
	Print( nCol1, nRow, cFrame7,	aCima[nCor],1 )
	if cTexto != NIL
		Print( nCol+1, nRow+1, Padc( cTexto, nRow1-nRow-1), aCima[nCor] )
	endif
	cSetColor( SetColor())
	nSetColor( cCor, Roloc( cCor ))
	return NIL

def MsAlerta( Texto, aArray, PosVertical, lRelevo )
********************************************************
	LOCAL nRetVal
	LOCAL PBack
	LOCAL Telavelha	 := SaveScreen()
	LOCAL nCor			 := CorBox()
	LOCAL Exceto		 := .F.
	LOCAL Ativo 		 :=  1
	LOCAL cFrame		 := "⁄ƒø≥Ÿƒ¿≥"
	LOCAL TamanhoTexto := Len( Texto ) + 2
	LOCAL aCor
	LOCAL aFundo
	LOCAL cCor
	LOCAL aCima
	LOCAL nTam			 := 0
	LOCAL aCol			 := {}
	LOCAL aRow			 := {}
	LOCAL nLenArray

	if oAmbiente:Visual
		return( Alerta( Texto, aArray ))
	else
		lRelevo		 := Iif( lRelevo = NIL, FALSO, lRelevo )
		if lRelevo // Alto Relevo
		  aCor	  := { 16,32,48,64,64,80,096,112,128,144,160,176,192,208,224 }
		  aFundo   := { 16,32,48,64,64,80,096,112,128,144,160,176,192,208,224 }
		  aCima	  := { 25,47,53,76,69,91,101,117,133,149,165,181,207,213,239 }
		else
		  aCor	  := { 25,47,53,76,69,91,101,117,133,149,165,181,207,213,239 }
		  aFundo   := { 25,47,53,76,69,91,101,117,133,149,165,181,207,213,239 }
		  aCima	  := { 16,32,48,64,64,80,096,112,128,144,160,176,192,208,224 }
		endif
		aArray	  := Iif( aArray = NIL, { " ƒŸ Okay " }, aArray )
		nLenArray  := Len( aArray )
		For nX  := 1 To nLenArray
			nTam += Len( aArray[nX] ) + 1
		Next
		cCor			 := aCor[nCor]
		TamanhoTexto := Iif( TamanhoTexto < nTam, nTam, TamanhoTexto )
		TamanhoTexto := Iif( TamanhoTexto < 16, 16, TamanhoTexto )
		PosVertical  := Iif( PosVertical = Nil .OR. PosVertical = 0, 11, PosVertical )
		nEsquerda	 := (80-TamanhoTexto)/2
		nComprimento := nEsquerda + TamanhoTexto
		nTexto		 := Len( Texto )
		nPosTexto	 := nEsquerda + ((TamanhoTexto - nTexto) / 2) + 1
		nCima 		 := PosVertical - 2
		nBaixo		 := PosVertical + 2
		nDireita 	 := nComprimento
		nLen			 := 1
		nSobra		 := ( TamanhoTexto - nTam ) / nLenArray
		For nX  := 1 To nLenArray
			Aadd( aRow, nBaixo-1 )
			Aadd( aCol, (nEsquerda+nSobra+nLen))
			nLen += Len(aArray[nX])+1
		Next
		Coluna		 := (TamanhoTexto - 9 ) / 2
		nRow			 := PosVertical + 2
		nCol			 := nEsquerda + Coluna
		nBot			 := PosVertical + 3
		nComp 		 := ( nComprimento - nEsquerda )-1

		ColorSet( @cCor, @PBack )
		M_Frame( cFrame )
		Box( nCima, nEsquerda, nBaixo, nDireita, M_Frame() + " ", aFundo[ nCor], 1, 8 )
		Print( nCima, nEsquerda, '⁄', aCima[ nCor ], 1 )
		Print( nCima, nEsquerda+1, Repl('ƒ',nComp), aCima[nCor] )
		For x := nCima+1 To nBaixo
			Print( x, nEsquerda, '≥', aCima[nCor], 1 )
		Next
		Print( nBaixo, nEsquerda, '¿',  aCima[nCor],1 )
		aPrint( nCima + 1, nPosTexto, Texto, aCima[nCor])
		nRetVal := M_Prompt( Exceto, Ativo, aRow, aCol, aArray, aFundo[nCor] )
		ResTela( TelaVelha )
		return( nRetVal )
	endif

def EXPLODE( Arg1, Arg2, Arg3, Arg4, Arg5, Arg6 )
******************************************************
Local Local1, Local2, Local3, Local4, Local5
Local2 := Arg4 - Arg2 + 1
Local2 := Int((Local2 - 2) / 2)
Arg2	 := Arg2 + Local2
Arg4	 := Arg4 - Local2
//box( Arg1, Arg2, Arg3, Arg4, Arg5, Arg6 )
For Local3 := 1 To Local2
	Local5  := 0
	For Local4 := 1 To 100
		Local5++
	Next
	Box( Arg1, Arg2 - Local3, Arg3, Arg4 + Local3, Arg5, Arg6 )
Next
return Nil

def AddButton(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9)
************************************************************************
Local Local1
Arg5	 := Iif(At("&", Arg5) == 0, "&" + Arg5, Arg5)
Arg7	 := Iif(ISNIL(Arg7), .F., Arg7)
Arg8	 := Iif(ISNIL(Arg8), { || nret() }, Arg8)
Arg9	 := Iif(ISNIL(Arg9), .T., Arg9)
Local1 := SubStr(Arg5, At("&", Arg5) + 1, 1)
AAdd(Arg1, {Arg5, Arg6, Arg8, Arg9, Arg7, Arg2, Arg3, Local1, Arg4})
return Nil

********************************
def NINKEY(Arg1)

	Local Local1, Local2, Local3
	Do While (.T.)
		Local1:= .F.
		if (Arg1 = Nil)
			Local2:= InKey()
		else
			Local2:= InKey(Arg1)
		endif
		if (Local2 != 0 .AND. (Local3:= SetKey(Local2)) != Nil)
			eval(Local3, procname(2), procline(2), "")
			Local1:= .T.
		endif
		if (!Local1)
			Exit
		endif
	EndDo
	return Local2

def NRET
********
	return Nil

def VISUALCLOCK
****************
	Local Local1, Local2
	Local2:= 0
	setcursor(0)
	Local1:= win(10, 28, 13, 51, "Rel¢gio - " + DToC(Date()), ;
		"W+*/B", "B+*/W")
	Do While (Local2 == 0)
		@ 12, 36 Say Time() Color "N*/W"
		Local2:= InKey(1)
	EndDo
	rstenv(Local1)
	return Nil

def CHKPRN
****************
	Local Local1
	Local1:= .T.
	Do While (!Fisprinter())
		if (msgbox2("Impressora nÑo preparada. Continuar ?") == 2)
			Local1:= .F.
			Exit
		endif
	EndDo
	return Local1


Procedure NSCREEN


def THE_END
********************************
	Local Local1, Local2
	Local1:= {padc("Analyze Tecnologia em Sistemas Ltda", 54), ;
		Replicate(" ", 54), ;
		padc("Rua Sophie Delamain, 114 - Belvedere", 54), ;
		padc("CEP: 13.600-000  Araras (SP)", 54), Replicate(" ", 54), ;
		padc("Fone: (0195) 41-6760 - Fax: (0195) 41-7606", 54), ;
		Replicate(" ", 54), padc("Todos os direitos reservados", 54), ;
		Replicate(" ", 54), Replicate(" ", 54), Replicate(" ", 54), ;
		Replicate(" ", 54), Replicate(" ", 54), Replicate(" ", 54)}
	Local2:= t:= x:= 0
	Set Color To N/W
	Clear Screen
	deskbox(0, 2, 24, 77, 2)
	deskbox(2, 7, 22, 72, 1)
	frame(4, 10, 6, 69, Nil, Nil, 2)
	frame(7, 10, 15, 69, Nil, Nil, 2)
	frame(16, 10, 20, 69, Nil, Nil, 2)
	@	5, 13 Say ;
		padc("Visual Lib - Biblioteca para design de interface", 54) ;
		Color "B/W"
	linbutton1(.F., 1, 18)
	Do While (.T.)
		if (Local2 == 14)

		else
			++Local2
		endif
		Local2:= Nil
		Scroll(8, 12, 14, 68, 1)
		@ 14, 13 Say Local1[Local2] Color Iif(Local2 == 1 .OR. Local2 ;
			== 8, "R/W", "N/W")
		InKey(0.5)
		t:= LastKey()
		if (t == 13 .OR. t == 27 .OR. Upper(Chr(t)) == "O")
			Exit
		endif
	EndDo
	Keyboard Chr(13)
	linbutton1(.T., 1, 18)
	setblink(.T.)
	Set Color To
	setmode(25, 80)
	Clear Screen
	Close Databases
	Quit
	return Nil

Procedure NBUTTON
*+------------------------------------------------------------------------------------------------+*

def NewButton()
*+------------------------------------------------------------------------------------------------+*
	return {}

def SHOWBUTTON(Arg1, Arg2)
*+------------------------------------------------------------------------------------------------+*
	aeval(Arg1, { |_1| drawbutton(_1, Arg2) })
	return Nil

Procedure NMISC2
*+------------------------------------------------------------------------------------------------+*

def DRAWBUTTON(Arg1, Arg2, Arg3, Arg4, Arg5)
*+------------------------------------------------------------------------------------------------+*
	Local Local1, Local2, Local3, Local4, Local5, Local6, Local7, ;
			Local8, Local9, Local10, Local11, Local12, Local13, Local14, ;
			Local15, Local16, Local17, Local18, Local19, Local20, Local21
	Arg3:= Iif(ISNIL(Arg3), 1, Arg3)
	Arg4:= Iif(ISNIL(Arg4), .T., Arg4)
	Arg5:= Iif(ISNIL(Arg5), .T., Arg5)
	Local10:= textbutton(Arg1[1])
	if (Arg2 == 1)
		Local1:= "N/W"
		Local2:= Iif(Arg5, "W*/N", "N*/N")
		Local3:= "W+*/N"
		Local4:= "W*/N"
		Local6:= "W+*/N"
		Local7:= "N+*/N"
		Local9:= Iif(Arg1[4], "GR+*/N", "W*/N")
	elseif (Arg2 == 2)
		Local1:= "N*/W"
		Local2:= Iif(Arg5, "W+/W", "N+/W")
		Local3:= "N/W"
		Local4:= "N+/W"
		Local6:= "N/W"
		Local7:= "W/W"
		Local9:= Iif(Arg1[4], "W+/W", "N+/W")
	endif
	if (Arg3 == 1)
		Local10:= padc(Local10, Arg1[9] - 3)
		Local11:= At(Upper(Arg1[8]), Upper(Local10)) - 1
		Local5:= Iif(Arg1[4], Local3, Local4)
		Local8:= Local7
	elseif (Arg3 == 2)
		Local10:= padc(Local10, Arg1[9] - 3)
		Local11:= At(Upper(Arg1[8]), Upper(Local10)) - 1
		Local5:= Iif(Arg1[4], Local3, Local4)
		Local8:= Local6
	elseif (Arg3 == 3)
		Local10:= " " + Left(padc(Local10, Arg1[9] - 3), Arg1[9] - 4)
		Local11:= At(Upper(Arg1[8]), Upper(Local10)) - 1
		Local5:= Iif(Arg1[4], Local3, Local4)
		Local8:= Local6
	endif
	Local20:= At(alltrim(Local10), Local10) - 1
	Local21:= Local20 + Len(Arg1[1]) + 2
	if (Arg4)
		Local12:= "’"
		Local13:= Iif(Arg5, "“", "◊")
		Local14:= "∑"
		Local15:= "∂"
		Local16:= "Ω"
		Local17:= "–"
		Local18:= "”"
		Local19:= "«"
	else
		Local12:= "÷"
		Local13:= Iif(Arg5, "—", "ÿ")
		Local14:= "∏"
		Local15:= "µ"
		Local16:= "æ"
		Local17:= "œ"
		Local18:= "‘"
		Local19:= "∆"
	endif
	@ Arg1[6] - 1, Arg1[7] Say Local12 + Replicate(Local13, Arg1[9] - 2) + Local14 Color Local1
	@ Arg1[6], Arg1[7] Say Local19 Color Local1
	@ Arg1[6], Arg1[7] + 1 Say "∂" Color Local2
	@ Arg1[6], Arg1[7] + 2 Say Local10 Color Local5
	@ Arg1[6], Arg1[7] + 2 + Local11 Say Arg1[8] Color Local9
	@ Arg1[6], Arg1[7] + Arg1[9] - 1 Say Local15 Color Local1
	@ Arg1[6] + 1, Arg1[7] Say Local18 + Replicate(Local17, Arg1[9] - 2) + Local16 Color Local1
	@ Arg1[6], Arg1[7] + Local20 Say "Ú" Color Local8
	@ Arg1[6], Arg1[7] + Local21 Say "Û" Color Local8
	return Nil


def SAVENV(Arg1, Arg2, Arg3, Arg4)
*+---------------------------------+*
	Local Local1
	Local1:= {}
	AAdd(Local1, Arg1)
	AAdd(Local1, Arg2)
	AAdd(Local1, Arg3)
	AAdd(Local1, Arg4)
	AAdd(Local1, SaveScreen(Arg1, Arg2, Arg3, Arg4))
	AAdd(Local1, SetColor())
	AAdd(Local1, setcursor())
	return Local1

def RSTENV(Arg1)
*+---------------------------------+*
	RestScreen(Arg1[1], Arg1[2], Arg1[3], Arg1[4], Arg1[5])
	Set Color To (Arg1[6])
	setcursor(Arg1[7])
	return Nil

def DWNMSG(Arg1)
*+---------------------------------+*

	@ 23,  1 Say padc(Arg1, 78) Color "R*/W"
	return .T.

def QEXIT(Arg1, Arg2, Arg3, Arg4)
*+---------------------------------+*
	Local Local1
	Local1:= savenv(33, 0, 33, 79)
	Arg4:= Iif(ISNIL(Arg4), .T., Arg4)
	if (!Arg4)
		Close Databases
		setblink(.T.)
		setmode(25, 80)
		Set Color To
		Clear Screen
		Quit
	elseif (msgbox2("Confirma o encerramento ?", "Sa°da", Nil, Nil, ;
			Nil, Nil, 2) == 1)
		Close Databases
		setblink(.T.)
		setmode(25, 80)
		Set Color To
		Clear Screen
		Quit
	endif
	rstenv(Local1)
	return Nil

def GINS
*+---------------------------------+*
	readinsert(.T.)
	setcursor(2)
	SetKey(K_INS, { || (Iif(readinsert(), setcursor(1), ;
	setcursor(2)), readinsert(!readinsert())) })
	return Nil

def DRAWFN( nTipo, cString, nRow, nCol, cColor )
*+----------------------------------------------+*
	LOCAL aFuncao := { 1, 9, 17, 25, 33, 41, 49, 57, 65, 73 }
	cColor := Iif(ISNIL( cColor ), Cor(2), cColor )
	nRow	 := Iif(ISNIL( nRow	 ), 24,	  nRow )
	nCol	 := Iif(ISNIL( nCol	 ), aFuncao[nTipo]-1, nCol )
	@ nRow, nCol+1 Say Left( cString, 7 ) Color AttrToa( cColor )
	@ nRow, nCol	Say Chr(223 + nTipo )  Color AttrToa( cColor )
	return Nil

def PROCBUTTON( Arg1, Arg2, Arg3)
*+----------------------------------------------+*
	Local Local1:= 0, Local2:= setcursor(0), Local3:= 0
	Arg2:= Iif(ISNIL(Arg2), 1, Arg2)
	Arg3:= Iif(ISNIL(Arg3), 1, Arg3)
	showbutton(Arg1, Arg2)
	Do While (!Arg1[Arg3][4])
		Arg3:= Iif(++Arg3 > Len(Arg1), 1, Arg3)
	EndDo
	Do While (.T.)
		drawbutton(Arg1[Arg3], Arg2, 2, .F.)
		if (Arg1[Arg3][2] != Nil .OR. Arg1[Arg3][2] != "")
			dwnmsg(Arg1[Arg3][2])
		endif
		if (Local1 == 13 .OR. Local1 = 32)
			InKey(0.1)
			drawbutton(Arg1[Arg3], Arg2, 1, .T.)
			Exit
		else
			Local1:= ninkey(0)
		endif
		if (Local1 == 27 )
			return( 0 )
		elseif ((Local3 := Ascan(Arg1, { |_1| Upper(Chr(Local1)) == Upper(_1[8]) })) != 0 .AND. Arg1[Local3][4])
			drawbutton(Arg1[Arg3], Arg2, 1)
			Arg3 := Local3
			Keyboard Chr(13)
		elseif (Local1 == 27 .AND. ( Local3 := ascan(Arg1, { |_1| _1[5] == .T. })) != 0 .AND. Arg1[Local3][4])
			drawbutton(Arg1[Arg3], Arg2, 1)
			Arg3 := Local3
			Keyboard Chr(13)
		endif
		if (Local1 == 5 .OR. Local1 == 19 .OR. Local1 == 271)
			drawbutton(Arg1[Arg3], Arg2, 1)
			Arg3:= Iif(--Arg3 == 0, Len(Arg1), Arg3)
			Do While (!Arg1[Arg3][4])
				Arg3:= Iif(--Arg3 == 0, Len(Arg1), Arg3)
			EndDo
		elseif (Local1 == 24 .OR. Local1 == 4 .OR. Local1 == 9)
			drawbutton(Arg1[Arg3], Arg2, 1)
			Arg3:= Iif(++Arg3 > Len(Arg1), 1, Arg3)
			Do While (!Arg1[Arg3][4])
				Arg3:= Iif(++Arg3 > Len(Arg1), 1, Arg3)
			EndDo
		elseif (Local1 == 13 .OR. Local1 = 32 )
			drawbutton(Arg1[Arg3], Arg2, 3, .F., .F.)
			InKey(0.1)
			drawbutton(Arg1[Arg3], Arg2, 2, .F.)
			eval(Arg1[Arg3][3])
		endif
	EndDo
	setcursor(Local2)
	return Arg3

def TEXTBUTTON(Arg1)
*+----------------------------------------------+*
	Local Local1, Local2, Local3, Local4
	Local1:= ""
	Local2:= At("&", Arg1)
	Local3:= SubStr(Arg1, 1, Local2 - 1)
	Local4:= SubStr(Arg1, Local2 + 1)
	return Iif(Local2 != 0, Local3 + Local4, Arg1)

def SETBUTTON(Arg1, Arg2, Arg3)
*+----------------------------------------------+*
	Local Local1
	Local1:= Arg1[Arg2][4]
	if (Arg3 != Nil)
		Arg1[Arg2][4]:= Arg3
	endif
	return Local1

def DESKTOP(Arg1, Arg2)
*+----------------------------------------------+*
	Arg1:= Iif(ISNIL(Arg1), ;
		"Analyze Tecnologia em Sistemas - Visual Lib", Arg1)
	Arg2:= Iif(ISNIL(Arg2), "W+/BG", Arg2)
	setblink(.F.)
	Set Color To W+/W
	//visual()
	Clear Screen
	@	0,  0 Say padc(Arg1, 80) Color Arg2
	@ 24,  0 Say padc(" ", 80) Color Arg2
	@	1,  0 Say padc(" ", 80) Color "N*/W"
	@ 23,  0 Say padc(" ", 80) Color "N*/W"
	return Nil

def NBOX(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6)
*+----------------------------------------------+*
	Local Local1
	Local1 := savenv(Arg1, Arg2, Arg3 + 1, Arg4 + 2)
	Arg5	 := Iif(ISNIL(Arg5), "N*/W", Arg5)
	Arg6	 := Iif(ISNIL(Arg6), .T., Arg6)
	@ Arg1, Arg2, Arg3, Arg4 Box "…–À« Ã»∂ " Color Arg5
	if (Arg6)
		Sombra( Arg1, Arg2, Arg3, Arg4)
	endif
	return Local1

def WIN(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7)
*+----------------------------------------------+*
	Local Local1
	Arg5	 := Iif(ISNIL(Arg5), "", Arg5)
	Arg6	 := Iif(ISNIL(Arg6), "W+/B", Arg6)
	Arg7	 := Iif(ISNIL(Arg7), "B*/W", Arg7)
	Local1 := nBox( Arg1, Arg2, Arg3, Arg4, Arg7)
	@ Arg1, Arg2 Say Padc(Arg5, Arg4 - Arg2 + 1) Color Arg6
	return Local1
endef

def SOMBRA(Arg1, Arg2, Arg3, Arg4)
*+----------------------------------------------+*

	Local Local1, Local2, Local3, Local4
	Local3:= SaveScreen(Arg1 + 1, Arg4 + 1, Arg3 + 1, Arg4 + 2)
	Local4:= SaveScreen(Arg3 + 1, Arg2 + 2, Arg3 + 1, Arg4 + 2)
	For Local1:= 2 To Len(Local3) Step 2
		Local2:= FT_shadow(Asc(SubStr(Local3, Local1, 1)))
		Local3:= stuff(Local3, Local1, 1, Local2)
	Next
	For Local1:= 2 To Len(Local4) Step 2
		Local2:= FT_shadow(Asc(SubStr(Local4, Local1, 1)))
		Local4:= stuff(Local4, Local1, 1, Local2)
	Next
	RestScreen(Arg1 + 1, Arg4 + 1, Arg3 + 1, Arg4 + 2, Local3)
	RestScreen(Arg3 + 1, Arg2 + 2, Arg3 + 1, Arg4 + 2, Local4)
	return Nil
endef	

def SHADOW(Arg1)
*+----------------------------------------------+*
	Local Local1, Local2, Local3
	Local1:= Arg1 % 16
	Local2:= (Arg1 - Local1) / 16
	Local3:= {0, 0, 8, 8, 0, 8, 0, 8, 0, 1, 2, 3, 4, 5, 6, 7}
	Local1:= Local3[Local1 + 1]
	Local2:= Local3[Local2 + 1]
	return Chr(16 * Local2 + Local1)
endef	

def MSGBOX3D1(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7)
*+----------------------------------------------+*
	Local Local1, Local2, Local3, Local4
	Arg4:= Iif(ISNIL(Arg4), "&OK", Arg4)
	Arg1:= Iif(ISNIL(Arg1), "", Arg1)
	Arg2:= Iif(ISNIL(Arg2), "AtenáÑo!", Arg2)
	Local1:= Iif(ISARRAY(Arg1), Len(Arg1), 1)
	Arg3:= Iif(ISNIL(Arg3), 12 - (Local1 + 8) / 2, Arg3)
	Arg5:= Iif(ISNIL(Arg5), "W+/N", Arg5)
	Arg6:= Iif(ISNIL(Arg6), "N/W", Arg6)
	Arg7:= Iif(ISNIL(Arg7), "N/W", Arg7)
	Local3:= newbutton()
	addbutton(Local3, Arg3 + 5 + Local1, 31, 18, Arg4, Nil, .T.)
	Local2:= win(Arg3, 10, Arg3 + 8 + Local1, 69, Arg2, Arg5, Arg6)
	@ Arg3 + 2, 11, Arg3 + 7 + Local1, 11 Box "«««««««««" Color "W+/W"
	@ Arg3 + 2, 68, Arg3 + 7 + Local1, 68 Box "∂∂∂∂∂∂∂∂∂" Color "N+/W"
	@ Arg3 + 2, 12 Say Replicate("–", 56) Color "W+/W"
	@ Arg3 + 7 + Local1, 12 Say Replicate("Ã", 56) Color "N+/W"
	if (ISARRAY(Arg1))
		For Local4:= 1 To Local1
			@ Arg3 + 2 + Local4, 13 Say padc(Arg1[Local4], 54) Color Arg7
		Next
	else
		@ Arg3 + 3, 13 Say padc(Arg1, 54) Color Arg7
	endif
	setcursor(0)
	procbutton(Local3, 1, 1)
	rstenv(Local2)
	return Nil

********************************
def MSGBOX3D2(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, ;
	Arg9, Arg10)

	Local Local1, Local2, Local3, Local4
	Arg4:= Iif(ISNIL(Arg4), "&Sim", Arg4)
	Arg5:= Iif(ISNIL(Arg5), "&NÑo", Arg5)
	Arg6:= Iif(ISNIL(Arg6), 1, Arg6)
	Arg7:= Iif(ISNIL(Arg7), 2, Arg7)
	Arg1:= Iif(ISNIL(Arg1), "", Arg1)
	Arg2:= Iif(ISNIL(Arg2), "AtenáÑo!", Arg2)
	Local1:= Iif(ISARRAY(Arg1), Len(Arg1), 1)
	Arg3:= Iif(ISNIL(Arg3), 12 - (Local1 + 8) / 2, Arg3)
	Arg8:= Iif(ISNIL(Arg8), "W+/N", Arg8)
	Arg9:= Iif(ISNIL(Arg9), "N/W", Arg9)
	Arg10:= Iif(ISNIL(Arg10), "N/W", Arg10)
	Local3:= newbutton()
	addbutton(Local3, Arg3 + 5 + Local1, 21, 18, Arg4, Nil, Iif(Arg7 ;
		== 1, .T., .F.))
	addbutton(Local3, Arg3 + 5 + Local1, 41, 18, Arg5, Nil, Iif(Arg7 ;
		== 2, .T., .F.))
	Local2:= win(Arg3, 10, Arg3 + 8 + Local1, 69, Arg2, Arg8, Arg9)
	@ Arg3 + 2, 11, Arg3 + 7 + Local1, 11 Box "«««««««««" Color "W+/W"
	@ Arg3 + 2, 68, Arg3 + 7 + Local1, 68 Box "∂∂∂∂∂∂∂∂∂" Color "N+/W"
	@ Arg3 + 2, 12 Say Replicate("–", 56) Color "W+/W"
	@ Arg3 + 7 + Local1, 12 Say Replicate("Ã", 56) Color "N+/W"
	if (ISARRAY(Arg1))
		For Local4:= 1 To Local1
			@ Arg3 + 2 + Local4, 13 Say padc(Arg1[Local4], 54) Color ;
				Arg10
		Next
	else
		@ Arg3 + 3, 13 Say padc(Arg1, 54) Color Arg10
	endif
	setcursor(0)
	Local4:= procbutton(Local3, 1, Iif(Arg6 < 3, Arg6, 2))
	rstenv(Local2)
	return Local4

def LinButton1( lProcessaOuExibe, nCor, nRow, cString, cMensagem )
***********************************************************************
LOCAL xButton	  := NewButton()
lProcessaOuExibe := Iif(ISNIL( lProcessaOuExibe), OK, lProcessaOuExibe )
nCor				  := Iif(ISNIL( nCor ), 1, nCor )
nRow				  := Iif(ISNIL( nRow ), 21, nRow )
cString			  := Iif(ISNIL( cString ), "&OK", cString )
AddButton( xButton, nRow, 31, (MaxCol()-61), cString,  cMensagem, true )
if ( lProcessaOuExibe )
	nRow := ProcButton( xButton, nCor )
else
	ShowButton( xButton, nCor )
endif
return(	nRow )

********************************
def MSGBOX3D3(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, ;
	Arg9, Arg10, Arg11)

	Local Local1, Local2, Local3, Local4
	Arg4:= Iif(ISNIL(Arg4), "&Sim", Arg4)
	Arg5:= Iif(ISNIL(Arg5), "&NÑo", Arg5)
	Arg6:= Iif(ISNIL(Arg6), "&Cancelar", Arg6)
	Arg7:= Iif(ISNIL(Arg7), 1, Arg7)
	Arg8:= Iif(ISNIL(Arg8), 3, Arg8)
	Arg1:= Iif(ISNIL(Arg1), "", Arg1)
	Arg2:= Iif(ISNIL(Arg2), "AtenáÑo!", Arg2)
	Local1:= Iif(ISARRAY(Arg1), Len(Arg1), 1)
	Arg3:= Iif(ISNIL(Arg3), 12 - (Local1 + 8) / 2, Arg3)
	Arg9:= Iif(ISNIL(Arg9), "W+/N", Arg9)
	Arg10:= Iif(ISNIL(Arg10), "N/W", Arg10)
	Arg11:= Iif(ISNIL(Arg11), "N/W", Arg11)
	Local3:= newbutton()
	addbutton(Local3, Arg3 + 5 + Local1, 13, 18, Arg4, Nil, Iif(Arg8 ;
		== 1, .T., .F.))
	addbutton(Local3, Arg3 + 5 + Local1, 31, 18, Arg5, Nil, Iif(Arg8 ;
		== 2, .T., .F.))
	addbutton(Local3, Arg3 + 5 + Local1, 49, 18, Arg6, Nil, Iif(Arg8 ;
		== 3, .T., .F.))
	Local2:= win(Arg3, 10, Arg3 + 8 + Local1, 69, Arg2, Arg9, Arg10)
	@ Arg3 + 2, 11, Arg3 + 7 + Local1, 11 Box "«««««««««" Color "W+/W"
	@ Arg3 + 2, 68, Arg3 + 7 + Local1, 68 Box "∂∂∂∂∂∂∂∂∂" Color "N+/W"
	@ Arg3 + 2, 12 Say Replicate("–", 56) Color "W+/W"
	@ Arg3 + 7 + Local1, 12 Say Replicate("Ã", 56) Color "N+/W"
	if (ISARRAY(Arg1))
		For Local4:= 1 To Local1
			@ Arg3 + 2 + Local4, 13 Say padc(Arg1[Local4], 54) Color ;
				Arg11
		Next
	else
		@ Arg3 + 3, 13 Say padc(Arg1, 54) Color Arg11
	endif
	setcursor(0)
	Local4:= procbutton(Local3, 1, Iif(Arg7 < 4, Arg7, 3))
	rstenv(Local2)
	return Local4

********************************
def CLRTED(Arg1, Arg2)

	Local Local1
	Local1:= SetColor()
	Set Color To N/W
	Arg1:= Iif(ISNIL(Arg1), 2, Arg1)
	Arg2:= Iif(ISNIL(Arg2), 22, Arg2)
	Scroll(Arg1, 0, Arg2, 79)
	Set Color To (Local1)
	return Nil

def MSGBOX1(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7)
**********************************************************
Local Local1, Local2, Local3, Local4
LOCAL nTamanhoButton := MaxCol()-61
Arg4	 := Iif(ISNIL(Arg4), "&OK", Arg4)
Arg1	 := Iif(ISNIL(Arg1), "", Arg1)
Arg2	 := Iif(ISNIL(Arg2), "AtenáÑo!", Arg2)
Local1 := Iif(ISARRAY(Arg1), Len(Arg1), 1)
Arg3	 := Iif(ISNIL(Arg3), 12 - (Local1 + 5) / 2, Arg3)
Arg5	 := Iif(ISNIL(Arg5), "W+*/R", Arg5)
Arg6	 := Iif(ISNIL(Arg6), "R+*/W", Arg6)
Arg7	 := Iif(ISNIL(Arg7), "N*/W", Arg7)
Local3 := NewButton()
addbutton( Local3, Arg3+ 3 + Local1, 31, nTamanhoButton, Arg4, Nil, .T.)
Local2 := Win( Arg3, 10, Arg3 + 5 + Local1, (MaxCol()-10), Arg2, Arg5, Arg6)
if (ISARRAY(Arg1))
	For Local4 := 1 To Local1
		@ Arg3 + 1 + Local4, 12 Say padc( Arg1[ Local4 ], (MaxCol()-23) ) Color Arg7
	Next
else
	@ Arg3 + 2, 12 Say padc(Arg1, (MaxCol()-23) ) Color Arg7
endif
setcursor(0)
nButton := ProcButton( Local3, 2, 1)
RsTenv( Local2 )
return( nButton )

def LINBUTTON3(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10, Arg11)
*+----------------------------------------------+*
	Local Local1
	Local1:= newbutton()
	Arg1:= Iif(ISNIL(Arg1), .T., Arg1)
	Arg2:= Iif(ISNIL(Arg2), 1, Arg2)
	Arg3:= Iif(ISNIL(Arg3), 21, Arg3)
	Arg4:= Iif(ISNIL(Arg4), 1, Arg4)
	Arg5:= Iif(ISNIL(Arg5), 3, Arg5)
	Arg6:= Iif(ISNIL(Arg6), "&OK", Arg6)
	Arg8:= Iif(ISNIL(Arg8), "&Alterar", Arg8)
	Arg10:= Iif(ISNIL(Arg10), "&Cancelar", Arg10)
	addbutton(Local1, Arg3, 11, 18, Arg6, Arg7, Iif(Arg5 == 1, .T., ;
		.F.))
	addbutton(Local1, Arg3, 31, 18, Arg8, Arg9, Iif(Arg5 == 2, .T., ;
		.F.))
	addbutton(Local1, Arg3, 51, 18, Arg10, Arg11, Iif(Arg5 == 3, .T., ;
		.F.))
	if (Arg1)
		Arg3:= procbutton(Local1, Arg2, Iif(Arg4 < 4, Arg4, 3))
	else
		showbutton(Local1, Arg2)
	endif
	return Arg3

def MSGBOX2(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10)
*+----------------------------------------------+*
	Local Local1, Local2, Local3, Local4
	Arg4	 := Iif(ISNIL(Arg4), "&Sim", Arg4)
	Arg5	 := Iif(ISNIL(Arg5), "&NÑo", Arg5)
	Arg6	 := Iif(ISNIL(Arg6), 1, Arg6)
	Arg7	 := Iif(ISNIL(Arg7), 2, Arg7)
	Arg1	 := Iif(ISNIL(Arg1), "", Arg1)
	Arg2	 := Iif(ISNIL(Arg2), "AtenáÑo!", Arg2)
	Local1 := Iif(ISARRAY(Arg1), Len(Arg1), 1)
	Arg3	 := Iif(ISNIL(Arg3), 12 - (Local1 + 7) / 2, Arg3)
	Arg8	 := Iif(ISNIL(Arg8), "W+*/R", Arg8)
	Arg9	 := Iif(ISNIL(Arg9), "R+*/W", Arg9)
	Arg10  := Iif(ISNIL(Arg10), "N*/W", Arg10)
	Local3 := newbutton()
	addbutton(Local3, Arg3 + 3 + Local1, 21, 18, Arg4, Nil, Iif(Arg7 == 1, .T., .F.))
	addbutton(Local3, Arg3 + 3 + Local1, 41, 18, Arg5, Nil, Iif(Arg7 == 2, .T., .F.))
	Local2 := Win( Arg3, 10, Arg3 + 5 + Local1, MaxCol()-10, Arg2, Arg8, Arg9)
	if (ISARRAY(Arg1))
		For Local4:= 1 To Local1
			@ Arg3 + 1 + Local4, 13 Say padc(Arg1[Local4], MaxCol()-25) Color Arg10
		Next
	else
		@ Arg3 + 2, 13 Say padc(Arg1, MaxCol()-25) Color Arg10
	endif
	setcursor(0)
	nButton := procbutton(Local3, 2, Iif(Arg6 < 3, Arg6, 2))
	rstenv(Local2)
	return( nButton )
endef
	
def LINBUTTON2(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9)
*+----------------------------------------------+*
	Local Local1
	Local1:= newbutton()
	Arg1:= Iif(ISNIL(Arg1), .T., Arg1)
	Arg2:= Iif(ISNIL(Arg2), 1, Arg2)
	Arg3:= Iif(ISNIL(Arg3), 21, Arg3)
	Arg4:= Iif(ISNIL(Arg4), 1, Arg4)
	Arg5:= Iif(ISNIL(Arg5), 2, Arg5)
	Arg6:= Iif(ISNIL(Arg6), "&OK", Arg6)
	Arg8:= Iif(ISNIL(Arg8), "&Cancelar", Arg8)
	addbutton(Local1, Arg3, 21, 18, Arg6, Arg7, Iif(Arg5 == 1, .T., ;
		.F.))
	addbutton(Local1, Arg3, 41, 18, Arg8, Arg9, Iif(Arg5 == 2, .T., ;
		.F.))
	if (Arg1)
		Arg3:= procbutton(Local1, Arg2, Iif(Arg4 < 3, Arg4, 2))
	else
		showbutton(Local1, Arg2)
	endif
	return Arg3
endef	

def MSGBOX3(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10, Arg11)
*+----------------------------------------------+*
	Local Local1, Local2, Local3, Local4
	Arg4:= Iif(ISNIL(Arg4), "&Sim", Arg4)
	Arg5:= Iif(ISNIL(Arg5), "&NÑo", Arg5)
	Arg6:= Iif(ISNIL(Arg6), "&Cancelar", Arg6)
	Arg7:= Iif(ISNIL(Arg7), 1, Arg7)
	Arg8:= Iif(ISNIL(Arg8), 3, Arg8)
	Arg1:= Iif(ISNIL(Arg1), "", Arg1)
	Arg2:= Iif(ISNIL(Arg2), "AtenáÑo!", Arg2)
	Local1:= Iif(ISARRAY(Arg1), Len(Arg1), 1)
	Arg3:= Iif(ISNIL(Arg3), 12 - (Local1 + 7) / 2, Arg3)
	Arg9:= Iif(ISNIL(Arg9), "W+*/R", Arg9)
	Arg10:= Iif(ISNIL(Arg10), "R+*/W", Arg10)
	Arg11:= Iif(ISNIL(Arg11), "N*/W", Arg11)
	Local3:= newbutton()
	addbutton(Local3, Arg3 + 3 + Local1, 13, 18, Arg4, Nil, Iif(Arg8 ;
		== 1, .T., .F.))
	addbutton(Local3, Arg3 + 3 + Local1, 31, 18, Arg5, Nil, Iif(Arg8 ;
		== 2, .T., .F.))
	addbutton(Local3, Arg3 + 3 + Local1, 49, 18, Arg6, Nil, Iif(Arg8 ;
		== 3, .T., .F.))
	Local2:= win(Arg3, 10, Arg3 + 5 + Local1, MaxCol()-10, Arg2, Arg9, Arg10)
	if (ISARRAY(Arg1))
		For Local4:= 1 To Local1
			@ Arg3 + 1 + Local4, 13 Say padc(Arg1[Local4], MaxCol()-25) Color ;
				Arg11
		Next
	else
		@ Arg3 + 2, 13 Say padc(Arg1, 54) Color Arg11
	endif
	setcursor(0)
	nButton := procbutton(Local3, 2, Iif(Arg7 < 3, Arg7, 2))
	rstenv(Local2)
	return( nButton )
endef	

def DESKBOX( Arg1, Arg2, Arg3, Arg4, Arg5)
***********************************************
LOCAL Local1 := "N+/W", Local2 := "W+/W"

Arg5		:= Iif(ISNIL(Arg5), 1, Arg5)
if (Arg5 == 2)
	Local1 := "W+/W"
	Local2 := "N+/W"
endif
@ Arg1, Arg2, Arg3, Arg2 Box "∂∂∂∂∂∂∂∂∂" Color Local1
@ Arg1, Arg4, Arg3, Arg4 Box "«««««««««" Color Local2
@ Arg1, Arg2 Say Replicate("Ã", Arg4 - Arg2 + 1) Color Local1
@ Arg3, Arg2 Say Replicate("–", Arg4 - Arg2 + 1) Color Local2
return Nil

def MSGBOX3D(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6)
*****************************************************
LOCAL Local1, Local2, Local3
LOCAL nTam	 := MaxCol()
Arg1:= Iif(ISNIL(Arg1), "", Arg1)
Arg2:= Iif(ISNIL(Arg2), "Aguarde", Arg2)
Local1:= Iif(ISARRAY(Arg1), Len(Arg1), 1)
Arg3:= Iif(ISNIL(Arg3), 12 - (Local1 + 6) / 2, Arg3)
Arg4:= Iif(ISNIL(Arg4), "W+/N", Arg4)
Arg5:= Iif(ISNIL(Arg5), "N/W", Arg5)
Arg6:= Iif(ISNIL(Arg6), "N/W", Arg6)
Local2 := win(Arg3, 16, Arg3 + 6 + Local1, (nTam-16), Arg2, Arg4, Arg5)
@ Arg3 + 2, 17, Arg3 + 5 + Local1, 17 Box "«««««««««" Color "W+/W"
@ Arg3 + 2, (nTam-17), Arg3 + 5 + Local1, (nTam-17) Box "∂∂∂∂∂∂∂∂∂" Color "N+/W"
@ Arg3 + 2, 18 Say Replicate("–", (nTam-35)) Color "W+/W"
@ Arg3 + 5 + Local1, 18 Say Replicate("Ã", (nTam-35)) Color "N+/W"
if (ISARRAY(Arg1))
	For Local3:= 1 To Local1
		@ Arg3 + 3 + Local3, 19 Say padc(Arg1[Local3], (nTam-37)) Color Arg6
	Next
else
	@ Arg3 + 4, 19 Say padc(Arg1, (nTam-37)) Color Arg6
endif
setcursor(0)
return Local2

def MSGBOX(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6)
*+----------------------------------------------+*

	Local Local1, Local2, Local3
	Arg1:= Iif(ISNIL(Arg1), "", Arg1)
	Arg2:= Iif(ISNIL(Arg2), "Aguarde", Arg2)
	Local1:= Iif(ISARRAY(Arg1), Len(Arg1), 1)
	Arg3:= Iif(ISNIL(Arg3), 12 - (Local1 + 5) / 2, Arg3)
	Arg4:= Iif(ISNIL(Arg4), "W+*/B", Arg4)
	Arg5:= Iif(ISNIL(Arg5), "B+*/W", Arg5)
	Arg6:= Iif(ISNIL(Arg6), "N*/W", Arg6)
	Local2:= win(Arg3, 18, Arg3 + 5 + Local1, 61, Arg2, Arg4, Arg5)
	if (ISARRAY(Arg1))
		For Local3:= 1 To Local1
			@ Arg3 + 2 + Local3, 20 Say padc(Arg1[Local3], 40) Color Arg6
		Next
	else
		@ Arg3 + 3, 20 Say padc(Arg1, 40) Color Arg6
	endif
	setcursor(0)
	return Local2

def FRAME(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9)
*+----------------------------------------------+*
Local Local1 := SetColor(), Local2 := dn := "", Local3:= Arg4 - Arg2 - 1, Local4:= y:= z:= 0
Arg6:= Iif(ISNIL(Arg6), 1, Arg6)
Arg7:= Iif(ISNIL(Arg7), 1, Arg7)
Arg8:= Iif(ISNIL(Arg8), "N/W", Arg8)
Arg9:= Iif(ISNIL(Arg9), "N/W", Arg9)
if (Arg7 == 1)
	Local2 := "N+/W"
	dn:= "W+/W"
elseif (Arg7 == 2)
	Local2 := "W+/W"
	dn:= "N+/W"
elseif (Arg7 == 3)
	Local2 := dn:= Arg8
endif
@ Arg1 + 1, Arg2, Arg3 - 1, Arg2 Box Replicate("«", 9) Color Local2
@ Arg1, Arg2 Say "Õ" + Replicate("ƒ", Local3) Color Local2
@ Arg3, Arg2 Say "Œ" Color Local2
@ Arg1 + 1, Arg4, Arg3 - 1, Arg4 Box Replicate("∂", 9) Color dn
@ Arg3, Arg2 + 1 Say Replicate("ƒ", Local3) + "º" Color dn
@ Arg1, Arg4 Say "ª" Color dn
if (Arg5 != Nil)
	z:= Len(Arg5)
	if (Arg6 == 1)
		@ Arg1, Arg2 + 2 Say " " + Arg5 + " " Color Arg9
	elseif (Arg6 == 2)
		@ Arg1, Arg4 - Local3 / 2 - z / 2 - 1 Say " " + Arg5 + " " Color Arg9
	elseif (Arg6 == 3)
		@ Arg1, Arg4 - z - 3 Say " " + Arg5 + " " Color Arg9
	endif
endif
Set Color To (Local1)
return Nil

def DOWNMENU(Arg1, Arg2, Arg3, Arg4, Arg5)
*+----------------------------------------------+*

	Local Local1, Local2, Local3, Local4, Local5, Local6, Local7, ;
		Local8
	Local1:= htk:= 0
	Local2:= setcursor(0)
	Local3:= Len(Arg1)
	Local4:= Arg1[1][10]
	For Local6:= 1 To Local3
		Local4:= Max(Arg1[Local6][10], Local4)
	Next
	For Local6:= 1 To Local3
		Arg1[Local6][10]:= Local4
	Next
	Local7:= Arg3 + Local3 + 1
	Local8:= Arg4 + Arg1[1][10] + 1
	if (procname(1) == "DOWNMENU" .AND. (Arg4 > 45 .OR. Arg4 + Arg5 > ;
			65))
		Arg4:= Arg4 + Arg5
		Local8:= Local8 + Arg5
		Arg4:= Arg4 - Iif(Local8 + 3 > 80, Arg5 + Arg1[1][10] + 2, 0)
		Local8:= Local8 - Iif(Local8 + 3 > 80, Arg5 + Arg1[1][10] + 2, ;
			0)
		Arg3:= Arg3 - Iif(Local7 + 1 > 22, Local7 + 1 - 22, 0)
		Local7:= Local7 - Iif(Local7 + 1 > 22, Local7 + 1 - 22, 0)
		if (Arg4 < 0)
			Arg4:= 77 - (Local8 - Arg4)
			Local8:= Arg4 + Arg1[1][10] + 1
		endif
	elseif (procname(1) == "DOWNMENU")
		Arg4:= Arg4 + Arg5
		Local8:= Local8 + Arg5
		Arg4:= Arg4 - Iif(Local8 + 3 > 80, Local8 + 3 - 80, 0)
		Local8:= Local8 - Iif(Local8 + 3 > 80, Local8 + 3 - 80, 0)
		Arg3:= Arg3 - Iif(Local7 + 1 > 22, Local7 + 1 - 22, 0)
		Local7:= Local7 - Iif(Local7 + 1 > 22, Local7 + 1 - 22, 0)
	else
		Arg4:= Arg4 - Iif(Local8 + 3 > 80, Local8 + 3 - 80, 0)
		Local8:= Local8 - Iif(Local8 + 3 > 80, Local8 + 3 - 80, 0)
		Arg3:= Arg3 - Iif(Local7 + 1 > 22, Local7 + 1 - 22, 0)
		Local7:= Local7 - Iif(Local7 + 1 > 22, Local7 + 1 - 22, 0)
	endif
	Local5:= nbox(Arg3, Arg4, Local7, Local8)
	For Local6:= 1 To Local3
		Arg1[Local6][6]:= Arg3 + Local6
		Arg1[Local6][7]:= Arg4 + 1
		drawdownit(Arg1[Local6], 1)
	Next
	Arg2:= Iif(ISNIL(Arg2), 1, Arg2)
	Do While (Arg1[Arg2][9])
		Arg2:= Iif(++Arg2 > Len(Arg1), 1, Arg2)
	EndDo
	Do While (.T.)
		drawdownit(Arg1[Arg2], 2)
		if (Arg1[Arg2][2] != Nil .OR. Arg1[Arg2][2] != "")
			dwnmsg(Arg1[Arg2][2])
		endif
		Local1:= ninkey(0)
		if ((htk:= ascan(Arg1, { |_1| Upper(Chr(Local1)) == ;
				Upper(_1[5]) })) != 0)
			drawdownit(Arg1[Arg2], 1)
			Arg2:= htk
			Keyboard Chr(13)
		endif
		Do Case
		Case Local1 == 5
			drawdownit(Arg1[Arg2], 1)
			Arg2:= Iif(--Arg2 == 0, Len(Arg1), Arg2)
			Do While (Arg1[Arg2][9])
				Arg2:= Iif(--Arg2 == 0, Len(Arg1), Arg2)
			EndDo
		Case Local1 == 24
			drawdownit(Arg1[Arg2], 1)
			Arg2:= Iif(++Arg2 > Len(Arg1), 1, Arg2)
			Do While (Arg1[Arg2][9])
				Arg2:= Iif(++Arg2 > Len(Arg1), 1, Arg2)
			EndDo
		Case Local1 == 27 .OR. Local1 == 19 .OR. Local1 == 4
			Arg2:= 0
			Exit
		Case Local1 == 13 .AND. Arg1[Arg2][4]
			if (ISARRAY(Arg1[Arg2][3]))
				flg:= .T.
				downmenu(Arg1[Arg2][3], 1, Arg1[Arg2][6] - 1, ;
					Arg1[Arg2][7], Arg1[Arg2][10])
				if (LastKey() == K_LEFT .OR. LastKey() == K_RIGHT)
					Arg2:= 0
					Exit
				endif
			else
				eval(Arg1[Arg2][3])
			endif
			aeval(Arg1, { |_1| drawdownit(_1, 1) })
		EndCase
	EndDo
	rstenv(Local5)
	setcursor(Local2)
	return Arg2

def AddBarItem(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7)
*+----------------------------------------------+*

	Local Local1, Local2, Local3
	Local3:= Len(Arg1)
	Arg2:= Iif(At("&", Arg2) == 0, "&" + Arg2, Arg2)
	Arg4:= Iif(ISNIL(Arg4), { || nret() }, Arg4)
	Arg5:= Iif(ISNIL(Arg5), .T., Arg5)
	Arg6:= Iif(ISNIL(Arg6), 1, Arg6)
	Local1:= SubStr(Arg2, At("&", Arg2) + 1, 1)
	Local2:= Len(Arg2) + 1
	if (Local3 == 0)
		Arg7:= Iif(ISNIL(Arg7), 1, Arg7)
	else
		Arg7:= Iif(ISNIL(Arg7), Arg1[Local3][7] + Arg1[Local3][8], Arg7)
	endif
	AAdd(Arg1, {Arg2, Arg3, Arg4, Arg5, Local1, Arg6, Arg7, Local2})
	return Nil

********************************
def BARMENU(Arg1, Arg2, Arg3)

	Local Local1:= htk:= 0, Local2:= setcursor(0), Local3:= ink:= ;
		.T., Local4:= .F.
	Arg2:= Iif(ISNIL(Arg2), 1, Arg2)
	Arg3:= Iif(ISNIL(Arg3), 1, Arg3)
	aeval(Arg1, { |_1| (_1[6]:= Arg2, drawbarite(_1, 1)) })
	Do While (.T.)
		drawbarite(Arg1[Arg3], 2)
		if (Local3 .AND. (Arg1[Arg3][2] != Nil .OR. Arg1[Arg3][2] != ;
				""))
			dwnmsg(Arg1[Arg3][2])
		endif
		if (ink)
			Local1:= ninkey(0)
		endif
		if ((htk:= ascan(Arg1, { |_1| Upper(Chr(Local1)) == ;
				Upper(_1[5]) })) != 0)
			drawbarite(Arg1[Arg3], 1)
			Arg3:= htk
			Keyboard Chr(13)
		endif
		Do Case
		Case Local1 == 19
			drawbarite(Arg1[Arg3], 1)
			Arg3:= Iif(--Arg3 == 0, Len(Arg1), Arg3)
		Case Local1 == 4
			drawbarite(Arg1[Arg3], 1)
			Arg3:= Iif(++Arg3 > Len(Arg1), 1, Arg3)
		Case Local1 == 27
			Arg3:= 0
			Exit
		Case Local1 == 13 .AND. Arg1[Arg3][4]
			if (ISARRAY(Arg1[Arg3][3]))
				downmenu(Arg1[Arg3][3], 1, Arg1[Arg3][6] + 1, ;
					Arg1[Arg3][7])
				if (LastKey() == K_LEFT .OR. LastKey() == K_RIGHT)
					Local1:= LastKey()
					Local3:= .F.
					ink:= .F.
					Local4:= .T.
					aeval(Arg1, { |_1| drawbarite(_1, 1) })
					Loop
				else
					Local3:= .T.
					ink:= .T.
					Local4:= .F.
				endif
			elseif (LastKey() == K_ENTER)
				eval(Arg1[Arg3][3])
				Local4:= .F.
			else
				Local3:= .T.
				ink:= .T.
				aeval(Arg1, { |_1| drawbarite(_1, 1) })
				Loop
			endif
			aeval(Arg1, { |_1| drawbarite(_1, 1) })
		EndCase
		if (Local4 .AND. Arg1[Arg3][4])
			Local1:= 13
			Local3:= .F.
			ink:= .F.
		elseif (!Arg1[Arg3][4])
			Local3:= .T.
			ink:= .T.
		endif
	EndDo
	setcursor(Local2)
	return Arg3

********************************
def DRAWBARITE(Arg1, Arg2)

	Local Local1, Local2, Local3, Local4
	Local3:= padr(" " + textmenu(Arg1[1]), Arg1[8])
	Local4:= At("&", Arg1[1])
	if (Arg2 == 1)
		Local1:= Iif(Arg1[4], "N*/W", "W*/W")
		Local2:= Iif(Arg1[4], "R+*/W", "N*/W")
	elseif (Arg2 == 2)
		Local1:= Iif(Arg1[4], "W+/N", "W/N")
		Local2:= Iif(Arg1[4], "R+/N", "W+/N")
	endif
	@ Arg1[6], Arg1[7] Say Local3 Color Local1
	@ Arg1[6], Arg1[7] + Local4 Say Arg1[5] Color Local2
	return Nil


def TextMenu(Arg1)
*=================*
	LOCAL local1, local2, local3
	
	Local1 := At("&", Arg1)
	Local2 := SubStr(Arg1, 1, Local1 - 1)
	Local3 := SubStr(Arg1, Local1 + 1)
	return Iif(Local1 != 0, Local2 + Local3, Arg1)

def SetBarItem(Arg1, Arg2, Arg3)
*===============================*
	LOCAL local1 := Arg1[Arg2][4]
	
	if (Arg3 != Nil)
		Arg1[Arg2][4]:= Arg3
	endif
	return Local1

proc NDWNMENU()
*===============*

def NEWDOWNMEN()
*********************
	return {}

def AddDownIte(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8)
**************************************************************
	Local Local1, Local2
	
	Local2 := Len(Arg1)	
	Arg2   := Iif(At("&", Arg2) == 0, "&" + Arg2, Arg2)
	Arg4   := Iif(ISNIL(Arg4), { || nret() }, Arg4)
	Arg6   := Iif(ISNIL(Arg6), .T., Arg6)
	Arg8   := Iif(ISNIL(Arg8), 3, Arg8)
	Local1 := SubStr(Arg2, At("&", Arg2) + 1, 1)
	
	if (Local2 == 0)
		Arg7:= Iif(ISNIL(Arg7), 3, Arg7)
		Arg5:= Iif(ISNIL(Arg5), Len(Arg2) + 4, Arg5)
	else
		Arg7:= Iif(ISNIL(Arg7), Arg1[Local2][6] + 1, Arg7)
		Arg5:= Iif(ISNIL(Arg5), Max(Arg1[Local2][10], Len(Arg2) + 4), Arg5)
	endif
	AAdd(Arg1, {Arg2, Arg3, Arg4, Arg6, Local1, Arg7, Arg8, .F., .F., Arg5})
	return Nil

********************************
def AddDownSep(Arg1, Arg2)

	LOCAL Local1, Local2, Local3
	Local3 := Len(Arg1)
	Arg2   := Iif(ISNIL(Arg2), 1, Arg2)
	Local2 := Iif(ISNIL(Local2), 3, Local2)
	if (Local3 == 0)
		Local1:= Iif(ISNIL(Local1), 3, Local1)
	else
		Local1:= Iif(ISNIL(Local1), Arg1[Local3][6] + 1, Local1)
	endif
	AAdd(Arg1, {Nil, Nil, Nil, .T., "", Local1, Local2, .F., .T., ;
		Arg2})
	return Nil

def DRAWDOWNIT(Arg1, Arg2)
***************************

	Local Local1, Local2, Local3, Local4, Local5, Local6
	Local5:= Iif(Arg1[8], "˚ ", "  ")
	Local6:= Iif(ISARRAY(Arg1[3]), Chr(16), " ")
	Local3:= Iif(Arg1[9], Replicate("ƒ", Arg1[10]), padr(Local5 + ;
		textmenu(Arg1[1]), Arg1[10] - 1) + Local6)
	Local4:= Iif(Arg1[9], 0, At("&", Arg1[1]) + 1)
	if (Arg2 == 1)
		Local1:= Iif(Arg1[4], "N*/W", "W*/W")
		Local2:= Iif(Arg1[4], "R+*/W", "N*/W")
	elseif (Arg2 == 2)
		Local1:= Iif(Arg1[4], "W+/N", "W/N")
		Local2:= Iif(Arg1[4], "R+/N", "W+/N")
	endif
	if (Arg1[9])
		@ Arg1[6], Arg1[7] Say Local3 Color Local1
	else
		@ Arg1[6], Arg1[7] Say Local3 Color Local1
		@ Arg1[6], Arg1[7] + Local4 Say Arg1[5] Color Local2
	endif
	return Nil

def CHKDOWNITE(Arg1, Arg2, Arg3)
********************************

	Local Local1
	Local1:= Arg1[Arg2][8]
	if (Arg3 != Nil)
		Arg1[Arg2][8]:= Arg3
	endif
	return Local1

def SetDownite(Arg1, Arg2, Arg3)
********************************
	LOCAL local1 := Arg1[Arg2][4]
	
	if (Arg3 != Nil)
		Arg1[Arg2][4] := Arg3
	endif
	return local1

def Help( cProg, nLine, xVar )
******************************
	LOCAL cScreen		:= SaveScreen()
	LOCAL aArray		:= {}
	LOCAL Help_Codigo := 1
	LOCAL cTexto
	LOCAL nHandle

	Set Key 28 To
	nHandle := Fopen( oAmbiente:xBase + "\HELP.HLP")
	if FLocate( nHandle, "/" + StrZero( Help_Codigo, 4) ) = 0
		cTitulo := MsReadLine( nHandle )
		WHILE !Feof( nHandle )
			cTexto := MsReadLine( nHandle )
			if Left( cTexto, 1 ) = "/"
				Exit
			else
				Aadd( aArray, cTexto )
			endif
		EndDo
		M_Title( cTitulo )
		FazMenu(05,10, aArray, Cor())
	else
		Alerta("Help nao Disponivel...")
	endif
	FClose( nHandle )
	Set Key 28 To Help
	return(resTela(cScreen))

def Extenso( Numero, Dinheiro, Linhas, Largura )
*****************************************************
/*
								 ⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ Valor a Imprimir por extenso
                         ≥  ⁄ƒƒƒƒƒƒƒƒƒƒƒƒ Tipo de Moeda (1-Real, 2 - Dolar)
								 ≥  ≥ ⁄ƒƒƒƒƒƒƒƒƒƒ Qtde de Linhas para impressao
		 LARG = 50	 &&	 ≥  ≥ ≥	 ƒƒƒƒƒƒƒ Comprimento da Linha de impressao
		 VALOR = EXTENSO( Vlr,2,3,LARG)
		 @ 14,05 Say LEFT(VALOR,LARG)
		 @ 15,05 Say SubStr(VALOR,LARG+1,LARG)
		 @ 16,05 Say RIGHT(VALOR,LARG)
*/

LOCAL Numero1	 := StrZero( Numero, 13, 2 )
PUBLI TipoMoeda := Dinheiro
PRIVA cTexto	 := ""
PRIVA aUnidade  := {"UM ","DOIS ","TRES ","QUATRO ","CINCO ","SEIS ","SETE ","OITO ","NOVE " }
PRIVA aDezena	 := {"DEZ ","VINTE ","TRINTA ","QUARENTA ", "CINQUENTA ","SESSENTA ","SETENTA ","OITENTA ","NOVENTA " }
PRIVA Ndb		 := {"DEZ ","ONZE ","DOZE ","TREZE ","QUATORZE ","QUINZE ","DEZESSEIS ", "DEZESSETE ","DEZOITO ","DEZENOVE " }
PRIVA aCentena  := {"CENTO ","DUZENTOS ","TREZENTOS ","QUATROCENTOS ","QUINHENTOS ","SEISCENTOS ","SETECENTOS ","OITOCENTOS ", "NOVECENTOS " }
PRIVA aMilhar	 := {"MILHAO ","MILHOES " }
PRIVA aCentavo  := {"CENTAVO","CENTAVOS"}
PRIVA cMil		 :=  "MIL "
PRIVA aMoeda	 := {{ "REAL ", "REAIS "}, {"DOLAR ", "DOLARES "}, {"HORA ", "HORAS "}}

if TipoMoeda = 3 // Horas
	aCentavo  := {"MINUTO","MINUTOS"}
endif
P1 := SubStr( Numero1, 2, 3 )
P2 := SubStr( Numero1, 5, 3 )
P3 := SubStr( Numero1, 8, 3 )
P4 := StrZero(( Numero - Int( Numero ) ) * 100, 3 )

Converte( P1, 1 )
Converte( P2, 2 )

if Val( P2) <> 0 .AND. Val( P3 ) < 100 .AND. Val( P4) = 0  // Ex. linha 50
   cTexto += cTexto  // + "E "
endif

Converte( P3, 3 )

if P3 = "000" .AND. VAL( P1 + P2 ) <> 0
	cTexto := cTexto + aMoeda[ TipoMoeda, 2 ]
endif

Converte( P4, 4 )
cTexto := Formata( cTexto, Linhas, Largura)
return cTexto

def Converte( x, Grandeza  )
********************************
	if x = "000"
	  return cTexto
	endif

	x1 := Left( x, 1 )
	x2 := SubStr( x, 2, 1 )
	x3 := Right( x, 1 )
	X4 := Right( x, 2 )

	if Grandeza = 4
	  cTexto += Iif( Val( P1 + P2 + P3 ) <> 0, "E ", "" )
	endif

	if x1 <> "0"         // Centena
		if x4 = "00" .AND. x1 = "1"
			cTexto += "CEM "
		else
			cTexto +=  aCentena[ Val( x1 ) ]
		endif
	endif

	if x4 >= "10" .AND. x4 <= "19"    // Dezena ate dezenove
		cTexto +=  Iif( x1 <> "0", "E " + Ndb[ Val( x4 ) -9 ] , Ndb[ Val( x4 ) -9 ] )
	endif

	if x2 >= "2"
	  if x1 <> "0"
		 cTexto += "E " + aDezena[ Val( x2 ) ]
	  else
		  cTexto += aDezena[ Val( x2 ) ]
	  endif
	endif

	if x3 <> "0" .AND. (x4 < "10" .OR. x4 > "19")
		if x1<> "0" .OR. x2 <> "0"
			cTexto += "E " + aUnidade[VAL(x3)]
		else
			cTexto += aUnidade[VAL(x3)]
		endif
	endif

	DO CASE
	CASE grandeza = 1
	  cTexto += Iif(VAL(x)=1, aMilhar[1], aMilhar[2])
	CASE grandeza = 2
	  cTexto += Iif(VAL(x) > 0, cMil, "" )
	CASE grandeza = 3
	  cTexto += Iif(VAL(p1+p2+p3)=1, aMoeda[ TipoMoeda, 1], aMoeda[ TipoMoeda, 2 ])
	CASE grandeza = 4
	  cTexto += Iif(VAL(x)=1, aCentavo[1], aCentavo[2])
	CASE grandeza = nil
	  cTexto += ""
	ENDCASE
	return( cTexto )

def formata( _Txt, _Lin, _Tam )
********************************	
	LOCAL qtd_lin := mlcount(_txt, _tam)
	LOCAL _txtaux := ""
	LOCAL linha
	LOCAL _i
	
	qtd_lin := iif(qtd_lin > _lin, _lin, qtd_lin)
	for _i = 1 TO qtd_lin
		linha = alltrim(memoline(_txt,_tam,_i))
		if _i <> qtd_lin
			while( true )
				falta = _tam-Len(linha)
				if falta > 20 .OR. right(linha,1)="."
					exit
				endif
				if len(linha) < _tam
					linha = strtran(linha," ",Chr(177))
					FOR _j = 1 TO falta
						acha = rat(chr(177),linha)
						if acha = 0
							exit
						endif
						linha = stuff(linha,acha,1,"  ")
					next
					linha = strtran(linha,Chr(177)," ")
				endif
				if Len(trim(linha))= _tam
					exit
				endif
			enddo
		endif
		_txtaux = _txtaux + linha
	next
	_txtaux = left(alltrim(_txtaux) + replicate("*",_tam * _lin),_tam * _lin)
	return (_txtaux)

def CodiOriginal( cNr_Original )
*************************************
LOCAL Arq_Ant	:= Alias()
LOCAL Ind_Ant	:= IndexOrd()
LOCAL lRetVal	:= OK


cNr_Original := AllTrim( cNr_Original )
Lista->(Order( LISTA_N_ORIGINAL ))
if Lista->(!DbSeek( cNr_Original ))
	ErrorBeep()
	Alerta("Erro: Nao Encontrado.")
	lRetVal := FALSO
endif
AreaAnt( Arq_Ant, Ind_Ant )
return( lRetVal )

*==================================================================================================*		

def Amax( aArray )
	LOCAL nLen	 := Len( aArray )
	LOCAL nY 	 := 1
	LOCAL nMaior := 0
	LOCAL cMaior := ""
	LOCAL nPos	 := 0

	FOR nY := 1 To nLen
		xVar := ValType( aArray[nY])
		if xVar = "N"
			if aArray[nY] > nMaior
				nMaior := aArray[nY]
			endif
		endif
	Next
	return( nMaior )
endef

*==================================================================================================*		

def DelTemp()
	Aeval( Directory( "t0*.*"),   { | aFile | Ferase( aFile[ F_NAME ] )})
	Aeval( Directory( "t1*.*"),   { | aFile | Ferase( aFile[ F_NAME ] )})
	Aeval( Directory( "t2*.*"),   { | aFile | Ferase( aFile[ F_NAME ] )})
	Aeval( Directory( "t*.tmp"),  { | aFile | Ferase( aFile[ F_NAME ] )})
	return( nil )
endef

*==================================================================================================*		
	
def CopyOk( cUnidade )
	LOCAL c1 := 0 //RomCkSum()
	LOCAL lOk
	LOCAL String
	LOCAL Temp
	LOCAL fHandle
	LOCAL xArquivo := "SC" + AllTrim( Str( c1 )) + ".PPP"

	fHandle := Fopen( xArquivo, 2 )
	if fHandle = -1
		lOk = .F.
	else
		sTring := Space(8)
		Fread( fHandle, @sTring, 8 )
		lOk = Iif( string == MsDecrypt( STR(c1,8,0)), OK, false )
	endif
	FClose( fHandle)
	return( lOk )
endef

*==================================================================================================*		
	
def CopyCria()
	LOCAL lOk	  := FALSO
	LOCAL c1 	  := 0 // RomCkSum()
	LOCAL String
	LOCAL Temp
	LOCAL fHandle
	LOCAL xArquivo := "SC" + AllTrim( Str( c1 )) + ".PPP"

	fHandle := FCreate( xArquivo, 4 )
	if fHandle <> -1
		lOk := Iif( FWrite( fHandle, MsEncrypt( Str( c1, 8, 0 )), 8 ) = 8, OK, false )
		FClose( fHandle )
	endif
	return( lOk )
endef

*==================================================================================================*		
	
def MSDecToChr( cString )
	LOCAL cNewString := ""
	LOCAL nTam
	LOCAL nX
	LOCAL cNumero

	nTam := StrCount( "#", cString )
	For nX := 1 To nTam
		cNumero := StrExtract( cString, "#", nX+1 )
		cNewString += Chr( Val( cNumero ))
	Next
	return ( cNewString )
endef

*==================================================================================================*		
	
def Opcoes( Par1, Par2, Par3)
	LOCAL cScreen := SaveScreen()
	LOCAL nChoice
	LOCAL aMenuArray := { " Calculadora "," Calendario "," Tabela Ascii " }
	
	Set Key -9 To
	while(true)
		Menu:Limpa()
		StatusInf("ESCOLHA COM SETAS E TECLE ENTER", "ESC-RETORNA")
		M_Title( "OPCOES" )
		nChoice := FazMenu( 03, 60, aMenuArray, Cor())
		if nChoice = 0
			Set Key -9 To Opcoes() // F10
			resTela( cScreen )
			Exit
		endif
		oMenu:Limpa()
		Do Case
		Case nChoice = 1
			Calc()
		Case nChoice = 2
			Calendario()
		Case nChoice = 3
			Ascii()
		EndCase
	enddo
endef

*==================================================================================================*		
				 
def ResTela( cScreen )
	return(RestScreen(,,,,  cScreen ))
endef
	
*==================================================================================================*		

/*
def SaveScreen()
	cScreen := FTempName("T*.BMP")
	ScrToDisk( cScreen, 00, 00, MaxRow(), MaxCol())
	return( cScreen )
endef

*==================================================================================================*		

def ResTela( cScreen )
	return( DiskToScr( cScreen, 0, 0, MaxCol(), MaxCol() ))
endef
*/

*==================================================================================================*		
	
def CpfCgcIntToStr( nCpfCgc )
**********************************
LOCAL cCgc	:= AllTrim( Str( nCpfCgc ))
LOCAL nTam	:= Len( cCgc )

if nTam <= 11
	cCpf1 := Left( cCgc, 3 )
	cCpf2 := SubStr( cCgc, 4, 3 )
	cCpf3 := SubStr( cCgc, 7, 3 )
	cCpf4 := SubStr( cCgc, 10, 2 )
	cCgc	:= cCpf1 + "." + cCpf2 + "." + cCpf3 + "-" + cCpf4
else
	cCgc1 := Left( cCgc, 2 )
	cCgc2 := SubStr( cCgc, 3, 3 )
	cCgc3 := SubStr( cCgc, 6, 3 )
	cCgc4 := SubStr( cCgc, 9, 4 )
	cCgc5 := SubStr( cCgc, 13, 2 )
	cCgc	:= cCgc1 + "." + cCgc2 + "." + cCgc3 + "/" + cCgc4 + "-" + cCgc5
endif
return( cCgc )

def EanDig( cString )
**************************
LOCAL nNumero1
LOCAL nNumero2
LOCAL nX
LOCAL nSoma
LOCAL nResto
LOCAL nTotal
LOCAL nDig

nNumero1 := 0
nNumero2 := 0
For nX := 2 To 12 Step 2
	nNumero1 += Val(SubStr( cString, nX, 1 ))
Next
For nX := 1 To 12 Step 2
	nNumero2 += Val(SubStr( cString, nX, 1 ))
Next
nNumero1 *= 3
nNumero2 *= 1
nSoma := nNumero1 + nNumero2

nResto := Mod( nSoma, 10 )
nTotal := nSoma
if nResto <> 0
	nTotal -= nResto
	nTotal += 10
endif
nDig := nTotal - nSoma
return( StrZero( nDig, 1 ))

def R_NTX( ARG1, ARG2, ARG3, ARG4, ARG5, ARG6, ARG7, ARG8 )
****************************************************************
LOCAL LOCAL1
LOCAL LOCAL2
LOCAL LOCAL3
LOCAL1 := &( "{ || " + Trim(ARG1) + " }" )
LOCAL2 := LastRec()
LOCAL3 := R_Opnbar(Iif( ARG3 = Nil, "INDEXING: " + Trim(Alias()), ARG3 ), LTrim(Str(LOCAL2)) + " Registro(s)", ARG5, ARG6, ARG7, ARG8)
if ( LOCAL2 == 0 )
	LOCAL2 := 1
endif
Index On ( R_Updbar(LOCAL3, 100 * RecNo() / LOCAL2), Eval(LOCAL1) ) To (ARG2)
R_Clsbar(LOCAL3)
return Nil

*:--------------------------------------------------------
def R_CLSBAR( ARG1 )
*************************
Local LOCAL1
LOCAL1 := Set(_SET_DEVICE, "SCREEN")
if ( ValType(ARG1) = "A" )
	RestScreen(ARG1[ 2 ], ARG1[ 3 ], ARG1[ 2 ] + 5, ARG1[ 3 ] + 54, ARG1[ 1 ])
endif
Set(_SET_DEVICE, LOCAL1)
return Nil

*:-----------------------------------------------------
def R_OPNBAR( ARG1, ARG2, ARG3, ARG4, ARG5, ARG6 )
*******************************************************
Local LOCAL1, LOCAL2, LOCAL3, LOCAL4, LOCAL5, LOCAL6, LOCAL7, LOCAL8, LOCAL9, LOCAL10, LOCAL11
LOCAL1 := {}
LOCAL3 := Set(_SET_DEVICE, "SCREEN")
LOCAL9 := "™ëçöòñåãöçöõﬂâöçåñêëﬂêôﬂ≠†Ωûç≥ñù◊÷ﬂ“ﬂàûñãﬂ«ﬂåöúêëõå—"
LOCAL10 := ""
For LOCAL11 := 1 To Len(LOCAL9)
	LOCAL10 := LOCAL10 + Chr(255 - Asc(SubStr(LOCAL9, LOCAL11, 1)))
Next
ARG2 := Iif( ARG2 = Nil, "", ARG2 )
ARG3 := Iif( ARG3 = Nil, 10, ARG3 )
ARG4 := Iif( ARG4 = Nil, 13, ARG4 )
ARG5 := Iif( ARG5 = Nil, "W+/B", ARG5 )
ARG6 := Iif( ARG6 = Nil, "GR+/B", ARG6 )
if ( ARG3 > 19 )
	ARG3 := 19
endif
if ( ARG4 > 25 )
	ARG4 := 25
endif
LOCAL5 := ARG3 + 4
LOCAL6 := ARG4 + 53
AAdd(LOCAL1, SaveScreen(ARG3, ARG4, LOCAL5 + 1, LOCAL6 + 1))
LOCAL2 := SetColor(ARG5)
Bar_Shbox(ARG3, ARG4, LOCAL5, LOCAL6)
if ( !Empty(ARG1) )
	if ( Len(ARG1) > LOCAL6 - ARG4 - 3 )
		ARG1 := Left(ARG1, LOCAL6 - ARG4 - 3)
	endif
	@ ARG3, ARG4 + ( LOCAL6 - ARG4 - Len(ARG1) - 1 ) / 2 Say "˛ " + ARG1 + " ˛"
endif
if ( !Empty(ARG2) )
	if ( Len(ARG2) > LOCAL6 - ARG4 - 3 )
		ARG2 := Left(ARG2, LOCAL6 - ARG4 - 3)
	endif
	@ LOCAL5, ARG4 + ( LOCAL6 - ARG4 - Len(ARG2) - 1 ) / 2 Say "˛ " + ARG2 + " ˛"
endif
@ ARG3 + 1, ARG4 + 25 Say Transform(0, "999%")
@ ARG3 + 3, ARG4 + 2 Say ""
For LOCAL4 := 1 To 9
	@ ARG3 + 3, ARG4 + 1 + LOCAL4 * 5 Say ""
Next
@ ARG3 + 3, LOCAL6 - 2 Say ""
@ ARG3 + 2, ARG4 + 2 Say Replicate(".", 50)
Set Color To (LOCAL2)
AAdd(LOCAL1, ARG3)
AAdd(LOCAL1, ARG4)
AAdd(LOCAL1, Iif( Procname(1) = "R_NTX", -1, 0 ))
AAdd(LOCAL1, ARG5)
AAdd(LOCAL1, ARG6)
Setcursor(0)
Set(_SET_DEVICE, LOCAL3)
return LOCAL1

*:--------------------------------------------------------
def R_PACK( ARG1, ARG2, ARG3, ARG4, ARG5 )
***********************************************
Local LOCAL1, LOCAL2, LOCAL3, LOCAL4, LOCAL5, LOCAL6
LOCAL1 := Alias()
LOCAL2 := Iif( LastRec() < 1, 1, LastRec() )
LOCAL3 := 0
LOCAL4 := Set(_SET_DELETED, .T.)
LOCAL5 := {}
LOCAL6 := R_Opnbar(Iif( ARG1 = Nil, "PACKING: " + Trim(Alias()), ARG1 ), LTrim(Str(LOCAL2)) + " record(s)", ARG2, ARG3, ARG4, ARG5)
Copy Structure To RvGTmp
Use RvGTmp New
Select (LOCAL1)
Goto Top
DBEval({ || ( LOCAL5 := Bar_Getrec(), Rvgtmp->( dbAppend() ), Rvgtmp->( Bar_Putrec(LOCAL5) ) ) }, { || !Deleted() }, { || R_Updbar(LOCAL6, 100 * ( LOCAL3 := LOCAL3 + 0.5 ) / LOCAL2) }, Nil, Nil, ;
	.F.)
Zap
Select RVGTmp
Goto Top
DBEval({ || ( LOCAL5 := Bar_Getrec(), dbSelectArea(LOCAL1), dbAppend(), Bar_Putrec(LOCAL5), dbSelectArea("RVGTmp") ) }, Nil, { || R_Updbar(LOCAL6, 100 * ( LOCAL3 := LOCAL3 + 0.5 ) / LOCAL2) }, ;
	Nil, Nil, .F.)
dbCloseArea("RVGTmp")
Select (LOCAL1)
Erase RvGTmp.DBF
Erase RvGTmp.DBT
Set Deleted (LOCAL4)
return R_Clsbar(LOCAL6)

*:--------------------------------------------------------
def R_UPDBAR( ARG1, ARG2 )
*******************************
Local LOCAL1, LOCAL2, LOCAL3
if ( ARG2 > 100 )
	ARG2 := 100
endif
LOCAL3 := Int(ARG2 / 2)
if ( ValType(ARG1) = "A" )
	if ( ARG1[ 4 ] < 0 )
		ARG1[ 4 ] := 0
	elseif ( LOCAL3 > ARG1[ 4 ] )
		LOCAL2 := Set(_SET_DEVICE, "SCREEN")
		LOCAL1 := SetColor(ARG1[ 5 ])
		@ ARG1[ 2 ] + 1, ARG1[ 3 ] + 25 Say Transform(ARG2, "999%")
		Set Color To (ARG1[ 6 ])
		@ ARG1[ 2 ] + 2, ARG1[ 3 ] + 2 Say Replicate("€", LOCAL3)
		ARG1[ 4 ] := LOCAL3
		Set Color To (LOCAL1)
		Set(_SET_DEVICE, LOCAL2)
	endif
endif
return .T.

*:--------------------------------------------------------
Static def BAR_GETREC
**************************
Local LOCAL1
LOCAL1 := {}
Aeval(Dbstruct(), { | _1, _2 | AAdd(LOCAL1, Fieldget(_2)) })
return LOCAL1

*:--------------------------------------------------------
Static def BAR_PUTREC( ARG1 )
**********************************
Aeval(Dbstruct(), { | _1, _2 | Fieldput(_2, ARG1[ _2 ]) })
return Nil

*:--------------------------------------------------------
Static def BAR_SHBOX( ARG1, ARG2, ARG3, ARG4 )
***************************************************
Local LOCAL1, LOCAL2
Scroll(ARG1, ARG2, ARG3, ARG4)
DispBox(ARG1, ARG2, ARG3, ARG4)
LOCAL1 := SaveScreen(ARG3 + 1, ARG2 + 1, ARG3 + 1, ARG4 + 1)
For LOCAL2 := 2 To Len(LOCAL1) Step 2
	LOCAL1 := Stuff(LOCAL1, LOCAL2, 1, "")
Next
RestScreen(ARG3 + 1, ARG2 + 1, ARG3 + 1, ARG4 + 1, LOCAL1)
LOCAL1 := SaveScreen(ARG1 + 1, ARG4 + 1, ARG3 + 1, ARG4)
For LOCAL2 := 2 To Len(LOCAL1) Step 2
	LOCAL1 := Stuff(LOCAL1, LOCAL2, 1, "")
Next
RestScreen(ARG1 + 1, ARG4 + 1, ARG3 + 1, ARG4, LOCAL1)
return Nil

def NtxProgress
********************
	LOCAL nReg		 := Recno()
	LOCAL nUltimo	 := LastRec()
	LOCAL nPorcento := ( nReg / nUltimo ) * 100
	LOCAL cComplete := LTrim( Str( Int( nPorcento )))

	if cComplete = "99"
		cComplete := "100"
	endif
	@ 08, 11 Say "˛ " + LTrim(Str(nReg)) + " de " + LTrim(Str(nUltimo )) + " Registros"
	@ 09, 11 Say "˛ " + cComplete + "%"
	@ 10, 11 Say Replicate("€", nPorcento/2 ) Color "W+/r"
	return .T.

def LookUp( cString, aArray )
**********************************
	// aDados := Chemov->(LookUp( '0000', {'Hist','Data', 'Docnr', 'Deb', 'Cre'})) //
	LOCAL aDados := {}
	LOCAL nY 	 := Len( aArray )
	LOCAL nX 	 := 0

	if DbSeek( cString )
		For nX := 1 To nY
			Aadd( aDados, FieldGet( FieldPos( aArray[ nX ] )))
		Next
	endif
	return( aDados )

def MsDecrypt( Pal )
**************************
	LOCAL cChave	:= ""
	LOCAL nX 		:= 0

	For nX := 0 To 10
		cChave += Chr( Asc( Chr( nX )))
	Next
	return( Decrypt( Pal, cChave ))

def MsEncrypt( Pal )
*************************
	LOCAL cChave	:= ""
	LOCAL nX 		:= 0

	For nX := 0 To 10
		cChave += Chr( Asc( Chr( nX )))
	Next
	return( Encrypt( Pal, cChave ))

def FazMenu( nTopo, nEsquerda, aArray, Cor )
*************************************************
	LOCAL cFrame     := m_Frame()
	LOCAL cFrame2	  := SubStr( "’Õ∏≥æÕ‘≥", 2, 1 )
	LOCAL nFundo	  := ( nTopo + Len( aArray ) + 3 )
	LOCAL nTamTitle  := ( Len( m_Title() ) + 12 )
	LOCAL nDireita   := ( nEsquerda + AmaxStrLen( aArray ) + 3 )
	LOCAL cTitulo    := m_Title() 
	LOCAL cChar      :=  "≥˚≥≥≥"
	
   hb_default(@Cor, oAmbiente:CorMenu)
	if ( nDireita - nEsquerda ) <  nTamTitle
		nDireita := ( nEsquerda + nTamTitle )
	endif
	
	if ( nFundo > MaxRow() )
		nFundo := MaxRow()-2
	endif
	
	MS_Box( nTopo, nEsquerda, nFundo, nDireita, cFrame, Cor )
	Print( nFundo-2, nEsquerda+1, Repl(SubStr( cFrame,2,1),(nDireita-nEsquerda)-1), Cor)
	Print( nFundo-1, nEsquerda+1, cTitulo, Roloc( Cor ), (nDireita-nEsquerda)-1)
	Print( nFundo-1, nDireita-8, cChar, Roloc( Cor ))
	nSetColor( Cor, oAmbiente:CorLightBar, Roloc( Cor ))
	//nChoice := Mx_Choice( @nTopo, @nEsquerda, aArray, Cor )
	return( nChoice := Achoice( nTopo+1, nEsquerda+1, nFundo-3, nDireita-1, aArray))
	
*--------------------------------------------------------------------------*	
def MaBox( nTopo, nEsq, nFundo, nDireita, Cabecalho, Rodape, lInverterCor )
*--------------------------------------------------------------------------*
	LOCAL cPattern := " "
	LOCAL pfore 	:= oAmbiente:Cormenu
	LOCAL pback    := oAmbiente:CorLightBar	
	LOCAL cCor     := oAmbiente:CorLightBar
	LOCAL pUns     := Roloc( pFore )
	
	hb_default(@nTopo, 0)
	hb_default(@nEsq, 0)
	hb_default(@nFundo,   maxrow())
	hb_default(@nDireita, maxcol())
	
	if(nDireita > maxcol(), nDireita := maxcol(), nDireita)		
	if(nFundo   > maxrow(), nFundo   := maxrow(), nFundo)	
	
   DispBegin()
	hb_DispBox( nTopo, nEsq, nFundo, nDireita, oAmbiente:Frame + cPattern, pfore )
   if oAmbiente:Sombra
      hb_Shadow( nTopo, nEsq, nFundo, nDireita)
   endif   
	
	if !(IsNil(Cabecalho))
		aPrint( nTopo, nEsq+1, "€", cCor, (nDireita-nEsq)-1)
		aPrint( nTopo, nEsq+1, Padc( Cabecalho, ( nDireita-nEsq)-1), cCor )
	endif
	
	if !(IsNil(Rodape))
		aPrint( nFundo, nEsq+1, "€", cCor, (nDireita-nEsq)-1)
		aPrint( nFundo, nEsq+1, Padc( Rodape, ( nDireita-nEsq)-1), cCor )
	endif
	nSetColor( pfore, pback, pUns )
   DispEnd()
	return NIL
endef
	
def MS_Box( nRow, nCol, nRow1, nCol1, cFrame, nCor)
********************************************************
	LOCAL nComp  := ( nCol1 - nCol )-1
	DEFAU cFrame TO M_Frame()
	DEFAU nCor	 TO Cor()

	Hb_DispBox( nRow, nCol, nRow1, nCol1, cFrame + " ", nCor)
   if oAmbiente:Sombra
      Hb_Shadow( nRow, nCol, nRow1, nCol1)   
   endif
   return nil

	//Box( nRow, nCol, nRow1, nCol1, M_Frame() + " ", nCor, 1, 8 )      // Funcky
	//DispBox( nRow, nCol, nRow1, nCol1, M_Frame() + " ", nCor, 1, 8 )  // Harbour

	for x := nRow To nRow1
		Print( x, nCol, Space(1), nCor, nComp+1, " ")
	next

	Print( nRow, nCol, Left(cFrame,1), nCor, 1 )
	Print( nRow, nCol+1, Repl(SubStr(cFrame,2,1),nComp), nCor )
	Print( nRow, nCol1, SubStr(cFrame,3,1), nCor, 1 )
	
	for x := nRow+1 To nRow1
		Print( x, nCol,  SubStr(cFrame,4,1), nCor, 1 )
		Print( x, nCol1, SubStr(cFrame,8,1), nCor, 1 )
	Next
	
	Print( nRow1, nCol, SubStr(cFrame,7,1),  nCor, 1 )
	Print( nRow1, nCol+1, Repl(SubStr(cFrame,6,1),nComp), nCor )
	Print( nRow1, nCol1, SubStr(cFrame,5,1), nCor, 1 )
return NIL

def Conf( Texto, aPrompt, cor)
   LOCAL cScreen   := SaveScreen()	
	LOCAL Les		 := 19
	LOCAL Exceto	 := .F.
	LOCAL Ativo 	 :=  1
	LOCAL aArray	 := { " Sim ", " Nao " }
	LOCAL cFundo	 := 207
	LOCAL cFrente	 := 192
	LOCAL Largjan	 := Len( Texto ) + 2
	LOCAL cFrame    := oAmbiente:Frame
	LOCAL nRetVal
	LOCAL PBack
	LOCAL nLen
	LOCAL Ces
	LOCAL Com
	LOCAL Coluna
	LOCAL nRow
	LOCAL nCol
	LOCAL nComp
	LOCAL nChoice
	LOCAL Centralizar := false
	LOCAL lPrompt     := true
	
	__DefaultNIL(@cor, oAmbiente:CorMsg)
	if aPrompt == nil .OR. !(IsArray(aPrompt))
	   aPrompt := aArray	
	endif
	nRetval := AlertaPy(Texto + ';-;;', cor, centralizar, lPrompt, aPrompt)
	restela(cScreen)
	return( nRetVal == 1 )
		
	if aPrompt == NIL
		if oAmbiente:Visual
			return(( nButton := MsgBox2( Texto ) == 1 ))
			ResTela( cScreen )
		endif
	endif

	LargJan := Iif( LargJan < 16, 16, LargJan )
	Les	  := Iif( Les = Nil .OR. Les = 0, 19, Les )
	Ces	  := (MaxCol()-LargJan)/2
	Com	  := Ces + LargJan
	Coluna  := (LargJan - 9 ) / 2
	nRow	  := Les + 2
	nCol	  := Ces + Coluna
	nBot	  := Les + 3
	nComp   := ( Com - Ces )-1
	
	M_Title( Texto )
	if aPrompt != NIL
		nLen := Len( aPrompt )
		//ColorSet( @cFundo, @PBack )
		MSFrame( Les-nLen, Ces, Les+3, Com, oAmbiente:CorMsg )
		nChoice := aChoice( (Les-nLen)+3, Ces+4, Les+5, Com-3, aPrompt )
		ResTela( cScreen )
		return( nChoice )
	endif
	//ColorSet( @cFundo, @PBack )
	MsFrame( Les-2, Ces, Les+3, Com, oAmbiente:CorMsg )
	nRetVal := aChoice( Les+1, Ces+4, Les+5, Com-3, aArray )
	ResTela( cScreen )
	return( nRetVal == 1 )

def MsFrame( nTopo, nEsquerda, nFundo, nDireita, Cor )
***********************************************************
	LOCAL cFrame2	:= SubStr( oAmbiente:Frame, 2, 1 )
	LOCAL pFore 	:= Iif( Cor = NIL, Cor(), Cor )
	LOCAL cPattern := " "
	LOCAL pBack

	ColorSet( @pfore, @pback )
	Box( nTopo, nEsquerda, nFundo, nDireita, oAmbiente:Frame + cPattern, pFore  )
	cSetColor( SetColor())
	nSetColor( pFore, Roloc( pFore ))
	@ nTopo+2, nEsquerda+1 SAY Repl( cFrame2, (nDireita - nEsquerda )-1 )
	@ nTopo+3, nEsquerda+2 TO  nFundo-1,nEsquerda+2
	@ nTopo+1, nEsquerda+1 SAY Padc( M_Title(), nDireita-nEsquerda-1)
	@ nTopo+3, nDireita-2  TO  nFundo-1, nDireita-2
return( NIL )

def IntToStrRepl( nValor, nTam )
************************************
	LOCAL cStr := StrTran( StrTran( Tran( nValor, "9999999999999.99" ), ".")," ", "0")
	return( Right( cStr, nTam ))

Proc LigaTela()
***************
	Set Cons On
	Set Devi To Screen
	return

Proc DesLigaTela()
******************
	Set Cons Off
	Set Devi To Print
	return

def AchaSegunda( dDate )
*****************************
	if cDow( dDate ) = 'Monday'
		return( dDate + 7 )
	endif
	For i = 1 To 7
		 if cDow( dDate + i ) = 'Monday'
			 return( dDate + i )
		 endif
	Next
	return dDate

def TempNew( cDeleteFile)
******************************
	LOCAL xTemp := FTempName()
	//LOCAL cTela := Mensagem("Aguarde, Criando Arquivo Temporario.")

	Ferase("*.tmp")
	//WHILE !File((xTemp))
		//xTemp := FTempName()
	//EndDo
	//ResTela( cTela )   
	return((FTempName())) 

def RetPerc( nDivisor, nDividendo )
****************************************
	LOCAL nDivi  := nDivisor / nDividendo
	LOCAL nMult  := nDivi * 100
	LOCAL Result := ( nMult - 100 )

	if Result == -100
		Result := 100
	endif
	return( Result )

*:--------------------------------------------------------
def RD( ARG1 )

	Local LOCAL1, LOCAL2
	static1 := 1
	LOCAL1 := Seconds()
	Do While ( ARG1 > LOCAL1 )
		LOCAL1 := LOCAL1 * 100 + Seconds()
	EndDo
	STATIC1 := ( STATIC1 + LOCAL1 ) / ( LOCAL2 := STATIC1 * LOCAL1 % ARG1 + 1 )
	return Int(LOCAL2)

* EOF

*:-------------------------------------------------------
Procedure SHUFFLE

	Local LOCAL1, LOCAL2, LOCAL3, LOCAL4, LOCAL5, LOCAL6, LOCAL7, LOCAL8, LOCAL9, LOCAL10, LOCAL11, LOCAL12, LOCAL13, LOCAL14, LOCAL15
	LOCAL1 := 5 * Rd(5) - 1
	LOCAL2 := 10 * Rd(8) - 1
	LOCAL3 := LOCAL1 - 4
	LOCAL4 := LOCAL2 - 9
	LOCAL5 := 0
	LOCAL9 := Setcursor(0)
	LOCAL10 := Row()
	LOCAL11 := Col()
	LOCAL12 := SaveScreen()
	LOCAL15 := SetColor("W/N")
	Scroll(LOCAL3, LOCAL4, LOCAL1, LOCAL2)
	Do While ( InKey(0.05) == 0 )
		LOCAL13 := {}
		LOCAL14 := 0
		if ( LOCAL1 < 24 .AND. LOCAL5  !=  3 )
			AAdd(LOCAL13, 1)
			LOCAL14++
		endif
		if ( LOCAL4 > 0 .AND. LOCAL5	!=  4 )
			AAdd(LOCAL13, 2)
			LOCAL14++
		endif
		if ( LOCAL3 > 0 .AND. LOCAL5	!=  1 )
			AAdd(LOCAL13, 3)
			LOCAL14++
		endif
		if ( LOCAL2 < 79 .AND. LOCAL5  !=  2 )
			AAdd(LOCAL13, 4)
			LOCAL14++
		endif
		LOCAL5 := LOCAL13[ Rd(LOCAL14) ]
		LOCAL7 := LOCAL8 := 0
		Do Case
		Case LOCAL5 == 1
			LOCAL1 := LOCAL1 + 5
			LOCAL7 := 1
		Case LOCAL5 == 2
			LOCAL4 := LOCAL4 - 10
			LOCAL8 := -2
		Case LOCAL5 == 3
			LOCAL3 := LOCAL3 - 5
			LOCAL7 := -1
		Case LOCAL5 == 4
			LOCAL2 := LOCAL2 + 10
			LOCAL8 := 2
		EndCase
		For LOCAL6 := 1 To 5
			Scroll(LOCAL3, LOCAL4, LOCAL1, LOCAL2, LOCAL7, LOCAL8)
			if ( InKey(0.05)	!=  0 )
				Exit
			endif
		Next
		if ( LOCAL6 <= 5 )
			Exit
		endif
		Do Case
		Case LOCAL5 == 1
			LOCAL3 := LOCAL3 + 5
		Case LOCAL5 == 2
			LOCAL2 := LOCAL2 - 10
		Case LOCAL5 == 3
			LOCAL1 := LOCAL1 - 5
		Case LOCAL5 == 4
			LOCAL4 := LOCAL4 + 10
		EndCase
	EndDo
	Set Color To (LOCAL15)
	RestScreen(Nil, Nil, Nil, Nil, LOCAL12)
	SetPos(LOCAL10, LOCAL11)
	Setcursor(LOCAL9)
	return
*:-------------------------------------------------------

Proc ScrollEsq()
****************
	LOCAL i

	for i := 1 To 13
		//Shift( 0, 0, 24, MaxCol(), -i )
		//   Inkey(.01)
	next
	return

*:-------------------------------------------------------

Proc ScrollDir()
****************
	LOCAL i

	for i := 1 To 13
		//Shift( 0, 0, 24, MaxCol(), i )
		//Inkey(.01)
	next
	return

*:-------------------------------------------------------

Proc CenturyOn()
*****************
	Set Cent On
	return

Proc CenturyOff()
****************
	Set Cent Off
	return

def FTempMemory()
*----------------*
	LOCAL cFile := ""	
	LOCAL nNumber 
	LOCAL cNumber 
	LOCAL snRandom := Seconds() / Exp(1) 
   LOCAL nLimit   := 65535 
	
	snRandom := Log( snRandom + Sqrt(2) ) * Exp(3) 
   snRandom := Val( Str(snRandom - Int(snRandom), 17, 15 ) ) 	
	nNumber  := HB_RandomInt(snRandom, 999999)	
	cNumber  := StrZero(nNumber, 7)	
	cFile    := 'mem' + cNumber	
	return cFile
endef	
	
def FTempRandomName( xCoringa, cDir )
*+-----------------------------------+*
	LOCAL cFile  := ""	
	LOCAL cExt 
	LOCAL nNumber 
	LOCAL cNumber 
	LOCAL snRandom := Seconds() / Exp(1) 
   LOCAL nLimit   := 65535 
	
	hb_default(@xCoringa, "t*.tmp")
   if at(".", xCoringa ) != 0
      cExt := "." + GetFileExtension(xCoringa)
   else
      cExt := "." + xCoringa
   endif   
	snRandom := Log( snRandom + Sqrt(2) ) * Exp(3) 
   snRandom := Val( Str(snRandom - Int(snRandom), 17, 15 ) ) 	
	nNumber  := HB_RandomInt(snRandom, 999999)	
	cNumber  := StrZero(nNumber,7)	
	cFile    := 't' + cNumber + cExt
	return cFile
endef		

*----------------------------------------------------------------------------------------------------------------------*

def GetFileExtension(cFile)   
	return(substr( cFile, at( ".", cFile ) + 1, 3 ))
endef	

*----------------------------------------------------------------------------------------------------------------------*

def FTempName( xCoringa, cDir )
	LOCAL cTempFile := ""
	LOCAL nConta    := 0
	LOCAL cTela     := Mensagem("Aguarde, Criando Arquivo Temporario.")
	
	hb_default(@cDir, ms_swap_tmp())	
	hb_default(@xCoringa, "t*.tmp")			
	//Aeval( Directory( cDir + xCoringa), { | aFile | ms_swap_ferase( aFile[F_NAME])})	

	cTempFile := cDir + FTempRandomName(xCoringa, cDir)
	While !file(cTempFile) .AND. nConta <= 100
		cTempFile := cDir + FTempRandomName(xCoringa, cDir)
		nConta++
	EndDo	
	restela(cTela)
	return( cTempFile )
endef

*----------------------------------------------------------------------------------------------------------------------*

def FTempPorExt(cExt, cDir)
   LOCAL cFile := ""

   hb_default(@cExt, 'tmp')      
   switch lower(cExt)
   case 'txt'
   case 'prn' 
      if isnil(cDir)
         cDir := oAmbiente:xBaseTmp
      endif   
      cDir += _SLASH_      
      return FTempName(cExt, cDir)
      exit
   case 'htm' 
      if isnil(cDir)
         cDir := oAmbiente:xBaseHtm
      endif   
      cDir += _SLASH_      
      return FTempName(cExt, cDir)   
      exit
   case 'doc' 
      if isnil(cDir)
         cDir := oAmbiente:xBaseDoc
      endif   
      cDir += _SLASH_      
      return FTempName(cExt, cDir)   
      exit
   otherwise
      if isnil(cDir)
         cDir := oAmbiente:xBaseTmp
      endif   
      cDir += _SLASH_      
      return FTempName('tmp', cDir)   
      exit   
   endswitch
endef

*==================================================================================================*
	
def HB_TempName()
*********************
   LOCAL nFileHandle
   LOCAL cFileName

   nFileHandle := HB_FTempCreate( ,,, @cFileName )

   if nFileHandle > 0
     FClose( nFileHandle )
   endif
   return cFileName
	
def MS_TempName( xCoringa, cDir ) 
*-------------------------------*
	//return(FT_TEMPFIL( FCurdir()))
	//return(HB_FTEMPCREATE())
	//return(HB_FTEMPCREATEeX())
	LOCAL nPos     := Rat(".", xCoringa)
	LOCAL nLen     := Len(xCoringa)	
	DEFAU cDir TO oAmbiente:xBaseTmp
			xCoringa := AllTrim(xCoringa)
			xCoringa := SubStr(xCoringa, nPos, 4)
			
	return(Upper(TempFile(cDir, xcoringa)))

def nTrim( nVal)	
*********************
	return( Trim(ValToStr(nVal)))
endef	
		
def xt_Random( nLimit )
**************************** 
   STATIC snRandom := Nil 
   LOCAL nDecimals
	LOCAL cLimit

   DEFAULT snRandom TO Seconds() / Exp(1) 
   DEFAULT nLimit   TO 65535 
   snRandom  := Log( snRandom + Sqrt(2) ) * Exp(3) 
   snRandom  := Val( Str(snRandom - Int(snRandom), 17, 15 ) ) 

   nDecimals := At(".", cLimit) 
   if nDecimals > 0 
      nDecimals := Len(cLimit)-nDecimals 
   endif 
   return Round( nLimit * snRandom, nDecimals )		

Proc Sx_Filter( xStrTop, xStrBottom )
*************************************
	Sx_ClrScope( 0 )
	Sx_ClrScope( 1 )
	Sx_SetScope( 0, xStrTop )
	Sx_SetScope( 1, xStrBottom )
	return

Proc Sx_DbSetFilter( xStrTop, xStrBottom )
******************************************
	Sx_ClrScope( S_TOP )
	Sx_ClrScope( S_BOTTOM )
	Sx_SetScope( S_TOP, xStrTop )
	Sx_SetScope( S_BOTTOM, xStrBottom )
	return

Proc Sx_DbClearFilter()
***********************
	Sx_ClrScope( S_TOP )
	Sx_ClrScope( S_BOTTOM )
	DbGoTop()
	return

def Sx_Count()
*******************
	if !Eof()
		return( 1 )
	endif
	return( 0)

def lAnoBissexto( dData )
	LOCAL nAno := Year( dData )
	return( nAno % 4 == 0 .AND. nAno % 100 != 0)
endef	

def DaysInAMonth(dIni, nMes, lString)
******************************************
	LOCAL aDias := {31 , 28 , 31 , 30 , 31 , 30 , 31 , 31 , 30 , 31 , 30 , 31} 
	LOCAL Result

	hb_default(@dIni, Date())
	hb_default(@nMes, Month(dIni))
	hb_default(@lString, FALSO)

	Result := aDias[nMes] 
	if (nMes = 2) .and. IsLeapYear(dIni)
		Result := 29 
	endif	
	return(if(lString == true , strzero(result,2), result))
	
def NomeMesesDoAno(dIni, nMes, lAbreviado, lUpper)
*******************************************************
	LOCAL aStringMes := {"Janeiro","Fevereiro","Marco","Abril","Maio","Junho","Julho","Agosto","Setembro","Outubro","Novembro","Dezembro"} 
	LOCAL Result

	hb_default(@dIni, Date())
	hb_default(@nMes, Month(dIni))
	hb_default(@lAbreviado, FALSO)
	hb_default(@lUpper, FALSO)

	Result := aStringMes[nMes] 	
	return(if(lUpper, upper(if(lAbreviado, Left(Result,3), Result)), Result))

def LastDayOfMonth(dIni, nMes, lString)
********************************************
	return(DaysInAMonth(dIni, nMes, lString))
	
def StringToData(cString)
******************************
	hb_default(@cString, Dtoc(Date()))
	return(cTod(cString))

def DataToString(dData)	
****************************
	hb_default(@dData, Date())
	return(Dtoc(dData))

def FirstDayOfMonth(dIni, nMes, lString)
*********************************************
	LOCAL Result	
	hb_default(@dIni, Date())
	hb_default(@nMes, Month(dIni))
	Result := 1
	return(if(lString == true , strzero(result, 2), result))
 
def NextMonth(dIni) 
************************
	hb_default(@dIni, Date())
	return(month(dIni + 1))

def IsLeapYear(dData)
**************************
	LOCAL nAno := Year( dData )
	return( nAno % 4 == 0 .AND. nAno % 100 != 0)

def DayOfWeek(dIni)
*************************
	hb_default(@dIni, Date())
	return(Day(dIni))

def Grafico( aArray, MostraVal, Titulo1, Titulo2, Titulo3, nBase )
***********************************************************************
LOCAL Porc     := 0
LOCAL aNumero  := {}
LOCAL CorBarra := { "W/N",  "G/W",  "BG/W", "R/W", "GR/W", "B/W", "RB/W", "W/N",;
						  "BG+/W", "G/W", "GR+/W", "B+/W",;
						  "W/N",  "G/W",  "BG/W", "R/W", "GR/W", "B/W", "RB/W", "W/N",;
						  "BG+/W", "G/W", "GR+/W", "B+/W" }
LOCAL CorLetra := { "N/W",  "N/G",  "N/BG", "N/R", "N/GR", "N/B", "N/RB", "N/W",;
						  "N/BG+", "N/G+", "N/GR+", "N/B+",;
						  "N/W",  "N/G",  "N/BG", "N/R", "N/GR", "N/B", "N/RB", "N/W",;
						  "N/BG+", "N/G+", "N/GR+", "N/B+" }

LOCAL Tam      := Len(aArray)
LOCAL aChr     := Array(Tam)
LOCAL nMaxRow  := MaxRow()
LOCAL nMaxCol  := MaxCol()
LOCAL Larg     := Round((nMaxCol*.75)/Tam,0)
LOCAL T        := 0
LOCAL Escala   := 0
LOCAL Porc1    := 0
LOCAL Num      := 0
LOCAL Num1     := 0
LOCAL Num2     := 0
LOCAL xY

nBase 	  := Iif( nBase = Nil, 1, nBase )
MostraVal  := Iif( MostraVal = NIL, .F., .T. )
Afill(aChr, Chr(219))
Porc       := aMax( aArray[1])

For xY     := 1 To Tam
	Aadd( aNumero, aArray[ xY, 1 ])
Next xY

Porc   := aMax( aNumero )
Escala := Porc / 10
Porc1  := Porc
Num    := 0
Num1   := 0
Num2   := 0

MaBox(01, 00, nMaxRow-1, nMaxCol, Titulo1 + " - " + Titulo2)
oMenu:StatSup()
oMenu:StatInf()

For nX := 2 To (nMaxRow-4)
   Write( nX, 6, Chr(179))
Next nX

For nY := 2 To (nMaxRow-3) Step 4
   Write( nY, 01, Tran(Int(Porc/nBase), "999999") + Repl(Chr(196),nMaxCol-10))
	Porc -= Escala
Next nY

Write( nX, 6, Chr(192) + Repl(Chr(196),nMaxCol-8))
t := (6-Larg)
For nN := 1 To Tam
   Write(nMaxRow-2, T + Larg + 1, Left( aArray[ nN, 2 ], Larg ) )
   Pos := Int( aArray[nN,1] * (nMaxRow-5) / Porc1 )
   Bar := ( nMaxRow-4 - Pos ) + 1
   For j := nMaxRow-4 To Bar Step -1
      @ j, t + Larg+1 Say Repl(aChr[nN],Larg) Color CorBarra[nN]
	Next J
	if MostraVal
      @ Bar, t + Larg + ( Larg / 2 )-3 Say Tran(Int( aArray[ nN, 1 ]/nBase), "99999999") Color CorLetra[nN]
	endif
   t += ( Larg + 1 )
Next nN

/*
if Titulo1 != NIL
   Write( MaxRow()-1, 00, Padc(Titulo1 + " - " + Titulo2, nMaxCol))
endif
if Titulo3 != NIL
   Write( 00, 00, Padc(Titulo3, nMaxCol))
endif
return Nil
*/

def Tecla_ESC()
********************
	LOCAL cScreen := SaveScreen()

	if Inkey() == ESC
		ErrorBeep()
		return(Conf("Pergunta: Deseja cancelar?"))
	endif
	return(FALSO)

def RJust( cString, nTam, cChar)
************************************
	LOCAL nLenStr  := Len(cString)
	LOCAL cStrTrim := AllTrim(cString)
	LOCAL nLenTrim := Len(cStrTrim)
	LOCAL cRetChar

	if( cChar = NIL, cChar := Space(1), cChar )
	if( nTam  = NIL, nTam  := (nLenStr-nLenTrim), nTam := (nTam-nLenTrim))
	cRetChar := Replicate(cChar, nTam) + cStrTrim
	return( cRetChar )

def LJust( cString, nTam, cChar)
************************************
	LOCAL nLenStr  := Len(cString)
	LOCAL cStrTrim := AllTrim(cString)
	LOCAL nLenTrim := Len(cStrTrim)
	LOCAL cRetChar

	if( cChar = NIL, cChar := Space(1), cChar )
	if( nTam  = NIL, nTam  := (nLenStr-nLenTrim), nTam := (nTam-nLenTrim))
	cRetChar := cStrTrim + Replicate(cChar, nTam)
	return( cRetChar )

def FBof( nHandle )
************************
   return FTell( nHandle) == 0

def FBot( nHandle )
************************
   LOCAL nPos := FSeek( nHandle, 0, FS_END )
   return nPos	!= -2	
		
def FTop( nHandle )
************************
   LOCAL nPos := FSeek( nHandle, 0, FS_SET )
   return nPos	!= -2	

def MS_FReadStr( nH, cB, nMaxLine )
	LOCAL cLine
	LOCAL nSavePos
	LOCAL nEol
	LOCAL nNumRead
	#define EOL HB_OSNEWLINE()
	
	if( nMaxLine = NIL, nMaxLine := 512, nMaxLine)
	cLine := space( nMaxLine )
	cB    := ''
	nSavePos := FSEEK( nH, 0, FS_RELATIVE )
	nNumRead := FREAD( nH, @cLine, nMaxLine )
	if ( nEol := AT( EOL, substr( cLine, 1, nNumRead ) ) ) == 0
	cB := cLine
	else
	cB := SUBSTR( cLine, 1, nEol - 1 )
	FSEEK( nH, nSavePos + nEol + 1, FS_SET )
	endif
	FSEEK( nH, nSavePos, FS_SET )
	//return nNumRead != 0
	return(cB)

def FReadLine( nH, nMaxLine )
**********************************
   LOCAL nSavePos
	LOCAL nNumRead
	LOCAL cBuffer
	LOCAL nEol
	LOCAL cB
	#define EOL HB_OSNEWLINE()		
	
	nMaxLine := if( nMaxLine = NIL, 512, nMaxLine)
	cBuffer  := Space(nMaxLine)
   nSavePos := FSEEK( nH, 0, FS_RELATIVE )
   nNumRead := FREAD( nH, @cBuffer, nMaxLine )
	if ( nEol := AT( EOL, substr( cBuffer, 1, nNumRead ))) == 0
      cB := cBuffer
   else
      cB := SUBSTR( cBuffer, 1, nEol - 1 )
      FSEEK( nH, nSavePos + nEol + 1, FS_SET )
   endif
	FSEEK( nH, nSavePos, FS_SET )
   return cB

def FReadByte( nH )
************************   
	LOCAL nSavePos, nNumRead, cBuffer := Space(1)
      
   nSavePos := FSEEK( nH, 0, FS_RELATIVE )
   nNumRead := FREAD( nH, @cBuffer, 1 )
	FSEEK( nH, nSavePos, FS_SET )
   return cBuffer	

//******************************************************************************	
  
/*
#define MAXLINELENGTH 2048
def FAdvance( nHandle )
   LOCAL k     := FTell( nHandle )
   LOCAL j     := Min( FLen( nHandle ) - k, MAXLINELENGTH )
   LOCAL cText 
   LOCAL nPos
	LOCAL lRetVal
	#define EOL HB_OSNEWLINE()

   cText := FReadStr( nHandle, j)
	if ( nPos := At(EOL, cText )) == 0
      nPos := FLen( nHandle )
   else
      nPos := k + nPos + 1
   endif
	lRetval := FSeek( nHandle, nPos, FS_SET )
	return( lRetVal )
*/
	
def FAdvance(nH)
*---------------------*
	LOCAL nSavePos
	LOCAL nNumRead
	LOCAL cBuffer
	LOCAL nEol
	LOCAL nPos
	LOCAL nMaxLine
	
	nMaxLine := if( nMaxLine = NIL, 512, nMaxLine)
	cBuffer  := Space(nMaxLine)
   nSavePos := FSEEK( nH, 0, FS_RELATIVE )
   nNumRead := FREAD( nH, @cBuffer, nMaxLine )
	if ( nEol := AT( EOL, substr( cBuffer, 1, nNumRead ))) == 0
      nPos := nSavePos
   else
	   nPos := nSavePos + nEol + 1
	endif
	return( FSEEK( nH, nPos, FS_SET))

def FLocate( nHandle, cStr, lFlag )
*----------------------------------------*
   LOCAL nPos    := FSeek( nHandle, 0, FS_RELATIVE )
   LOCAL nNewPos := -2   // not found return code
   LOCAL j       := FLen( nHandle ) - nPos
   LOCAL cText   := Space( j )

   FRead( nHandle , @cText , j )
   if HB_IsLogical( lFlag ) .and. lFlag
      j := hb_AtI( cStr, cText )
   else
      j := hb_At( cStr, cText )
   endif   
   if j > 0
      nNewPos := nPos + j - 1
      FSeek( nHandle, nNewPos, FS_SET )
   endif
   return nNewPos

def FLen( nHandle )
*-----------------------*
   LOCAL nPos := FSeek( nHandle, 0, FS_RELATIVE )
   LOCAL nLen := FSeek( nHandle, 0, FS_END )
   FSeek( nHandle, nPos, FS_SET )
   return nLen
	
def FTell( nHandle )
*-----------------------*
   return FSeek(nHandle, 0, FS_RELATIVE)
	
def FWriteLine( nH, cBuffer)
*--------------------------------*  
	LOCAL nSavePos
	LOCAL nNumRead
	#define EOL HB_OSNEWLINE()
	
   nSavePos := FSEEK( nH, 0, FS_RELATIVE )
   FBot(nH)
	nNumRead := FWRITE( nH, cBuffer + EOL)
	FSEEK( nH, nSavePos, FS_SET )
   return nNumRead != 0	

def Untrim( cString, nTam)
*------------------------------*
	LOCAL nLenStr  := Len(cString)
	LOCAL cChar    := Space(1)
	LOCAL cRetChar

	if( nTam  = NIL, nTam := nLenStr, nTam)
	cRetChar := cString + Replicate(cChar, nTam)
	return( Left(cRetChar,nTam))

def FCurdir()
*-----------------*
	LOCAL cRetChar
   #ifdef __PLATFORM__WINDOWS
      cRetChar := CurDrive() + ':\' + Curdir()
   #else
      cRetChar := Curdir()   
   #endif
	return(cRetChar)

def aMaxStrLen( xArray )
*----------------------------*
	LOCAL nTam    := Len(xArray)
	LOCAL nLen    := 0
	LOCAL nMaxLen := 0
	LOCAL x

	For x := 1 To nTam
		nLen := Len(xArray[x])
		if nMaxLen < nLen
			nMaxLen := nLen
		endif	
	Next
	return( nMaxLen )

def aPrintLen( xArray )
*==================================================================================================*
	return( Len( xArray))

def StrSwap( string, cChar, nPos, cSwap)
*==================================================================================================*
	LOCAL nConta := StrCount( cChar, string ),;
	      aPos,;
	      nX,;
			nLen
	
	if nConta > 0
      aPos := aStrPos(string, cChar)
		nLen := Len(aPos)
		if nLen >= 0
		   if nPos <= nLen
		      string := Stuff(string, aPos[nPos], Len(cChar), cSwap)
		   endif
		endif	
	endif
return( string)

def aStrPos(string, delims)
*===============================*
	LOCAL nConta  := GT_StrCount(delims, string)
	LOCAL nLen    := Len(delims)
	LOCAL cChar   := Repl("%",nLen)
	LOCAL aNum    := {}
	LOCAL x

	if cChar == delims
		cChar := Repl("*",delims)
	endif	

	if nConta = 0
		return(aNum)
	endif

	FOR x := 1 To nConta 
		nPos   := At( Delims, string )
		string := Stuff(string, nPos, 1, cChar)
		Aadd( aNum, nPos)
	Next
	Aadd( aNum, Len(string)+1)
	return(aNum)

def StrExtract( string, delims, ocurrence )
*===============================================*
	LOCAL nInicio := 1
	LOCAL nConta  := GT_StrCount(delims, string)
	LOCAL aArray  := {}
	LOCAL aNum    := {}
	LOCAL nLen    := Len(delims)
	LOCAL cChar   := Repl('%',nLen)
	LOCAL cNewStr := String
	LOCAL nPosIni := 1
	LOCAL aPos
	LOCAL nFim
	LOCAL x
	LOCAL nPos

	if cChar == delims
		cChar := Repl("*",nLen)
	endif	

	if nConta = 0 .AND. ocurrence > 0
	  return(string)
	endif
		

	/*
	For x := 1 to nConta
		nInicio   := At( Delims, cNewStr)
		cNewStr   := Stuff(cNewStr, nInicio, 1, cChar)
		nFim      := At( Delims, cNewStr)
		cString   := SubStr(cNewStr, nInicio+1, nFim-nInicio-1)
		if !Empty(cString)
			Aadd( aArray, cString)
		End		
	Next
	*/

	/*
	For x := 1 to nConta
		nPos      := At( Delims, cNewStr)
		cNewStr   := Stuff(cNewStr, nPos, 1, cChar)
		nLen      := nPos-nPosini
		cString   := SubStr(cNewStr, nPosIni, nLen)
		nFim      := At( Delims, cNewStr)
		nPosIni   := nPos+1
		if !Empty(cString)
			Aadd( aArray, cString)
		End		
	Next
	*/
  
	aPos   := aStrPos(string, Delims)
	nConta := Len(aPos)
	For x := 1 to nConta 
		nInicio  := aPos[x]
		if x = 1
			cString   := Left(String, nInicio-1)
		else
			nFim     := aPos[x-1]
			cString  := SubStr(String, nFim+1, nInicio-nFim-1)
		endif	
		Aadd( aArray, cString)
	Next

	nConta := Len(aArray)
	if ocurrence > nConta .OR. oCurrence = 0
		return(string)
	endif
	return(aArray[ocurrence])

*+-----------------------------------------------------------------------------------	
	
def StrSplit( string, delims)
	LOCAL nInicio := 1
	LOCAL nConta  := GT_StrCount(delims, string)
	LOCAL aArray  := {}
	LOCAL aNum    := {}
	LOCAL nLen    := Len(delims)
	LOCAL cChar   := Repl('%',nLen)
	LOCAL cNewStr := String
	LOCAL nPosIni := 1
	LOCAL aPos
	LOCAL nFim
	LOCAL x
	LOCAL nPos

	if cChar == delims
		cChar := Repl("*",nLen)
	endif

	if nConta = 0 
		return { string }
	endif
		
	aPos   := aStrPos(string, Delims)
	nConta := Len(aPos)
	For x := 1 to nConta 
		nInicio  := aPos[x]
		if x = 1
			cString   := Left(String, nInicio-1)
		else
			nFim     := aPos[x-1]
			cString  := SubStr(String, nFim+1, nInicio-nFim-1)
		endif	
		Aadd( aArray, cString)
	Next
	return(aArray)
endef

*+-----------------------------------------------------------------------------------

def M_Message( cString, cCor)
	LOCAL nMaxRow := MaxRow()
	LOCAL nMaxCol := MaxCol()
	LOCAL nLen    := Len(cString)
	LOCAL row     := ((nMaxRow/2)-5)
	LOCAL Col     := ((nMaxCol-nLen)/2)

	MS_Box(row, col, row+4, col+ nLen+6, M_Frame(), cCor)
	Print(row+2, col+3, cString, cCor)
	return(NIL)
endef

*+-----------------------------------------------------------------------------------	
	
def FTruncate()
	return NIL
endef

*+-----------------------------------------------------------------------------------	
	
def Shr
	return nil
endef   

def achartest
	return nil
endef   

def M_Prompt
	return NIL
endef   

def Write( Linha, Col, xString, nCor)
*-----------------------------------*
	LOCAL Color_Ant := SetCOlor()

	Linha   := Iif( Linha	= NIL, Row(),	Linha   )
	Col	  := Iif( Col		= NIL, Col(),	Col	  )
	xString := Iif( xString = NIL, "",     xString )

	if nCor = nil
		//SetColor(ColorIntToStr(Color_Ant))
		DevPos( Linha, Col ) ; Qqout( xString )
	else	
		Print( Linha, Col, xString, nCor )
      SetColor( Color_Ant)	
   endif		
	return nil
endef   

def Print( row, col, string, attrib, length, cChar)
*+-----------------------------------------------------+*
	LOCAL Color_Ant := SetColor()
	LOCAL nLen      := Len(string)
	DEFAU attrib    TO oMenu:CorMenu //ColorStrToInt(Color_Ant)
	DEFAU length    TO nLen
	DEFAU cChar     TO Space(1)

	if length > nLen
		string += Repl(cChar,length-nlen)
		nLen   := length
	endif	
	SetColor(ColorIntToStr(attrib))
	DevPos(row, col) ; DevOut(Left(string,nLen))
	//hb_DispOutAt( row, col, Left(string,nLen))	
	SetColor( Color_Ant)
	return NIL

def printf(string, attrib)
	LOCAL Color_Ant := SetColor()
	LOCAL row       := row()
	LOCAL col       := col()
	DEFAU attrib  TO oMenu:CorMenu //ColorStrToInt(Color_Ant)

	SetColor(ColorIntToStr(attrib))
	DevPos(row, col) ; DevOut(string)
	//hb_DispOutAt( row, col, string)
	SetColor( Color_Ant)
	return string
endef

*+-----------------------------------------------------------------------------------

def aPrint( row, col, string, attrib, length)
	LOCAL Color_Ant := SetColor()
	LOCAL nLen      := Len(string)

	hb_default(@attrib, ColorStrToInt(SetColor()))
	hb_default(@length, nLen)

	if length > nLen
		string += Repl(Space(1),length-nlen)
		nLen   := length
	endif	

	dispbegin()
	SetColor(ColorIntToStr(attrib))
	DevPos(row, col) ; DevOut(Left(string,nLen))
	SetColor( Color_Ant)
	dispend()
	return NIL
endef

*+-----------------------------------------------------------------------------------

def Roloc(nColor)
	LOCAL cColor  := ColorIntToStr(nColor)
	LOCAL inverse := FT_InvClr( cColor)

	return(nColor := ColorStrToInt(inverse))
endef

*+-----------------------------------------------------------------------------------

def ColorIntToStr(xColor)
	LOCAL cColor
	//return(cColor := hb_NToColor(xColor))
	return(cColor := FT_n2Color(xColor))
enddef

*+-----------------------------------------------------------------------------------

def ColorStrToInt(xColor)
	LOCAL nColor
	//return (nColor := hb_ColorToN(xColor()))
	return( nColor := FT_Color2n(xColor))
endef

*+-----------------------------------------------------------------------------------

def Cls( CorFundo, PanoFundo, lforcar )
	LOCAL nDelay     := 0
	LOCAL row        := 0
	LOCAL col        := 0
	LOCAL row1       := MaxRow()
	LOCAL col1       := MaxCol() 
	LOCAL nComp      := ( col1 - col )
	LOCAL nLen       := Len( Panofundo)
	LOCAL cString    := ""
	LOCAL xString    := ""
	LOCAL nConta     := 0
	LOCAL y          := 0
	LOCAL x          := 0
	STATI cScreen    := NIL
	STATI xPanoFundo := ""
	STATI xCorFundo  := NIL
	DEFAU CorFundo   TO oAmbiente:CorFundo
	DEFAU PanoFundo  TO oAmbiente:PanoFundo

	//HB3.2/3.4
	//FT_CLS( row, col, row1, col1, corfundo)
	//HB3.0
	//hb_DispBox( 00, 00, maxrow(), maxcol(), Repl(PanoFundo,9))

	ms_cls(CorFundo, PanoFundo, nDelay)
   return nil
   
	//Tela(CorFundo, PanoFundo)
	//Ms_Char(CorFundo, PanoFundo)
	//Ms_Cls(CorFundo, PanoFundo)
	//return NIL


	if lforcar = nil
		if !(xPanoFundo == PanoFundo ) .OR. !(xCorFundo == CorFundo )
			cScreen := NIL
		endif
	else
		cScreen := NIL
	endif

	if cScreen == NIL
		//for x := row To row1
			//ft_WrtChr( nX, nY, PanoFundo, Cor())
			//ft_VidStr( x, col, Panofundo, corfundo) 
		//   Print( x, col, Panofundo, corfundo, MaxCol(), panofundo)
		//next
		nConta = row1 * col1 
		for x := 1 TO nConta STEP nlen
			//ft_WrtChr( nX, nY, PanoFundo, Cor())
			//ft_VidStr( x, col, Panofundo, corfundo) 
			cString += PanoFundo       
		next
		y := 0
		for x := 1 to nConta STEP col1
			xString := SubStr( cString, x, col1)
			Print( y++, 0, xString, corfundo, col1, xString)
		next
		xPanoFundo := PanoFundo
		xCorFundo  := CorFundo
		cScreen    := SaveScreen()
	endif
	//FT_Shadow(oAmbiente:sombra)
	return( restela( cScreen ))
endef

*+-----------------------------------------------------------------------------------

def ColorStandard(nStd)
****************************
	STATI nStandard
	LOCAL nSwap := nStandard
	
	if (ISNIL(nStd))
      return nStandard
   else
      nStandard := nStd
   endif
   return nSwap

def ColorEnhanced(nEnh)
****************************
	STATI nEnhanced
	LOCAL nSwap := nEnhanced
	
	if (ISNIL(nEnh))
      return nEnhanced
   else
      nEnhanced := nEnh
   endif
   return nSwap
	
def ColorUnselected(nUns)
****************************
STATI nUnselected
LOCAL nSwap := nUnselected
	
	if (ISNIL(nUns))
      return nUnselected
   else
      nUnselected := nUns
   endif
   return nSwap
	
def nSetColor(std, enh, uns)
*********************************
	LOCAL cStd, ;
			cEnh, ;
			cUns, ;
			cColor

	cStd	 := attrtoa(std)
	cEnh	 := attrtoa(enh)
	cUns	 := attrtoa(uns)
	//cColor := setcolor()

	ColorStandard(std)
	ColorEnhanced(enh)
	ColorUnselected(uns)
	cColor := cStd + ',' + cEnh + ',,,' + cUns

	//cColor := strswap(cColor, "," , 1, cStd)
	//cColor := strswap(cColor, "," , 2, cEnh)
	//cColor := strswap(cColor, "," , 4, cUns)
	Setcolor( cColor )
	return COlorStrToInt(cColor)

def cSetColor(ColorStr)
*----------------------*
   LOCAL nStd, ;
         nEnh, ;
         nUns
         
   nStd := atoattr( strextract( ColorStr, ",", 1))
   nEnh := atoattr( strextract( ColorStr, ",", 2))
   nUns := atoattr( strextract( ColorStr, ",", 4))

   /*
   * Set FUNCky Colors
   */
   ColorStandard(nStd)
   ColorEnhanced(nEnh)
   Colorunselected(nUns)

   /* Set Clipper Colors */
   SetColor( ColorStr )
   return ColorIntToStr(ColorStrToInt(ColorStr));
endef

def atoattr(cColor)
*------------------*
   return (ColorStrToInt(cColor))
endef   

def attrtoa(nColor)
*------------------*
   return (ColorIntToStr(nColor))		
endef   


def MS_QuadroCorInt()
*-------------------*
   LOCAL x := 10
   LOCAL y := 10
   LOCAL a

   // MS_Box(09 , 12 , 29 , 70)		
   dispbox(09 , 12 , 29 , 70)		
   for a := 1 to 256
         //Print( x, y*3, Repl(Chr(x+64),3), x*y,)
         //Print( a,   b*6, hb_NToColor(a*b), a*b)
         if y >= 64
            y := 10
            x++
         endif	
         y += 4
         Print( x, y, StrZero(HB_ColorToN(hb_NToColor(a)),3), a,)
   next
   return nil
endef   

def MS_QuadroCorStr()
*-------------------*
   LOCAL x := 10
   LOCAL y := 10
   LOCAL a

   // MS_Box(09,15,28,135)
   dispbox(09,15,28,135)   
   for a := 1 to 256
         //Print( x, y*3, Repl(Chr(x+64),3), x*y,)
         //Print( a,   b*6, hb_NToColor(a*b), a*b)
         if y >= 128
            y := 10
            x++
         endif	
         y += 8
         Print( x, y, hb_NToColor(a), a,)
   next
   return nil
endef   

//def FT_DskSize( cDrive )
//   return hb_vfDirSpace( cDrive + hb_osDriveSeparator(), HB_DISK_TOTAL )

//def FT_DskFree( cDrive )
//   return hb_vfDirSpace( cDrive + hb_osDriveSeparator(), HB_DISK_FREE )

def ShellRun( cComando )
*****************************
LOCAL intWindowStyle := 0
LOCAL WshShell
LOCAL lRet
LOCAL oExec

/*
intWindowStyle
0 Hides the window and activates another window.
1 Activates and displays a window. if the window is minimized or maximized, the system restores it to its original size and position. An application should specify this flag when displaying the window for the first time.
2 Activates the window and displays it as a minimized window.
3 Activates the window and displays it as a maximized window.
4 Displays a window in its most recent size and position. The active window remains active.
5 Activates the window and displays it in its current size and position.
6 Minimizes the specified window and activates the next top-level window in the Z order.
7 Displays the window as a minimized window. The active window remains active.
8 Displays the window in its current state. The active window remains active.
9 Activates and displays the window. if the window is minimized or maximized, the system restores it to its original size and position. An application should specify this flag when restoring a minimized window.
10 Sets the show-state based on the state of the program that started the application.
*/

#ifdef __XHARBOUR__
   WshShell := CreateObject("WScript.Shell")
#else
   //WshShell := win_oleCreateObject("WScript.Shell")
#endif

lRet     := WshShell:Run("%comspec% /c " + cComando, intWindowStyle, .F.)
WshShell := NIL
return Iif( lRet = 0, .T., .F.)
	
*==================================================================================================*	
	
def ShellExec( cComando )
	LOCAL intWindowStyle := 0
	LOCAL WshShell
	LOCAL lRet
	LOCAL oExec

	/*
	intWindowStyle
	0 Hides the window and activates another window.
	1 Activates and displays a window. if the window is minimized or maximized, the system restores it to its original size and position. An application should specify this flag when displaying the window for the first time.
	2 Activates the window and displays it as a minimized window.
	3 Activates the window and displays it as a maximized window.
	4 Displays a window in its most recent size and position. The active window remains active.
	5 Activates the window and displays it in its current size and position.
	6 Minimizes the specified window and activates the next top-level window in the Z order.
	7 Displays the window as a minimized window. The active window remains active.
	8 Displays the window in its current state. The active window remains active.
	9 Activates and displays the window. if the window is minimized or maximized, the system restores it to its original size and position. An application should specify this flag when restoring a minimized window.
	10 Sets the show-state based on the state of the program that started the application.
	*/

	#ifdef __XHARBOUR__
		WshShell := CreateObject("WScript.Shell")
	#else
		//WshShell := win_oleCreateObject("WScript.Shell")
	#endif

	//oExec := oShell:Run("%comspec% /c " + cComando, intWindowStyle, .F.)
	oExec    := WshShell:Exec(cComando)
	lRet     := oExec:Status 
	WshShell := NIL
	return Iif( lRet = 0, .T., .F.)
endef

*==================================================================================================*	
	
def M_View( row, col, row1, col1, cFile, nCor )
	MaBox(row, col, row1, col1)
	FT_DFSetup(cFile, row+1, col+1, row1-1, col1-1, 1, nCor, Roloc(nCor),"EeQqXx", .T., 5, col1-1, 8196)
	cKey := FT_DispFile()
	FT_DFClose()
	return NIL
endef

*==================================================================================================*		

def MX_PopFile( row, col, row1, col1, xCoringa, nColor)
	LOCAL aFileList  := {}
	LOCAL nChoice 
	
   hb_default(@row, 02)
   hb_default(@col, 10)
   hb_default(@row1, MaxRow()-2)
   hb_default(@col1, Maxcol()-1)
   hb_default(@ncolor, 31)
   
	Aeval( Directory( xCoringa ), {|aDirectory|;
								Aadd( aFileList,;								
								PADR( aDirectory[F_NAME], 15 ) + ;
								if( SUBSTR( aDirectory[F_ATTR], 1,1) == "D", "   <DIR>", ;
								TRAN(       aDirectory[F_SIZE], "99,999,999 B"))  + "  " + ;
								DTOC(       aDirectory[F_DATE])       + "  " + ;
								SUBSTR(     aDirectory[F_TIME], 1, 5) + "  " + ;
								SUBSTR(     aDirectory[F_ATTR], 1, 4) + "  " )})
	if (nChoice := FazMenu(row, col, aFileList, nColor)) = 0
		return ""
	endif
	return( AllTrim(left(aFileList[nChoice],15)))
endef
	
*==================================================================================================*	

def MS_Version()
   LOCAL k
   ? "-------------------------------------------------------------------"
	? "Harbour versÑo:                    " , hb_Version( 0 )
	? "Compilador usado:                  " , hb_Version( HB_VERSION_COMPILER ) 
   ? "Harbour build date:                " , hb_Version( HB_VERSION_BUILD_DATE_STR ) 
   ? "Major version number:              " , hb_Version( HB_VERSION_MAJOR )
   ? "Minor version number:              " , hb_Version( HB_VERSION_MINOR )
   ? "Revision number:                   " , hb_Version( HB_VERSION_RELEASE )
   ? "Build status:                      " , hb_Version( HB_VERSION_STATUS )
	? "PCode:                             " , hb_Version( 10 )
	? "Compilado em:                      " , hb_Version( 11 )
	? "Ambiente:                          " , hb_Version( 21 )
	? "Cpu:                               " , hb_Version( 24 )
	? "-------------------------------------------------------------------"
   
	for k = 0 TO 25
      ? k , hb_Version( k )
   next k
   ? "-------------------------------------------------------------------"
	
   
   return
endef

*==================================================================================================*	

	
/*
********************************
def MX_CHOICE(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6)
   return maxchoice(@Arg1, @Arg2, @Arg3, @Arg4, @Arg5, Arg6)
endef

*==================================================================================================*	
	
def NSTUFF(Arg1)
   local Local1
   Local1 := 2
   __nstuff(Arg1)
   do while (Local1 > 0)
      Local1--
   enddo
   return Nil	
endef

*==================================================================================================*		

def AFILL(Arg1, Arg2, Arg3, Arg4)
   aeval(Arg1, {|_1, _2| Arg1[_2]:= Arg2}, Arg3, Arg4)
   return Arg1
endef

*==================================================================================================*			

def ACLONE(Arg1)
   local Local1, Local2, Local3
   if (!(ISARRAY(Arg1)))
      return Nil
   endif
   Local3:= Len(Arg1)
   Local1:= array(Local3)
   for Local2:= 1 to Local3
      if (ISARRAY(Arg1[Local2]))
         Local1[Local2]:= aclone(Arg1[Local2])
      else
         Local1[Local2]:= Arg1[Local2]
      endif
   next
   return Local1
endef

*==================================================================================================*			

def PUTKEY(Arg1)
   keyboard ""
   nstuff(Arg1)
   do while (InKey() != Arg1)
   enddo
   return Nil
endef

def MAXCHOICE(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6)
	local Local1[56], Local2[lastrow() - 3], Local3[lastrow() - 3], ;
	Local4[lastrow() - 3], Local5[4], Local6, Local7, Local8, ;
   Local9, Local10
   Local1[43]:= Arg5
   Local1[21]:= Len(Local1[43])
   if (Local1[21] < 1)
      m_data(30, -3)
      return -3
   endif
   Local6:= Arg6
   Local7:= Local1[7]
   colorset_(@Local6, @Local7)
   Local1[5]:= Local6
   Local1[7]:= Local7
   Local1[6]:= roloc(Local1[5])
   Local1[1]:= Arg1
   Local1[2]:= Arg2
   Local1[3]:= Arg3
   Local1[4]:= Arg4
   if (Local1[1] < m_data(8) .OR. Local1[2] < m_data(9) .OR. ;
         Local1[3] > m_data(10) .OR. Local1[4] > m_data(11))
      m_data(30, -6)
      return -6
   endif
   Local1[17]:= iif(m_data(29) == 1, m_data(1), 1)
   Local1[15]:= iif(m_data(29) == 1, m_data(2), 1)
   Local1[34]:= ""
   Local1[35]:= ""
   Local1[33]:= ""
   Local1[29]:= Local2
   Local1[30]:= Local3
   Local1[31]:= Local4
   Local5[1]:= Local1[1]
   Local5[2]:= Local1[2]
   Local5[3]:= Local1[3]
   Local5[4]:= Local1[4]
   Local1[32]:= Local5
   maxinit(Local1)
   maxarrfill(Local1)
   m_csron()
   m_csroff()
   Local1[34]:= savevideo(0, 0, Local1[41], Local1[42])
   m_wait(1)
   maxdrawbox(Local1)
   do while (.T.)
      m_csroff()
      maxdisplay(Local1)
      m_csron()
      do while (.T.)
         updatechoi(Local1)
         Local1[13]:= Local1[15]
         Local9:= .F.
         Local10:= .F.
         do while (.T.)
            Local1[12]:= InKey()
            if (Local1[12] != 0)
               Local8:= SetKey(Local1[12])
               if (Local8 != Nil)
                  Local6:= eval(Local8, procname(2), procline(2), ;
                     readvar(), @Local1)
                  if (ISNIL(Local6))
                     loop
                  elseif (Local6 == 0)
                     maxrefresh(Local1)
                  endif
                  loop
               else
                  exit
               endif
            elseif ((Local9:= _isbutton(1)) .OR. (Local10:= ;
                  _isbutton(2)))
               exit
            elseif (kbdstat(16) .OR. kbdstat(2))
               exit
            endif
         enddo
         do case
         case Local9 .AND. !m_region(Local1[1], Local1[2], ;
               Local1[3], Local1[4])
            if (m_data(3) == 1)
               maxret(Local1, @Arg1, @Arg2, @Arg3, @Arg4)
               m_data(30, -2)
               m_data(4, 1)
               return -2
            else
               loop
            endif
         case kbdstat(2) .OR. Local10 .AND. (m_region(Local1[1], ;
               Local1[4], Local1[3], Local1[4]) .OR. ;
               m_region(Local1[3], Local1[2], Local1[3], Local1[4]))
            maxexpandb(Local1)
            loop
         case Local1[12] == 27 .OR. Local9 .AND. m_row() == ;
               Local1[3] - 1 .AND. m_col() > Local1[2] .AND. m_col() ;
               == Local1[4] - Local1[23]
            putkey(27)
            maxret(Local1, @Arg1, @Arg2, @Arg3, @Arg4)
            m_data(30, 0)
            return 0
         case Local1[12] == 13 .OR. Local9 .AND. m_region(Local1[1] ;
               + 1, Local1[2] + 1, Local1[3] - 3, Local1[4] - 1)
            if (Local1[10] < 1)
               loop
            endif
            if (Local9)
               do while (_isbutton(1))
                  Local1[36]:= m_aregion(Local1[29], Local1[30], ;
                     Local1[29], Local1[31])
                  if (Local1[36] > 0)
                     Local1[15]:= Local1[36]
                     updatechoi(Local1)
                     Local1[13]:= Local1[15]
                     loop
                  endif
               enddo
               if (!m_region(Local1[1] + 1, Local1[2] + 1, Local1[3] ;
                     - 3, Local1[4] - 1))
                  loop
               endif
            endif
            putkey(13)
            maxret(Local1, @Arg1, @Arg2, @Arg3, @Arg4)
            Arg5:= aclone(Local1[43])
            m_data(30, -1)
            return Local1[17] + Local1[15] - 1
         case Local1[12] == 18 .OR. Local10 .AND. m_row() == ;
               Local1[3] - 1 .AND. m_col() > Local1[2] .AND. m_col() ;
               == Local1[4] - Local1[24]
            putkey(18)
            if (Local1[17] == 1)
               loop
            elseif (Local1[17] <= Local1[10] + 1)
               Local1[17]:= 1
               Local1[15]:= 1
            else
               Local1[17]:= Local1[17] - Local1[10]
            endif
            m_wait(2)
            exit
         case Local1[12] == 3 .OR. Local10 .AND. m_row() == ;
               Local1[3] - 1 .AND. m_col() > Local1[2] .AND. m_col() ;
               == Local1[4] - Local1[25]
            putkey(3)
            if (Local1[17] == Local1[21] - (Local1[10] - 1))
               loop
            elseif (Local1[17] + Local1[10] > Local1[21] - ;
                  (Local1[10] - 1))
               Local1[17]:= Local1[21] - (Local1[10] - 1)
               Local1[15]:= Local1[10]
            else
               Local1[17]:= Local1[17] + Local1[10]
            endif
            m_wait(2)
            exit
         case kbdstat(16) .OR. Local10 .AND. m_region(Local1[1], ;
               Local1[2], Local1[3], Local1[4])
            maxmovebox(Local1)
            loop
         case Local1[12] == 5 .OR. Local9 .AND. m_row() == Local1[3] ;
               - 1 .AND. m_col() == Local1[4] - Local1[24] .AND. ;
               m_col() > Local1[2]
            m_wait(1)
            putkey(5)
            if (Local1[15] == 1)
               if (Local1[17] == 1)
                  loop
               else
                  Local1[17]:= Local1[17] - 1
                  exit
               endif
            else
               Local1[15]:= Local1[15] - 1
               loop
            endif
         case Local1[12] == 24 .OR. Local9 .AND. m_row() == ;
               Local1[3] - 1 .AND. m_col() == Local1[4] - Local1[25] ;
               .AND. m_col() > Local1[2]
            m_wait(1)
            putkey(24)
            if (Local1[15] == Local1[10])
               if (Local1[17] == Local1[21] - (Local1[10] - 1))
                  loop
               else
                  Local1[17]:= Local1[17] + 1
                  exit
               endif
            else
               Local1[15]:= Local1[15] + 1
               loop
            endif
         case Local1[12] == 19 .OR. Local9 .AND. m_row() == ;
               Local1[3] - 1 .AND. m_col() == Local1[4] - Local1[26] ;
               .AND. m_col() > Local1[2]
            putkey(19)
            if (Local1[19] <= 1)
               exit
            else
               Local1[19]:= Local1[19] - 1
            endif
            exit
         case Local1[12] == 4 .OR. Local9 .AND. m_row() == Local1[3] ;
               - 1 .AND. m_col() == Local1[4] - Local1[27] .AND. ;
               m_col() > Local1[2]
            putkey(4)
            if (Local1[19] >= Local1[20] - Local1[11] + 1)
               loop
            else
               Local1[19]:= Local1[19] + 1
            endif
            exit
         case Local1[12] == 29 .OR. Local9 .AND. m_region(Local1[1], ;
               Local1[2] + 1, Local1[1], Local1[4] - 1)
            putkey(29)
            Local1[17]:= 1
            Local1[15]:= 1
            exit
         case Local1[12] == 1
            putkey(1)
            Local1[15]:= 1
            loop
         case Local1[12] == 23 .OR. Local9 .AND. m_region(Local1[3], ;
               Local1[2] + 1, Local1[3], Local1[4] - 1)
            putkey(23)
            if (Local1[10] > 0)
               Local1[17]:= Local1[21] - (Local1[10] - 1)
               Local1[15]:= Local1[10]
            endif
            exit
         case Local1[12] == 6
            putkey(6)
            Local1[15]:= Max(Local1[10], 1)
            loop
         case Local1[12] != 0
            if (Local1[10] < 1)
               loop
            endif
            Local1[36]:= atest(Chr(Local1[12]), Local1[43], ;
               Local1[17] + Local1[15])
            if (Local1[36] < 1)
               Local1[36]:= atest(Chr(Local1[12]), Local1[43])
            endif
            if (Local1[36] > 0)
               if (Local1[36] + (Local1[10] - 1) > Local1[21])
                  Local1[17]:= Local1[21] - (Local1[10] - 1)
                  Local1[15]:= Local1[36] - Local1[17] + 1
               else
                  Local1[17]:= Local1[36]
                  Local1[15]:= 1
               endif
               if (m_data(19) == 1)
                  keyboard Chr(13)
               endif
               exit
            endif
         otherwise
            loop
         endcase
      enddo
   enddo
   return Nil
endef

*==================================================================================================*		

static def MAXRET(Arg1, Arg2, Arg3, Arg4, Arg5)
   m_csroff()
   if (Arg1[10] > 0)
      print(Arg1[1] + Arg1[15], Arg1[2] + 1, Arg1[43][Arg1[15] - 1 + ;
         Arg1[17]], Arg1[5], Arg1[11], Arg1[19])
   endif
   m_csron()
   m_data(1, Arg1[17])
   m_data(2, Arg1[15])
   m_data(24, Arg1[1])
   m_data(25, Arg1[2])
   m_data(26, Arg1[3])
   m_data(27, Arg1[4])
   m_data(4, 0)
   if (Arg1[1] != Arg1[32][1] .OR. Arg1[2] != Arg1[32][2] .OR. ;
         Arg1[3] != Arg1[32][3] .OR. Arg1[4] != Arg1[32][4])
      m_data(28, 1)
      Arg2:= Arg1[1]
      Arg3:= Arg1[2]
      Arg4:= Arg1[3]
      Arg5:= Arg1[4]
   else
      m_data(28, 0)
   endif
   if (m_data(22) == 1)
      m_csroff()
      restvideo(0, 0, Arg1[41], Arg1[42], Arg1[34])
      m_csron()
   endif
   return Nil
endef

*==================================================================================================*		

static def MAXEXPANDB(Arg1)
   local Local1
   if (m_data(32) == 1)
      return Nil
   endif
   Local1:= setshadow(.F.)
   Arg1[39]:= 0
   Arg1[36]:= m_row()
   Arg1[37]:= m_col()
   if (_isbutton(2))
      m_movement()
      Arg1[39]:= iif(m_region(Arg1[3], Arg1[4], Arg1[3], Arg1[4]), ;
         0, iif(m_region(Arg1[1], Arg1[4], Arg1[3] - 1, Arg1[4]), 1, ;
         -1))
   else
      Arg1[36]:= Arg1[3]
      Arg1[37]:= Arg1[4]
   endif
   Arg1[38]:= iif(Arg1[39] == 0, "", iif(Arg1[39] == 1, "", ""))
   m_csroff()
   if (Arg1[10] > 0)
      print(Arg1[1] + Arg1[15], Arg1[2] + 1, Arg1[43][Arg1[15] - 1 + ;
         Arg1[17]], Arg1[5], Arg1[11], Arg1[19])
   endif
   Arg1[35]:= savevideo(0, 0, Arg1[41], Arg1[42])
   box(Arg1[1], Arg1[2], Arg1[3], Arg1[4], Left(m_frame(), 8), ;
      roloc(Arg1[5]))
   print(Arg1[36], Arg1[37], Arg1[38], Arg1[7], 1)
   do while (kbdstat(2) .OR. _isbutton(2))
      if (_isbutton(2))
         m_csroff()
         if (m_movement() == 0 .OR. Arg1[36] == m_row() .AND. ;
               Arg1[37] == m_col())
            loop
         endif
         Arg1[36]:= iif(Arg1[39] < 1, m_row(), Arg1[36])
         Arg1[37]:= iif(Arg1[39] > -1, m_col(), Arg1[37])
      else
         m_csron()
         Arg1[12]:= InKey()
         if (Arg1[12] != 0)
            do case
            case Arg1[12] == 54
               Arg1[37]:= iif(Arg1[4] = Arg1[42], Arg1[37], Arg1[37] ;
                  + 1)
            case Arg1[12] == 50
               Arg1[36]:= iif(Arg1[3] == Arg1[41], Arg1[36], ;
                  Arg1[36] + 1)
            case Arg1[12] == 52
               Arg1[37]:= iif(Arg1[4] == Arg1[2] + 1, Arg1[37], ;
                  Arg1[37] - 1)
            case Arg1[12] == 56
               Arg1[36]:= iif(Arg1[3] == Arg1[1] + 1, Arg1[36], ;
                  Arg1[36] - 1)
            case Arg1[12] == 51
               Arg1[37]:= iif(Arg1[4] == Arg1[42], Arg1[37], ;
                  Arg1[37] + 1)
               Arg1[36]:= iif(Arg1[3] == Arg1[41], Arg1[36], ;
                  Arg1[36] + 1)
            case Arg1[12] == 57
               Arg1[36]:= iif(Arg1[3] == Arg1[1] + 1, Arg1[36], ;
                  Arg1[36] - 1)
               Arg1[37]:= iif(Arg1[4] == Arg1[2] + 1, Arg1[37], ;
                  Arg1[37] - 1)
            endcase
         else
            loop
         endif
      endif
      if (Arg1[36] <= Arg1[1])
         Arg1[36]:= Arg1[1] + 1
      elseif (Arg1[36] - Arg1[1] - 3 > Arg1[21])
         Arg1[36]:= Arg1[1] + Arg1[21] + 3
         m_csrput(Arg1[36], m_col())
      elseif (Arg1[36] >= m_data(10))
         Arg1[36]:= m_data(10)
         m_csrput(Arg1[36], m_col())
      endif
      if (Arg1[37] <= Arg1[2])
         Arg1[37]:= Arg1[2] + 1
         m_csrput(m_row(), Arg1[37])
      elseif (Arg1[37] >= m_data(11))
         Arg1[37]:= m_data(11)
         m_csrput(m_row(), Arg1[37])
      endif
      if (Arg1[39] > -1)
         Arg1[4]:= Arg1[37]
      endif
      if (Arg1[39] < 1)
         Arg1[3]:= Arg1[36]
      endif
      m_csroff()
      restvideo(Arg1[35])
      box(Arg1[1], Arg1[2], Arg1[3], Arg1[4], Left(m_frame(), 8), ;
         roloc(Arg1[5]))
      print(Arg1[36], Arg1[37], Arg1[38], Arg1[7], 1)
   enddo
   m_csroff()
   m_csrput(Arg1[36], Arg1[37])
   _donut(Arg1[34], Arg1[1], Arg1[2], Arg1[3], Arg1[4])
   Arg1[11]:= Arg1[4] - Arg1[2] - 1
   Arg1[10]:= Arg1[3] - Arg1[1] - 3
   Arg1[15]:= iif(Arg1[15] > Arg1[10], Max(Arg1[10], 1), Arg1[15])
   if (Arg1[17] + (Arg1[10] - 1) > Arg1[21])
      Arg1[17]:= Arg1[21] - (Arg1[10] - 1)
      Arg1[15]:= Arg1[10]
   endif
   Arg1[13]:= Arg1[15]
   setshadow(Local1)
   maxdrawbox(Arg1)
   maxdisplay(Arg1)
   m_csron()
   maxarrfill(Arg1)
   return Nil
endef

*==================================================================================================*		

static def MAXMOVEBOX(Arg1)
   local Local1, Local2, Local3, Local4, Local5, Local6
   if (m_data(32) == 1)
      return Nil
   endif
   m_csroff()
   Arg1[36]:= m_row()
   Arg1[37]:= m_col()
   Local5:= Arg1[36]
   Local6:= Arg1[37]
   Local1:= Arg1[1]
   Local2:= Arg1[2]
   Local3:= Arg1[3]
   Local4:= Arg1[4]
   if (Arg1[10] > 0)
      print(Arg1[1] + Arg1[15], Arg1[2] + 1, Arg1[43][Arg1[15] - 1 + ;
         Arg1[17]], Nil, Arg1[5], Arg1[11], Arg1[19])
   endif
   Arg1[35]:= savevideo(Arg1[1], Arg1[2], Arg1[3], Arg1[4])
   _maxmov(@Local1, @Local2, @Local3, @Local4, @Local5, @Local6, ;
      Arg1[34], Arg1[5])
   Arg1[36]:= Local5
   Arg1[37]:= Local6
   Arg1[1]:= Local1
   Arg1[2]:= Local2
   Arg1[3]:= Local3
   Arg1[4]:= Local4
   _donut(Arg1[34], Arg1[1], Arg1[2], Arg1[3], Arg1[4])
   restvideo(Arg1[1], Arg1[2], Arg1[3], Arg1[4], Arg1[35])
   box(Arg1[1], Arg1[2], Arg1[3], Arg1[4], m_frame(), Arg1[5])
   if (Arg1[10] > 0)
      print(Arg1[1] + Arg1[15], Arg1[2] + 1, Arg1[43][Arg1[15] - 1 + ;
         Arg1[17]], Arg1[7], Arg1[11], Arg1[19])
   endif
   m_csron()
   maxarrfill(Arg1)
   return Nil
endef

*==================================================================================================*

static def MAXARRFILL(Arg1)
   local Local1
   afill(Arg1[29], -1)
   afill(Arg1[30], -1)
   afill(Arg1[31], -1)
   if (Arg1[10] > 0)
      for Local1:= 1 to Arg1[10]
         Arg1[29][Local1]:= Arg1[1] + Local1
         Arg1[30][Local1]:= Arg1[2] + 1
         Arg1[31][Local1]:= Arg1[2] + Arg1[11]
      next
   endif
   return Nil
endef

*==================================================================================================*		

static def UPDATECHOI(Arg1)
   if (Arg1[15] != Arg1[13] .AND. Arg1[10] > 0)
      m_csroff()
      print(Arg1[1] + Arg1[15], Arg1[2] + 1, Arg1[43][Arg1[15] - 1 + ;
         Arg1[17]], Arg1[7], Arg1[11], Arg1[19])
      print(Arg1[1] + Arg1[13], Arg1[2] + 1, Arg1[43][Arg1[13] - 1 + ;
         Arg1[17]], Arg1[5], Arg1[11], Arg1[19])
      m_csron()
   endif
   return Nil
endef

*==================================================================================================*		

static def MAXINIT(Arg1)
   Arg1[21]:= Len(Arg1[43])
   if (Arg1[21] < 1)
      Arg1[43][1]:= ""
      Arg1[21]:= 1
      Arg1[15]:= 1
      Arg1[17]:= 1
   endif
   Arg1[13]:= 1
   Arg1[10]:= Arg1[3] - Arg1[1] - 3
   Arg1[11]:= Arg1[4] - Arg1[2] - 1
   Arg1[20]:= amaxstrlen(Arg1[43])
   Arg1[41]:= lastrow()
   Arg1[42]:= lastcol()
   Arg1[19]:= 1
   Arg1[28]:= _controlpa()
   Arg1[22]:= Len(Arg1[28])
   Arg1[23]:= Arg1[22] - 1
   Arg1[24]:= Arg1[23] - 2
   Arg1[25]:= Arg1[23] - 4
   Arg1[26]:= 4
   Arg1[27]:= 2
   if (Arg1[21] < Arg1[10])
      Arg1[3]:= Arg1[1] + Arg1[21] + 3
      Arg1[10]:= Arg1[21]
   endif
   if (Arg1[17] + (Arg1[10] - 1) > Arg1[21])
      Arg1[17]:= Arg1[21] - (Arg1[10] - 1)
      Arg1[15]:= iif(Arg1[10] < 1, 1, Arg1[10])
   endif
   if (Arg1[15] > Arg1[10])
      Arg1[15]:= iif(Arg1[10] < 1, 1, Arg1[10])
   endif
   return Nil
endef

static def MAXREFRESH(Arg1)
   maxinit(Arg1)
   maxarrfill(Arg1)
   m_csroff()
   maxdrawbox(Arg1)
   maxdisplay(Arg1)
   m_csron()
   return Nil
endef

*==================================================================================================*		

static def MaxDisplay(Arg1)
   local Local1
   if (Arg1[10] > 0)
      arrprint(Arg1[1] + 1, Arg1[2] + 1, Arg1[43], Arg1[17], Arg1[10], Arg1[5], Arg1[11], Arg1[19])
      print(Arg1[1] + Arg1[15], Arg1[2] + 1, Arg1[43][Arg1[15] - 1 + Arg1[17]], Arg1[7], Arg1[11], Arg1[19])
   endif
   return Nil
endef	
*/

*==================================================================================================*		

def Toggle_Acento()
	if oAmbiente:Acento
		Desliga_Acento()
	else
		Liga_Acento()
	endif
endef	

*==================================================================================================*		

def Liga_Acento()
	Set Key VAR_AGUDO  To Act_Geral()
	Set Key VAR_CIRCUN To Act_Geral()
	Set Key VAR_TREMA  To Act_Geral()
	Set Key VAR_CEDMIN To Act_Geral()
	Set Key VAR_CEDMAI To Act_Geral()
	Set Key VAR_GRAVE  To Act_Geral()
	Set Key VAR_TIL	 To Act_Geral()
	Set Key VAR_HifEN  To Act_Geral()
	oAmbiente:Acento := true
	return true
endef	

*==================================================================================================*		

def Desliga_Acento()
	set key VAR_AGUDO  to
	set key VAR_CIRCUN to
	set key VAR_TREMA  to
	set key VAR_CEDMIN to
	set key VAR_CEDMAI to
	set key VAR_GRAVE  to
	set key VAR_TIL	 to
	set key VAR_HifEN  to
	oAmbiente:Acento := false
	return false
endef

*==================================================================================================*	
	
def Act_Geral()
	LOCAL COD_ACENTO := Chr( LastKey())
	LOCAL VAR_CNF_AC := ['a†'eÇ'i°'o¢'u£'AÜ'Eê'Iã'Oü'Uñ'cá'CÄ] + ; // Agudo
							  [`aÖ`eä`iç`oï`uó`Aë`Eí`Iò`O©`Uù`cá`CÄ] + ; // Grave
							  [^aÉ^eà^oì^Aè^Eâ^Oå^cá^CÄ]				  + ; // Circunflexo
							  [~aÑ~n§~oî~Aé~N•~Oô~cá~CÄ]				  + ; // Til
							  [uÅ Uö]                                + ; // Trema
							  [_a¶_A¶_oß_Oß]								  + ; // H°fen
							  [ á{Ä]                                   // Cedilha

	if COD_ACENTO $ "[{"
		COD_ACENTO += " "
	else
		COD_ACENTO += chr( abs( inkey( 0 ) ) )
	endif
	COD_ACENTO = at( COD_ACENTO, VAR_CNF_AC )
	if COD_ACENTO != 0
		keyboard substr( VAR_CNF_AC, COD_ACENTO + 2, 1 )
	else
		ErrorBeep()
		KeyBoard lastkey()
	endif
	oAmbiente:Acento := OK
endef
	
*==================================================================================================*	

def ms_swap_tmp()
	LOCAL cBase := alltrim(oAmbiente:xRoot)
	
	if right(cBase, 1) == "/" .OR. right(cBase, 1) == "\" 
		cBase := left(cBase, len(cBase)-1)		
	endif	
	cBase += DEF_SEP				
	cBase += "tmp"
	cBase += DEF_SEP				
	return(cBase)
endef

*==================================================================================================*	

def DosShell(cComando)
      !( GetEnv( _SHELLENV_ ))      
      return nil
endef

*==================================================================================================*	
   
def StaTusInf( XNOMEFIR, Msg, Color )
******************************************
	LOCAL nCol	:= LastRow()
	LOCAL Tam	:= MaxCol()
	DEFAU Msg   TO ""
	DEFAU	Color TO Cor(2)
				
	aPrint( nCol, 00, Msg, Color, MaxCol() )
	Pos := ( Tam - Len( XNOMEFIR ) )
	aPrint( nCol, Pos, XNOMEFIR, Color )
	return Nil
endef	

*==================================================================================================*

def StaTusSup( Msg, Color )
	LOCAL Tam	:= MaxCol()
			Msg	:= Iif( Msg = Nil, "", Msg )
			Color := Iif( Color = Nil, Cor(2), Color )
	Print( 00, 00, Padc( Msg, Tam ) , Color, Tam )
	Print( 00, (Tam-8), Clock( 00, (Tam-8), Color ), Color )
	return Nil
endef

*==================================================================================================*
   
def Clock(row,col)
   LOCAL ph1
   Iif( row = Nil , row := Row(), row )
   Iif( col = Nil , col := Col(), col )
   //pH1 := hb_idleAdd( {|| write( row, col-10, Dtoc(Date()), omenu:corcabec), write( row, col, Time(), omenu:corcabec), SetCursor( iif( Upper( "on" ) == "ON", 1, 0 ) )   })
   //Clock12(row, col)
   return( Dtoc(Date()) + ' ' + Time())
endef   
   
*==================================================================================================*
   
def DateToStr( dParms )
   Return( Dtos( dParms ))
endef   

*==================================================================================================*

def StrToVal( nParms )
   Return(Val(StrTran(nParms,",",".")))
   Return( Str( nParms ))
endef   

*==================================================================================================*

def ValToStr( nParms )
   Return( Str( nParms ))
endef   

*==================================================================================================*

def IntToStr( nParms )
   Return( AllTrim(Str( nParms )))
endef   

*==================================================================================================*

def Barra()
   Return( Trans( (Recno()/Lastrec())*100, "@R 999.99%"))
endef

*==================================================================================================*   