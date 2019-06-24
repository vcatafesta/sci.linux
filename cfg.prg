//#include "sci.ch"
#include "clientes.ch"
#include "hbver.ch"
#include "fileio.ch"

#Define  XEXE            "SCI.EXE"
#Define  XSISTEM_VERSAO  "- Vers„o 9.4.01 x86_64 "
#Define  XSISTEM_1       "Macrosoft SCI for Linux"
#Define  XSISTEM_2       "Macrosoft SCI - CONTROLE ESTOQUE"
#Define  XSISTEM_3       "Macrosoft SCI - CONTAS RECEBER"
#Define  XSISTEM_4       "Macrosoft SCI - CONTAS PAGAR"
#Define  XSISTEM_5       "Macrosoft SCI - CONTAS CORRENTES"
#Define  XSISTEM_6       "Macrosoft SCI - CONTROLE VENDEDORES"
#Define  XSISTEM_7       "Macrosoft SCI - CONTROLE PRODUCAO"
#Define  XSISTEM_8       "Macrosoft SCI - CONTROLE PONTO"
#Define  DATALIMITE      DTOC(DATE()+15) // MM/DD/YY
#Translate MsWriteLine	    => FWriteLine
#Translate MsReadLine	    => FReadL sci.err ine
#Translate Encrypt 	 	 	 => HB_Crypt
#Translate Decrypt			 => HB_Decrypt

