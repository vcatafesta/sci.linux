cClock := Time()

cls
while .t. .AND. lastkey() != 27
	aHora          := ft_elapsed(,, cClock, Time())
	nRetval        := aHora[4 , 2] // segundos
	if nretval >= 1
	   @ 10, 10 say time()
	   cClock := Time()
	endif	
enddo	
