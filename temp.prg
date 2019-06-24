function main
LOCAL aStruct, aList, aRet

cls
aStruct := { ;
   { "CODE",  "N",  4, 0 }, ;
   { "NAME",  "C", 10, 0 }, ;
   { "PHONE", "C", 13, 0 }, ;
   { "IQ",    "N",  3, 0 } }
aList := { "IQ", "NAME" }
aRet := __FLedit( aStruct, aList )
                   // { { "IQ", "N", 3, 0 }, { "NAME", "C", 10, 0 } }

aRet := __FLedit( aStruct, {} )
? aRet == aStruct  // .T.

aList := { "iq", "NOTEXIST" }
aRet := __FLedit( aStruct, aList )
                   // { { "IQ", "N", 3, 0 } }
aList := { "NOTEXIST" }
aRet := __FLedit( aStruct, aList )  // {}
main2()

function main2
	LOCAL aStruct, aList, aRet
	USE test

	aStruct := dbStruct()
	nChoice := achoice(00,00,24,79, aStruct, .t.)
	aList := { "NAME" }
	afl := __FLedit( aStruct, aList )
	dbCreate( "onlyname.dbf", afl )

