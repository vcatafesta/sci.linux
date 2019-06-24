/*
  旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴?
 芙																								 ?
 芙	Modulo.......: RDDSYS.PRG						   								 ?						 
 芙	Sistema......: FUNCOES RDD      							            	    ?  
 芙	Aplicacao....: SCI - SISTEMA COMERCIAL INTEGRADO                      ?
 芙	Versao.......: 8.5.00							                            ?
 芙	Programador..: Vilmar Catafesta				                            ?
 芙   Empresa......: Macrosoft Informatica Ltda                             ?
 芙	Inicio.......: 12.11.1991 						                            ?
 芙   Ult.Atual....: 12.04.2018                                             ?
 芙   Compilador...: Harbour 3.2/3.4                                        ?
 芙   Linker.......: BCC/GCC/MSCV                                           ?
 芙	Bibliotecas..:  									                            ?
 鳧컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
 賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽
*/

ANNOUNCE RDDSYS
INIT PROCEDURE RddInit()
   // No driver is set as default
   // Forces drivers to be linked in
   REQUEST DBFNTX
   REQUEST DBFCDX
	REQUEST DBFNSX
	//REQUEST DBFMDX
   //REQUEST DBPX
   return

// EOF - RDDSYS.PRG //
