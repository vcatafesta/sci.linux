*
* Program str
*
* Copyright 2007-2018 Vilmar Catafesta [vcatafesta@gmail.com]
*
* ∞∞∞±±≤≤≤€€€
*
#include "sci.ch"
#include "tstring.prg"

#xtranslate hb_mutexLock( <x>, <n> ) 	=> iif(! HB_ISNUMERIC(<n>), hb_mutexLock(<x>) iif(<n> <= 0, hb_MutexTryLock(<x>), hb_MutexTimeOutLock(<x>, <n>)))
//#xtranslate str(<xValue>)  				=> iif(hb_isNumeric(<xValue>), hb_nToc(<xValue>), <xValue>)
//#xtranslate trim(<xValue>)  			=> ltrim(rtrim(iif(hb_isNumeric(<xValue>), hb_nToc(<xValue>), <xValue>)))
#xtranslate alltrim(<xValue>)  			=> ltrim(rtrim(<xValue>))

def main(...)
	LOCAL x := 99.99
	//LOCAL x := "Galego Vcatafesta Evili"
	LOCAL s := TString():New()

	REQUEST HB_LANG_PT
	hb_langSelect( "pt" )

	cls
	? "Str, Copyright(c) 2018, Vilmar Catafesta"
	? "Versao Harbour : ", hb_Version(HB_VERSION_HARBOUR )
	? "Compiler C++   : ", hb_Version(HB_VERSION_COMPILER)
	? "Computer       : ", NetName()
	?
	?
	? lin()
	?

	? t
	
	//nKey := inkey(0)
	? "HB_KEYSETLAST(27)", HB_KEYSETLAST(27)
	? "HB_KEYCLEAR()", HB_KEYCLEAR()
	? "HB_KEYLAST()", HB_KEYLAST()

	? "valtype :", valtype(x)
	? "changed :", s:changed
	? "get     :", s:get
	? "len     :", s:len
	? "value   :", s:value

	? replicate("=", x)
	? "set     		:", s:set := "vilmar catafesta"
	? "get     		:", s:get
	? "type    		:", s:type
	? "len     		:", s:len
	? "changed 		:", s:changed
	? "value   		:", s:value
	? "upcase  		:", s:upcase, s:upper
	? "lower  		:", s:lower
	? "value   		:", s:value
	? "capitalize 	:", s:capitalize
	? "capitalize 	:", capitalize(s:value)

	? replicate("=", x)

	? "set     		:", s:set := replicate("*", 10)
	? "get     		:", s:get
	? "len     		:", s:len
	? "changed 		:", s:changed
	? "value   		:", s:value
	? "valtype 		:", valtype(s:value)
	? "len     		:", len(s:value)
	s:destroy()
	? "len     		:", len(s:value)
	? lin()

	cNome := 1
	? procname() + "(" + alltrim(procline()) + ")", valtype(cnome), strzero(cnome, 20, 2) //, valtype(strzero(cnome,10))

    cNome := "VILMAR"
	? procname() + "(" + alltrim(procline()) + ")", valtype(cnome), strzero(cnome, 20, 2) //, valtype(strzero(cnome,10))
	//? procname() + "(" + alltrim(procline()) + ")", valtype(cnome), str(cnome),  valtype(str(cnome))
	//? procname() + "(" + alltrim(procline()) + ")", valtype(cnome), ltrim(cnome), valtype(trim(cnome))
	//? procname() + "(" + alltrim(procline()) + ")", valtype(cnome), Alltrim(cnome), valtype(Alltrim(cnome))
	//? procname() + "(" + alltrim(procline()) + ")", valtype(nil),   str(nil, 5), valtype(str(nil,5))
	//? procname() + "(" + alltrim(procline()) + ")", valtype("VILMAR"),  str("VILMAR"), valtype(str("VILMAR"))
	//? procname() + "(" + alltrim(procline()) + ")", valtype("VILMAR"),  str("VILMAR", 5), valtype(str("VILMAR",5))
	//? procname() + "(" + alltrim(procline()) + ")", valtype({}),  str({}, 5), valtype(str({},5))
	//?
	quit

def lin()
	return(replicate("=", 100))
