#include "inkey.ch"
#include "set.ch"

FUNCTION MAIN  // io demo
*************
LOCAL getlist:={}
LOCAL mVar := SPACE(10)
// press F10 to access io
SETKEY( K_F10,{|| IO( K_F10 ) }) 
WHILE LASTKEY() != K_ESC
   SCROLL()
   @ 00,00 SAY "Press F10 for I/O"
   @ 10,10 SAY "Testing: "GET mVar
   READ
END
return (NIL)  // end demo

/*
ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
лл- By: John E. Graceland ( 4-12-94 )                                        лл
лл- IO interactive prompt used to make calls to functions                    лл
лл- Link into your application and use as a low memory overhead debugger     лл
лл  that can remain linked to the clients app - use backdoor access          лл
лл  or use during development to perform various tests or simply compile and лл
лл  link as a stand alone to tone your PPO level skill or don't use it!      лл
лл- Clipper 5.n  - Compile /n/b/w                                            лл
лл- Syntax: Io([<SetKeyValueN>])                                             лл
лл  SetKeyValueN is the SETKEY() value that was used to invoke IO() from     лл
лл  your app.  ie. SETKEY( K_F10,{|| IO( K_F10 ) })                          лл
лл- Features: Run most any Clipper function from the interaction prompt.     лл
лл  or run your own UDF's, create variables, code blocks, arrays,            лл
лл  expand macros, etc, etc...                                               лл
лл- Interactive Prompt Syntax:                                               лл
лл  ? n:=1  //1                                                              лл
лл  ? a:={"Lennon","Joplin","Hendrix","Morrison","Cobain"}                   лл
лл  ? a[5]  //inclusion error                                                лл
лл  ? b:=({|| DATE() }                                                       лл
лл  ? EVAL( b )  // 04/12/94                                                 лл
лл- returns nothing                                                          лл
ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
*/

//#include "inkey.ch"
PROCEDURE IO( nKeyValue )
*************************
LOCAL aCommand  := {""},cError
LOCAL nCursor   := SETCURSOR(1)
LOCAL cScr      := SAVESCREEN(0,0,24,79)
LOCAL cColor    := SETCOLOR("W+/bg,W+/bg,,,W+/bg")
LOCAL getlist   := {}
LOCAL bRight    := SETKEY(K_RIGHT,NIL)
LOCAL bLeft     := SETKEY(K_LEFT,NIL)
LOCAL bUp       := SETKEY(K_UP,NIL)
LOCAL bDown     := SETKEY(K_DOWN,NIL)
LOCAL cAlias    := ALIAS()
LOCAL nArea     := SELECT(),nRecno,nOrder
LOCAL bKeyValue := SETKEY( nKeyValue, NIL )
LOCAL lScore    := SET( _SET_SCOREBOARD, .t.)
LOCAL bHelp     := SETKEY(K_F1, {|| Help()} )
MEMVAR cCommand
nKeyValue := if( nKeyValue==NIL, 0, nKeyValue )

SET EXCLUSIVE OFF

if LEN( cAlias ) > 0 
   nRecno := RECNO()
   nOrder := INDEXORD()
END

SCROLL()

//Macro expansion requires PRIVATE declaration
PRIVATE cCommand := SPACE(240)  
SETKEY( K_CTRL_ENTER, {|| LastQuery( @cCommand, aCommand, .T. ) } )

