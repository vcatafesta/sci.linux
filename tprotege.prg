#include <sci.ch>

CLASS TProtege
Export:
	 VAR Protegido
	 VAR Erro
	 VAR Ferror
	 VAR MsgErro
	 VAR Rotina
    VAR Proteger
    VAR Arquivos
    VAR File
Export:
	 METHOD New CONSTRUCTOR
    METHOD Protege
    METHOD Encryptar
    METHOD Decryptar
    METHOD DesProtege
Hidden:
    MESSAGE Add METHOD TAddProtege
	 
ENDCLASS

METHOD New()
************
::Protegido := FALSO
::Erro		:= FALSO
::Ferror 	:= 0
::MsgErro   := ""
::Rotina 	:= ""
::Proteger  := OK
::File      := ""
::Arquivos := {}
return( Self )

METHOD TAddProtege()
********************
if Ascan( ::Arquivos, ::File ) = 0
   Aadd( ::Arquivos, ::File )
endif
return( Self )

METHOD Encryptar( cFile )
*************************
    Use ( cFile ) New
    //Sx_DBFencrypt( '63771588')
    ::Protegido := OK
    return(Self)

METHOD Decryptar( cFile )
*************************
    Use ( cFile ) New
    //Use ( cFile ) PASSWORD '63771588' New
    //Sx_DBFdecrypt()
    ::Protegido := FALSO
    return(Self)

METHOD Protege( cFile )
**********************
LOCAL Read_Bytes
LOCAL Write_Bytes
LOCAL Handle
LOCAL Buffers
LOCAL nPos

if ::Proteger == FALSO
   return( Self )
endif

::File := cFile
if ( nPos := Ascan( ::Arquivos, ::File )) <> 0
   Adel( ::Arquivos, nPos )
endif

::Rotina := "TProtege.Protege"
if ValType( cFile ) != "C"
	::Protegido := FALSO
	::Erro		:= OK
	::Ferror 	:= 0
	::MsgErro	:= "ARQUIVO NAO LOCALIZADO"
	return( Self )
endif

Handle := FOpen( cFile, FO_READWRITE )
if Ferror() != 0
	FClose( Handle )
	::Protegido := FALSO
	::Erro		:= OK
	::Ferror 	:= Ferror()
	::MsgErro	:= "ERRO DE ABERTURA DE :" + cFile
	return( Self )
endif

Buffer := Space(01)
Read_Bytes := FRead( Handle, @Buffer, 1 )
if Read_Bytes != 1
	FClose( Handle )
	::Protegido := FALSO
	::Erro		:= OK
	::Ferror 	:= 0
	::MsgErro	:= "ERRO DE LEITURA DE :" + cFile
	return( Self )
endif

if Asc(Buffer) == 3
  Buffer := Chr(4)
else
	FClose( Handle )
	::Protegido := OK
	::Erro		:= FALSO
	::Ferror 	:= 0
	::MsgErro	:= "ARQUIVO JA PROTEGIDO :" + cFile
	return( Self )
endif
FSeek( Handle, 0, 0 )
Write_Bytes := FWrite( Handle, Buffer, 1 )
if Write_Bytes != 1
	FClose( Handle )
	::Protegido := FALSO
	::Erro		:= OK
	::Ferror 	:= 0
	::MsgErro	:= "ERRO DE GRAVACAO :" + cFile
	return( Self )
endif
FClose( Handle )
::Protegido := OK
::Erro		:= FALSO
::Ferror 	:= 0
::MsgErro	:= "SUCESSO NA PROTECAO DO ARQUIVO :" + cFile
return( Self )

METHOD DesProtege( cFile )
**************************
LOCAL Read_Bytes
LOCAL Write_Bytes
LOCAL Handle
LOCAL Buffers

::File := cFile
if Ascan( ::Arquivos, ::File ) <> 0
   return( Self )
endif
::Rotina := "TProtege.DesProtege"
if ValType( cFile ) != "C"
	::Protegido := OK
	::Erro		:= OK
	::Ferror 	:= 0
	::MsgErro	:= "ARQUIVO NAO LOCALIZADO"
	return( Self )
endif

Handle := FOpen( cFile, FO_READWRITE )
if Ferror() != 0
	FClose( Handle )
	::Protegido := OK
	::Erro		:= OK
	::Ferror 	:= Ferror()
	::MsgErro	:= "ERRO DE ABERTURA DE :" + cFile
	return( Self )
endif

Buffer := Space(01)
Read_Bytes := FRead( Handle, @Buffer, 1 )
if Read_Bytes != 1
	FClose( Handle )
	::Protegido := OK
	::Erro		:= OK
	::Ferror 	:= 0
	::MsgErro	:= "ERRO DE LEITURA DE :" + cFile
	return( Self )
endif

if Asc(Buffer) == 4
  Buffer := Chr(3)
else
	FClose( Handle )
	::Protegido := FALSO
	::Erro		:= OK
	::Ferror 	:= 0
	::MsgErro	:= "ARQUIVO JA DESPROTEGIDO :" + cFile
	return( Self )
endif
FSeek( Handle, 0, 0 )
Write_Bytes := FWrite( Handle, Buffer, 1 )
if Write_Bytes != 1
	FClose( Handle )
   ::Protegido := OK
	::Erro		:= OK
	::Ferror 	:= 0
   ::MsgErro   := "ERRO DE GRAVACAO DE :" + cFile
	return( Self )
endif
FClose( Handle )
::Protegido := FALSO
::Erro      := FALSO
::Ferror    := 0
::MsgErro   := "SUCESSO NA DESPROTECAO DO ARQUIVO :" + cFile
Aadd( ::Arquivos, ::File )
return( Self )

Function TProtegeNew()
**********************
return( TProtege():New())
