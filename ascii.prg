? ConverteStrToNumber("002796-01")
*-----------------------------------------------*


function ConverteStrToNumber(cDocnr)
*-----------------------------------------------*
    LOCAL aLetras := {}
	LOCAL nStart  := 65
	LOCAL nStop   := nStart + 24
	LOCAL cNumber	
	LOCAL cLetra := asc(right(upper(cDocnr),1))

   	if cLetra >= nStart .AND. cLetra <= nStop // Letras A-Z
		for i := nStart to nStop
			aadd(aLetras, upper(chr(i)))
		next
		cNumber := strzero(ascan(aLetras, right(cDocnr,1)),2)
		cDocnr  := substr(cDocnr, 2, 7) + cNumber	// 002796-
	endif
	return(cDocnr)
