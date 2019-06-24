REQUEST HB_MEMIO

function main()
	DemoHbmemio()
	//DemoHash2()
	//DemoHash3()
	//DemoHash4()
	return nil
	
proc DemoHbmemio()
      LOCAL i
		
		cls
		Use receber shared new		
		aStru := Receber->(DbStruct())
		
		dbCreate( "mem:test", aStru, , .T., "memarea" )
		appe from receber 
		receber->(DbCloseArea())
		
       /*dbCreate( "mem:test",;
		 				{{ "F0", "+", 0, 0 },;
		 			  	 { "F1", "N", 9, 0 } }, , .T., "memarea" )

		 INDEX ON FIELD->F0 TAG f0 To mem:test
		 INDEX ON FIELD->F1 TAG f1 To mem:test						 
       
		 FOR i := 1 TO 10000
          memarea->(dbAppend())
          //FIELD->F1 := hb_Random(10000) * 100000
          memarea->F1 := hb_RandomInt(10000)
       NEXT
       
		 //dbEval({|| QOut( memarea->F0 ), QQOut( FIELD->F1 )})
		 */
		 
		 memarea->(browse())
		 //DemoHash()		 
       memarea->(dbCloseArea())

       /* Copy files to a disk */
       hb_vfCopyFile( "mem:test.dbf", "test1.dbf" )
       hb_vfCopyFile( "mem:test.ntx", "test1.ntx" )

       /* Free memory */
		 
       dbDrop( "mem:test" )		 
		 
		 
function DemoHash()
	aCustomer := {} // Declare / define an empty array
	
	memarea->(DbGoTop())
	while !Eof()
		AADD(aCustomer, { memarea->Codi, Memarea->Nome } )
		DBSKIP()
	enddo
	
	a1Record := {}

	FOR EACH a1Record IN aCustomer
		? a1Record[ 1 ], a1Record[ 2 ]
	NEXT	
	@ MAXROW(), 0
	WAIT "Tecle algo"

	
	nRecord := ASCAN( aCustomer, { | a1Record | a1Record[ 1 ] == '12816' } )
	? aCustomer[ nRecord, 1 ], aCustomer[ nRecord, 2 ]	
	WAIT "Tecle algo"

	hCustomer := { => } // Declare / define an empty hash
	memarea->(DbGoTop())
	while !Eof()
		hCustomer[ Field->Codi ] := Memarea->Nome
		DBSKIP()
	ENDDO
	
	h1Record := NIL
	FOR EACH h1Record IN hCustomer
		? h1Record: __ENUMKEY(), h1Record:__ENUMVALUE()
	NEXT
	@ MAXROW(), 0
	WAIT "Tecle algo"

	hCustomer := { => } // Declare / define an empty hash
	DBGOTOP()
	WHILE .NOT. EOF()
		a1Data:= { NOME, ENDE, BAIR, CIDA}
		hCustomer[ CODI ] := a1Data
		DBSKIP()
	ENDDO
	h1Record := NIL
	FOR EACH h1Record IN hCustomer
		a1Key  := h1Record:__ENUMKEY()
		a1Data := h1Record:__ENUMVALUE()
		? a1Key
		AEVAL( a1Data, { | x1 | QQOUT( x1 ) } )
	NEXT
	WAIT "Tecle algo"			 
			 
