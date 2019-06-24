#include <sci.ch>
#require hbnf.hbc

CLASS TFile
    Export:
		  VAR RowPrn
		  VAR Pagina
		  VAR Tamanho
		  VAR NomeFirma
		  VAR Sistema
		  VAR Titulo
		  VAR Cabecalho
		  VAR Separador
		  VAR Registros

    Export:
        METHOD New CONSTRUCTOR
        
		  METHOD Inicio
		  METHOD Eject
		  METHOD PrintOn
		  METHOD PrintOff
		  MESSAGE cabec method Inicio
        MESSAGE DfClose     INLINE Ft_dfclose()    // Close file displayed by FT_DISPFILE()         
        MESSAGE DfSetup     INLINE Ft_dfsetup()    // Set up parameters for FT_DISPFILE()
        MESSAGE DfDispfile  INLINE Ft_DispFile()   // Browse a text file
        MESSAGE Append      INLINE Ft_FAppend()    // Appends a line to the currently selected text file
        MESSAGE Delete      INLINE Ft_FDelete()    // Deletes a line from the currently selected text file   
        MESSAGE Eof         INLINE Ft_Feof()       // Determine when end of text file is encountered
        MESSAGE Ferror      INLINE Ft_Ferror()     // Return the error code for a text file operation 
        MESSAGE GoBottom    INLINE Ft_FGobot()     // Go to the last record in a text file
        MESSAGE Goto        INLINE Ft_FGoto()      // Move record pointer to specific record in a text file
        MESSAGE Gotop       INLINE Ft_FGotop()     // Go to the first record in a text file
        MESSAGE Insert      INLINE Ft_FInsert()    // Inserts a line in the currently selected text file 
        MESSAGE LastRec     INLINE Ft_FLastRe()    // Get the no. of records in the currently selected text file
        MESSAGE Readln      INLINE Ft_FReadLn()    // Read a line from the currently selected text file
        MESSAGE Recno       INLINE Ft_FRecno()     // Return the current record number of a text file
        MESSAGE Select      INLINE Ft_FSelect()    // Select a text file workarea
        MESSAGE Skip        INLINE Ft_FSkip()      // Move the record pointer to a new position in a text file
        MESSAGE Use         INLINE Ft_FUse()       // Open or close a text file for use by the FT_F* functions
        MESSAGE Writeln     INLINE Ft_FWriteLn()   // Write a line to the currently selected text file        
EndClass

Method New() class TFile
		  ::RowPrn	  := 0
		  ::Pagina	  := 0
		  ::Tamanho   := 80
		  ::NomeFirma := if( XNOMEFIR = NIL, AllTrim(oAmbiente:xFanta), XNOMEFIR )
        ::Sistema   := "Macrosoft NOME DO PROGRAMA"
		  ::Titulo	  := "TITULO DO RELATORIO"
		  ::Cabecalho := "CODIGO DESCRICAO"
		  ::Separador := "="
		  ::Registros := 0
        return( Self )

Method Inicio() class TFile
		LOCAL nTam := ::Tamanho / 2
		LOCAL Hora := Time()
		LOCAL Data := Dtoc( Date() )
		::Pagina++

		DevPos( 0, 0) ; QQout( Padc( ::NomeFirma, ::Tamanho ))
		Qout( Padc( ::Sistema, ::Tamanho ))
		Qout( Padc( ::Titulo, ::Tamanho ))
		Qout( Padr( "Pagina : " + StrZero( ::Pagina, 3 ), ( nTam     ) ) + Padl( Data + " - " + Hora, ( nTam  ) ) )
		Qout( Repl( ::Separador, ::Tamanho ))
		Qout( ::Cabecalho )
		Qout( Repl( ::Separador, ::Tamanho ))
      ::RowPrn := 7
      return( Self )
		
Method PrintOn(cCodigoControle) class TFile
	PrintOn()
	if cCodigoControle != NIL
		Fprint( cCodigoControle)
	endif		
   SetPrc(0,0)
	return self
	
Method PrintOff(cCodigoControle) class TfILE
	if cCodigoControle != NIL
		Fprint( cCodigoControle)
	endif		   
	PrintOff()
	return self	
		
Method EJect() class TFile
	::RowPrn := 0
   __Eject()
	SetPrc(0,0)
   return self

Function TFileNew()
*********************
return( TFile():New())


