/*
  ��������������������������������������������������������������������������?
 ݳ																								 ?
 ݳ	Modulo.......: RDDSYS.PRG						   								 ?						 
 ݳ	Sistema......: FUNCOES RDD      							            	    ?  
 ݳ	Aplicacao....: SCI - SISTEMA COMERCIAL INTEGRADO                      ?
 ݳ	Versao.......: 8.5.00							                            ?
 ݳ	Programador..: Vilmar Catafesta				                            ?
 ݳ   Empresa......: Macrosoft Informatica Ltda                             ?
 ݳ	Inicio.......: 12.11.1991 						                            ?
 ݳ   Ult.Atual....: 12.04.2018                                             ?
 ݳ   Compilador...: Harbour 3.2/3.4                                        ?
 ݳ   Linker.......: BCC/GCC/MSCV                                           ?
 ݳ	Bibliotecas..:  									                            ?
 ����������������������������������������������������������������������������
 ��������������������������������������������������������������������������
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
