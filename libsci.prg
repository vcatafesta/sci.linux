/*
  +-------------------------------------------------------------------------+
 ??																								 ?
 ??	Programa.....: FUNCOES.PRG 														 ?
 ??	Aplicacaoo...: MODULO DE FUNCOES DE APOIO AO SCI							 ?
 ??	Versao.......: 19.50 																 ?
 ??	Programador..: Vilmar Catafesta													 ?
 ??	Empresa......: Microbras Com de Prod de Informatica Ltda 				 ?
 ??	Inicio.......: 12 de Novembro de 1991. 										 ?
 ??	Ult.Atual....: 06 de Dezembro de 1998. 										 ?
 ??	Compilacao...: Clipper 5.2e														 ?
 ??	Linker.......: Blinker 7.0													   	 ?
 ??	Bibliotecas..: Clipper/Funcoes/Mouse/Funcky15/Funcky50/Classe/Classic ?
 ?+-------------------------------------------------------------------------+
 ??????????????????????????????????????????????????????????????????????
*/
#include "achoice.ch"
#include "ctnnet.ch"
#include "funcoes.ch"
#include "inkey.ch"
#include "set.ch"
#include "fileman.ch"
#include "box.ch"
#include "common.ch"
#include "fileio.ch"
#include "directry.ch"
#include "getexit.ch"
#include "permissa.ch"
#include "indice.ch"

#define FALSO               .F.
#define OK                  .T.
#define SETA_CIMA           5
#define SETA_BAIXO          24
#define SETA_ESQUERDA       19
#define SETA_DIREITA        4
#define TECLA_SPACO         32
#define TECLA_ALT_F4        -33
#define ENABLE              .T.
#define DISABLE             .F.
#define LIG                 .T.
#define DES                 .F.
#define ESC                 27
#define ENTER               13

#Define VAR_AGUDO   39								 && Indicador de agudo
#Define VAR_CIRCUN  94								 && Indicador de circunflexo
#Define VAR_TREMA   34								 && Indicador de trema
#Define VAR_CEDMIN  91								 && Cedilha min?sculo opcional [
#Define VAR_CEDMAI  123 							 && Cedilha mai?sculo opcional {
#Define VAR_GRAVE   96								 && Indicador de grave
#Define VAR_TIL	  126 							 && Indicador de til
#Define VAR_HifEN   95								 && Indicador de ? ? sublinhado+a/o
#Define S_TOP		  0
#Define S_BOTTOM	  1
#translate P_Def( <var>, <val> ) => if( <var> = NIL, <var> := <val>, <var> )
#translate ifNil( <var>, <val> ) => if( <var> = NIL, <var> := <val>, <var> )

#XCOMMAND DEFAULT <v1> TO <x1> [, <vn> TO <xn> ]								;
			 =>																				;
			 if <v1> == NIL ; <v1> := <x1> ; END									;
			 [; if <vn> == NIL ; <vn> := <xn> ; END ]
#XCOMMAND DEFAU <v1> TO <x1> [, <vn> TO <xn> ]								;
			 =>																				;
			 if <v1> == NIL ; <v1> := <x1> ; END									;
			 [; if <vn> == NIL ; <vn> := <xn> ; END ]

	
static Static13
static Static14
static Static1 := "+-+?+-+?"
static Static2 := ""
static Static3 := {1, 1, 0, 0, 0, 0, 0, 0, 0, 24, 79, 1, 0, 0, 0, 1, 8, 1, 0, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, -999, 0, 0, Nil}



********************************
function M_FRAME(Arg1)
   local Local1 := Static1
	
	if (ISNIL(Arg1))
      return Static1
   else
      Static1:= Arg1
   endif
   return Local1
	
Function FCurdir()
******************
LOCAL cRetChar

cRetChar := CurDrive() + ':\' + Curdir()
return(cRetChar)

********************************
function M_TITLE(Arg1)
   local Local1 := Static2
	
   if (ISNIL(Arg1))
      return Static2
   else
      Static2:= Arg1
   endif
   return Local1

********************************
function M_DATA(Arg1, Arg2)
   local Local1 := Nil
	
   if (ISNIL(Arg1) .AND. ISNIL(Arg2))
      return Static3
   endif
   if (Arg1 < 1 .OR. Arg1 > 32)
      return -1
   endif
   if (ISNIL(Arg2))
      Local1:= Static3[Arg1]
   else
      Local1:= Static3[Arg1]
      Static3[Arg1]:= Arg2
   endif
   return Local1

********************************
function M_DATASAVE

   return Static3

********************************
function M_DATAREST(Arg1)

   Static3:= aclone(Arg1)
   return Nil	
	
	
Function FazMenu( nTopo, nEsquerda, aArray, Cor )
*************************************************
	LOCAL cFrame2	  := SubStr( M_Frame(), 2, 1 )
	LOCAL nFundo	  := ( nTopo + Len( aArray ) + 3 )
	LOCAL nTamTitle  := ( Len( M_Title() ) + 12 )
	LOCAL nDireita   := ( nEsquerda + AmaxStrLen( aArray ) + 1 )
	LOCAL cTitulo    := M_Title() 
	LOCAL cChar      :=  "?v?=??"

	if ( nDireita - nEsquerda ) <  nTamTitle
		nDireita := ( nEsquerda + nTamTitle )
	endif
	Cor := Iif( Cor = NIL, Cor(), Cor )
	//MaBox( nTopo, nEsquerda, nFundo, nDireita )
	MS_Box( nTopo, nEsquerda, nFundo, nDireita )
	Print(nFundo-2, nEsquerda+1, Repl(SubStr(M_Frame(),2,1),(nDireita-nEsquerda)-1), Cor())
	Print(nFundo-1, nEsquerda+1, cTitulo, Roloc(Cor()), (nDireita-nEsquerda)-1)
	Print(nFundo-1, nDireita-8, cChar, Roloc(Cor()))
	//nChoice := Mx_Choice( @nTopo, @nEsquerda, aArray, Cor )
	nSetColor(Cor)
	nChoice := Achoice( nTopo+1, nEsquerda+1, nFundo-1, nDireita-1, aArray)
return( nChoice )	


Function ResTela( cScreen )
***************************
return( RestScreen( 0, 0, MaxRow(), MaxCol(),  cScreen ))

Function Cls( CorFundo, PanoFundo )
***********************************
LOCAL row   := 0
LOCAL col   := 0
LOCAL row1  := MaxRow()
LOCAL col1  := MaxCol() 
LOCAL nComp := ( col1 - col )
LOCAL nLen  := Len( Panofundo)
FT_CLS( row, col, row1, col1, corfundo)

//hb_DispBox( 00, 00, maxrow(), maxcol(), Repl(PanoFundo,nLen))

for x := row To row1
   Print( x, col, Panofundo, corfundo, MaxCol(), panofundo)
next

return NIL

Function aPrint( row, col, string, attrib, length)
*************************************************
LOCAL Color_Ant := SetColor(), ;
      nLen      := Len(string)
DEFAU attrib TO ColorStrToInt(SetColor()),;
      length TO nLen

if length > nLen
   string += Repl(Space(1),length-nlen)
	nLen   := length
endif	

SetColor(ColorIntToStr(attrib))
DevPos(row, col) ; DevOut(Left(string,nLen))
SetColor( Color_Ant)
return NIL

//******************************************************************************

Function Roloc(nColor)
**********************
LOCAL cColor  := ColorIntToStr(nColor)
LOCAL inverse := FT_InvClr( cColor)
return(nColor := ColorStrToInt(inverse))


FUNCTION nSetColor(std, enh, uns)
*********************************
LOCAL cStd, ;
	   cEnh, ;
		cUns, ;
		cColor

cStd	 := attrtoa(std)
cEnh	 := attrtoa(enh)
cUns	 := attrtoa(uns)
//cColor := setcolor()

