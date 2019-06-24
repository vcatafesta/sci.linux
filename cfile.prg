REQUEST LETO
#include "rddleto.ch"
#include <sci.ch>
#include <hwgui.ch>

FUNCTION Main( cIp )

   LOCAL cBuf, arr, i, lTmp, nTmp, nHandle
   LOCAL nPort := 2812
	
	cPath = cIp
	
	set dele on
   // ALTD()
	cls
   IF Empty( cPath )
      cPath := "//10.0.0.66:2812/"
   ELSE
      cPath := "//" + cPath + iif( ":" $ cPath, "", ":" + AllTrim( Str( nPort ) ) )
      cPath += iif( Right( cPath, 1 ) == "/", "", "/" )
   ENDIF

   ? "Hey, LetoDBf:", LETO_PING()
   ? "Connect to " + cPath + " - "
   IF ( LETO_CONNECT( cPath ) ) == F_ERROR
      ? "Error connecting to server:", LETO_CONNECT_ERR(), LETO_CONNECT_ERR( .T. )      
      RETURN NIL
   ELSE
      ?? "Ok"
   ENDIF
	? LETO_PING()
	? "----------------------------------------------------------------"
	
	
	printon()
	? "TESTE"
	PRINTOFF()
	
	/*
	? 1, FCurdir()
	
	_SEP_ := '/'
	
	? 2, cfile := "TESTE.INI"
	? 3, cDir  := "TESTE"
	? 4, leto_makedir(cDir)		
	? 5, cPath 
	? 6, cPath := cPath + cDir + _SEP_
	? 7, cBase := cDir + + _SEP_
	
	? 8, lFile := ms_swap_file(cbase + cFile)
	if !(lFile)
		? 9, ms_swap_fcreate(cbase + cFile, 0)  		
	endif	
	? 10, lFile := ms_swap_file(cbase + cFile)
	*/


FUNCTION SelectPrinter() 
	LOCAL nPrn:=1 
	//LOCAL aPrn:= GetPrinters(.t.) 	
	LOCAL aPrn
	// IF EMPTY(aPrn) 
		// wvw_messagebox(,"Não foi encontrada nenhuma Impressora Instalada!",48) 
		// Return 
	// ENDIF 
	
	//WVW_nOpenWindow("Escolha uma impressora",2,1,10,40) 
	DO WHILE !EMPTY(nPrn) 
		Setcolor("N/W") 
		//WVW_nOpenWindow("Escolha uma impressora",2,1,10,40) 
		nPrn:= ACHOICE(2,1,10,40,getprinters(),.T.,,nPrn) 
		IF nPrn == 0 
			exit 
		ENDIF 
		//wvw_messagebox(aPrn[nPrn][2],64) 
		//wvw_lclosewindow() 
	ENDDO 
	RETURN(NIL) 

	

**********************************
Function Imprime(cArq,cPrint,cTit)
**********************************
	Local oPrn
	LOCAL aPrn:=WIN_PRINTERLIST()

	hb_default(@cPrint,win_PrinterGetDefault())
	hb_default(@cTit,"PEDIDO")

	If Empty(cArq)
		hwg_Msginfo('Informe algo p/ imprimir.')
		Return .F.
	EndIf
	If empty(aPrn)
		hwg_Msginfo('Não há impressoras instaladas')
		Return .F.
	EndIf

	 nRet := Win_PrintFileRaw(cPrint,cArq,cTit)
	 if nRet < 1
		 cMsg := 'Erro Imprimindo: '
		SWITCH nRet
			CASE -1
				cMsg += "Parâmetro inválido passado" ; EXIT
			CASE -2
				cMsg += "WinAPI OpenPrinter() Falha na chamada"      ; EXIT
			CASE -3
				cMsg += "WinAPI StartDocPrinter() Falha na chamada"  ; EXIT
			CASE -4
				cMsg += "WinAPI StartPagePrinter() Falha na chamada" ; EXIT
			CASE -5
				cMsg += "WinAPI malloc() of memory failed"      ; EXIT
			CASE -6
				cMsg += "Arquivo " + cArq + " não Localizado"   ; EXIT
			//DEFAULT
			//   cMsg += cFile + " PRINTED OK!!!"
			END

		  hwg_Msgstop(cMsg)
	 EndIf
	Return .T.

	
