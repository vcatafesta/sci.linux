#include <sci.ch>

#define SCORE_ROW 	  0
#define SCORE_COL 	  60

#define GET_CLR_UNSELECTED      0
#define GET_CLR_ENHANCED        1
#define GET_CLR_CAPTION         2
#define GET_CLR_ACCEL           3

//#include "hbapigt.h"

#Define VAR_AGUDO 		 39	 // Indicador de agudo
#Define VAR_CIRCUN		 94	 // Indicador de circunflexo
#Define VAR_TREMA 		 34	 // Indicador de trema
#Define VAR_CEDMIN		 91	 // Cedilha min£sculo opcional [
#Define VAR_CEDMAI		 123	 // Cedilha mai£sculo opcional {
#Define VAR_GRAVE 		 96	 // Indicador de grave
#Define VAR_TIL			 126	 // Indicador de til
#Define VAR_HifEN 		 95	 // Indicador de ¦ § sublinhado+a/o
#define _GET_INSERT_ON	 7 	 // "Ins"
#define _GET_INSERT_OFF  8 	 // "   "
#define _GET_INVD_DATE	 9 	 // "Data Invalida"
#define _GET_RANGE_FROM  10	 // "Range: "
#define _GET_RANGE_TO	 11		 // " - "
#define K_UNDO 			 K_CTRL_U
#define CTRL_END_SPECIAL OK		 // Para Ficar no Ultimo Get qdo teclar ctr+end
#define ECHO_CHAR        "*"
#define ECHO_CHAR 		 "þ"
#define LOW 				 32
#define HIGH				 127

STATIC sbFormat
STATIC slUpdated	:= .F.
STATIC slKillRead
STATIC slBumpTop
STATIC slBumpBot
STATIC snLastExitState
STATIC snLastPos
STATIC soActiveGet
STATIC scReadProcName
STATIC snReadProcLine

#define GSV_KILLREAD 		1
#define GSV_BUMPTOP			2
#define GSV_BUMPBOT			3
#define GSV_LASTEXIT 		4
#define GSV_LASTPOS			5
#define GSV_ACTIVEGET		6
#define GSV_READVAR			7
#define GSV_READPROCNAME	8
#define GSV_READPROCLINE	9
#define GSV_COUNT 			9

FUNCTION ReadModal( GetList, nPos )
***********************************
	LOCAL oGet
	LOCAL aSavGetSysVars
	LOCAL nTam := Len( GetList )
	LOCAL x

	if ( VALTYPE( sbFormat ) == "B" )
		EVAL( sbFormat )
	endif

	if ( EMPTY( GetList ) )

		// S'87 compatibility
		SETPOS( MAXROW() - 1, 0 )
		return (.F.)						// NOTE

	endif

	// Preserve state variables
	aSavGetSysVars := ClearGetSysVars()

	// Set these for use in SET KEYs
	scReadProcName := PROCNAME( 1 )
	snReadProcLine := PROCLINE( 1 )

	// Set initial GET to be read
	if !( VALTYPE( nPos ) == "N" .AND. nPos > 0 )
		nPos := Settle( Getlist, 0 )
	endif

	// Vilmar
	if oAmbiente:Get_Ativo
		For x := 1 To nTam
			PostActiveGet( oGet := GetList[ x ] )
			oGet:Display()
		Next
	endif
	WHILE !( nPos == 0 )
		//aVarGet := Array( Len( GetList ) )  // by JPA to otimize screen update
      //FOR EACH oElement IN GetList        // by JPA to otimize screen update
      //   aVarGet[ oElement:__EnumIndex ] := oElement:VarGet()
      //NEXT
	
	
		// Get next GET from list and post it as the active GET
		PostActiveGet( oGet := GetList[ nPos ] )

		// Read the GET
		if oGet:Picture != nil
			if oGet:cType != "N" .AND. oGet:cType != "L" .AND. oGet:cType != "D"
				if At("@S", oGet:picture) > 0    // Campo Senha?
					oGet:lHideInput := .T.
					oGet:cStyle     := ECHO_CHAR 
					//ATail(GetList):reader := {|o| o:varPut(GetPsw(o))}
				endif	
			endif
		endif
		if ( VALTYPE( oGet:reader ) == "B" )
			EVAL(oGet:reader,oGet)			// Use custom reader block
		else
			GetReader(oGet)					// Use standard reader
		endif

		//FOR EACH oElement IN GetList // by JPA to otimize screen update
      //   if aVarGet[ oElement:__EnumIndex ] != oElement:VarGet()
      //      oElement:Display()
      //   endif
      //NEXT
				
		// Move to next GET based on exit condition
		nPos := Settle( GetList, nPos )

	ENDDO


	// Restore state variables
	RestoreGetSysVars( aSavGetSysVars )

	// S'87 compatibility
	SETPOS( MAXROW() - 1, 0 )
	return ( slUpdated )

	