ColorStandard(std)
ColorEnhanced(enh)
ColorUnselected(uns)
cColor := cStd + ',' + cEnh + ',,,' + cUns

//cColor := strswap(cColor, "," , 1, cStd)
//cColor := strswap(cColor, "," , 2, cEnh)
//cColor := strswap(cColor, "," , 4, cUns)
Setcolor( cColor )
return Nil

//******************************************************************************

FUNCTION cSetColor(ColorStr)
****************************
LOCAL nStd, ;
		nEnh, ;
		nUns
		
nStd := atoattr( strextract( ColorStr, ",", 1))
nEnh := atoattr( strextract( ColorStr, ",", 2))
nUns := atoattr( strextract( ColorStr, ",", 4))

/*
* Set FUNCky Colors
*/
ColorStandard(nStd)
ColorEnhanced(nEnh)
Colorunselected(nUns)

/* Set Clipper Colors */
SetColor( ColorStr )
return Nil

//******************************************************************************

Function atoattr(cColor)
************************
return (ColorStrToInt(cColor))

//******************************************************************************

Function attrtoa(nColor)
************************
return (ColorIntToStr(nColor))		

//******************************************************************************

Function MS_QuadroCorInt()
**************************
LOCAL x := 10
LOCAL y := 10
LOCAL a

MS_Box(09,12,29,70)		
For a := 1 to 256
	   //Print( x, y*3, Repl(Chr(x+64),3), x*y,)
		//Print( a,   b*6, hb_NToColor(a*b), a*b)
		if y >= 64
		   y := 10
			x++
		endif	
		y += 4
		Print( x, y, StrZero(HB_ColorToN(hb_NToColor(a)),3), a,)
Next
return NIL

Function Cor( nTipo )
*********************
ifNil( nTipo, 1 )
if nTipo = 1
	return( oAmbiente:CorMenu	)
endif
return( oAmbiente:CorCabec )

Function M_Message( cString, cCor)
**********************************
LOCAL nMaxRow := MaxRow()
LOCAL nMaxCol := MaxCol()
LOCAL nLen    := Len(cString)
LOCAL row     := ((nMaxRow/2)-5)
LOCAL Col     := ((nMaxCol-nLen)/2)

MS_Box(row, col, row+4, col+ nLen+6, M_Frame(), cCor)
Print(row+2, col+3, cString, cCor)
return(NIL)

Function Print( row, col, string, attrib, length, cChar)
********************************************************
LOCAL Color_Ant := SetColor(), ;
      nLen      := Len(string)
DEFAU attrib TO ColorStrToInt(SetColor()),;
      length TO nLen
DEFAU cChar TO Space(1)

if length > nLen
   string += Repl(cChar,length-nlen)
	nLen   := length
endif	

SetColor(ColorIntToStr(attrib))
DevPos(row, col) ; DevOut(Left(string,nLen))
SetColor( Color_Ant)
return NIL

Function Clock(row,col)
*************************
Iif( row = Nil, row := Row(), row )
Iif( col = Nil, col := Col(), col )
//Clock12(row, col)
return(Time())

Function ColorSet( pfore, pback, pUns )
***************************************
	if pfore == nil 
		 pfore := Standard()
		 pback := Enhanced()
	elseif pfore < 0 
		 pfore := Standard()
		 pback := Enhanced()
	else
		 pback := Roloc(pfore)
	endif
	return( nil )
	
Function MS_Box( nRow, nCol, nRow1, nCol1, cFrame, nCor)
********************************************************
LOCAL nComp 	 := ( nCol1 - nCol )-1
DEFAU cFrame TO M_Frame()
DEFAU nCor	 TO Cor()

return(Hb_DispBox( nRow, nCol, nRow1, nCol1, cFrame + " ", nCor))

//Box( nRow, nCol, nRow1, nCol1, M_Frame() + " ", nCor, 1, 8 )      // Funcky
//DispBox( nRow, nCol, nRow1, nCol1, M_Frame() + " ", nCor, 1, 8 )  // Harbour

For x := nRow To nRow1
   Print( x, nCol, Space(1), nCor, nComp+1, " ")
Next

Print( nRow, nCol, Left(cFrame,1), nCor, 1 )
Print( nRow, nCol+1, Repl(SubStr(cFrame,2,1),nComp), nCor )
Print( nRow, nCol1, SubStr(cFrame,3,1), nCor, 1 )
For x := nRow+1 To nRow1
	Print( x, nCol,  SubStr(cFrame,4,1), nCor, 1 )
	Print( x, nCol1, SubStr(cFrame,8,1), nCor, 1 )
Next
Print( nRow1, nCol, SubStr(cFrame,7,1),  nCor, 1 )
Print( nRow1, nCol+1, Repl(SubStr(cFrame,6,1),nComp), nCor )
Print( nRow1, nCol1, SubStr(cFrame,5,1), nCor, 1 )
return NIL

Function Alerta( cString, aArray )
**********************************
if oAmbiente:Visual
	aArray := Iif( aArray = NIL, {"&OK"}, aArray )
	nTam := Len( aArray )
	if 	 nTam = 1
		nButton := MsgBox1( cString, SISTEM_NA1 )
		return( nButton )
	elseif nTam = 2
		aArray[1] := "&" + AllTrim( aArray[1] )
		aArray[2] := "&" + AllTrim( aArray[2] )
		nButton := MsgBox2( cString, SISTEM_NA1, NIL, aArray[1], aArray[2] )
		return( nButton )
	elseif nTam = 3
		aArray[1] := "&" + AllTrim( aArray[1] )
		aArray[2] := "&" + AllTrim( aArray[2] )
		aArray[3] := "&" + AllTrim( aArray[3] )
		nButton := MsgBox3( cString, SISTEM_NA1, NIL, aArray[1], aArray[2], aArray[3] )
		return( nButton )
	elseif nTam > 3
		nButton := Alert( cString, aArray, oAmbiente:CorAlerta )
		return( nButton )
	endif
else
	aArray := Iif( aArray = NIL, { " Okay " }, aArray )
	return( Alert( cString, aArray, oAmbiente:CorAlerta ))
endif


Function StrHotKey(cMenu, cHotKey)
******************************
   LOCAL cChar   := "^"
	LOCAL cSwap   := Space(0)
	LOCAL nConta
	LOCAL cStr
	LOCAL cNew

	nConta := GT_StrCount( cChar, cMenu )
   if nConta >0
	   cHotKey := StrExtract(cMenu, cChar, 1 )
	   cMenu   := StrSwap(cMenu, cChar, 1, cSwap)
   endif
return	


FUNCTION ColorStandard( nStd )

   // ***************************
   STATI nStandard
   LOCAL nSwap := nStandard

   if ( ISNIL( nStd ) )
      return nStandard
   else
      nStandard := nStd
   endif
   return nSwap

// ******************************************************************************

   FUNCTION ColorEnhanced( nEnh )

   // ***************************
   STATI nEnhanced
   LOCAL nSwap := nEnhanced

   if ( ISNIL( nEnh ) )
      return nEnhanced
   else
      nEnhanced := nEnh
   endif
   return nSwap

// ******************************************************************************

   FUNCTION ColorUnselected( nUns )

   // ***************************
   STATI nUnselected
   LOCAL nSwap := nUnselected

   if ( ISNIL( nUns ) )
      return nUnselected
   else
      nUnselected := nUns
   endif
   return nSwap

	 FUNCTION ColorIntToStr( xColor )

   // ***************************
   LOCAL cColor
   return( cColor := ft_N2Color( xColor ) )

   FUNCTION ColorStrToInt( xColor )

   // ***************************
   LOCAL nColor
   return( nColor := ft_Color2N( xColor ) )

	
Function aMaxStrLen( xArray )
*****************************
LOCAL nTam    := Len(xArray)
LOCAL nLen    := 0
LOCAL nMaxLen := 0
LOCAL x

