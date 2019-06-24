/*
 * This sample demonstrates how to use file functions with Leto db server
 * EnableFileFunc = 1 must be set in server's letodb.ini
 */
REQUEST LETO
#include "rddleto.ch"
#include "fileio.ch"

FUNCTION Main( cPath )

   LOCAL cBuf, arr, i, lTmp, nTmp, nHandle
   LOCAL nPort := 2812

   // ALTD()
   IF Empty( cPath )
      cPath := "//127.0.0.1:2812/"
   ELSE
      cPath := "//" + cPath + iif( ":" $ cPath, "", ":" + AllTrim( Str( nPort ) ) )
      cPath += iif( Right( cPath, 1 ) == "/", "", "/" )
   ENDIF

   ? "Hey, LetoDBf:", LETO_PING()

   ? "Connect to " + cPath + " - "
   IF ( LETO_CONNECT( cPath ) ) == -1
      ? "Error connecting to server:", LETO_CONNECT_ERR(), LETO_CONNECT_ERR( .T. )
      WAIT
      RETURN NIL
   ELSE
      ?? "Ok"
   ENDIF

   ? "Hey, LetoDBf:", LETO_PING()

   /* No more cPath needed after Leto_connect() */

   ? 'leto_file( "test1.txt" ) - '
   lTmp := LETO_FILE( "test1.txt" )
   ?? iif( lTmp, "Ok", "No" )
   i := LETO_FERROR()
   ? 'file functions working ? - ' + iif( i == 100, "disabled", ;
      iif( i == iif( lTmp, 0, 2 ), "well well", "ups, error: " + Str( LETO_FERROR(), 5, 0 ) ) )

   ? 'leto_memowrite( "test1.txt", "A test N1" ) - '
   ?? iif( LETO_MEMOWRITE( "test1.txt", "A test N1" ), "Ok", "Failure" )

   ? 'leto_file( "test1.txt" ) - '
   ?? iif( LETO_FILE( "test1.txt" ), "Ok", "No" )

   ? 'leto_memoread( "test1.txt" ) - '
   ?? LETO_MEMOREAD( "test1.txt" )

   ? 'leto_frename( "test1.txt", "test2.txt" ) - '
   ?? iif( LETO_FRENAME( "test1.txt", "test2.txt" ) == 0, "Ok", "Failure" )
   ?? iif( ! LETO_FILE( "test1.txt" ), "!", " fail" )
   ?? iif( LETO_FILE( "test2.txt" ), "!", " fail" )

   ? 'leto_fcopy( "test2.txt", "test1.txt" ) - '
   ?? iif( LETO_FCOPY( "test2.txt", "test1.txt" ) == 0, "Ok", "Failure" )
   ?? iif( LETO_FILE( "test1.txt" ), "!", " fail" )

   ? 'leto_fileread( "test2.txt", 7, 2 ) - '
   ?? iif( LETO_FILEREAD( "test2.txt", 7, 2, @cBuf ) > 0, "'" + cBuf + "'", "Failure" )
   ?? iif( cBuf == "N1", " - Ok", " - Failure" )

   ? 'leto_filewrite( "test2.txt", 7, "N2" ) - '
   ?? iif( LETO_FILEWRITE( "test2.txt", 7, "N2" ), "Ok", "Failure" )

   ? 'leto_memoread( "test2.txt" ) - '
   cBuf := LETO_MEMOREAD( "test2.txt" )
   ?? "'" + cBuf + "' - "
   ?? iif( cBuf == "A test N2", "Ok", "Failure" )

   ? 'leto_filesize( "test2.txt" ) - '
   ?? LETO_FILESIZE( "test2.txt" )

   ? 'leto_filewrite( "test2.txt", 0, 2048 * "A" ) - '
   ?? iif( LETO_FILEWRITE( "test2.txt", 0, Replicate( "A", 2048 ) ), "Ok", "Failure" )

   ? 'leto_filesize( "test2.txt" ) - '
   ?? LETO_FILESIZE( "test2.txt" )
   LETO_FILEREAD( "test2.txt", 0, 0, @cBuf )
   IF cBuf == Replicate( "A", 2048 )
      ?? " fine"
   ENDIF

#ifndef __XHARBOUR__
   ? 'leto_fCopyFromSrv( "test3.txt", "test2.txt" ) - '
   lTmp := LETO_FCOPYFROMSRV( "test3.txt", "test2.txt", 1000 )
   ?? iif( lTmp, "Ok", "Failure" )
   ?? iif( File( "test3.txt" ), "!", "@" )
   IF ! lTmp
      ?? FError(), LETO_FERROR( .F. ), LETO_FERROR( .T. )
   ENDIF

   MemoWrit( "test3.txt", Replicate( "z", 123456 ) )
   ? 'leto_fCopyToSrv( "test3.txt", "test2.txt" ) - '
   lTmp := LETO_FCOPYTOSRV( "test3.txt", "test2.txt", 1000 )
   ?? iif( lTmp, "Ok", "Failure" )
   ?? iif( LETO_FILESIZE( "test2.txt" ) == 123457, "!", "@" )  /* +1 for strg-z */
   IF ! lTmp
      ?? FError(), LETO_FERROR( .F. ), LETO_FERROR( .T. )
   ENDIF
   FErase( "test3.txt" )