WHILE (.T.)
   cCommand:=SPACE(240)
   DISPBEGIN()
   @ 00,00 SAY PADR("<Esc> Exit  <?> Query",80," ") // COLOR "n/W,n/W/,,,n/w" 
   @ 00,01 SAY "Esc" COLOR "n/bg"
   @ 00,13 SAY "?"   COLOR "n/bg"
   @ 01,00 SAY PADR("",80,"Ф")
   @ 23,00 SAY ". "
   @ 23,02 GET cCommand PICT "@S78" VALID LastQuery( @cCommand,aCommand )
   @ 24,00 SAY StatusLine() COLOR "n/W,n/W/,,,n/w" 
   DISPEND()
   READ

   cCommand := ALLTRIM( cCommand )
   AADD(aCommand,ALLTRIM(cCommand))
   LastQuery(,aCommand,,LEN(aCommand) )

   if LASTKEY()==K_ESC
      if ALERT("Exit IO System",{"OK","Cancel"})==1
         EXIT
      END
   elseif cCommand = "?" // query
      cCommand := ALLTRIM(SUBSTR(cCommand,2))
      SCROLL(2,0,23,79,1)
      if TYPE(cCommand) == "U" .OR. TYPE(cCommand) == "UE" 
         if TYPE(cCommand) == "U" 
            cError := " // Argument Error or Unknown Function"
         elseif TYPE(cCommand) == "UE" 
            cError := " // Syntactical Error"
         END
         @ 23,2 SAY cError ;SCROLL(2,0,23,79,2)
      else
         if !UnRecoverableError(cCommand )
            @ 23,2 SAY &cCommand. ; if(TALK(),SCROLL(2,0,23,79,2),"")
         else
            @ 23,2 SAY if(SELECT()!=0,"//No Index File in Use or Index Order Set to 0","No Workarea in Use.") ;SCROLL(2,0,23,79,2)
         END
      END
   else // command
       @ 23,2 SAY " // [?] not found" ;SCROLL(2,0,23,79,2)
      //Interpret( cCommand )  // if you must you will have to write this yourself
   END

END
SETKEY(K_RIGHT,bRight)
SETKEY(K_LEFT,bLeft)
SETKEY(K_UP,bUp)
SETKEY(K_DOWN,bDown)
SETKEY(K_F1, bHelp )
SETKEY(nKeyValue,bKeyValue)
SETCOLOR(cColor)
RESTSCREEN(0,0,24,79,cScr)
SETCURSOR(nCursor)
SET( _SET_SCOREBOARD, lScore)
if LEN( cAlias ) > 0 
   SELECT(nArea)
   dbGoTo(nRecno)
   dbSetOrder(nOrder)
END
return 

***************************************
STATIC FUNCTION UnRecoverableError( c )
***************************************
// prevent calls to unrecoverable errors
STATIC;
a := {;
"BOF",;
"DBAPPEND",;
"DBCLEARFILTER",;
"DBCLEARINDEX",;
"DBCLEARRELATION",;
"DBCLOSEALL",;
"DBCLOSEAREA",;
"DBCOMMIT",;
"DBCREATEINDEX",;
"DBDELETE",;
"DBEDIT",;
"DBEVAL",;
"DBF",;
"DBFILTER",;
"DBGOBOTTOM",;
"DBGOTO",;
"DBGOTOP",;
"DBRECALL",;
"DBREINDEX",;
"DBRELATION",;
"DBRSELECT",;
"DBSEEK",;
"DBSETDRIVER",;
"DBSETFILTER",;
"DBSETINDEX",;
"DBSETORDER",;
"DBSETRELATION",;
"DBSKIP",;
"DBSTRUCT",;
"DBUNLOCK",;
"DELETED",;
"EOF",;
"FCOUNT",;
"FIELDBLOCK",;
"FIELDGET",;
"FIELDNAME",;
"FIELDPOS",;
"FIELDPUT",;
"FIELDWBLOCK",;
"FLOCK",;
"FOUND",;
"HEADER",;
"INDEXKEY",;
"INDEXORD",;
"LASTREC",;
"LUPDATE",;
"RECNO",;
"RECSIZE",;
"RLOCK",;
"USED";
}

STATIC;
b:={;
"DBSEEK",; 
"INDEXKEY",;
"INDEXORD";
}

// no workarea in use error
LOCAL lRetval:= LEN(ALIAS()) == 0  .AND.;
      ASCAN( a, {|x| UPPER(c) = UPPER(x) }) != 0

if !lRetval
   // no index in use error
   lRetval:= INDEXORD()==0 .AND. ASCAN( b, {|x| UPPER(c) = UPPER(x) }) != 0
END

return lRetval

****************************************************************
STATIC FUNCTION LastQuery( cCommand,aCommand,lCtrlEnter,lUpdate)
****************************************************************
STATIC nIndex:=1
LOCAL oGet:=GETACTIVE()
lCtrlEnter:=if(lCtrlEnter==NIL,.F.,lCtrlEnter)
if lUpdate !=NIL
   nIndex:=LEN(aCommand)
elseif LASTKEY()==K_UP
   cCommand:=PADR(aCommand[nIndex],240," ")
   nIndex:=if(nIndex-1<1,LEN(aCommand),nIndex-1)
elseif LASTKEY()==K_DOWN
   cCommand:=PADR(aCommand[nIndex],240," ")
   nIndex:=if(nIndex+1>LEN(aCommand),1,nIndex+1)