For x := 1 To nTam
	nLen := Len(xArray[x])
	if nMaxLen < nLen
		nMaxLen := nLen
	endif	
Next
return( nMaxLen )

//******************************************************************************

Function aPrintLen( xArray )
*****************************
return( Len( xArray))
	
Function StrExtract( string, delims, ocurrence )
************************************************
LOCAL nInicio := 1
LOCAL nConta  := GT_StrCount(delims, string)
LOCAL aArray  := {}
LOCAL aNum    := {}
LOCAL nLen    := Len(delims)
LOCAL cChar   := Repl('%',nLen)
LOCAL cNewStr := String
LOCAL nPosIni := 1
LOCAL aPos
LOCAL nFim
LOCAL x
LOCAL nPos

if cChar == delims
   cChar := Repl("*",nLen)
endif	

if nConta = 0 .AND. ocurrence > 0
   return(string)
endif
	

/*
For x := 1 to nConta
   nInicio   := At( Delims, cNewStr)
   cNewStr   := Stuff(cNewStr, nInicio, 1, cChar)
	nFim      := At( Delims, cNewStr)
	cString   := SubStr(cNewStr, nInicio+1, nFim-nInicio-1)
	if !Empty(cString)
	   Aadd( aArray, cString)
	End		
Next
*/

/*
For x := 1 to nConta
   nPos      := At( Delims, cNewStr)
   cNewStr   := Stuff(cNewStr, nPos, 1, cChar)
	nLen      := nPos-nPosini
	cString   := SubStr(cNewStr, nPosIni, nLen)
	nFim      := At( Delims, cNewStr)
	nPosIni   := nPos+1
	if !Empty(cString)
	   Aadd( aArray, cString)
	End		
Next
*/

aPos   := aStrPos(string, Delims)
nConta := Len(aPos)
For x := 1 to nConta 
   nInicio  := aPos[x]
	if x = 1
	   cString   := Left(String, nInicio-1)
	else
		nFim     := aPos[x-1]
	   cString  := SubStr(String, nFim+1, nInicio-nFim-1)
	endif	
	Aadd( aArray, cString)
Next

nConta := Len(aArray)
if ocurrence > nConta .OR. oCurrence = 0
   return(string) 
endif

return(aArray[ocurrence])


Function StrSwap( string, cChar, nPos, cSwap)
*********************************************
	LOCAL nConta := GT_StrCount( cChar, string ),;
	      aPos,;
	      nX,;
			nLen
	
	if nConta > 0
      aPos := aStrPos(string, cChar)
		nLen := Len(aPos)
		if nLen >= 0
		   if nPos <= nLen
		      string := Stuff(string, aPos[nPos], Len(cChar), cSwap)
		   endif
		endif	
	endif
return( string)

//******************************************************************************

Function aStrPos(string, delims)
********************************
LOCAL nConta  := GT_StrCount(delims, string)
LOCAL nLen    := Len(delims)
LOCAL cChar   := Repl("%",nLen)
LOCAL aNum    := {}
LOCAL x

if cChar == delims
   cChar := Repl("*",delims)
endif	

if nConta = 0
   return(aNum)
endif

FOR x := 1 To nConta 
   nPos   := At( Delims, string )
	string := Stuff(string, nPos, 1, cChar)
	Aadd( aNum, nPos)
Next
Aadd( aNum, Len(string)+1)
return(aNum)

//******************************************************************************

Function MSGBOX1(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7)
**********************************************************
Local Local1, Local2, Local3, Local4
LOCAL nTamanhoButton := MaxCol()-61
Arg4	 := Iif(ISNIL(Arg4), "&OK", Arg4)
Arg1	 := Iif(ISNIL(Arg1), "", Arg1)
Arg2	 := Iif(ISNIL(Arg2), "Aten??o!", Arg2)
Local1 := Iif(ISARRAY(Arg1), Len(Arg1), 1)
Arg3	 := Iif(ISNIL(Arg3), 12 - (Local1 + 5) / 2, Arg3)
Arg5	 := Iif(ISNIL(Arg5), "W+*/R", Arg5)
Arg6	 := Iif(ISNIL(Arg6), "R+*/W", Arg6)
Arg7	 := Iif(ISNIL(Arg7), "N*/W", Arg7)
Local3 := NewButton()
addbutton( Local3, Arg3+ 3 + Local1, 31, nTamanhoButton, Arg4, Nil, .T.)
Local2 := Win( Arg3, 10, Arg3 + 5 + Local1, (MaxCol()-10), Arg2, Arg5, Arg6)
if (ISARRAY(Arg1))
	For Local4 := 1 To Local1
		@ Arg3 + 1 + Local4, 12 Say padc( Arg1[ Local4 ], (MaxCol()-23) ) Color Arg7
	Next
else
	@ Arg3 + 2, 12 Say padc(Arg1, (MaxCol()-23) ) Color Arg7
endif
setcursor(0)
nButton := ProcButton( Local3, 2, 1)
RsTenv( Local2 )
return( nButton )

********************************
Function LINBUTTON3(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, ;
	Arg9, Arg10, Arg11)

	Local Local1
	Local1:= newbutton()
	Arg1:= Iif(ISNIL(Arg1), .T., Arg1)
	Arg2:= Iif(ISNIL(Arg2), 1, Arg2)
	Arg3:= Iif(ISNIL(Arg3), 21, Arg3)
	Arg4:= Iif(ISNIL(Arg4), 1, Arg4)
	Arg5:= Iif(ISNIL(Arg5), 3, Arg5)
	Arg6:= Iif(ISNIL(Arg6), "&OK", Arg6)
	Arg8:= Iif(ISNIL(Arg8), "&Alterar", Arg8)
	Arg10:= Iif(ISNIL(Arg10), "&Cancelar", Arg10)
	addbutton(Local1, Arg3, 11, 18, Arg6, Arg7, Iif(Arg5 == 1, .T., ;
		.F.))
	addbutton(Local1, Arg3, 31, 18, Arg8, Arg9, Iif(Arg5 == 2, .T., ;
		.F.))
	addbutton(Local1, Arg3, 51, 18, Arg10, Arg11, Iif(Arg5 == 3, .T., ;
		.F.))
	if (Arg1)
		Arg3:= procbutton(Local1, Arg2, Iif(Arg4 < 4, Arg4, 3))
	else
		showbutton(Local1, Arg2)
	endif
	return Arg3

*****************************************************************************
Function MSGBOX2(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10)
*****************************************************************************
	Local Local1, Local2, Local3, Local4
	Arg4	 := Iif(ISNIL(Arg4), "&Sim", Arg4)
	Arg5	 := Iif(ISNIL(Arg5), "&N?o", Arg5)
	Arg6	 := Iif(ISNIL(Arg6), 1, Arg6)
	Arg7	 := Iif(ISNIL(Arg7), 2, Arg7)
	Arg1	 := Iif(ISNIL(Arg1), "", Arg1)
	Arg2	 := Iif(ISNIL(Arg2), "Aten??o!", Arg2)
	Local1 := Iif(ISARRAY(Arg1), Len(Arg1), 1)
	Arg3	 := Iif(ISNIL(Arg3), 12 - (Local1 + 7) / 2, Arg3)
	Arg8	 := Iif(ISNIL(Arg8), "W+*/R", Arg8)
	Arg9	 := Iif(ISNIL(Arg9), "R+*/W", Arg9)
	Arg10  := Iif(ISNIL(Arg10), "N*/W", Arg10)
	Local3 := newbutton()
	addbutton(Local3, Arg3 + 3 + Local1, 21, 18, Arg4, Nil, Iif(Arg7 == 1, .T., .F.))
	addbutton(Local3, Arg3 + 3 + Local1, 41, 18, Arg5, Nil, Iif(Arg7 == 2, .T., .F.))
	Local2 := Win( Arg3, 10, Arg3 + 5 + Local1, MaxCol()-10, Arg2, Arg8, Arg9)
	if (ISARRAY(Arg1))
		For Local4:= 1 To Local1
			@ Arg3 + 1 + Local4, 13 Say padc(Arg1[Local4], MaxCol()-25) Color Arg10
		Next
	else
		@ Arg3 + 2, 13 Say padc(Arg1, MaxCol()-25) Color Arg10
	endif
	setcursor(0)
	nButton := procbutton(Local3, 2, Iif(Arg6 < 3, Arg6, 2))
	rstenv(Local2)
	return( nButton )