#endif

   ? 'leto_memowrite( "test2.txt", 4095 * "B" ) - '
   ?? iif( LETO_MEMOWRITE( "test2.txt", Replicate( "B", 4095 ) ), "Ok", "Failure" )
   ?? iif( LETO_FILESIZE( "test2.txt" ) == 4096, "!", "@" )  /* +1 for strg-z */
   ? 'leto_filesize( "test2.txt" ) - '
   ?? LETO_FILESIZE( "test2.txt" )
   cBuf := LETO_MEMOREAD( "test2.txt" )
   IF cBuf == Replicate( "B", 4095 )
      ?? " fine"
   ELSE
      ?? " wrong"
   ENDIF

   ? 'leto_DirMake( "TEST" ) - '
   ?? iif( LETO_DIRMAKE( "TEST" ) == 0, "Ok", "Failure" )
   ?? iif( LETO_DIREXIST( "TEST" ), " verified", "!" )
   ? 'leto_DirRemove( "TEST" ) - '
   ?? iif( LETO_DIRREMOVE( "TEST" ) == 0, "Ok", "Failure" )
   ?? iif( ! LETO_DIREXIST( "TEST" ), " verified", "!" )

   ? "Press any key to continue..."
   ?
   arr := LETO_DIRECTORY( "*.dbf" )
   ? hb_strformat("%s %d", 'leto_directory():', Len(arr))
   Inkey( 0 )
   ? "found files: "
   FOR i := 1 TO Len( arr )
      ? arr[ i, 1 ] + "; "
   NEXT
   ? "----------"
   ? "Press any key to continue..."

   ? 'leto_ferase( "test2.txt" ) - '
   ?? iif( LETO_FERASE( "test2.txt" ) == 0, "Ok", "Failure" )
   LETO_FERASE( "test1.txt" )
   ?

   ? "Press any key to finish..."
   Inkey( 0 )

	#ifndef __XHARBOUR__
   ? 'leto_FCreate( "test3.txt" ) - '
   nHandle := LETO_FCREATE( "test3.txt" )      
   ? nHandle, ValType( nHandle )
   ? leto_ferror()
	
   Inkey( 0 )
   ?? iif( nHandle >= 0, "Ok", "Failure -- no further tests leto_F*() test" )
   IF nHandle >= 0
      ? "Press any key to continue..."
      Inkey( 0 )
      ? 'leto_FClose( nHandle ) - '
      ?? iif( LETO_FCLOSE( nHandle ),  "Ok", "Failure" )
      ?? iif( ! LETO_FCLOSE( nHandle ),  "!", "Fail" )
      ? 'leto_FOpen( "test3.txt", READWRITE ) - '
      nHandle := LETO_FOPEN( "test3.txt", FO_READWRITE )
      ?? iif( nHandle >= 0, "Ok", "Failure" )
      IF nHandle >= 0
         ? 'leto_FWrite( nHandle, "testx12" ) - '
         nTmp := LETO_FWRITE( nHandle, "testx21" )
         ?? iif( nTmp == 7, "Ok", "Failure" )
         ? 'leto_FSeek( nHandle, 4, 0 ) - '
         nTmp := LETO_FSEEK( nHandle, 4, 0 )
         ?? iif( nTmp == 4, "Ok", "Failure" )
         LETO_FWRITE( nHandle, "3" )
         ? 'leto_FSeek( nHandle, 0, 2 ) - '
         nTmp := LETO_FSEEK( nHandle, 0, 2 )
         ?? iif( nTmp == 7, "Ok", "Failure" )
         ?? " --- EOF - " + iif( LETO_FEOF( nHandle ), "Ok", "Failure" )
         LETO_FWRITE( nHandle, "0" + Chr( 0 ) )
         cBuf := Space( 12 )
         LETO_FSEEK( nHandle, 0, 0 )
         ? 'leto_FRead( nHandle, @cBuf, 10 ) - '
         nTmp := LETO_FREAD( nHandle, @cBuf, 10 )
         ?? iif( nTmp == 9, "Ok", "Failure" )
         ?? iif( Len( cBuf ) == 12 .AND. Left( cBuf, 9 ) == "test3210" + Chr( 0 ), " !!", "" )
         LETO_FSEEK( nHandle, 0, 0 )
         ? 'leto_FReadSTR( nHandle, 10 ) - '
         cBuf := LETO_FREADSTR( nHandle, 10 )
         ?? iif( Len( cBuf ) == 8 .AND. Left( cBuf, 8 ) == "test3210", "Ok", "Failure" )
         LETO_FSEEK( nHandle, 0, 0 )
         ? 'leto_FReadLEN( nHandle, 10 ) - '
         cBuf := LETO_FREADLEN( nHandle, 10 )
         ?? iif( Len( cBuf ) == 9 .AND. Left( cBuf, 9 ) == "test3210" + Chr( 0 ), "Ok", "Failure" )
         LETO_FCLOSE( nHandle )
         ?
      ENDIF
      ? "Press any key to continue..."
      Inkey( 0 )
      LETO_FERASE( "test3.txt" )
   ENDIF
#endif
