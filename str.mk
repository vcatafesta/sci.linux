INC 		=	-IC:\sci\include -IC:\hb34.src\harbour-core\include
CFLAGS	=	-i$(INC)

.prg.c:
	harbour $*.prg -n $(INC)

str.c			: str.prg ..\include\sci.ch
tstring.c	: tstring.prg ..\include\sci.ch	

all			: teste.exe
teste.exe	: str.c tstring.c
str.c       : str.prg
tstring.c   : tstring.prg

clean:
	rm -rf *.o

mrproper: clean
	rm -rf teste