Proc GetReader( oGet )
**********************
	LOCAL nTimeSaver := 60 // oIni:ReadInteger( 'sistema', 'screensaver', 60 )
	LOCAL nKey		  := 0

	if ( GetPreValidate( oGet ) )
		oGet:setFocus()
		SetCursor( iif( Upper( "on" ) == "ON", 1, 0 ) )
		WHILE ( oGet:exitState == GE_NOEXIT )
		   if ( oGet:typeOut )
				oGet:exitState := GE_ENTER
			endif
			WHILE ( oGet:exitState == GE_NOEXIT )
				WHILE (( nKey := INKEY( nTimeSaver )) = 0 )
					SetCursor( iif( Upper( "on" ) == "ON", 1, 0 ) )
					protela()
					//Shuffle()
				ENDDO
				GetApplyKey(oGet,nKey)
			ENDDO
			if (!GetPostValidate(oGet))
			  oGet:exitState := GE_NOEXIT
			endif
		ENDDO
	endif
	oGet:killFocus()
	return

PROCEDURE GetApplyKey( oGet, nKey )
***********************************
	LOCAL VAR_CNF_AC := ['a 'e‚'i¡'o¢'u£'A†'E'I‹'OŸ'U–'c‡'C€] + ; // Agudo
						  [`a…`eŠ`i`o•`u—`A‘`E’`I˜`O©`U`c‡`C€]  + ; // Grave
						  [^aƒ^eˆ^o“^A^E‰^OŒ^c‡^C€]				 + ; // Circunflexo
						  [~a„~n¤~o”~AŽ~N¥~O™~c‡~C€]				 + ; // Til
						  ["u"Uš]                               + ; // Trema
						  [_a¦_A¦_o§_O§]								 + ; // H¡fen
						  [ ‡{ €]                                   // Cedilha
	LOCAL cKey
	LOCAL Cod_Acento
	LOCAL bKeyBlock

	if !( ( bKeyBlock := setkey( nKey ) ) == NIL )
		GetDoSetKey( bKeyBlock, oGet )
		return
	endif

	DO CASE
	CASE ( nKey == K_UP )
		oGet:exitState := GE_UP

	CASE ( nKey == K_SH_TAB )
		oGet:exitState := GE_UP

	CASE ( nKey == K_DOWN )
		oGet:exitState := GE_DOWN

	CASE ( nKey == K_TAB )
		oGet:exitState := GE_ENTER // GE_DOWN

	CASE ( nKey == K_ENTER )
		oGet:exitState := GE_ENTER

	CASE ( nKey == K_ESC )
		if ( SET( _SET_ESCAPE ) )
			oGet:undo()
			oGet:exitState := GE_ESCAPE
		endif

	CASE ( nKey == K_ALT_F4 )
		if ( SET( _SET_ESCAPE ) )
			oGet:undo()
			oGet:exitState := GE_ESCAPE
		endif

	CASE ( nKey == K_PGUP )
		oGet:exitState := GE_WRITE

	CASE ( nKey == K_PGDN )
		oGet:exitState := GE_WRITE

	CASE ( nKey == K_CTRL_HOME )
		oGet:exitState := GE_TOP

	CASE ( nKey == K_CTRL_PGDN )
		oGet:exitState := GE_BOTTOM

	CASE ( nKey == K_CTRL_PGUP )
		oGet:exitState := GE_TOP

#ifdef CTRL_END_SPECIAL
	// Both ^W and ^End go to the last GET
	CASE ( nKey == K_CTRL_END )
		oGet:exitState := GE_BOTTOM
#else
	// Both ^W and ^End terminate the READ (the default)
	CASE ( nKey == K_CTRL_W )
		oGet:exitState := GE_WRITE
#endif

	CASE ( nKey == K_INS )
		SET( _SET_INSERT, !SET( _SET_INSERT ) )
		ShowScoreboard()

	CASE ( nKey == K_UNDO )
		oGet:undo()

	CASE ( nKey == K_HOME )
		oGet:home()

	CASE ( nKey == K_END )
		oGet:end()

	CASE ( nKey == K_RIGHT )
		oGet:right()

	CASE ( nKey == K_LEFT )
		oGet:left()

	CASE ( nKey == K_CTRL_RIGHT )
		oGet:wordRight()

	CASE ( nKey == K_CTRL_LEFT )
		oGet:wordLeft()

	CASE ( nKey == K_BS )
		oGet:backSpace()

	CASE ( nKey == K_DEL )
		oGet:delete()

	CASE ( nKey == K_CTRL_T )
		oGet:delWordRight()

	CASE ( nKey == K_CTRL_Y )
		oGet:delEnd()

	CASE ( nKey == K_CTRL_DEL )
		oGet:delEnd()

	CASE ( nKey == K_CTRL_BS )
		oGet:delWordLeft()
		
	OTHERWISE
	
		if ( nKey >= 32 .AND. nKey <= 255 )
			cKey		  := CHR( nKey )
			Cod_Acento := Chr( nKey )
			***************************************************************
			// Codigo Acrescentado em 19.02.2015
			// Codigo Alterado	  em 11.07.2016

			if oGet:Picture != NIL
				if oGet:cType != "N" .AND. oGet:cType != "L" .AND. oGet:cType != "D" // Codigo Acrescentado em 29.09.2016
					if At("@L", oGet:picture) > 0
						cKey	  := Lower( cKey )
					endif
					if At("@U", oGet:picture) > 0
						cKey	  := Upper( cKey )
					endif
				endif	
			endif	
			***************************************************************
			if ( oGet:type == "N" .AND. ( cKey == "." .OR. cKey == "," ) )
				oGet:toDecPos()
			else
				if nKey = VAR_AGUDO	.OR. ;
					nKey = VAR_CIRCUN .OR. ;
					nKey = VAR_TREMA	.OR. ;
					nKey = VAR_CEDMIN .OR. ;
					nKey = VAR_CEDMAI .OR. ;
					nKey = VAR_GRAVE	.OR. ;
					nKey = VAR_TIL 	.OR. ;
					nKey = VAR_HifEN
					if COD_ACENTO $ "[{"                       // Tratamento do cedilha aternativo
						COD_ACENTO += " "                       // Completa tamanho do ACENTO
					else
						COD_ACENTO += chr( abs( inkey( 0 ) ) )  // Obt‚m pr¢ximo caractere
					endif
					COD_ACENTO = at( COD_ACENTO, VAR_CNF_AC )  // Obt‚m caractere correspondente
					if COD_ACENTO != 0								 // Se existe correspondˆncia
						cKey := SubStr( VAR_CNF_AC, COD_ACENTO + 2, 1 )
					else					 								 // Sinaliza erro
						if (SET( _SET_BELL ))
							?? CHR(7)
						endif
					endif
				endif
				if (SET( _SET_INSERT))
					oGet:insert( cKey )
				else
					oGet:overstrike( cKey )
				endif

				if ( oGet:typeOut )
					if ( SET( _SET_BELL ) )
						?? CHR(7)
					endif
					if ( !SET( _SET_CONFIRM ) )
						oGet:exitState := GE_ENTER
					endif
				endif
			endif
		endif

		EventState()
		
	ENDCASE
	return

//================================================================================================	
	
FUNCTION GetPreValidate( oGet )

	LOCAL lSavUpdated
	LOCAL lWhen := .T.

	if !( oGet:preBlock == NIL )
		lSavUpdated := slUpdated
		lWhen       := EVAL( oGet:preBlock, oGet )
		oGet:display()
		ShowScoreBoard()
		slUpdated := lSavUpdated
	endif

	if ( slKillRead )
		lWhen          := .F.
		oGet:exitState := GE_ESCAPE		 // Provokes ReadModal() exit
	elseif ( !lWhen )
		oGet:exitState := GE_WHEN			 // Indicates failure

	else
		oGet:exitState := GE_NOEXIT		 // Prepares for editing
	END
	return ( lWhen )

PROCEDURE GetDoSetKey( keyBlock, oGet )
	LOCAL lSavUpdated

	// if editing has occurred, assign variable
	if ( oGet:changed )
		oGet:assign()
		slUpdated := .T.
	endif
	lSavUpdated := slUpdated
	EVAL( keyBlock, scReadProcName, snReadProcLine, ReadVar() )
	ShowScoreboard()
	oGet:updateBuffer()
	slUpdated := lSavUpdated

	if ( slKillRead )
		oGet:exitState := GE_ESCAPE		// provokes ReadModal() exit
	endif
	return

STATIC FUNCTION Settle( GetList, nPos )
	LOCAL nExitState

	if ( nPos == 0 )
		nExitState := GE_DOWN
	else
		nExitState := GetList[ nPos ]:exitState
	endif

	if ( nExitState == GE_ESCAPE .or. nExitState == GE_WRITE )
		return ( 0 )					// NOTE
	endif

	if !( nExitState == GE_WHEN )
		// Reset state info
		snLastPos := nPos
		slBumpTop := .F.
		slBumpBot := .F.
	else
		// Re-use last exitState, do not disturb state info
		nExitState := snLastExitState
	endif

	//
	// Move
	//
	DO CASE
	CASE ( nExitState == GE_UP )
		nPos--

	CASE ( nExitState == GE_DOWN )
		nPos++

	CASE ( nExitState == GE_TOP )
		nPos		  := 1
		slBumpTop  := .T.
		nExitState := GE_DOWN

	CASE ( nExitState == GE_BOTTOM )
		nPos		  := LEN( GetList )
		slBumpBot  := .T.
		nExitState := GE_UP

	CASE ( nExitState == GE_ENTER )
		nPos++

	ENDCASE

	//
	// Bounce
	//
	if ( nPos == 0 )								// Bumped top
		if ( !ReadExit() .and. !slBumpBot )
			slBumpTop  := .T.
			nPos 		  := snLastPos
			nExitState := GE_DOWN
		endif

	elseif ( nPos == len( GetList ) + 1 )	// Bumped bottom
		if ( !ReadExit() .and. !( nExitState == GE_ENTER ) .and. !slBumpTop )
			slBumpBot	:= .T.
			nPos 		:= snLastPos
			nExitState := GE_UP
		else
			nPos := 0
		endif
	endif

	// Record exit state
	snLastExitState := nExitState

	if !( nPos == 0 )
		GetList[ nPos ]:exitState := nExitState
	endif
	return ( nPos )

STATIC PROCEDURE PostActiveGet( oGet )
	GetActive( oGet )
	ReadVar( GetReadVar( oGet ) )
	ShowScoreBoard()
	return

STATIC FUNCTION ClearGetSysVars()
	LOCAL aSavSysVars[ GSV_COUNT ]

	// Save current sys vars
	aSavSysVars[ GSV_KILLREAD ]	  := slKillRead
	aSavSysVars[ GSV_BUMPTOP ] 	  := slBumpTop
	aSavSysVars[ GSV_BUMPBOT ] 	  := slBumpBot
	aSavSysVars[ GSV_LASTEXIT ]	  := snLastExitState
	aSavSysVars[ GSV_LASTPOS ] 	  := snLastPos
	aSavSysVars[ GSV_ACTIVEGET ]	  := GetActive( NIL )
	aSavSysVars[ GSV_READVAR ] 	  := ReadVar( "" )
	aSavSysVars[ GSV_READPROCNAME ] := scReadProcName
	aSavSysVars[ GSV_READPROCLINE ] := snReadProcLine

	// Re-init old ones
	slKillRead		 := .F.
	slBumpTop		 := .F.
	slBumpBot		 := .F.
	snLastExitState := 0
	snLastPos		 := 0
	scReadProcName  := ""
	snReadProcLine  := 0
	slUpdated		 := .F.
	return ( aSavSysVars )

STATIC PROCEDURE RestoreGetSysVars( aSavSysVars )
	slKillRead		 := aSavSysVars[ GSV_KILLREAD ]
	slBumpTop		 := aSavSysVars[ GSV_BUMPTOP ]
	slBumpBot		 := aSavSysVars[ GSV_BUMPBOT ]
	snLastExitState := aSavSysVars[ GSV_LASTEXIT ]
	snLastPos		 := aSavSysVars[ GSV_LASTPOS ]

	GetActive( aSavSysVars[ GSV_ACTIVEGET ] )
	ReadVar( aSavSysVars[ GSV_READVAR ] )

	scReadProcName  := aSavSysVars[ GSV_READPROCNAME ]
	snReadProcLine  := aSavSysVars[ GSV_READPROCLINE ]
	return

STATIC FUNCTION GetReadVar( oGet )

	LOCAL cName := UPPER( oGet:name )
	LOCAL i

	if !( oGet:subscript == NIL )	   
		FOR i := 1 TO LEN( oGet:subscript )			
			if    valtype(oGet:subscript[i]) = "C"
				cName += "[" + LTRIM( oGet:subscript[i]) + "]"
			elseif valtype(oGet:subscript[i]) = "N"	
				cName += "[" + LTRIM( STR( oGet:subscript[i] ) ) + "]"
			endif							
		NEXT
	END
	return ( cName )

PROCEDURE __SetFormat( b )
	sbFormat := if( VALTYPE( b ) == "B", b, NIL )
	return

PROCEDURE __KillRead()
	slKillRead := .T.
	return

FUNCTION GetActive( g )
	LOCAL oldActive := soActiveGet

	if ( PCOUNT() > 0 )
		soActiveGet := g
	endif
	return ( oldActive )

FUNCTION Updated()
	return slUpdated

FUNCTION ReadExit( lNew )
	return ( SET( _SET_EXIT, lNew ) )

FUNCTION ReadInsert( lNew )
	return ( SET( _SET_INSERT, lNew ) )

STATIC PROCEDURE ShowScoreboard()
	LOCAL nRow
	LOCAL nCol

	if ( SET( _SET_SCOREBOARD ) )
		nRow := ROW()
		nCol := COL()

		SETPOS( SCORE_ROW, SCORE_COL )
		DISPOUT( if( SET( _SET_INSERT ), NationMsg(_GET_INSERT_ON),;
					NationMsg(_GET_INSERT_OFF)) )
		SETPOS( nRow, nCol )
	endif
	return

STATIC PROCEDURE DateMsg()
	LOCAL nRow
	LOCAL nCol

	if ( SET( _SET_SCOREBOARD ) )
		nRow := ROW()
		nCol := COL()

		SETPOS( SCORE_ROW, SCORE_COL )
		DISPOUT( NationMsg(_GET_INVD_DATE) )
		SETPOS( nRow, nCol )

		WHILE ( NEXTKEY() == 0 )
		END

		SETPOS( SCORE_ROW, SCORE_COL )
		DISPOUT( SPACE( LEN( NationMsg(_GET_INVD_DATE) ) ) )
		SETPOS( nRow, nCol )
	endif
	return

FUNCTION RangeCheck( oGet, junk, lo, hi )
	LOCAL cMsg, nRow, nCol
	LOCAL xValue

	if ( !oGet:changed )
		return ( .T. ) 			// NOTE
	endif

	xValue := oGet:varGet()

	if ( xValue >= lo .and. xValue <= hi )
		return ( .T. ) 			// NOTE
	endif

	if ( SET(_SET_SCOREBOARD) )

		cMsg := NationMsg(_GET_RANGE_FROM) + LTRIM( TRANSFORM( lo, "" ) ) + ;
			NationMsg(_GET_RANGE_TO) + LTRIM( TRANSFORM( hi, "" ) )

		if ( LEN( cMsg ) > MAXCOL() )
			cMsg := SUBSTR( cMsg, 1, MAXCOL() )
		endif

		nRow := ROW()
		nCol := COL()

		SETPOS( SCORE_ROW, MIN( 60, MAXCOL() - LEN( cMsg ) ) )
		DISPOUT( cMsg )
		SETPOS( nRow, nCol )

		WHILE ( NEXTKEY() == 0 )
		END

		SETPOS( SCORE_ROW, MIN( 60, MAXCOL() - LEN( cMsg ) ) )
		DISPOUT( SPACE( LEN( cMsg ) ) )
		SETPOS( nRow, nCol )

	endif
	return ( .F. )

FUNCTION ReadKill( lKill )
	LOCAL lSavKill := slKillRead

	if ( PCOUNT() > 0 )
		slKillRead := lKill
	endif
	return ( lSavKill )

FUNCTION ReadUpdated( lUpdated )
	LOCAL lSavUpdated := slUpdated

	if ( PCOUNT() > 0 )
		slUpdated := lUpdated
	endif
	return ( lSavUpdated )

FUNCTION ReadFormat( b )
	LOCAL bSavFormat := sbFormat

	if ( PCOUNT() > 0 )
		sbFormat := b
	endif
	return ( bSavFormat )

FUNCTION GetPsw( oGet )
***********************
	LOCAL nTimeSaver := oIni:ReadInteger( 'sistema', 'screensaver', 60 )
	LOCAL nRet		  := GE_NOEXIT
	LOCAL cKey
	LOCAL nKey
	LOCAL cAuxVar
	LOCAL cOriginal
	LOCAL cScreen := savescreen()

	if ( GetPreValidate( oGet ) )
		oGet:setFocus()
		oGet:exitState := GE_NOEXIT
		cAuxVar := cOriginal := oGet:original
		WHILE ( oGet:exitState == GE_NOEXIT )
			if ( oGet:typeOut )
				oGet:exitState := GE_ENTER
			endif
			while (oGet:exitState == GE_NOEXIT)
				while (( nKey := INKEY( nTimeSaver )) = 0 )
					//Protela()
					Shuffle()
				enddo
				DO CASE
				CASE ( nKey == K_UP )
					cAuxVar := cOriginal
					oGet:undo()
					oGet:exitState := GE_UP

				CASE ( nKey == K_SH_TAB )
					oGet:exitState := GE_UP

				CASE ( nKey == K_DOWN )
					oGet:exitState := GE_DOWN

				CASE ( nKey == K_TAB )
					oGet:exitState := GE_ENTER // GE_DOWN

				CASE ( nKey == K_ENTER )
					oGet:exitState := GE_ENTER

				CASE ( nKey == K_ESC )
					if ( SET( _SET_ESCAPE ) )
						cAuxVar := cOriginal
						oGet:undo()
						oGet:exitState := GE_ESCAPE
					endif

				CASE ( nKey == K_ALT_F4 )
					if ( SET( _SET_ESCAPE ) )
						cAuxVar := cOriginal
						oGet:undo()
						oGet:exitState := GE_ESCAPE
					endif

				CASE ( nKey == K_PGUP )
					oGet:exitState := GE_WRITE

				CASE ( nKey == K_PGDN )
					oGet:exitState := GE_WRITE

				CASE ( nKey == K_CTRL_HOME )
					oGet:exitState := GE_TOP

				CASE ( nKey == K_CTRL_PGDN )
					oGet:exitState := GE_BOTTOM

				CASE ( nKey == K_CTRL_PGUP )
					oGet:exitState := GE_TOP

				#ifdef CTRL_END_SPECIAL

				// Both ^W and ^End go to the last GET
				CASE ( nKey == K_CTRL_END )
					oGet:exitState := GE_BOTTOM

				#else

				// Both ^W and ^End terminate the READ (the default)
				CASE ( nKey == K_CTRL_W )
					oGet:exitState := GE_WRITE

				#endif

				CASE ( nKey == K_INS )
					SET( _SET_INSERT, !SET( _SET_INSERT ) )
					ShowScoreboard()

				CASE ( nKey == K_UNDO )
					oGet:undo()

				CASE ( nKey == K_HOME )
					oGet:home()

				CASE ( nKey == K_END )
					oGet:end()

				CASE ( nKey == K_RIGHT )
					oGet:right()

				CASE ( nKey == K_LEFT )
					oGet:left()

				CASE ( nKey == K_CTRL_RIGHT )
					oGet:wordRight()

				CASE ( nKey == K_CTRL_LEFT )
					oGet:wordLeft()

				CASE ( nKey == K_BS )
					cAuxVar := STUFF(cAuxVar, oGet:pos - 1, 1, " ")
					oGet:backSpace()

				CASE ( nKey == K_DEL )
					oGet:delete()

				CASE ( nKey == K_CTRL_T )
					oGet:delWordRight()

				CASE ( nKey == K_CTRL_Y )
					oGet:delEnd()

				CASE ( nKey == K_CTRL_DEL )
					oGet:delEnd()

				CASE ( nKey == K_CTRL_BS )
					oGet:delWordLeft()

				OTHERWISE
					if (nKey >= LOW) .AND. (nKey <= HIGH)
						cKey := CHR(nKey)
						cAuxVar := STUFF(cAuxVar, oGet:pos, 1, cKey)
						oGet:insert(ECHO_CHAR)
						if (oGet:typeOut)
							oGet:exitState := GE_ENTER
						endif
					endif
					EventState()
				ENDCASE
			EndDO
			cBuffer     := oGet:Buffer
			if (!GetPostValidate(oGet, cAuxVar))
				oGet:exitState := GE_NOEXIT
			endif
			//oGet:Buffer := cBuffer
			//oget:varput( cBuffer )
			//oget:end()
		EndDO
	endif
	oGet:killFocus()
	restscreen(,,,,cScreen)
	return(cAuxVar)

FUNCTION GetPostValidate(oGet, cAuxVar)
***************************************
	LOCAL lSavUpdated
	LOCAL lValid := .T.

	if ( oGet:exitState == GE_ESCAPE )
		return ( lValid ) 						// NOTE
	endif

   if ( oGet:exitState == GE_UP )
		return ( lValid ) 						// NOTE
	endif

	if oGet:Buffer = "00/00/00"
		oGet:assign()
		oGet:updateBuffer()
		return( lValid )
	endif

	if ( oGet:badDate() )
		oGet:home()
      AlertaPy("ERRO: Data invalida.", oAmbiente:CorAlerta)
		oGet:Undo()
		return( !lValid )
	endif

   /*
   if ( oGet:exitState == GE_ENTER )
      if cAuxVar != NIL
         if (oGet:buffer == Space(Len(oget:buffer)))
            oGet:Undo()
            oGet:home()
            oGet:Buffer := cAuxVar
            oGet:Varput( cAuxVar )
            oGet:assign()
            oGet:home()
            return( .F. )
         endif
      endif
   endif
   */

	// if editing occurred, assign the new value to the variable
	if ( oGet:changed )
		oGet:assign()
		slUpdated := .T.
	endif

   oGet:reset()

	// Check VALID condition if specified
   cBuffer := oGet:Buffer
	if !( oGet:postBlock == NIL )

		lSavUpdated := slUpdated

		// S'87 compatibility
		SETPOS( oGet:row, oGet:col + LEN( oGet:buffer ) )
      
		/*
		if !(cAuxVar == NIL)
         oGet:Buffer := cAuxVar
         oGet:Varput( cAuxVar )
         oGet:assign()
      endif
		*/
		
		lValid := EVAL( oGet:postBlock, oGet )

		// Reset S'87 compatibility cursor position
		SETPOS( oGet:row, oGet:col )

		ShowScoreBoard()
      /*
		* Codigo Acrescentado em 08.08.2016
		*/
		oGet:cType := ValType(cBuffer) // necessario quando parametro por referencia altera tipo
		oGet:updateBuffer()
		slUpdated  := lSavUpdated

		if ( slKillRead )
			oGet:exitState := GE_ESCAPE		// Provokes ReadModal() exit
			lValid := .T.

		endif
	endif
	
	/*
   if cAuxVar != NIL
      oGet:buffer := cBuffer
      oGet:VarPut( cBuffer )
		oGet:end()
   endif
		
   if !lValid
      if (oGet:buffer == Space(Len(oget:buffer)))
         oGet:home()
      endif
   endif
	*/

	return ( lValid )

class Tget from GET
	EXPORTED:
		VAR cType

endclass

*-------------------*
function EventState()
*-------------------*
	#include "hbgtinfo.ch"
	hb_gtInfo( HB_GTI_INKEYFILTER, { | nKey |
			LOCAL nBits, lIsKeyCtrl
			SWITCH nKey
			CASE K_MWBACKWARD			
				oGet:exitState := GE_DOWN
				return K_DOWN
			CASE K_MWFORWARD				
				oGet:exitState := GE_UP			
				return K_UP
			CASE K_RBUTTONDOWN
				return K_ESC
			CASE K_RDBLCLK
				return K_ESC
			CASE K_CTRL_V
				nBits      := hb_GtInfo( HB_GTI_KBDSHIFTS )
				lIsKeyCtrl := ( nBits == hb_BitOr( nBits, HB_GTI_KBD_CTRL ) )
				if lIsKeyCtrl
					hb_GtInfo( HB_GTI_CLIPBOARDPASTE )
					return 0
				endif
			CASE K_CTRL_INS
				if !oAmbiente:lReceber // quando K_CTRL_INS é usada em TReceposi
					nBits      := hb_GtInfo( HB_GTI_KBDSHIFTS )
					lIsKeyCtrl := ( nBits == hb_BitOr( nBits, HB_GTI_KBD_CTRL ) )
					if lIsKeyCtrl
						hb_GtInfo( HB_GTI_CLIPBOARDPASTE )
						return 0
					endif
				endif	
			CASE K_CTRL_X
				nBits      := hb_gtInfo( HB_GTI_KBDSHIFTS )
            lIsKeyCtrl := ( nBits == hb_BitOr( nBits, HB_GTI_KBD_CTRL))
            if lIsKeyCtrl
					if GetActive() != NIL
						hb_gtInfo( HB_GTI_CLIPBOARDDATA, Transform( GetActive():VarGet(), "" ) )
                  GetActive():DelEnd()
                  return 0
               endif
            endif	
			CASE K_CTRL_C 
				nBits      := hb_gtInfo( HB_GTI_KBDSHIFTS )
				lIsKeyCtrl := ( nBits == hb_BitOr( nBits, HB_GTI_KBD_CTRL ) )
				if lIsKeyCtrl
					//Alerta( "Copiado para area de transferência" )
					oMenu:ContaReg( "COPIADO PARA AREA DE TRANSFERENCIA.  ")		
					if GetActive() != NIL
						hb_gtInfo( HB_GTI_CLIPBOARDDATA, Transform( GetActive():VarGet(), "" ) )
						return 0
					endif
				endif
				
			ENDSWITCH
			return nKey
		})

FUNCTION MouseWheelDown()
   KEYBOARD Chr( K_DOWN )
   return NIL

FUNCTION MouseWheelUp()
   KEYBOARD Chr( K_UP )
   return NIL		