/*
FT_DFCLOSE
Posted on September 26, 2013 by vivaclipper
FT_DFCLOSE()
 Close file displayed by FT_DISPFILE()

 Syntax

      FT_DFCLOSE() -> NIL

 Arguments

     None

 Returns

     NIL

 Description

     Closes the file opened by FT_DFSETUP()

 Examples

     @ 4,9 TO 11,71

     FT_DFSETUP("test.txt", 5, 10, 10, 70, 1, 7, 15,;
                 "AaBb" + Chr(143), .T., 5, 132, 4096)

     cKey = FT_DISPFILE()

     FT_DFCLOSE()

     @ 20,0 SAY "Key that terminated FT_DISPFILE() was: " + '[' + cKey + ']'

 Source: DFILE.PRG
 
 
FT_DFSETUP
Posted on September 26, 2013 by vivaclipper
FT_DFSETUP()
 Set up parameters for FT_DISPFILE()

 Syntax

      FT_DFSETUP( <cInFile>, <nTop>, <nLeft>, <nBottom>, <nRight>, ;
               <nStart>, <nCNormal>, <nCHighlight>, <cExitKeys>,   ;
               <lBrowse>, <nColSkip>, <nRMargin>, <nBuffSize> ) -> nResult

 Arguments

        <cInFile>     - text file to display (full path and filename)
        <nTop>        - upper row of window
        <nLeft>       - left col of window
        <nBottom>     - lower row of window
        <nRight>      - right col of window
        <nStart>      - line to place highlight at startup
        <nCNormal>    - normal text color     (numeric attribute)
        <nCHighlight> - text highlight color  (numeric attribute)
        <cExitKeys>   - terminating key list  (each byte of string is a
                        key code)
        <lBrowse>     - act-like-a-browse-routine flag
        <nColSkip>    - col increment for left/right arrows
        <nRMargin>    - right margin - anything to right is truncated
        <nBuffSize>   - size of the paging buffer

 Returns

     0 if successful, FError() code if not

 Description

     Note: make sure you allocate a buffer large enough to hold enough
     data for the number of lines that you have in the window.  Use the
     following formula as a guideline:

        buffer size = (# of line) + 1 * RMargin

     This is the smallest you should make the buffer.  For normal use,
     4096 bytes is recommended

 Examples

     @ 4,9 TO 11,71

     FT_DFSETUP("test.txt", 5, 10, 10, 70, 1, 7, 15,;
                "AaBb" + Chr(143), .T., 5, 132, 4096)

     cKey = FT_DISPFILE()

     FT_DFCLOSE()

     @ 20,0 SAY "Key that terminated FT_DISPFILE() was: " + '[' + cKey + ']'

 Source: DFILE.PRG 
 
 
FT_DISPFILE
Posted on September 26, 2013 by vivaclipper
FT_DISPFILE()
 Browse a text file

 Syntax

      FT_DISPFILE() -> cExitkey

 Arguments

     None

 Returns

     The ASCII keystroke that terminated FT_DISPFILE()

 Description

     This routine displays a text file within a defined window using as
     little memory as possible.  The text file to display has to be
     present or an error value of 0 is returned (as a character.)

     Assumptions: The routine assumes that all lines are terminated
                  with a CR/LF sequence (0x0d and 0x0a).

     Note:        Make sure you allocate a buffer large enough to hold
                  enough data for the number of lines that you have
                  in the window.  Use the following formula as a
                  guideline - buffer size = (# of line) + 1 * RMargin
                  this is the smallest you should make the buffer and
                  for normal use I recommend 4096 bytes.

     Cursor Keys: Up, Down    - moves the highlight line
                  Left, Right - moves the window over nColSkip col's
                  Home        - moves the window to the far left
                  End         - moves the window to the nRMargin column
                  PgUp, PgDn  - moves the highlight one page
                  Ctrl-PgUp   - moves the highlight to the file top
                  Ctrl-PgDn   - moves the highlight to the file bottom
                  Ctrl-Right  - moves the window 16 col's to the right
                  Ctrl-Left   - moves the window 16 col's to the left

                  Esc, Return - terminates the function

                  All other keys are ignored unless they are specified
                  within cExitKeys parameter.  This list will tell the
                  routine what keys terminate the function.  Special
                  keys must be passed by a unique value and that value
                  can be found by looking in the keys.h file.

 Examples

     @ 4,9 TO 11,71

     FT_DFSETUP("test.txt", 5, 10, 10, 70, 1, 7, 15,;
                 "AaBb" + Chr(143), .T., 5, 132, 4096)

     cKey = FT_DISPFILE()

     FT_DFCLOSE()

     @ 20,0 SAY "Key that terminated FT_DISPFILE() was: " + '[' + cKey + ']'

 Source: DISPC.C 
 

 FT_FAPPEND
Posted on September 26, 2013 by vivaclipper
FT_FAPPEND()
 Appends a line to the currently selected text file

 Syntax

      FT_FAPPEND( [ < nLines > ] ) -> NIL

 Arguments

     <nLines> is the number of lines that should be appended to the
     end of the currently selected text file.

     If <nLines> is omitted, one record is appended.

 Returns

     NIL

 Description

     This function appends a line of text to the file in the currently
     selected text file workarea.  Text lines are delimited with a
     CRLF pair.  The record pointer is moved to the last appended
     record.

     Multiple lines may be appended with one call to FT_FAPPEND().

     A text file "record" is a line of text terminated by a CRLF pair.
     Each line appended with this function will be empty.

     NOTE:  Occasionally a text file may contain a non-CRLF terminated
     line, at the end of the file ("stragglers").  This function assumes
     these stragglers to be the last line of the file, and begins
     appending the new lines after this line.  In other words, if the
     last line in the text file is not terminated with a CRLF pair prior
     to calling FT_FAPPEND(), the function will terminate that last line
     before appending any new lines.

 Examples

     // add a blank line of text to a file
     FT_FUSE( "test.txt" )

     ?FT_FRECNO()           // displays 5

     FT_FAPPEND()

     ?FT_FRECNO()           // displays 6

 Source: FTTEXT.C
 
 
*/