/*
  �������������������������������������������������������������������������Ŀ
 ݳ                                                                         �
 ݳ   Programa.....: SCIAPI.PRG                                                �
 ݳ   Aplicacao....: SCI - SISTEMA COMERCIAL INTEGRADO SCI                  �
 ݳ   Versao.......: 6.2.30                                                 �
 ݳ   Escrito por..: Vilmar Catafesta                                       �
 ݳ   Empresa......: Macrosoft Sistemas de Informatica Ltda.                �
 ݳ   Inicio.......: 12 de Novembro de 1991.                                �
 ݳ   Ult.Atual....: 25 de Julho de 2016.                                   �
 ݳ   Linguagem....: Clipper 5.2e/C/Assembler                               �
 ݳ   Linker.......: Blinker 6.00                                           �
 ݳ   Bibliotecas..: Clipper/Funcoes/Mouse/Funcky15/Funcky50/Classe/Classic �
 ݳ   Bibliotecas..: Oclip/Six3                                             �
 ����������������������������������������������������������������������������
 ��������������������������������������������������������������������������
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
	//SayCls(23, "**���VILMAR**", 0, 00, 00)
	//ms_SetConsole(50 , 110)
	//ms_cls(ncor, "���")
	//? MS_MAXROW(), MS_MAXBUFFERROW()
	//? MS_MAXCOL(), MS_MAXBUFFERCOL()
	//? MS_SETBUFFER(50,120)
	//? MS_MAXROW(), MS_MAXBUFFERROW()
	//? MS_MAXCOL(), MS_MAXBUFFERCOL()
	inkey(0)

	/*
	for ncor := 0 to 255   
		MS_Cls(ncor, "���")
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
	//ms_writechar(31, "���VILMAR****")

	//Qout( Ms_MaxRow())
	//Qout( Ms_MaxCol())
	return nil

/*-----------------------------------------------------------------------------------------------*/	

