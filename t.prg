#include "browsearraysrc.prg"

func main(...)
	//ateste := hb_Directory(hb_dirbase())
	cls
	ateste := hb_Directory()
	? hb_ps()
	? hb_progname()
	? valtype(ateste)
	? videotype()
	? memory(0)
	inkey(0)
	setcolor("w+/b")
	browsearray(ateste)