Function LINBUTTON2(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9)
*************************************************************************
	Local Local1
	Local1:= newbutton()
	Arg1:= Iif(ISNIL(Arg1), .T., Arg1)
	Arg2:= Iif(ISNIL(Arg2), 1, Arg2)
	Arg3:= Iif(ISNIL(Arg3), 21, Arg3)
	Arg4:= Iif(ISNIL(Arg4), 1, Arg4)
	Arg5:= Iif(ISNIL(Arg5), 2, Arg5)
	Arg6:= Iif(ISNIL(Arg6), "&OK", Arg6)
	Arg8:= Iif(ISNIL(Arg8), "&Cancelar", Arg8)
	addbutton(Local1, Arg3, 21, 18, Arg6, Arg7, Iif(Arg5 == 1, .T., ;
		.F.))
	addbutton(Local1, Arg3, 41, 18, Arg8, Arg9, Iif(Arg5 == 2, .T., ;
		.F.))
	if (Arg1)
		Arg3:= procbutton(Local1, Arg2, Iif(Arg4 < 3, Arg4, 2))
	else
		showbutton(Local1, Arg2)
	endif
	return Arg3

************************************************************************************
Function MSGBOX3(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10, Arg11)
************************************************************************************
	Local Local1, Local2, Local3, Local4
	Arg4:= Iif(ISNIL(Arg4), "&Sim", Arg4)
	Arg5:= Iif(ISNIL(Arg5), "&N?o", Arg5)
	Arg6:= Iif(ISNIL(Arg6), "&Cancelar", Arg6)
	Arg7:= Iif(ISNIL(Arg7), 1, Arg7)
	Arg8:= Iif(ISNIL(Arg8), 3, Arg8)
	Arg1:= Iif(ISNIL(Arg1), "", Arg1)
	Arg2:= Iif(ISNIL(Arg2), "Aten??o!", Arg2)
	Local1:= Iif(ISARRAY(Arg1), Len(Arg1), 1)
	Arg3:= Iif(ISNIL(Arg3), 12 - (Local1 + 7) / 2, Arg3)
	Arg9:= Iif(ISNIL(Arg9), "W+*/R", Arg9)
	Arg10:= Iif(ISNIL(Arg10), "R+*/W", Arg10)
	Arg11:= Iif(ISNIL(Arg11), "N*/W", Arg11)
	Local3:= newbutton()
	addbutton(Local3, Arg3 + 3 + Local1, 13, 18, Arg4, Nil, Iif(Arg8 ;
		== 1, .T., .F.))
	addbutton(Local3, Arg3 + 3 + Local1, 31, 18, Arg5, Nil, Iif(Arg8 ;
		== 2, .T., .F.))
	addbutton(Local3, Arg3 + 3 + Local1, 49, 18, Arg6, Nil, Iif(Arg8 ;
		== 3, .T., .F.))
	Local2:= win(Arg3, 10, Arg3 + 5 + Local1, MaxCol()-10, Arg2, Arg9, Arg10)
	if (ISARRAY(Arg1))
		For Local4:= 1 To Local1
			@ Arg3 + 1 + Local4, 13 Say padc(Arg1[Local4], MaxCol()-25) Color ;
				Arg11
		Next
	else
		@ Arg3 + 2, 13 Say padc(Arg1, 54) Color Arg11
	endif
	setcursor(0)
	nButton := procbutton(Local3, 2, Iif(Arg7 < 3, Arg7, 2))
	rstenv(Local2)
	return( nButton )

***********************************************
Function DESKBOX( Arg1, Arg2, Arg3, Arg4, Arg5)
***********************************************
LOCAL Local1 := "N+/W", Local2 := "W+/W"
Arg5		:= Iif(ISNIL(Arg5), 1, Arg5)
if (Arg5 == 2)
	Local1 := "W+/W"
	Local2 := "N+/W"
endif
@ Arg1, Arg2, Arg3, Arg2 Box "?????????" Color Local1
@ Arg1, Arg4, Arg3, Arg4 Box "?????????" Color Local2
@ Arg1, Arg2 Say Replicate("?", Arg4 - Arg2 + 1) Color Local1
@ Arg3, Arg2 Say Replicate("-", Arg4 - Arg2 + 1) Color Local2
return Nil

*****************************************************
Function MSGBOX3D(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6)
*****************************************************
LOCAL Local1, Local2, Local3
LOCAL nTam	 := MaxCol()
Arg1:= Iif(ISNIL(Arg1), "", Arg1)
Arg2:= Iif(ISNIL(Arg2), "Aguarde", Arg2)
Local1:= Iif(ISARRAY(Arg1), Len(Arg1), 1)
Arg3:= Iif(ISNIL(Arg3), 12 - (Local1 + 6) / 2, Arg3)
Arg4:= Iif(ISNIL(Arg4), "W+/N", Arg4)
Arg5:= Iif(ISNIL(Arg5), "N/W", Arg5)
Arg6:= Iif(ISNIL(Arg6), "N/W", Arg6)
Local2 := win(Arg3, 16, Arg3 + 6 + Local1, (nTam-16), Arg2, Arg4, Arg5)
@ Arg3 + 2, 17, Arg3 + 5 + Local1, 17 Box "?????????" Color "W+/W"
@ Arg3 + 2, (nTam-17), Arg3 + 5 + Local1, (nTam-17) Box "?????????" Color "N+/W"
@ Arg3 + 2, 18 Say Replicate("-", (nTam-35)) Color "W+/W"
@ Arg3 + 5 + Local1, 18 Say Replicate("?", (nTam-35)) Color "N+/W"
if (ISARRAY(Arg1))
	For Local3:= 1 To Local1
		@ Arg3 + 3 + Local3, 19 Say padc(Arg1[Local3], (nTam-37)) Color Arg6
	Next
else
	@ Arg3 + 4, 19 Say padc(Arg1, (nTam-37)) Color Arg6
endif
setcursor(0)
return Local2

********************************
Function MSGBOX(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6)

	Local Local1, Local2, Local3
	Arg1:= Iif(ISNIL(Arg1), "", Arg1)
	Arg2:= Iif(ISNIL(Arg2), "Aguarde", Arg2)
	Local1:= Iif(ISARRAY(Arg1), Len(Arg1), 1)
	Arg3:= Iif(ISNIL(Arg3), 12 - (Local1 + 5) / 2, Arg3)
	Arg4:= Iif(ISNIL(Arg4), "W+*/B", Arg4)
	Arg5:= Iif(ISNIL(Arg5), "B+*/W", Arg5)
	Arg6:= Iif(ISNIL(Arg6), "N*/W", Arg6)
	Local2:= win(Arg3, 18, Arg3 + 5 + Local1, 61, Arg2, Arg4, Arg5)
	if (ISARRAY(Arg1))
		For Local3:= 1 To Local1
			@ Arg3 + 2 + Local3, 20 Say padc(Arg1[Local3], 40) Color Arg6
		Next
	else
		@ Arg3 + 3, 20 Say padc(Arg1, 40) Color Arg6
	endif
	setcursor(0)
	return Local2