elseif lCtrlEnter
   if oGet:pos>1
      cCommand := PADR(SUBSTR(cCommand,1,oGet:pos),240," ")
   else
      ccommand:=SPACE(240)   
   END
END
return (.T.)

**************************
STATIC FUNCTION StatusLine
**************************
return PADR("К Status: К"+if(""==ALIAS(),"",PADR(ALIAS(),8," ")+" К Rec: "+ALLTRIM(STR(RECNO()))+" of "+ALLTRIM(STR(LASTREC()))+" К "+if(DELETED(),"Del","   ")+" К "+INDEXKEY()),80," ")

***********************
STATIC FUNCTION Include
***********************
EXTERNAL;
ACHOICE,;
ACOPY,;
ADEL,;
ADIR,;
AFIELDS,;
AFILL,;
AINS,;
ALLTRIM,;
ASCAN,;
ASORT,;
BIN2I,;
BIN2L,;
BIN2W,;
CURDIR,;
DBEDIT,;
DBFILTER,;
DESCEND,;
DISKSPACE,;
DOSERROR,;
DBRELATION,;
DBRSELECT,;
READINSERT,;
SETCANCEL,;
READEXIT,;
ERRORLEVEL,;
FCLOSE,;
FCREATE,;
FERROR,;
FOPEN,;
FREAD,;
FREADSTR,;
FSEEK,;
FWRITE,;
GETE,;
HARDCR,;
HEADER,;
I2BIN,;
ISALPHA,;
INDEXEXT,;
INDEXORD,;
ISLOWER,;
ISUPPER,;
ISPRINTER,;
L2BIN,;
LUPDATE,;
MEMOEDIT,;
MEMOLINE,;
MEMOREAD,;
MEMOTRAN,;
MEMOWRIT,;
MLCOUNT,;
MLPOS,;
NETERR,;
NEXTKEY,;
LEFT,;
ALIAS,;
RAT,;
SAVESCREEN,;
SCROLL,;
RIGHT,;
RECSIZE,;
ERRORSYS,;
NETNAME,;
SETCOLOR,;
SETPRC,;
SOUNDEX,;
STRTRAN,;
STUFF,;
TONE,;
MEMORY

EXTERNAL;
ACLONE,;
AEVAL,;
ARRAY,;
ASIZE,;
DBCREATE,;
DBEVAL,;
DBSTRUCT,;
DIRECTORY,;
ERRORBLOCK,;
FERASE,;
FRENAME,;
ISDIGIT,;
MAXCOL,;
MAXROW,;
PADL,;
PADC,;
PADR,;
QOUT,;
QQOUT,;
READMODAL,;
SETCURSOR,;
SETKEY,;
GETNEW,;
TBROWSENEW,;
TBROWSEDB,;
BROWSE,;
SETMODE,;
SETBLINK,;
FIELDPUT,;
FIELDGET,;
DBF,;
GETENV,;
VERSION,;
DEVOUT,;
DEVOUTPICT,;
FIELDWBLOCK,;
TBCOLUMNNEW,;
DISPOUT,;
READVAR,;
LASTKEY,;
SET

EXTERNAL;
_VTERM,;
_VOPS,;
_VMACRO,;
_VDB,;
_VDBG,;
__ACCEPT,;
DISPBOX,;
__GET,;
RANGECHECK,;
__ATPROMPT,;
DBAPPEND,;
__DBAPP,;   // (use in v5.01) __DBAPPSDF,;__DBAPPDEL,;
__KILLREAD,;
__MCLEAR,;
__KEYBOARD,;
DBCLOSEARE,;
DBCOMMITAL,;
__DBCONTIN,;
__DBCOPYST,;
__DBCOPYXS,;
__DBCOPY,;
__DBCREATE,;
DBDELETE,;
__DBLIST,;
__EJECT,;
DBSEEK,;
DBGOTO,;
DBGOTOP,;
DBGOBOTTOM,;
DBCREATEIN,;
__ACCEPTST,;
__DBJOIN,;
__LABELFOR,;
__DBLOCATE,;
__MENUTO,;
__DBPACK,;
__QUIT,;
DBRECALL,;
__MXRELEAS,;
__MRELEASE,;
__REPORTFO,;
__MRESTORE,;
RESTSCREEN,;
__RUN,;
__MSAVE,;
DBSELECTAR,;
__SETCENTU,;
DBSETFILTE,;
__SETFORMA,;
__SETFUNCT,;
DBCLEARIND,;
DBSETINDEX,;
SETKEY,;
DBSETORDER,;
DBCLEARREL,;
DBSETRELAT,;
DBSKIP,;
__DBSORT,;
__TEXTSAVE,;
__TEXTREST,;
__DBTOTAL,;
__TYPEFILE,;
__COPYFILE,;
DBUNLOCK,;
DBUNLOCKAL,;
__DBUPDATE,;
DBUSEAREA,;
__WAIT,;
__DBZAP,;
__ATCLEAR,;
__BOXD,;
__BOXS,;
__DIR,;
__CLEAR,;
_VDBG,;
SETTYPEAHE,;
__GETA,;
DISPBEGIN,;
DISPEND,;
ALTD,;
ATAIL,;
DBCOMMIT,;
DBCOMMITALL,;
DBSETDRIVER,;
FIELDPOS,;
MEMVARBLOCK,;
MLCTOPOS,;
MPOSTOLC,;
OUTSTD,;
OUTERR,;
FILE

