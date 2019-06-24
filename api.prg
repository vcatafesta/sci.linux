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

def teste()
/*-----------------------------------------------------------------------------------------------*/	
	LOCAL ncor := 31
	LOCAL x    := 999
	LOCAL cstr := ms_replicate("=", 80)
	LOCAL cfor := MS_for(100)
	LOCAL ctit := capitalize("Macrosoft api " + ProcName())
	
	//setcolor("")			
	//MS_Cls(nCor)	
	ms_SetConsoleTitle(cTit)
	? cstr	
	? "Api for Win32, Copyright (c) 1991-2018, Vilmar Catafesta"
	? "Versao Harbour : ", hb_Version(HB_VERSION_HARBOUR )
	? "Compiler C++   : ", hb_Version(HB_VERSION_COMPILER)
	? "Computer       : ", NetName()
	? cstr
	
	? "Len cstr        :", len(cstr)
	? "Len ncor        :", len(ncor)	
	? "Len x           :", len(x)	
	? "Len .t.         :", len(.t.)	
	? "Len .f.         :", len(.f.)	
	? "Len ms_for(100) :", len(cfor)
	? "val x           :", val("100")
	? "val x           :", hb_val("100")
	
	? "capitalize      :", capitalize("vilmar catafesta ")
	? "capitalize      :", len(capitalize("vilmar catafesta "))
	
		
	//SayCls(23, "**°±²VILMAR**", 0, 00, 00)
	//ms_SetConsole(50 , 110)
	//ms_cls(ncor, "°±²")
	//? MS_MAXROW(), MS_MAXBUFFERROW()
	//? MS_MAXCOL(), MS_MAXBUFFERCOL()
	//? MS_SETBUFFER(50,120)
	//? MS_MAXROW(), MS_MAXBUFFERROW()
	//? MS_MAXCOL(), MS_MAXBUFFERCOL()
	

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


#require "hbwin"

PROCEDURE PrinterMain()
	Teste1()
	//CriaPdf()

PROCEDURE Teste1()
   LOCAL nPrn := 1
   LOCAL cFileName := Space( 40 )
   LOCAL GetList := {}

   LOCAL aPrn := win_printerList()

   CLS

   if Empty( aPrn )
      Alert( "No printers installed - Cannot continue" )
   else
      DO WHILE nPrn != 0
         CLS
         @ 0, 0 SAY "win_PrintFileRaw() test program. Choose a printer to test"
         @ 1, 0 SAY "File name:" GET cFileName PICT "@!K"
         READ
         @ 2, 0 TO MaxRow(), MaxCol()
         nPrn := AChoice( 3, 1, MaxRow() - 1, MaxCol() - 1, aPrn, .T.,, nPrn )
         if nPrn != 0
            PrnTest( aPrn[ nPrn ], cFileName )
         endif
      ENDDO
   endif

   return

STATIC PROCEDURE PrnTest( cPrinter, cFileName )

   LOCAL lDelete

   if Empty( cFileName )
      hb_MemoWrit( cFileName := hb_FNameExtSet( __FILE__, ".prn" ), "Hello World!" + Chr( 12 ) )
      lDelete := .T.
   else
      lDelete := .F.
   endif

   Alert( "win_PrintFileRaw() returned: " + hb_ntos( win_PrintFileRaw( cPrinter, cFileName, "testing raw printing" ) ) )

   if lDelete
      FErase( cFileName )
   endif

	CLS
   Teste2()

#require "hbwin"

PROCEDURE Teste2()

   LOCAL aPrn
   LOCAL nPrn := 1
   LOCAL cDocName := "Raw printing test"
   LOCAL cFileName := Space( 256 )
   LOCAL GetList := {}

   if Empty( aPrn := win_printerList() )
      Alert( "No printers installed - Cannot continue" )
   else
      DO WHILE nPrn > 0

         CLS
         @ 0, 0 SAY "Raw printing test. Choose a printer to test"
         @ 1, 0 SAY "File name:" GET cFileName PICTURE "@KS40"
         READ
         @ 2, 0 TO MaxRow(), MaxCol()

         if ( nPrn := AChoice( 3, 1, MaxRow() - 1, MaxCol() - 1, aPrn, .T.,, nPrn ) ) > 0

            if Empty( cFileName )
               Alert( "win_PrintDataRaw() returned: " + ;
                  hb_ntos( win_PrintDataRaw( aPrn[ nPrn ], "Hello World!" + hb_BChar( 12 ), cDocName ) ) )
            else
               Alert( "win_PrintFileRaw() returned: " + ;
                  hb_ntos( win_PrintFileRaw( aPrn[ nPrn ], cFileName, cDocName ) ) )
            endif
         endif
      ENDDO
   endif