*---------------------------*
function main()
*---------------------------*
   LOCAL hSci           := Hash() // {=>}
	LOCAL cEncrypt       := ENCRYPT
	LOCAL cXnomefir      := ENCRYPT
	LOCAL cVersao        := XSISTEM_VERSAO
	LOCAL cSis1          := XSISTEM_1
	LOCAL cSis2          := XSISTEM_2
	LOCAL cSis3          := XSISTEM_3
	LOCAL cSis4          := XSISTEM_4
	LOCAL cSis5          := XSISTEM_5
	LOCAL cSis6          := XSISTEM_6
	LOCAL cSis7          := XSISTEM_7
	LOCAL cSis8          := XSISTEM_8
	LOCAL cExe           := XEXE	
	LOCAL cSystem_Versao := XSISTEM_VERSAO
	LOCAL cSci           := XSISTEM_1
	LOCAL cTestelan      := XSISTEM_2
	LOCAL cReceLan       := XSISTEM_3
	LOCAL cPagalan       := XSISTEM_4
	LOCAL cChelan        := XSISTEM_5
	LOCAL cVendedores    := XSISTEM_6
	LOCAL cProducao      := XSISTEM_7
	LOCAL cPonto         := XSISTEM_8
	Set Century On
   Set Date To Italian
   
   cSystem_Versao += Dtoc(Date()) + " " + Left(Time(),5)
	
	?
	? "cfg, Copyright(c) 2018, Vilmar Catafesta"
	? "   Versao Harbour : ", hb_Version(HB_VERSION_HARBOUR )
	? "   Compiler C++   : ", hb_Version(HB_VERSION_COMPILER)
	?
	?	
	Qout("þþþ Excluindo sci.cfg...")
	Ferase("sci.cfg")	
	Qout("þþþ Criando novo sci.cfg...")
	handle := FCreate("sci.cfg")
	if ( Ferror() != 0 )
		Alert("Erro de Criacao de sci.cfg")
		__Quit()
	endif
	Qout("þþþ Gravando String em sci.cfg...")
	cMicrobras := "CCopyright (c) 1991, 2018 Vilmar Catafesta"
	cEndereco  := "AAv Castelo Branco, 693 * Pioneiros * (69)3451-3085/98110-1393 * Pimenta Bueno/RO"
	cTelefone  := "eemail * vcatafesta@sybernet.com.br/vcatafesta@gmail.com   "
	cCidade    := "hhttp://www.sybernet.com.br - Todos Direitos Reservados"
	
	MsWriteLine( Handle, "[ENDERECO_STRING]")
	MsWriteLine( Handle, cMicroBras )
	MsWriteLine( Handle, cEndereco )
	MsWriteLine( Handle, cTelefone )
	MsWriteLine( Handle, cCidade )
	//
	MsWriteLine( Handle, "" )
	//
	MsWriteLine( Handle, "[ENDERECO_CODIGO]")
	MsWriteLine( Handle, MsEncrypt( cMicrobras ))
	MsWriteLine( Handle, MsEncrypt( cEndereco ))
	MsWriteLine( Handle, MsEncrypt( cTelefone ))
	MsWriteLine( Handle, MsEncrypt( cCidade ))
	//
	MsWriteLine( Handle, "" )
	//
	MsWriteLine( Handle, "[SCI_STRING]")
	MsWriteLine( Handle, " ÚÄÄÄÄÄ¿    ÚÄÄÄÄÄ¿  ÚÄ¿")
	MsWriteLine( Handle, " ßßßßßßÀ¿   ßßßßßßÀ¿ ßß³")
	MsWriteLine( Handle, "ßßßßßßßß³  ßßßßßßßß³ ßß³")
	MsWriteLine( Handle, "ßß³   ßßÙ  ßß³   ßßÙ ßß³")
	MsWriteLine( Handle, "ßßÀÄÄÄÄ¿   ßß³       ßß³")
	MsWriteLine( Handle, "ßßßßßßßÀ¿  ßß³       ßß³")
	MsWriteLine( Handle, " ßßßßßßß³  ßß³       ßß³")
	MsWriteLine( Handle, "      ßß³  ßß³       ßß³")
	MsWriteLine( Handle, "ßßÄÄÄÄßß³  ßßÀÄÄÄßß³ ßß³")
	MsWriteLine( Handle, "ßßßßßßßßÙ  ßßßßßßßßÙ ßß³")
	MsWriteLine( Handle, " ßßßßßßÙ    ßßßßßßÙ  ßßÙ")
	//
	MsWriteLine( Handle, "" )
	//
	MsWriteLine( Handle, "[SCI_CODIGO]")
	MsWriteLine( Handle, MSEncrypt(" ÚÄÄÄÄÄ¿    ÚÄÄÄÄÄ¿  ÚÄ¿"))
	MsWriteLine( Handle, MSEncrypt(" ßßßßßßÀ¿   ßßßßßßÀ¿ ßß³"))
	MsWriteLine( Handle, MSEncrypt("ßßßßßßßß³  ßßßßßßßß³ ßß³"))
	MsWriteLine( Handle, MSEncrypt("ßß³   ßßÙ  ßß³   ßßÙ ßß³"))
	MsWriteLine( Handle, MSEncrypt("ßßÀÄÄÄÄ¿   ßß³       ßß³"))
	MsWriteLine( Handle, MSEncrypt("ßßßßßßßÀ¿  ßß³       ßß³"))
	MsWriteLine( Handle, MSEncrypt(" ßßßßßßß³  ßß³       ßß³"))
	MsWriteLine( Handle, MSEncrypt("      ßß³  ßß³       ßß³"))
	MsWriteLine( Handle, MSEncrypt("ßßÄÄÄÄßß³  ßßÀÄÄÄßß³ ßß³"))
	MsWriteLine( Handle, MSEncrypt("ßßßßßßßßÙ  ßßßßßßßßÙ ßß³"))
	MsWriteLine( Handle, MSEncrypt(" ßßßßßßÙ    ßßßßßßÙ  ßßÙ"))
	Fclose(handle)      
	Qout("þþþ Arquivo sci.cfg. OK.")
	Qout("þþþ Criando sci.dbf.")
	CriaDbf()
	Qout("þþþ Anexando Informacoes.")
	Set Date To USA
	Use sci New
	DbAppend()
	Sci->EMPRESA  := MSEncrypt( ENCRYPT )        ; Sci->NOME     := ENCRYPT
	Sci->CODI_SCI := MSEncrypt( XSISTEM_1 )      ; Sci->NOME_SCI := XSISTEM_1
	Sci->CODI_EST := MSEncrypt( XSISTEM_2 )      ; Sci->NOME_EST := XSISTEM_2
	Sci->CODI_REC := MSEncrypt( XSISTEM_3 )      ; Sci->NOME_REC := XSISTEM_3
	Sci->CODI_PAG := MSEncrypt( XSISTEM_4 )      ; Sci->NOME_PAG := XSISTEM_4
	Sci->CODI_CHE := MSEncrypt( XSISTEM_5 )      ; Sci->NOME_CHE := XSISTEM_5
	Sci->CODI_VEN := MSEncrypt( XSISTEM_6 )      ; Sci->NOME_VEN := XSISTEM_6
	Sci->CODI_PRO := MSEncrypt( XSISTEM_7 )      ; Sci->NOME_PRO := XSISTEM_7
	Sci->CODI_PON := MSEncrypt( XSISTEM_8 )      ; Sci->NOME_PON := XSISTEM_8
	Sci->CODI_VER := MSEncrypt( cSystem_Versao)  ; Sci->NOME_VER := cSystem_Versao
	Sci->NOMEEXE  := MSEncrypt( XEXE )
	Sci->LIMITE   := MSEncrypt( DATALIMITE )
	Set Date Brit
	Qout("þþþ", Sci->Nome )
	Qout("þþþ Limite", Sci->(MSDecrypt( Limite )))
	Qout("þþþ Arquivos de Configuracao OK.")
	Qout()
	
	return nil
	Quit