********************************************************************
Function FRAME(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9)
********************************************************************
Local Local1 := SetColor(), Local2 := dn := "", Local3:= Arg4 - Arg2 - 1, Local4:= y:= z:= 0
Arg6:= Iif(ISNIL(Arg6), 1, Arg6)
Arg7:= Iif(ISNIL(Arg7), 1, Arg7)
Arg8:= Iif(ISNIL(Arg8), "N/W", Arg8)
Arg9:= Iif(ISNIL(Arg9), "N/W", Arg9)
if (Arg7 == 1)
	Local2 := "N+/W"
	dn:= "W+/W"
elseif (Arg7 == 2)
	Local2 := "W+/W"
	dn:= "N+/W"
elseif (Arg7 == 3)
	Local2 := dn:= Arg8
endif
@ Arg1 + 1, Arg2, Arg3 - 1, Arg2 Box Replicate("?", 9) Color Local2
@ Arg1, Arg2 Say "-" + Replicate("-", Local3) Color Local2
@ Arg3, Arg2 Say "+" Color Local2
@ Arg1 + 1, Arg4, Arg3 - 1, Arg4 Box Replicate("?", 9) Color dn
@ Arg3, Arg2 + 1 Say Replicate("-", Local3) + "+" Color dn
@ Arg1, Arg4 Say "+" Color dn
if (Arg5 != Nil)
	z:= Len(Arg5)
	if (Arg6 == 1)
		@ Arg1, Arg2 + 2 Say " " + Arg5 + " " Color Arg9
	elseif (Arg6 == 2)
		@ Arg1, Arg4 - Local3 / 2 - z / 2 - 1 Say " " + Arg5 + " " Color Arg9
	elseif (Arg6 == 3)
		@ Arg1, Arg4 - z - 3 Say " " + Arg5 + " " Color Arg9
	endif
endif
Set Color To (Local1)
return Nil

********************************
Function LINBUTTON4(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, ;
	Arg9, Arg10, Arg11, Arg12, Arg13)

	Local Local1
	Local1:= newbutton()
	Arg1:= Iif(ISNIL(Arg1), .T., Arg1)
	Arg2:= Iif(ISNIL(Arg2), 1, Arg2)
	Arg3:= Iif(ISNIL(Arg3), 21, Arg3)
	Arg4:= Iif(ISNIL(Arg4), 1, Arg4)
	Arg5:= Iif(ISNIL(Arg5), 4, Arg5)
	Arg6:= Iif(ISNIL(Arg6), "&OK", Arg6)
	Arg8:= Iif(ISNIL(Arg8), "&Alterar", Arg8)
	Arg10:= Iif(ISNIL(Arg10), "&Excluir", Arg10)
	Arg12:= Iif(ISNIL(Arg12), "&Cancelar", Arg12)
	addbutton(Local1, Arg3, 1, 18, Arg6, Arg7, Iif(Arg5 == 1, .T., ;
		.F.))
	addbutton(Local1, Arg3, 21, 18, Arg8, Arg9, Iif(Arg5 == 2, .T., ;
		.F.))
	addbutton(Local1, Arg3, 41, 18, Arg10, Arg11, Iif(Arg5 == 3, .T., ;
		.F.))
	addbutton(Local1, Arg3, 61, 18, Arg12, Arg13, Iif(Arg5 == 4, .T., ;
		.F.))
	if (Arg1)
		Arg3:= procbutton(Local1, Arg2, Iif(Arg4 < 5, Arg4, 4))
	else
		showbutton(Local1, Arg2)
	endif
	return Arg3
	
	
Function NewButton()
********************
return {}

********************************
Function RSTENV(Arg1)

	RestScreen(Arg1[1], Arg1[2], Arg1[3], Arg1[4], Arg1[5])
	Set Color To (Arg1[6])
	setcursor(Arg1[7])
	return Nil
	
Function ADDBUTTON(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9)
************************************************************************
Local Local1
Arg5	 := Iif(At("&", Arg5) == 0, "&" + Arg5, Arg5)
Arg7	 := Iif(ISNIL(Arg7), .F., Arg7)
Arg8	 := Iif(ISNIL(Arg8), { || nret() }, Arg8)
Arg9	 := Iif(ISNIL(Arg9), .T., Arg9)
Local1 := SubStr(Arg5, At("&", Arg5) + 1, 1)
AAdd(Arg1, {Arg5, Arg6, Arg8, Arg9, Arg7, Arg2, Arg3, Local1, Arg4})
return Nil

Function PROCBUTTON( Arg1, Arg2, Arg3)
**************************************
Local Local1:= 0, Local2:= setcursor(0), Local3:= 0
Arg2:= Iif(ISNIL(Arg2), 1, Arg2)
Arg3:= Iif(ISNIL(Arg3), 1, Arg3)
showbutton(Arg1, Arg2)
Do While (!Arg1[Arg3][4])
	Arg3:= Iif(++Arg3 > Len(Arg1), 1, Arg3)
EndDo
Do While (.T.)
	drawbutton(Arg1[Arg3], Arg2, 2, .F.)
	if (Arg1[Arg3][2] != Nil .OR. Arg1[Arg3][2] != "")
		dwnmsg(Arg1[Arg3][2])
	endif
	if (Local1 == 13 .OR. Local1 = 32)
		InKey(0.1)
		drawbutton(Arg1[Arg3], Arg2, 1, .T.)
		Exit
	else
		Local1:= ninkey(0)
	endif
	if (Local1 == 27 )
		return( 0 )
	elseif ((Local3 := Ascan(Arg1, { |_1| Upper(Chr(Local1)) == Upper(_1[8]) })) != 0 .AND. Arg1[Local3][4])
		drawbutton(Arg1[Arg3], Arg2, 1)
		Arg3 := Local3
		Keyboard Chr(13)
	elseif (Local1 == 27 .AND. ( Local3 := ascan(Arg1, { |_1| _1[5] == .T. })) != 0 .AND. Arg1[Local3][4])
		drawbutton(Arg1[Arg3], Arg2, 1)
		Arg3 := Local3
		Keyboard Chr(13)
	endif
	if (Local1 == 5 .OR. Local1 == 19 .OR. Local1 == 271)
		drawbutton(Arg1[Arg3], Arg2, 1)
		Arg3:= Iif(--Arg3 == 0, Len(Arg1), Arg3)
		Do While (!Arg1[Arg3][4])
			Arg3:= Iif(--Arg3 == 0, Len(Arg1), Arg3)
		EndDo
	elseif (Local1 == 24 .OR. Local1 == 4 .OR. Local1 == 9)
		drawbutton(Arg1[Arg3], Arg2, 1)
		Arg3:= Iif(++Arg3 > Len(Arg1), 1, Arg3)
		Do While (!Arg1[Arg3][4])
			Arg3:= Iif(++Arg3 > Len(Arg1), 1, Arg3)
		EndDo
	elseif (Local1 == 13 .OR. Local1 = 32 )
		drawbutton(Arg1[Arg3], Arg2, 3, .F., .F.)
		InKey(0.1)
		drawbutton(Arg1[Arg3], Arg2, 2, .F.)
		eval(Arg1[Arg3][3])
	endif
EndDo
setcursor(Local2)
return Arg3

********************************
Function TEXTBUTTON(Arg1)

	Local Local1, Local2, Local3, Local4
	Local1:= ""
	Local2:= At("&", Arg1)
	Local3:= SubStr(Arg1, 1, Local2 - 1)
	Local4:= SubStr(Arg1, Local2 + 1)
	return Iif(Local2 != 0, Local3 + Local4, Arg1)

********************************
Function SETBUTTON(Arg1, Arg2, Arg3)

	Local Local1
	Local1:= Arg1[Arg2][4]
	if (Arg3 != Nil)
		Arg1[Arg2][4]:= Arg3
	endif
	return Local1
	

Function NRET
**************
return Nil

Function SHOWBUTTON(Arg1, Arg2)
*******************************
	aeval(Arg1, { |_1| drawbutton(_1, Arg2) })
	return Nil

********************************
Procedure NMISC2

