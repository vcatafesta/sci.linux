#include "browsearraysrc.prg"
#require "hbmemio"
REQUEST HB_MEMIO

PROCEDURE Main()
	LOCAL tmp
	LOCAL aStru := {;
					{ "F1", "N", 9, 0 },;
					{ "F2", "+", 9, 0 };
				   }

	dbCreate( "mem:memiotest", aStru, , .T., "xmemarea" )
   	FOR tmp := 1 TO 1000
    	dbAppend()
      	FIELD->F1 := hb_randNum( 1000 )
   	NEXT

   	INDEX ON FIELD->F1 TAG f1
   	//dbEval( {|| QOut( FIELD->F1 ) } )
   	//BrowseArray(xmemarea->(DbStruct()))
	? fieldname(FIELD->f1), fieldtype(FIELD->f1)
	? fieldname(FIELD->f2),	fieldtype(FIELD->f2), valtype(fieldtype(FIELD->f2))
   	dbCloseArea()
   	dbDrop( "mem:memiotest" )  /* Free memory resource */
   	RETURN