function DemoHash2()

	CLS
	aFruits := { "appricot", "cherry", "melon", "pear", "grapes", "mulberry" }

	c1Fruit := '' // Variable for iteration value must be exist 
               // before FOR ... statement 
	?
	? "Traversing an array :"
	?
	FOR EACH c1Fruit IN aFruits 
		?? c1Fruit, ''
	NEXT 
	WAIT "Tecle algo"

	/* Note that this loop is equivalent to : 
    ?
    FOR n1Fruit := 1 TO LEN( aFruits )
        c1Fruit := aFruits[ n1Fruit ]
        ?? c1Fruit, ''
    NEXT */

	/* For a list in reverse order with classical FOR 
    ? 
    FOR n1Fruit := LEN( aFruits ) TO 1 STEP -1
        c1Fruit := aFruits[ n1Fruit ]
        ?? c1Fruit, ''
    NEXT */ 

	/* ... and with FOR EACH*/
    ? 
    ? "Traversing an array in revers order :"
    ?
    FOR EACH c1Fruit IN aFruits DESCEND
        ?? c1Fruit, ''
    NEXT 
	 WAIT "Tecle algo"

	/* Sometime we needs something like this : 

    ?
    FOR n1Fruit := 1 TO LEN( aFruits )
       c1Fruit := aFruits[ n1Fruit ]
       ?? STR( n1Fruit, 2 ), ":", c1Fruit + ';'
    NEXT */ 

	/* FOR EACH loop allow us using some 'internal' functions;
                          but a 'special' way : */
   ?
   ? "Traversing an array with indexs :"
   ?
   FOR EACH c1Fruit IN aFruits 
       ?? STR( c1Fruit:__ENUMINDEX(), 2 ), ":", c1Fruit + ';'
   NEXT 
	WAIT "Tecle algo"

   cString := "This is a string"

/* ... and a string example : 

   ?
   ? "Iterating a string by FOR .. NEXT :"
   ?
   FOR nIndex := 1 TO LEN( cString )
      ?? cString[ nIndex ]
   NEXT */


   ch := ''
   ? 
   ? "Iterating a string :"
   ?

   FOR EACH ch IN cString
       ? ch, asc(ch)
   NEXT 
	WAIT "Tecle algo"

	
	
	c1Char := ''
   ? 
   ? "Iterating a string in reverse order :"
   ?
   FOR EACH c1Char IN cString DESCEND
      ?? c1Char
   NEXT 
	WAIT "Tecle algo"

   ?
   ? "Nested loop example :"
   aArray := { "This is", "an array" }
   c1String := ''

   FOR EACH c1String IN aArray
      ? "----- Outer Loop -----"
      ? c1String:__ENUMINDEX(), c1String
      ? "----- Inner Loop -----"
      FOR EACH c1Char IN c1String
         ? c1Char:__ENUMINDEX(), c1Char
      NEXT 
   NEXT 
	WAIT "Tecle algo"

   ?
   ? "Traversing a Hash : "
   ? "EnumKey EnumValue EnumBase[ EnumKey ]"
   ? "-------- ---------------- -------------------"
   hSoftWare := { => }
   HB_HKeepOrder( hSoftWare, .T. ) 
   hSoftWare['MinGW ' ]  := 'C Compiler '
   hSoftWare['Harbour' ] := 'Clipper Compiler'
   hSoftWare['HMG ' ]    := 'GUI Library '
   
	hProgram := NIL // { => }
   FOR EACH hProgram IN hSoftWare
      ? hProgram:__ENUMKEY(), "=>", hProgram:__ENUMVALUE(),; 
      hProgram:__ENUMBASE()[hProgram:__ENUMKEY()] // Alternate syntax 
   NEXT 
	WAIT "Tecle algo"
	
   ?
   ? "Multiple base, multiple value : "
   aArrayNr := { 1, 2, 3 }
   aArrayEn := { "one", "two", "three" }
   aArrayFr := { "un", "deux", "Trois" }
   cNumNr := 0
   cNumEn := ''
   cNumFr := ''
   FOR EACH cNumNr, cNumEn, cNumFr IN aArrayNr, aArrayEn, aArrayFr
      ? cNumNr, cNumEn, cNumFr
   NEXT 	
   @ MAXROW(), 0
   WAIT "EOF ForEach.prg"
return // ForEach.Prg.Main()			 