Function DRAWBUTTON(Arg1, Arg2, Arg3, Arg4, Arg5)
*************************************************
Local Local1, Local2, Local3, Local4, Local5, Local6, Local7, ;
		Local8, Local9, Local10, Local11, Local12, Local13, Local14, ;
		Local15, Local16, Local17, Local18, Local19, Local20, Local21
Arg3:= Iif(ISNIL(Arg3), 1, Arg3)
Arg4:= Iif(ISNIL(Arg4), .T., Arg4)
Arg5:= Iif(ISNIL(Arg5), .T., Arg5)
Local10:= textbutton(Arg1[1])
if (Arg2 == 1)
	Local1:= "N/W"
	Local2:= Iif(Arg5, "W*/N", "N*/N")
	Local3:= "W+*/N"
	Local4:= "W*/N"
	Local6:= "W+*/N"
	Local7:= "N+*/N"
	Local9:= Iif(Arg1[4], "GR+*/N", "W*/N")
elseif (Arg2 == 2)
	Local1:= "N*/W"
	Local2:= Iif(Arg5, "W+/W", "N+/W")
	Local3:= "N/W"
	Local4:= "N+/W"
	Local6:= "N/W"
	Local7:= "W/W"
	Local9:= Iif(Arg1[4], "W+/W", "N+/W")
endif
if (Arg3 == 1)
	Local10:= padc(Local10, Arg1[9] - 3)
	Local11:= At(Upper(Arg1[8]), Upper(Local10)) - 1
	Local5:= Iif(Arg1[4], Local3, Local4)
	Local8:= Local7
elseif (Arg3 == 2)
	Local10:= padc(Local10, Arg1[9] - 3)
	Local11:= At(Upper(Arg1[8]), Upper(Local10)) - 1
	Local5:= Iif(Arg1[4], Local3, Local4)
	Local8:= Local6
elseif (Arg3 == 3)
	Local10:= " " + Left(padc(Local10, Arg1[9] - 3), Arg1[9] - 4)
	Local11:= At(Upper(Arg1[8]), Upper(Local10)) - 1
	Local5:= Iif(Arg1[4], Local3, Local4)
	Local8:= Local6
endif
Local20:= At(alltrim(Local10), Local10) - 1
Local21:= Local20 + Len(Arg1[1]) + 2
if (Arg4)
	Local12:= "+"
	Local13:= Iif(Arg5, "-", "+")
	Local14:= "+"
	Local15:= "?"
	Local16:= "+"
	Local17:= "-"
	Local18:= "+"
	Local19:= "?"
else
	Local12:= "+"
	Local13:= Iif(Arg5, "-", "+")
	Local14:= "+"
	Local15:= "?"
	Local16:= "+"
	Local17:= "-"
	Local18:= "+"
	Local19:= "?"
endif
@ Arg1[6] - 1, Arg1[7] Say Local12 + Replicate(Local13, Arg1[9] - 2) + Local14 Color Local1
@ Arg1[6], Arg1[7] Say Local19 Color Local1
@ Arg1[6], Arg1[7] + 1 Say "?" Color Local2
@ Arg1[6], Arg1[7] + 2 Say Local10 Color Local5
@ Arg1[6], Arg1[7] + 2 + Local11 Say Arg1[8] Color Local9
@ Arg1[6], Arg1[7] + Arg1[9] - 1 Say Local15 Color Local1
@ Arg1[6] + 1, Arg1[7] Say Local18 + Replicate(Local17, Arg1[9] - 2) + Local16 Color Local1
@ Arg1[6], Arg1[7] + Local20 Say "=" Color Local8
@ Arg1[6], Arg1[7] + Local21 Say "=" Color Local8
return Nil
	
	
Function NINKEY(Arg1)

	Local Local1, Local2, Local3
	Do While (.T.)
		Local1:= .F.
		if (Arg1 = Nil)
			Local2:= InKey()
		else
			Local2:= InKey(Arg1)
		endif
		if (Local2 != 0 .AND. (Local3:= SetKey(Local2)) != Nil)
			eval(Local3, procname(2), procline(2), "")
			Local1:= .T.
		endif
		if (!Local1)
			Exit
		endif
	EndDo
	return Local2
	
	
********************************
Function DWNMSG(Arg1)

	@ 23,  1 Say padc(Arg1, 78) Color "R*/W"
	return .T.


******************************************************
Function WIN(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7)
******************************************************
Local Local1
Arg5	 := Iif(ISNIL(Arg5), "", Arg5)
Arg6	 := Iif(ISNIL(Arg6), "W+/B", Arg6)
Arg7	 := Iif(ISNIL(Arg7), "B*/W", Arg7)
Local1 := nBox( Arg1, Arg2, Arg3, Arg4, Arg7)
@ Arg1, Arg2 Say Padc(Arg5, Arg4 - Arg2 + 1) Color Arg6
return Local1
	
*************************************************
Function NBOX(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6)
*************************************************
Local Local1
Local1 := savenv(Arg1, Arg2, Arg3 + 1, Arg4 + 2)
Arg5	 := Iif(ISNIL(Arg5), "N*/W", Arg5)
Arg6	 := Iif(ISNIL(Arg6), .T., Arg6)
@ Arg1, Arg2, Arg3, Arg4 Box "+--?-?+? " Color Arg5
if (Arg6)
	Sombra( Arg1, Arg2, Arg3, Arg4)
endif
return Local1

********************************
Function SAVENV(Arg1, Arg2, Arg3, Arg4)

	Local Local1
	Local1:= {}
	AAdd(Local1, Arg1)
	AAdd(Local1, Arg2)
	AAdd(Local1, Arg3)
	AAdd(Local1, Arg4)
	AAdd(Local1, SaveScreen(Arg1, Arg2, Arg3, Arg4))
	AAdd(Local1, SetColor())
	AAdd(Local1, setcursor())
	return Local1
	
********************************
Function SOMBRA(Arg1, Arg2, Arg3, Arg4)

	Local Local1, Local2, Local3, Local4
	Local3:= SaveScreen(Arg1 + 1, Arg4 + 1, Arg3 + 1, Arg4 + 2)
	Local4:= SaveScreen(Arg3 + 1, Arg2 + 2, Arg3 + 1, Arg4 + 2)
	For Local1:= 2 To Len(Local3) Step 2
		Local2:= FT_shadow(Asc(SubStr(Local3, Local1, 1)))
		Local3:= stuff(Local3, Local1, 1, Local2)
	Next
	For Local1:= 2 To Len(Local4) Step 2
		Local2:= FT_shadow(Asc(SubStr(Local4, Local1, 1)))
		Local4:= stuff(Local4, Local1, 1, Local2)
	Next
	RestScreen(Arg1 + 1, Arg4 + 1, Arg3 + 1, Arg4 + 2, Local3)
	RestScreen(Arg3 + 1, Arg2 + 2, Arg3 + 1, Arg4 + 2, Local4)
	return Nil
	
def MX_PopFile( row, col, row1, col1, xCoringa, nColor)
*******************************************************
	LOCAL aFile  := {}
	LOCAL nChoice 
	
	//Aeval( Directory( xCoringa ), { | xFile | Aadd( aFile, Upper(xFile[ F_NAME ]))})
   Aeval( Directory( xCoringa ), { | xFile | Aadd( aFile, xFile[ F_NAME ])})
	if (nChoice := FazMenu(Row, Col, aFile, nColor)) = 0
	   return ""
	endif
	return( aFile[nChoice])
endef   

Function Pattern() 
****************
LOCAL x
LOCAL aPattern := {}

For x:= 0 To 255 step 16
   Aadd( aPattern, {x, x+15, x+12})
next
return ( aPattern )

	
Function AscanPattern(nCor)	  
***************************
LOCAL aPattern := Pattern()
LOCAL nX