return (NIL)

*******************************************************************
FUNCTION Alert( cMessage, aChoices, nTopRow, cColor, lBell, nTime )
*******************************************************************
/*
 - Alert() substitude
 - John E. Graceland ( 3-23-94 )
 - Replacement for Clipper's ALERT() Function
 - Clipper 5.n
 - Syntax: Alert( <cMessage> [,<aChoices>, <nTopRow>, <cColor>, <lBell>] )
 - Features: Emulates Clipper's ALERT(), additional options are
             Starting row position of box, set color, sound bell
             Invoke Clipper's debugger from within Alert(), time out a 
             message, displays vertically when cannot fit horizontally.
 - returns a numeric value equal to the option selected, <Esc> = 0
*/

LOCAL;
n,;
nCol,;
nRow,;
cScreen,;
nPromLeft,;
nBoxLeft,;
nBoxRight,;
nMsgLen,;
nBoxLen    := 0,;
nPromLen   := 0,;
cOldColor  := SETCOLOR(),;
cOldWrap   := SET( 35, "ON" ),;
lOldCenter := SET( 37, .F. ),;
lOldBlink  := SETBLINK(.F.),;
aMessage   := {},;
bPgUp      := SETKEY(K_PGUP, {||NIL} ),;
bPgDn      := SETKEY(K_PGDN, {||NIL} ),;
nChoice    := 0,;
lVertical  := (.F.),;
nBoxWidth  := 0,;
nMaxBottom,;
nCur

if aChoices==NIL
   // force "OK" if no choices are passed
   aChoices:={}
   AADD(aChoices,if(nTime==NIL,"OK","<Esc>"))
END

// set length of prompt line
AEVAL( aChoices, {|aArray| nPromLen += LEN(aArray)+2 })

// load message array
WHILE ";" $ cMessage
   // test for multiple line message
   AADD(aMessage, SUBSTR(cMessage,1,AT(";",cMessage)-1 ) )
   cMessage := STUFF(cMessage,1,AT(";",cMessage), "" )
END
if "" != cMessage
   // add remaining message string to array
   AADD(aMessage,cMessage)
END
nMsgLen := LEN(aMessage)

// determine box length based on largest message line
AEVAL( aMessage, {|aArray| nBoxLen := MAX(nBoxLen,LEN(aArray)+4) })

nPromLen  += ( (LEN(aChoices)+1) * 2 )
cColor    := Iif( ISCOLOR(), Iif( cColor == NIL,"W+/BG,N/W+",cColor),"N/W,W+/N")
lBell     := Iif( lBell == NIL, .F., lBell )
nTopRow   := Iif( nTopRow == NIL, 10, nTopRow )

// test for the larger of box length vs. length of prompt line
nBoxWidth := Iif( nBoxLen > nPromLen, nBoxLen, nPromLen + 4 )
lVertical := ( MAXCOL() - nBoxWidth ) / 2 < 0

if lVertical
   nBoxWidth:=nBoxLen
   AEVAL( aChoices, {|aArray| nBoxWidth := MAX( nBoxWidth,LEN(aArray)) })
   nBoxLeft  := ( MAXCOL() - nBoxWidth ) / 2
   nBoxRight := nBoxLeft + nBoxWidth + 2
   nPromLeft := nBoxLeft 
