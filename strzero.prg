#include "sci.ch"
REQUEST HB_LANG_PT

func main(...)
	hb_langSelect( "pt" )
	//cVar := ms_space("VILMAR", 20)
	//? strzero(cVar, 40)
	//? len(strzero(cVar, maxcol()))
	? 0, strzero()
	? 1, strzero("VILMAR")
	? 2, strzero(DATE())

	? 3, strzero(1)
	? 4, strzero(1, DATE())
	? 5, strzero(1, "VILMAR")

	? 6, strzero("VILMAR", "VILMAR")
	? 7, strzero(1, "VILMAR")
	? 8, strzero(1, "VILMAR", 2)
	? 9, strzero(DATE(), "VILMAR", "VILMAR")
	?10, strzero("VILMAR", 20)
	?11, strzero("VILMAR", DATE())
	?12, strzero("VILMAR", 10, 2)
	?13, strzero(10, 20, 10)
	?13, strzero("VILMAR", 0, 0, 65)
	//? strzero(), valtype(strzero())

for i := 1 to 10
	? strzero(i,2)
next