For nX := 1 To Len( aPattern)
   if nCor >= aPattern[nX,1] .AND. nCor <= aPattern[nX,2]
	   return( aPattern[nX,3])
	endif
next
return( 0 )
	

FUNCTION Main8()
   LOCAL cF1, cF2, cF3
   LOCAL GETLIST := {}
	//LOCAL aObjects  := WvtSetObjects( {} )

	altd()
   Wvt_SetGui( .T. )

   SetMode( 25, 80 )
   SetColor( "N/W" )
   CLS

   Wvt_SetTitle( "Giovanni's Window" )

   SetColor( "N/W,N/GR*,,,N/W*" )

   cF1 = Space( 30 )
   cF2 = Space( 30 )
   cF3 = Space( 30 )

   @ 08, 10 SAY "Enter field 1  " GET cF1
   @ 10, 10 SAY "Enter field 2  " GET cF2
   @ 12, 10 SAY "Enter field 3  " GET cF3

   READ

   return
	
	
   //Altd()
   cls
   // Cls(Cor(), "¦")
   // ? cString := MSDecToChr("#65#66#")
   // DispBox( 10, 1, 09, 40)
   // FT_XBox(,,,,,,,"teste")
   // FT_DispMsg({{"Tecle algo para continuar", "ESC"},{"w+/B","w+/b"}})
   // HB_DispOutAtBox(10,10,"Tecle algo para continuar", "i-©¦¥-È¦")

   // ? nColor := ColorStrToInt("w+/r")
   // ? cColor := ColorIntToStr(23)

   // xcolor := 75 // (1 * 16)+ 7 && white on blue
   // ? maxRow()
   // ? inverse := roloc(xcolor)
   // print(MaxRow(),0,"BRANCO/AZUL", xColor, MaxCol())
   // print(0,0,"AZUL/BRANCO", inverse, MaxCol())
   // MS_Box( 10, 10, 20, 40)
   // ? omenu := TDois():New()
   // ? omenu:show()
   // ? omenu:cNome
   // ? omenu:cCodi
   // cSetColor("W+/B,BG/GR*,N/N,N/N,W+/R")
   // ? SetColor()
   // ? ColorStandard()
   // ? ColorEnhanced()
   // ? ColorUnselected()
   // nSetColor(23,75,40)
   // ? SetColor()
   // ? ColorStandard()
   // ? ColorEnhanced()
   // ? ColorUnselected()
   // ? MS_TempName(".TMP")
   // ? m_message("MENSAGEM CENTRALIZADA NA TELA", Cor())
   // ? hb_ColorToN(Setcolor())
   // ? hb_NToColor(23*16)

   // BkGrnd( 00, 00, maxrow(), maxcol(), "¦" )
   // DispBox( 10, 10, 20, 40, M_Frame() + " ")
   // inkey(0)
   // cls
   // Inkey(0)
   // Hb_DispBox( 10, 10, 20, 40, M_Frame() + " ", Cor())

   // colorido()
   // ft_calendar()

   // MS_QuadroCorInt()
   // MS_QuadroCorStr()
   //? cStr := StrExtract( "M^enu", "^", 1 )
   //? cStr := StrSwap( "M^enu", "^", 1, "INSERT" )
	
	//a := {'UM','DOIS'}
	//ACHOICE( 10, 10, 20, 30, A, .T.)
	//? memory()
	//? DiskSpace()

	//ShellRUn("firefox.exe" + "C.PRG")
	//ShellExec("firefox.exe c.prg")
	
	//MyRUn("regedit")
	//MyRUn("calc")
	
	
	//M_View(00, 00, MaxRow(), MaxCol(), "C.PRG", 75 )
 	
   //MS_Cls(10, 10, 20, 40, 15)
	
	//forx_c()
	 //DispBox( 0, 0, MaxRow(), MaxCol(), Replicate( hb_UTF8ToStrBox( "¦" ), 9 ), "BG/B" )
    DispBox( 0, 0, MaxRow(), MaxCol(), Replicate("¦", 9), "BG/B" )
		
	/*
	Set Date Brit
	set century on
	//RddSetDefault("DBFNSX")
	use recibo new VIA "DBFNSX"
   Index On CODI TAG RECIBO1 TO RECIBO
	Index On VCTO TAG RECIBO2 TO RECIBO
	
	DbSetOrder(2)
	cCodi := "00059"
	dIni  := Ctod("20/06/2016")
	dFim  := Ctod("30/06/2016")
	
	//Set filter to Vcto >= dIni .and. Vcto <= dFim
   //Goto bottom 
	DbGotop()
	OrdScope(0, dIni )
	OrdScope(1, dFim )
	DbGotop()
	Browse()
	OrdScope(0, NIL )
	OrdScope(1, NIL )
	DbGotop()
	Browse()
	*/	
	//wapi_ShellExecute (hwndapp, "abrir", "c: / WINDOWS/README. WRI"," "," ", 3) 

return( NIL )

/*						  
hb_gtDrawBox( hb_itemGetNI( pTop ),;
                    hb_itemGetNI( pLeft ),;
                    hb_itemGetNI( pBottom ),;
                    hb_itemGetNI( pRight ),;
                    "¦¦¦¦",;
                    iColor )

*/

	
Function ShellRun( cComando )
*****************************
LOCAL intWindowStyle := 0
LOCAL WshShell
LOCAL lRet
LOCAL oExec

/*
intWindowStyle
0 Hides the window and activates another window.
1 Activates and displays a window. if the window is minimized or maximized, the system restores it to its original size and position. An application should specify this flag when displaying the window for the first time.
2 Activates the window and displays it as a minimized window.
3 Activates the window and displays it as a maximized window.
4 Displays a window in its most recent size and position. The active window remains active.
5 Activates the window and displays it in its current size and position.
6 Minimizes the specified window and activates the next top-level window in the Z order.
7 Displays the window as a minimized window. The active window remains active.
8 Displays the window in its current state. The active window remains active.
9 Activates and displays the window. if the window is minimized or maximized, the system restores it to its original size and position. An application should specify this flag when restoring a minimized window.
10 Sets the show-state based on the state of the program that started the application.
*/

#ifdef __XHARBOUR__
   WshShell := CreateObject("WScript.Shell")
#else
   WshShell := win_oleCreateObject("WScript.Shell")
#endif

lRet     := WshShell:Run("%comspec% /c " + cComando, intWindowStyle, .F.)
WshShell := NIL
return Iif( lRet = 0, .T., .F.)
	
Function ShellExec( cComando )
*******************************
LOCAL intWindowStyle := 0
LOCAL WshShell
LOCAL lRet
LOCAL oExec

/*
intWindowStyle
0 Hides the window and activates another window.
1 Activates and displays a window. if the window is minimized or maximized, the system restores it to its original size and position. An application should specify this flag when displaying the window for the first time.
2 Activates the window and displays it as a minimized window.
3 Activates the window and displays it as a maximized window.
4 Displays a window in its most recent size and position. The active window remains active.
5 Activates the window and displays it in its current size and position.
6 Minimizes the specified window and activates the next top-level window in the Z order.
7 Displays the window as a minimized window. The active window remains active.
8 Displays the window in its current state. The active window remains active.
9 Activates and displays the window. if the window is minimized or maximized, the system restores it to its original size and position. An application should specify this flag when restoring a minimized window.
10 Sets the show-state based on the state of the program that started the application.
*/

#ifdef __XHARBOUR__
   WshShell := CreateObject("WScript.Shell")
#else
   WshShell := win_oleCreateObject("WScript.Shell")
#endif

//oExec := oShell:Run("%comspec% /c " + cComando, intWindowStyle, .F.)
oExec    := WshShell:Exec(cComando)
lRet     := oExec:Status 
WshShell := NIL
return Iif( lRet = 0, .T., .F.)
	