def PrintOn( lFechaSpooler )
	LOCAL nQualPorta := 1
	LOCAL cSaida	  := ""

	SET DEFAULT TO                                // always needed 
	SET DEFAULT TO TESTE.TXT      					// only if necessary 
	SET DEVICE TO PRINT 
	//SET(24, cPath + "TEXTO.TXT", .F.)
	SET(24, "TESTE.TXT", .f.)
	SET CONSOLE OFF 
	SET PRINT ON 	
	SetPrc(0,0)

	//SET PRINT TO (cPath + "TEXTO.TXT") // dos error 123	
	//SET PRINT TO //10.0.0.66:2812/TEXTO.TXT
	//Set Print On	

	return Nil
endef

*==================================================================================================*		

def AbreSpooler()
**********************
	iif( oAmbiente:Spooler, Set( _SET_PRINTFILE, oAmbiente:cArquivo, false ), Set( _SET_PRINTFILE, "" ))
	return NULL
endef

*==================================================================================================*		
	
def PrintOff()
	//PrintOn( true )
	//FPrint( RESETA )
	Set Devi To Screen
	Set Prin Off
	Set Cons On
	Set Print to
	//CloseSpooler()
	return Nil
endef
	
	
*==================================================================================================*	

def ms_swap_ferase(cFile)   	

	if (oAmbiente:Letoativo)
		return leto_ferase(cPath + cFile)		
	else
		return Ferase(cFile)
	endif	
endef

*==================================================================================================*	

def ms_swap_rename(cFile, cNewFile)   	
	
	if (oAmbiente:Letoativo)
		return (leto_frename(cPath + cFile, cPath + cNewFile) == 0)		
	else
		return msrename(cFile, cNewFile)
	endif	
endef

*==================================================================================================*	

def ms_swap_fclose(handle)   	
	return leto_fclose(handle)		

endef

*==================================================================================================*	

def ms_swap_fopen(cFile, mode)   	
	LOCAL Handle
	
	hb_default(@mode, FO_READWRITE + FO_SHARED)
	handle := leto_fopen(cFile, Mode)		
	//alert("FOPEN: " + cFile + " Handle:" + str(handle) + " Ferror: "+ str(leto_ferror()))
	return handle
	
endef

*==================================================================================================*	

def ms_swap_fcreate(cFile, mode)   	
	LOCAL Handle
	
	hb_default(@mode, FC_NORMAL)
	Handle := leto_fcreate(cFile, mode)		
	//alert("FOPEN: " + cFile + " Handle:" + str(handle) + " Ferror: "+ str(leto_ferror()))
	return handle
	
endef

*==================================================================================================*	

def ms_swap_ferror()   	
   LOCAL nError
	
	nError := leto_ferror()				
	return nError	
	
endef

*==================================================================================================*	


def ms_swap_file(cFile)   	

	return(leto_file(cFile))
	
endef

*==================================================================================================*	

def ms_swap_fwrite(...)
		return(leto_fwrite(...))
endef


*==================================================================================================*	

//def ms_swap_fseek(handle, mode, fs_set)   	
def ms_swap_fseek(...)   	
	
	return leto_fseek(...)

endef

*==================================================================================================*	

//def ms_swap_fread(handle, cbuffer, fs_set)   	
def ms_swap_fread(...)   	
	
	return leto_fread(...)

endef

*==================================================================================================*	

def ms_swap_extensao(cFile, cNewExt)   	
	LOCAL cOldExt  := GetFileExtension(cFile)
	LOCAL cNewFile 
	
	cNewFile := Left(cFile, len(cFile)-4)	
	cNewFile += cNewExt
	
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

def truefalse(xvar)
	if xvar
		return "true"
	else		
		return "false"
	endif	
endef	

*==================================================================================================*	

def FCurdir()
*-----------------*
	LOCAL cRetChar

	cRetChar := CurDrive() + ':\' + Curdir()
	return(cRetChar)
endef
	
def GetFileExtension(cFile)
   return( UPPER( SUBSTR( cFile, AT( ".", cFile ) + 1, 3 )))
endef	