else
   nBoxLeft  := ( MAXCOL() - nBoxWidth ) / 2
   nBoxRight := nBoxLeft + nBoxWidth
   nPromLeft := ( ( MAXCOL()-nPromLen ) / 2) 
END

// save the original screen
DISPBEGIN()

SETCOLOR( cColor )
// display Alert box

nMaxBottom := nTopRow+nMsgLen+if(lVertical,LEN(aChoices)+1,2)+1
if nMaxBottom > MAXROW()-1
   nTopRow -= nMaxBottom - MAXROW()
   nMaxBottom := MAXROW()
END

cScreen:=SAVESCREEN(nTopRow, nBoxLeft, nMaxBottom, nBoxRight+1)
@ nTopRow, nBoxLeft, nMaxBottom, nBoxRight+1 BOX "кФПГйФРГ " 

FOR n:=1 TO nMsgLen
   @ nTopRow+n,nBoxLeft+1 SAY PADC( aMessage[n], nBoxWidth, SPACE(1) )
NEXT

nCol       := nPromLeft + if(lVertical,1,3 )
cOldWrap   := SET( 35, "ON" )
lOldCenter := SET( 37, .F. )

// Display the prompt line
nRow:=ROW()+2
FOR n:=1 TO LEN( aChoices )
   if lVertical
      if nTime==NIL
         @ nRow+n-1, nCol PROMPT SPACE(1)+aChoices[n]+SPACE(1)
      else
         @ nRow+n-1, nCol SAY SPACE(1)+aChoices[n]+SPACE(1)
      END
   else
      if nTime==NIL
         @ nRow, nCol PROMPT SPACE(1)+aChoices[n]+SPACE(1)
      else
         @ nRow, nCol SAY SPACE(1)+aChoices[n]+SPACE(1)
      END
      nCol += LEN(aChoices[n])+4 
   END
NEXT
DISPEND()

if lBell
   // sound bell
   TONE(499,2)
   TONE(299,1)
endif
if nTime == NIL
   MENU TO nChoice
else
   nCur:=SETCURSOR(0)
   INKEY( nTime )
   SETCURSOR(nCur)
END
// restore some settings here
SET( 35, cOldWrap )
SET( 37, lOldCenter )
SETBLINK( lOldBlink )
RESTSCREEN(nTopRow, nBoxLeft, nMaxBottom, nBoxRight+1,cScreen)
SETCOLOR( cOldColor )
SETKEY(K_PGUP, bPgUp )
SETKEY(K_PGDN, bPgDn )

return if( (LASTKEY()=K_ESC.OR.LASTKEY()=K_PGUP.OR.LASTKEY()=K_PGDN),0,nChoice)

******************
FUNCTION Talk( l )
******************
STATIC lSet2:=(.T.)
if l != NIL
   lSet2:=l
END
return lSet2

********************
STATIC Function Help
********************
LOCAL s:=SAVESCREEN(0,0,MAXROW(),MAXCOL()),n:=SETCURSOR()
STATIC lInHelp:=(.F.)
if lInHelp
   return (NIL)
END
lInHelp:=(.T.)
SETCURSOR(0)

SCROLL()
DISPBEGIN()
TEXT
    IO() -  the interactive prompt for PPO developers or
            add to any app for low memory() debugger.

    <Esc>... return to the calling program or Exit
    <?>  ... preceed all function calls with ? character

    You can invoke most Clipper functions from the IO() prompt.  
    As in other DOT utilities,  unrecoverable error conditions 
    may be created by the user.  ie. ? dbUseArea(.t.,"","cus")  
    will create an unrecoverable 650 error.  You can modify your 
    errorsys.prg to trap these errors.  


    IO() Samples:
    ЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭ
    Arrays:              Code Blocks:             Macros:
    ? a := {1,2,3,4,5}   ? DATE()                 ? m := "mVar"
    ? b := a               04/14/94                 mvar
    ? b[1] := 999        ? b := { |n| DATE()+n}   ? &m. := TIME()
      999                ? EVAL( b, 10 )            11:43:51
    ? a[1]                 04/24/94               ? mVar
      999                                           11:43:51
    ? ASCAN( a, 5 )
      5

    Have Fun!
ENDTEXT
DISPEND()
INKEY(0)
RESTSCREEN(0,0,MAXROW(),MAXCOL() ,s)
lInHelp:=(.F.) 
SETCURSOR(n)
return (NIL)









