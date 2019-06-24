REQUEST LETO
#include <sci.ch>
#include "rddleto.ch"
#include "fileio.ch"

FUNCTION Main( cIp )

   LOCAL cBuf, arr, i, lTmp, nTmp, nHandle
   LOCAL nPort := 2812
	PUBL oIni		 := TIniNew("SCI.INI")
	PUBL oIni
	PUBL oAmbiente
	
	cPath = cIp
	
	set dele on
   // ALTD()
	cls
   IF Empty( cPath )
      cPath := "//127.0.0.1:2812/"
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
	
	? i, oIni:Ferror	
	for i := 1 to 100		
		? i, oINi:WriteString('LETO', "var" + strzero(i,3), strzero(i,3))
	next
	alert("OPEN :" + strzero(oini:WriteOpen, 5) + " WRITE :" + strzero(oini:WriteCount, 5))
	
	? 8, oINi:ReadString("LETO", "var")
	? 9, oIni:Close()
	? 10, oIni:Ferror

   ? 11, LETO_PING()
	
	/*
	? 'leto_FCreate( "T.TXT" ) - '
   ? nHandle := LETO_FCREATE( "T.TXT" ), leto_ferror()     	
	//? LETO_FCLOSE(nHandle), leto_ferror()	
	? "RENAME", LETO_FRENAME("T.TXT", "NEW.TXT" ), leto_ferror()              
	if leto_ferror() == FO_DENYWRITE
	   ? "Tentativa negada"
		? "FCLOSE", Leto_Fclose(nHandle)		
	endif	
	? "RENAME", LETO_FRENAME("T.TXT", "NEW.TXT" ), leto_ferror()              
	
	? "LETO_FILE", leto_file( cPath + "TESTE.DBF")
	if !leto_file("TESTE.DBF")
		? "DBCREATE", dbcreate("TESTE.DBF", {{"CODIGO", "C", 5, 0}})	
	else
		alert("TESTE.DBF existe")
	endif	
	use TESTE Shared new alias x
	appe from "teste.old"
	? ALIAS(), USED()	
	//browse()
	dBCLOSEAREA()
	? "FERROR", LETO_FERROR()
	*/
	
	*==================================================================================================*	

def GetFileExtension(cFile)
****************************
   return( UPPER( SUBSTR( cFile, AT( ".", cFile ) + 1, 3 )))
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
	
		
		leto_file(cFile)
		handle := leto_fopen(cFile, Mode)		
		//alert("FOPEN: " + cFile + " Handle:" + str(handle) + " Ferror: "+ str(leto_ferror()))
		return handle
	
endef

*==================================================================================================*	

def ms_swap_fcreate(cFile, mode)   	
	LOCAL Handle
	
		? leto_file(cFile)
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

def ms_swap_file(cFile)   	

	return(leto_file(cFile))
	
endef

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

def ValueAndTypeVar(xvar)	
	switch valtype(xvar)
		case "C" 
			alertpy("Tipo : ", "C", ";Valor :" + trimstr(xvar))
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
