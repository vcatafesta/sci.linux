/*
  ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 İ³                                                                         ³
 İ³   Programa.....: SCIAPI.PRG                                                ³
 İ³   Aplicacao....: SCI - SISTEMA COMERCIAL INTEGRADO SCI                  ³
 İ³   Versao.......: 6.2.30                                                 ³
 İ³   Escrito por..: Vilmar Catafesta                                       ³
 İ³   Empresa......: Macrosoft Sistemas de Informatica Ltda.                ³
 İ³   Inicio.......: 12 de Novembro de 1991.                                ³
 İ³   Ult.Atual....: 25 de Julho de 2016.                                   ³
 İ³   Linguagem....: Clipper 5.2e/C/Assembler                               ³
 İ³   Linker.......: Blinker 6.00                                           ³
 İ³   Bibliotecas..: Clipper/Funcoes/Mouse/Funcky15/Funcky50/Classe/Classic ³
 İ³   Bibliotecas..: Oclip/Six3                                             ³
 İÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
 ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

#include <sci.ch>

//ANNOUNCE HB_GT_SYS 
//REQUEST HB_GT_WIN
//REQUEST HB_GT_WVT_DEFAULT


function sciapi()
/*-----------------------------------------------------------------------------------------------*/	
	LOCAL ncor := 31
	
	setcolor("")			
	cls

	ms_cls(31)
	@ 00, 0 say ms_replicate("=", 100)
	@ 10, 0 say ms_replicate("=", 100)
	? ms_SetConsoleTitle(ProcName())
	//SayCls(23, "**°±²VILMAR**", 0, 00, 00)
	//ms_SetConsole(50 , 110)
	//ms_cls(ncor, "°±²")
	//? MS_MAXROW(), MS_MAXBUFFERROW()
	//? MS_MAXCOL(), MS_MAXBUFFERCOL()
	//? MS_SETBUFFER(50,120)
	//? MS_MAXROW(), MS_MAXBUFFERROW()
	//? MS_MAXCOL(), MS_MAXBUFFERCOL()
	inkey(0)

	/*
	for ncor := 0 to 255   
		MS_Cls(ncor, "°±²")
		Qout( ncor )
		inkey(0.01)
		//inkey(5)
	next	
	*/

	//MS_Cls(15)
	//cscreen := SaveScreen()
	//inkey(0)
	//cls
	//inkey(0)
	//restScreen(,,,, cScreen)
	//inkey(0)

	//Msg("Parametro 1 incorrecto", "Atencion")
	//ms_writechar(31, "°±²VILMAR****")

	//Qout( Ms_MaxRow())
	//Qout( Ms_MaxCol())
	return nil

/*-----------------------------------------------------------------------------------------------*/	

