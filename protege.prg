#Include "FILEIO.CH"

Function Main( cFile )
**********************
Cls
Qout("��� Lendo ", cFile)
if DbfProtege( cFile )
  Qout("��� Arquivo DesProtegido.")
  Qout("��� Protegendo Arquivo.")
  Qout()
  Quit
endif
if DbfDesProtege( cFile )
  Qout("��� Arquivo Protegido.")
  Qout("��� DesProtegendo Arquivo.")
  Qout()
  Quit
endif

Function DbfProtege( cFile )
****************************
LOCAL Read_Bytes
LOCAL Write_Bytes
LOCAL Handle
LOCAL Buffers

if ValType( cFile ) != "C"
   return( .F. )
endif

Handle := FOpen( cFile, FO_READWRITE )
Qout("��� Abrindo Arquivo.")
if Ferror() != 0
  FClose( Handle )
  Alert("Erro Abertura: " + Str( Ferror()))
  return( .F. )
endif

Qout("��� Lendo Arquivo.")
Buffer := Space(01)
Read_Bytes := FRead( Handle, @Buffer, 1 )
if Read_Bytes != 1
  FClose( Handle )
  Alert("Erro Leitura: " + Str( Ferror()))
  return( .F. )
endif

if Asc(Buffer) == 3
  Buffer := Chr(4)
else
  FClose( Handle )
  return( .F. )
endif
Qout("��� Escrevendo no Arquivo.")
FSeek( Handle, 0, 0 )
Write_Bytes := FWrite( Handle, Buffer, 1 )
if Write_Bytes != 1
  FClose( Handle )
  Alert("Erro Gravacao: " + Str( Ferror()))
  return( .F. )
endif
FClose( Handle )
return( .T. )

Function DbfDesProtege( cFile )
*******************************
LOCAL Read_Bytes
LOCAL Write_Bytes
LOCAL Handle
LOCAL Buffers

if ValType( cFile ) != "C"
   return( .F. )
endif

Qout("��� Abrindo Arquivo.")
Handle := FOpen( cFile, FO_READWRITE )
if Ferror() != 0
  FClose( Handle )
  Alert("Erro Abertura: " + Str( Ferror()))
  return( .F. )
endif

Qout("��� Lendo Arquivo.")
Buffer := Space(01)
Read_Bytes := FRead( Handle, @Buffer, 1 )
if Read_Bytes != 1
  FClose( Handle )
  Alert("Erro Leitura: " + Str( Ferror()))
  return( .F. )
endif

if Asc(Buffer) == 4
  Buffer := Chr(3)
else
  FClose( Handle )
  return( .F. )
endif
Qout("��� Escrevendo no Arquivo.")
FSeek( Handle, 0, 0 )
Write_Bytes := FWrite( Handle, Buffer, 1 )
if Write_Bytes != 1
  FClose( Handle )
  Alert("Erro Gravacao: " + Str( Ferror()))
  return( .F. )
endif
FClose( Handle )
return( .T. )