Function M_View( row, col, row1, col1, cFile, nCor )
****************************************************
DispBox(row, col, row1, col1)
FT_DFSetup(cFile, row+1, col+1, row1-1, col1-1, 1, nCor, Roloc(nCor),"EeQqXx", .T., 5, MaxCol()+80, 8196)
cKey := FT_DispFile()
FT_DFClose()
return NIL


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

	
FUNCTION Colorido()

   // ******************
   LOCAL aClrs   := {}
   LOCAL lColour := IsColor()
   LOCAL cChr    := Chr( 254 ) + Chr( 254 )


   SET SCOREBOARD OFF
   SetBlink( .F. )       // Allow bright backgrounds

   aClrs := { ;
      { "Desktop",        "N/BG",                         "D", "#" }, ;
      { "Cabecalho",      "N/W",                          "C"      }, ;
      { "Top Menu",       "N/BG,N/W,W+/BG,W+/N,GR+/N",    "M"      }, ;
      { "Sub Menu",       "W+/N*,GR+/N*,GR+/N*,W+/R,G+/R", "M"      }, ;
      { "GET Ativo",      "W/B,  W+/N,,, W/N",            "G"      }, ;
      { "GET Proximo",    "N/BG, W+/N,,, W/N",            "G"      }, ;
      { "Help",           "N/G,  W+/N,,, W/N",            "W"      }, ;
      { "Mensagem Erro",  "W+/R*,N/GR*,,,N/R*",           "W"      }, ;
      { "Database Query", "N/BG, N/GR*,,,N+/BG",          "B"      }, ;
      { "Pick List",      "N/GR*,W+/B,,, BG/GR*",         "A"      } }

   aClrs := ft_ClrSel( aClrs, lColour, cChr )

   nChoice := AChoice( 10, 10, 20, 40, aClrs[ 3 ], .T. )

   nErrorCode := 0
   ft_SaveArr( aClrs, 'COR.DAT', @nErrorCode )
   if nErrorCode = 0
      aSave := ft_RestArr( 'COR.DAT', @nErrorCode )
      if nErrorCode # 0
         ? 'Error restoring array'
      endif
   else
      ? 'Error writing array'
   endif
   return( .T. )


// ******************************************************************************

   FUNCTION MS_TempName( xCoringa )

   // ******************************
   // return(FT_TEMPFIL( FCurdir()))
   // return(HB_FTEMPCREATE())
   // return(HB_FTEMPCREATEeX())
   LOCAL nPos     := RAt( ".", xCoringa )
   LOCAL nLen     := Len( xCoringa )
   xCoringa := AllTrim( xCoringa )
   xCoringa := SubStr( nPos, ( nLen - nPos ), xCoringa )
   return( TempFile( FCurdir(), xcoringa ) )

// ******************************************************************************

   
   FUNCTION Main5()

   LOCAL aColors  := {}
   LOCAL aBar     := { " Sair ", " Relatorios ", " Video " }

   // Include the following two lines of code in your program, as is.
   // The first creates aOptions with the same length as aBar.  The
   // second assigns a three-element array to each element of aOptions.
   LOCAL aOptions[ Len( aBar ) ]
   Cls

   AEval( aBar, {| x, i| aOptions[ i ] := { {}, {}, {} } } )

   // fill color array
   // Box Border, Menu Options, Menu Bar, Current Selection, Unselected
   aColors := { "W+/G", "N/G", "N/G", "N/W", "N+/G" }

   // array for first pulldown menu
   ft_Fill( aOptions[ 1 ], 'A. Alterar Cores', {|| Colorido() }, .T. )
   ft_Fill( aOptions[ 1 ], 'B. Enter Daily Charges', {|| .T. },     .F. )
   ft_Fill( aOptions[ 1 ], 'C. Enter Payments On Accounts', {|| Main2() },     .T. )

   // array for second pulldown menu
   ft_Fill( aOptions[ 2 ], 'A. Print Member List', {|| .T. },     .T. )
   ft_Fill( aOptions[ 2 ], 'B. Print Active Auto Charges', {|| .T. },     .T. )

   // array for third pulldown menu
   ft_Fill( aOptions[ 3 ], 'A. Transaction Totals Display', {|| .T. },     .T. )
   ft_Fill( aOptions[ 3 ], 'B. Display Invoice Totals', {|| .T. },     .T. )
   ft_Fill( aOptions[ 3 ], 'C. Exit To DOS', {|| .F. },     .T. )

   // Call FT_FILL() once for each item on each pulldown menu, passing it
   // three parameters:

   // CALL FT_MENU1
   ft_Menu1( aBar, aOptions, aColors, 0 )
   FUNCTION Main3()

   LOCAL i, ar[ 3, 26 ], aBlocks[ 3 ], aHeadings[ 3 ]
   LOCAL nElem := 1, bGetFunc

   // Set up two dimensional array "ar"

   FOR i = 1 TO 26
      ar[ 1, i ] := i          // 1  ->  26  Numeric
      ar[ 2, i ] := Chr( i + 64 )  // "A" -> "Z"  Character
      ar[ 3, i ] := Chr( 91 -i )  // "Z" -> "A"  Character
   NEXT i

   // SET UP aHeadings Array for column headings

   aHeadings  := { "Numeros", "Letras", "Reverso" }

   // Need to set up individual array blocks for each TBrowse column

   aBlocks[ 1 ] := {|| Str( ar[ 1, nElem ], 2 ) } // prevent default 10 spaces
   aBlocks[ 2 ] := {|| ar[ 2, nElem ] }
   aBlocks[ 3 ] := {|| ar[ 3, nElem ] }

   // set up TestGet() as the passed Get Function so FT_ArEdit knows how
   // to edit the individual gets.

   // bGetFunc   := { | b, ar, nDim, nElem | TestGet(b, ar, nDim, nElem) }
   bGetFunc   := {| b, ar, nDim, nElem | colorido( b, ar, nDim, nElem ) }
   SetColor( "N/W, W/N, , , W/N" )
   CLEAR SCREEN
   ft_ArEdit( 3, 5, 18, 75, ar, @nElem, aHeadings, aBlocks, bGetFunc )
   FUNCTION Fubar()
   return .T.

   FUNCTION Main2()

   LOCAL mainmenu := ;
      { { "Data Entry", "Enter data",   {|| ft_Menu2( datamenu )  } }, ;
      { "Reports",    "Hard copy",    {|| ft_Menu2( repmenu )   } }, ;
      { "Maintenance", "Reindex files", {|| ft_Menu2( maintmenu ) } }, ;
      { "Quit", "See ya later" } }

   cls
   ft_Menu2( mainmenu )
	
	
   FUNCTION MSDecToChr( cString )
   // ***************************
   LOCAL cNewString := ""
   LOCAL nTam
   LOCAL nX
   LOCAL cNumero

   nTam := gt_StrCount( "#", cString )
   FOR nX := 1 TO nTam
      ? cNumero := StrExtract( cString, "#", nX )
      ? cNewString += Chr( Val( cNumero ) )
      ? nx, ValType( cNumero ), Len( cNumero )
   NEXT
   return ( cNewString )


   CLASS TTeste

   Export:
   VAR cNome
   VAR cCodi


   METHOD NEW CONSTRUCTOR
   METHOD Show
ENDCLASS

   METHOD New() CLASS TTeste

   ::cNome := "VILMAR"
   ::cCodi := "0005"
   return( Self )


   METHOD Show() CLASS TTeste

   // *************
   QOut( ::cNome )
   QOut( ::cCodi )
   return( self )

   FUNCTION TMenuNew()
   return( TTeste():New() )

// ****************************************************

   CLASS TDois INHERIT TTeste

   Export:
ENDCLASS


/* This is an original work by Isa Asudeh and is placed in the public domain.

   Modification history

      Rev 1.1   15 Aug 1991 23:05:24   GLENN
   Forest Belt proofread/edited/cleaned up doc

      Rev 1.0   31 May 1991 21:07:26   GLENN
   Initial revision.
 */