//* INI Code *//
Function DemoHash3()
   LOCAL myHash := Hash()

   myHash[ "WINDOW" ] := Hash()
   HSetCaseMatch( myHash[ "WINDOW" ] , .F. )

   myHash[ "WINDOW" ][ "BACKCOLOR" ] := "GET,SET,RUN,DEFINE"
   myHash[ "WINDOW" ][ "CHILD"     ] := "GET,SET,RUN,DEFINE"
   myHash[ "WINDOW" ][ "COL"       ] := "GET,SET,RUN,DEFINE"
   myHash[ "WINDOW" ][ "FLAGS"     ] := "GET,SET,RUN,DEFINE"
   myHash[ "WINDOW" ][ "TYPE"      ] := "GET,SET,RUN,DEFINE"
   myHash[ "WINDOW" ][ "WIDTH"     ] := "GET,SET,RUN,DEFINE"

   ? HHasKey( myHash[ "WINDOW" ] , "COL" )
   ? HHasKey( myHash[ "WINDOW" ] , "TYPE" )

   inkey(0)
	return .T.
	
#include <xhb.ch>
PROCEDURE DemoHash4()	
	aFruits := { "apple", "appricot", "cherry", "melon", "pear", "mulberry" }

	? "aFruits", if( "pear"   $ aFruits, '', 'not ' ) + "contain pear"
	? "aFruits", if( "grapes" $ aFruits, '', 'not ' ) +"contain grapes"

	aComplex := ARRAY( 10 )
	AEVAL( aComplex, { | x1, i1 | aComplex[ i1 ] := i1 } )

	aComplex[ 5 ] := DATE()
	aComplex[ 7 ] := .F.

	cls
	?
	? "aComplex", if( 3 $ aComplex, '', 'not ' ) + "contain 3"
	? "aComplex", if( 13 $ aComplex, '', 'not ' ) + "contain 13"
	? "aComplex", if( .T. $ aComplex, '', 'not ' ) + "contain .T."
	? "aComplex", if( .F. $ aComplex, '', 'not ' ) + "contain .F."

	 
	hEmpty := { => }
	?
	? "hEmpty is a", VALTYPE( hEmpty ), "type variable have",;
	STR( LEN( hEmpty ), 1 ), "element and it's",;
	if( EMPTY( hEmpty ), '', 'not' ), "Empty"

	hCountries := { 'Argentina' => "Buenos Aires" }
	hCountries += { 'Brasil' => "Brasilia" }
	hCountries += { 'Chile' => "Santiago" }
	hCountries += { 'Mexico' => "Mexico City" }

	?
	? "hCountries is a", VALTYPE( hCountries ), "type variable have",;
	STR( LEN( hCountries ), 1 ), "elements and and it's",;
	if( EMPTY( hCountries ), '', 'not' ), "Empty"
	cCountry := NIL
	
	FOR EACH cCountry IN hCountries
	? cCountry:__ENUMKEY(), "=>", cCountry:__ENUMVALUE()
	NEXT 

	hDays := { 'Days' => { "Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun" } }

	?
	? "hDays", if( 'Days' $ hDays, '', 'not ' ) + "contain Days" 
	? "hDays", if( "Mon" $ hDays, '', 'not ' ) + "contain Mon" 
	? "hDays['Days']", if( "Fri" $ hDays["Days"], '', 'not ' ) + "contain Fri"
	 
	hLanguages := 	{ "EN" => "English" } +; 
						{ "DE" => "Deutsche" } +; 
						{ "ES" => "Español" } +; 
						{ "FR" => "Français" } +; 
						{ "IT" => "Italiano" } +; 
						{ "PL" => "Polkski" } +; 
						{ "PT" => "Português" } +; 
						{ "RU" => "Russkî" } +; 
						{ "TR" => "Türkçe" }

	?
	? "hLanguages is a", VALTYPE( hLanguages ), "type variable have",;
	STR( LEN( hLanguages ), 1 ), "elements and and it's",;
	if( EMPTY( hLanguages ), '', 'not' ), "Empty"
	cLanguage := NIL 
	FOR EACH cLanguage IN hLanguages
		? cLanguage:__ENUMKEY(), "=>", cLanguage:__ENUMVALUE()
	NEXT 

	@ MAXROW(), 0 
	WAIT "EOF OprOLoad.prg"
	return // OprOLoad.Prg.Main()