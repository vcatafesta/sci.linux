//#include "sci.ch"
#include "browsearraysrc.prg"

#define MTR_INCREMENT 	1

function main(...)
	RddSetDefault("DBFCDX")
	cls
	ver()
	ferase("test.cdx")
	use test NEW
	index on first tag test1 to test EVAL {|| MYMETER() } EVERY MTR_INCREMENT
	index on last  tag test2 to test EVAL {|| MYMETER() } EVERY MTR_INCREMENT
	? OrdBagName(1), OrdName(1), IndexKey(1)
	? OrdBagName(2), OrdName(2), IndexKey(2)
	AchaIndice("test")

#include <hbver.ch>
function ver()
	?
	? "Index(), Copyright(c) 2018, Vilmar Catafesta"
	? "Versao Harbour : ", hb_Version(HB_VERSION_HARBOUR )
	? "Compiler C++   : ", hb_Version(HB_VERSION_COMPILER)
	?
	return nil

FUNCTION AchaIndice(cDbf)
	LOCAL nX
	LOCAL nY
   LOCAL aIndice := ArrayIndices()

	FOR EACH nX IN aIndice
		? len(nX)
		FOR EACH nY IN nX
         if nY:__enumindex() == 1 .and. alltrim(lower(cDbf)) != alltrim(lower(nY))
            alert(cDbf + " found at " +  str(nY:__enumindex()))
            exit
         endif
         if nY:__enumindex() == 1
            loop
         endif
		? lower(nY), nY:__enumindex()-1, lower(OrdName(nY:__enumindex()-1))
        ? lower(nY) == lower(OrdName(nY:__enumindex()-1))
		NEXT
	NEXT


FUNCTION MYMETER()
	STATIC nRecsDone := 1
	nRecsDone += MTR_INCREMENT
	nconta := round((nRecsDone/LastRec())*100,0)
	if nConta <= 100
		@ 09, 00 SAY "Reindexando..."
		@ 10, 00 SAY replicate(chr(219),nConta) + AllTrim(Str(nConta)) + "%"
	endif
    RETURN (.T.)

FUNCTION ArrayIndices()
*----------------*
	LOCAL aArquivos := {}
	Aadd( aArquivos, { "testA",      "test1", "test2", "test3"})
	Aadd( aArquivos, { "testB",      "test1", "test2", "test3"})
	Aadd( aArquivos, { "test",       "test1", "test2", "test3"})
	//Aadd( aArquivos, { "EMPRESA",   "EMPRESA1"})
	return( aArquivos )

