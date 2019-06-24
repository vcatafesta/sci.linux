// HBMK2 %PRG% -lrddnsx
#include "dbinfo.ch"
REQUEST dbfnsx
PROCEDURE Main()
   rddSetDefault( "DBFNSX" )
   // hb_rddInfo( RDDI_LOCKSCHEME, , "DBFNSX" )
   FErase( "test.nsx" )
   dbCreate( "test.dbf", { { "T1", "C", 10, 0 } } )
   USE test EXCLUSIVE
   INDEX ON FIELD->T1 TAG test1 TO test
   USE test SHARED 
   ? "test Finished"
   return