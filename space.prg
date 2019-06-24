REQUEST HB_LANG_PT

function main(...)
	hb_langSelect( "pt" )
	? len(ms_space("VILMAR", 30))
	cnome := ms_space("Vilmar catafesta", 50)
	? len(cNome)
	? cNome += "Evili"