#require "hbwin"
#include "simpleio.ch"

PROCEDURE Teste3()

   Dump( win_printerList( .F., .F. ) )
   Dump( win_printerList( .F., .T. ) )
   Dump( win_printerList( .T., .F. ) )
   Dump( win_printerList( .T., .T. ) )

   ? "win_printerGetDefault():", ">" + win_printerGetDefault() + "<"
   ? "win_printerStatus():", hb_ntos( win_printerStatus() )

   return

STATIC PROCEDURE Dump( a )

   LOCAL b, c

   ? "==="
   FOR EACH b IN a
      ?
      if HB_ISARRAY( b )
         FOR EACH c IN b
            ?? c:__enumIndex(), c
            if c:__enumIndex() == 2
               ?? "", ;
                  ">>" + win_printerPortToName( c ) + "<<", ;
                  "|>>" + win_printerPortToName( c, .T. ) + "<<|"
            endif
            ?
         NEXT
         ? "---"
      else
         ? b, win_printerExists( b ), win_printerStatus( b )
      endif
		inkey(0)
   NEXT
   return

	
#require "hbwin"
#include "simpleio.ch"
PROCEDURE Teste4()

   LOCAL a := win_printerGetDefault()

   ? ">" + a + "<"

   ? win_printerSetDefault( a )

   return	


	
? WIN_PRINTEREXISTS()     
? WIN_PRINTERSTATUS()     
? WIN_PRINTERPORTTONAME() 
? WIN_PRINTERLIST()       
? WIN_PRINTERGETDEFAULT() 
? WIN_PRINTERSETDEFAULT() 
? WIN_PRINTFILERAW()      



Win_PrintFileRaw(Win_PrinterGetDefault(), "REPLACE.PRG", "Relatorio Teste")
Alert( "Retorno: " + hb_ntos( WIN_PRINTFILERAW( cPrinter, "REPLACE.PRG", "testando impress„o" ) ) )

SelecionaImpressora()

Function SelecionaImpressora()
Local aPrinterList := {}, nOpc := 1, lCancel := .f.

aPrinterList := Win_PrinterList()
For nCont = 1 To Len(aPrinterList)
   if aPrinterList[nCont] == Win_PrinterGetDefault()
      nOpc := nCont
      Exit
   endif
Next   
Achoice(20,Int(MaxCol()/4), 40, 79, aPrinterList,@nOpc,"Impressora a utilizar")
lCancel := ( LastKey() == 27 )
if .Not. lCancel
   Win_PrinterSetDefault(aPrinterList[nOpc])
endif   
return lCancel


cls

? ReplAll("abcd  ", "-")           // "abcd--"
? ReplAll("001234", " ", "0")      // "  1234"
? ReplAll("   d  ", "-")           // "---d--"
? ReplAll(" d d  ", "-")           // "-d d--"


#require "hbwin"
PROCEDURE CriaPdf()

   LOCAL oPC, nTime, cDefaultPrinter, oPrinter, nEvent := 0

   if Empty( oPC := win_oleCreateObject( "PDFCreator.clsPDFCreator" ) )
      ? "Could not create PDFCreator COM object"
      return
   endif

   /* Setup event notification */
   oPC:__hSink := __axRegisterHandler( oPC:__hObj, {| X | nEvent := X } )

   oPC:cStart( "/NoProcessingAtStartup" )
   oPC:_cOption( "UseAutosave", 1 )
   oPC:_cOption( "UseAutosaveDirectory", 1 )
   oPC:_cOption( "AutosaveDirectory", hb_DirSepDel( hb_DirBase() ) )
   oPC:_cOption( "AutosaveFilename", "pdfcreat.pdf" )
   oPC:_cOption( "AutosaveFormat", 0 )

   cDefaultPrinter := oPC:cDefaultPrinter
   oPC:cDefaultPrinter := "PDFCreator"
   oPC:cClearCache()

   /* You can do any printing here using WinAPI or
      call a 3rd party application to do printing */
