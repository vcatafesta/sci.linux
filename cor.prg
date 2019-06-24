#include "sci.ch"

def main(...)
	cls
	ver()
	ms_quadroCorInt()
	inkey(0)
	cls
	ms_quadrocorstr()
	inkey(0)

#include <hbver.ch>
	def ver()
	?
	? "Cor(), Copyright(c) 2018, Vilmar Catafesta"
	? "Versao Harbour : ", hb_Version(HB_VERSION_HARBOUR )
	? "Compiler C++   : ", hb_Version(HB_VERSION_COMPILER)
	?
	?	
	return nil
