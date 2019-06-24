FUNCTION Main
	teste()

function teste
local harr := hb_Hash( "six", 6, "eight", 8, "eleven", 11 )
 
   harr[10] := "str1"
   harr[23] := "str2"
   harr["fantasy"] := "fiction"
 
   ? harr[10], harr[23]                                   // str1  str2
   ? harr["eight"], harr["eleven"], harr["fantasy"]       // 8       11  fiction
   ? len(harr)                                            // 6
   ?
	
	@ MAXROW(), 0
	WAIT "Tecle algo"
 
   hSouth := { 'Argentina' => "Buenos Aires",;
               'Brasil'    => "Brasilia",;
               'Chile'     => "Santiago" }
   hNorth:= { 'USA'    => "Washington DC",;
              'Canada' => "Ottawa",;
              'Mexico' => "Mexico City" }

   * a hash contains two hashes :

   hAmerica := { "America" => { "North" => hNorth,;
                                "South" => hSouth } }

   * Standart array indexing syntax :

   ? hAmerica[ "America", "North", "USA" ] // Washington DC

   * Alternate syntax to indexing :

   ? hAmerica[ "America"][ "South" ][ "Chile" ] // Santiago

   ?
   @ MAXROW(), 0
	WAIT "Tecle algo"
	
	
	aCustomer := {}
	Use Receber New
	
	while !Eof()
		AADD(aCustomer, { CODI, NOME } )
		DBSKIP()
	enddo
	
	a1Record := {}

	FOR EACH a1Record IN aCustomer
		? a1Record[ 1 ], a1Record[ 2 ]
	NEXT	
	@ MAXROW(), 0
	WAIT "Tecle algo"

	
nRecord := ASCAN( aCustomer, { | a1Record | a1Record[ 1 ] == '00001' } )
? aCustomer[ nRecord, 1 ], aCustomer[ nRecord, 2 ]	


hCustomer := { => } // Declare / define an empty hash
DBGOTOP()
WHILE .NOT. EOF()
   hCustomer[ CODI ] := NOME
   DBSKIP()
ENDDO
h1Record := NIL
FOR EACH h1Record IN hCustomer
   ? h1Record: __ENUMKEY(),h1Record:__ENUMVALUE()
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