#if 1
   oPrinter := win_Prn():New( "PDFCreator" )
   oPrinter:Create()
   oPrinter:startDoc( "Harbour print job via PDFCreator" )
   oPrinter:NewLine()
   oPrinter:NewLine()
   oPrinter:TextOut( "Hello, PDFCreator! This is Harbour :)" )
   oPrinter:EndDoc()
   oPrinter:Destroy()
#else
   oPrinter := NIL
   ? "Do some printing to PDFCreator printer and press any key..."
   Inkey( 0 )
#endif

   oPC:cPrinterStop := .F.

   nTime := hb_MilliSeconds()
   DO WHILE nEvent == 0 .AND. hb_MilliSeconds() - nTime < 10000
      hb_idleSleep( 0.5 )
      /* The following dummy line is required to allow COM server to send event [Mindaugas] */
      oPC:cOption( "UseAutosave" )
   ENDDO

   SWITCH nEvent
   CASE 0
      ? "Print timeout"
      EXIT
   CASE 1
      ? "Printed successfully"
      EXIT
   CASE 2
      ? "Error:", oPC:cError():Description
      EXIT
   OTHERWISE
      ? "Unknown event"
   ENDSWITCH

   oPC:cDefaultPrinter := cDefaultPrinter
   oPC:cClose()
   oPC := NIL

   return
	
PROC TESTE6()	
cArq := "c:\SCI\TESTE.TXT"
SET CONSOLE OFF
SET DEVICE TO PRINT
SET PRINTER TO (cArq)
SET PRINT ON
? Time()
SET PRINT OFF
SET PRINTER TO
SET DEVICE TO SCREEN
SET CONSOLE ON

// cDefaultPrinter:= WIN_PRINTERGETDEFAULT()
// WIN_PRINTFILERAW(cDefaultPrinter, cArq)
ImprimeRaw( cArq )


FUNCTION ImprimeRaw(cArq)
LOCAL cPrinter:= WIN_PrinterGetDefault() , cMsg:="", nRet, nErro, cMensagem

      nRet:=WIN_PrintFileRaw(cPrinter,cArq,'Impressao Sistema')
      if nRet < 0
         cMsg := 'Erro Imprimindo: '+hb_ntos(nRet)+" "
         SWITCH nRet
         CASE -1
            cMsg+="Parƒmetros inv lidos passados para fun‡„o."   ; EXIT
         CASE -2
            cMsg+="WinAPI OpenPrinter() falha na chamada."      ; EXIT
         CASE -3 
            cMsg+="WinAPI StartDocPrinter() falha na chamada."  ; EXIT
         CASE -4
            cMsg+="WinAPI StartPagePrinter() falha na chamada." ; EXIT
         CASE -5
            cMsg+="WinAPI malloc() falha de mem¢ria."           ; EXIT
         CASE -6
            cMsg+="Arquivo " + cArq + " n„o localizado."        ; EXIT
         END
         nErro := wapi_GetLastError()
         cMensagem := space(128)
         wapi_FormatMessage(,,,,@cMensagem)
        Alert("N§ erro: "+hb_ntos(nErro)+;
                                hb_eol()+;
                                hb_eol()+;
                                cMsg+;
                                hb_eol()+;
                                hb_eol()+;
                               cMensagem)
         
      endif
return Nil


#require "hbnf"
PROCEDURE Teste_Box()

   LOCAL i

   SetColor( "W/B" )
   CLS
   FOR i := 0 TO MaxRow()
      @ i, 0 SAY Replicate( "@", MaxCol() + 1 )
   NEXT

   ft_XBox( , , , , , , , "This is a test", "of the ft_XBox() function" )
   ft_XBox( "L", "W", "D", "GR+/R", "W/B", 1, 10, "It is so nice", ;
      "to not have to do the messy chore", ;
      "of calculating the box size!" )
   ft_XBox( , "W", "D", "GR+/R", "W/B", MaxRow() - 8, 10, "It is so nice", ;
      "to not have to do the messy chore", ;
      "of calculating the box size!", ;
      "Even though this line is way too long, and is in fact longer than the screen width, if you care to check!" )

   return
	
