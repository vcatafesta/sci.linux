REQUEST LETO
#include "rddleto.ch"
#include "fileio.ch"

FUNCTION Main( cIp )

   LOCAL cBuf, arr, i, lTmp, nTmp, nHandle
   LOCAL nPort := 2812
	
	cPath = cIp
	
	
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
	? LETO_PING()
	? "----------------------------------------------------------------"
	? LETO_GETCURRENTCONNECTION()
	? LETO_GETLOCALIP()
	? LETO_GETSERVERMODE()
	? LETO_GETSERVERVERSION()
	? "----------------------------------------------------------------"
	
	printon()
	ctexto := ;	
		"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor " + hb_eol() +;
		"incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud "+ hb_eol() +;
		"exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure "+ hb_eol() +;
		"dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur." + hb_eol() +;
		"Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt "+ hb_eol() +;
		"mollit anim id est laborum."
	? ctexto
	printoff()
	
	
	

function PrintOn( lFechaSpooler )
	LOCAL nQualPorta := 1
	LOCAL cSaida	  := ""
	
	//SET(_SET_PRINTFILE, cPath + "TESTE.TXT", .T.) //  dos error 53
	? LETO_SETPRINTTO(24, cPath + "TESTE.TXT", .F.)		
	SET(24, "TESTE.TXT", .F.)		
	SET DEVICE TO PRINT 
	SET PRINT ON 
	SET CONSOLE OFF 
	//SetPrc(0,0)
	
	return Nil

*==================================================================================================*		
	
function PrintOff()
	//PrintOn( true )
	//FPrint( RESETA )
	Set Devi To Screen
	Set Prin Off
	Set Cons On
	Set Print to
	//CloseSpooler()
	return Nil
	