*---------------------------*
function CriaDbf()
*---------------------------*
	DbCreate("sci.dbf", ;
					{{ "EMPRESA",    "C", 40, 0 },;
					{ "NOME",       "C", 40, 0 },;
					{ "CODI_SCI",   "C", 45, 0 },;
					{ "NOME_SCI",   "C", 45, 0 },;
					{ "CODI_EST",   "C", 40, 0 },;
					{ "NOME_EST",   "C", 40, 0 },;
					{ "CODI_REC",   "C", 40, 0 },;
					{ "NOME_REC",   "C", 40, 0 },;
					{ "CODI_PAG",   "C", 40, 0 },;
					{ "NOME_PAG",   "C", 40, 0 },;
					{ "CODI_CHE",   "C", 40, 0 },;
					{ "NOME_CHE",   "C", 40, 0 },;
					{ "CODI_VEN",   "C", 40, 0 },;
					{ "NOME_VEN",   "C", 40, 0 },;
					{ "CODI_PRO",   "C", 40, 0 },;
					{ "NOME_PRO",   "C", 40, 0 },;
					{ "CODI_PON",   "C", 40, 0 },;
					{ "NOME_PON",   "C", 40, 0 },;
					{ "CODI_VER",   "C", 40, 0 },;
					{ "NOME_VER",   "C", 40, 0 },;
					{ "NOMEEXE",    "C", 12, 0 },;
					{ "LIMITE",     "C", 10, 0 }})
	return

*--------------------*
function MsDecrypt( Pal )
*--------------------*
	LOCAL cChave	:= ""
	LOCAL nX 		:= 0

	for nX := 0 To 10
		cChave += Chr( Asc( Chr( nX )))
	next
	return( Decrypt( Pal, cChave ))

*--------------------*
function MsEncrypt( Pal )
*--------------------*
	LOCAL cChave	:= ""
	LOCAL nX 		:= 0

	for nX := 0 To 10
		cChave += Chr( Asc( Chr( nX )))
	next
	return( Encrypt( Pal, cChave ))

*---------------------------*	
function FWriteLine( nH, cBuffer)
*---------------------------*
	LOCAL nSavePos
	LOCAL nNumRead
	#define EOL HB_OSNEWLINE()
	
   nSavePos := fseek( nH, 0, FS_RELATIVE )
   FBot(nH)
	nNumRead := fwrite( nH, cBuffer + EOL)
	fseek( nH, nSavePos, FS_SET )
   return nNumRead != 0	
	
*---------------------------*
function FBot( nHandle )
*---------------------------*
   LOCAL nPos := FSeek( nHandle, 0, FS_END )
   return nPos	!= -2	
	
