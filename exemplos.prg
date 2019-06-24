#include "hbclass.ch"
PROCEDURE Main

SetColor( "W/B,N/W,,,W/B" )
CLS
Nota := NotaClass():New()
@ 1, 0 SAY "Valor da Nota:" GET Nota:Valor VALID Nota:CalculaImpostos()
@ 2, 0 SAY "Base ICMS....:" GET Nota:IcmBase WHEN .F.
@ 3, 0 SAY "Base Reducao.:" GET Nota:IcmReducao VALID Nota:CalculaImpostos()
@ 4, 0 SAY "Alíquota.....:" GET Nota:IcmAliquota VALID Nota:CalculaImpostos()
@ 5, 0 SAY "Valor ICMS...:" GET Nota:IcmValor WHEN .F.
@ 6, 0 SAY "Base ST......:" GET Nota:StBase WHEN .F.
@ 7, 0 SAY "IVA..........:" GET Nota:StIVA VALID Nota:CalculaImpostos()
@ 8, 0 SAY "Aliq.ST......:" GET Nota:StAliquota VALID Nota:CalculaImpostos()
@ 9, 0 SAY "Valor ST.....:" GET Nota:StValor WHEN .F.
READ

CREATE CLASS NotaClass
   VAR Valor       INIT 0
   VAR IcmBase     INIT 0
   VAR IcmReducao  INIT 0
   VAR IcmAliquota INIT 0
   VAR IcmValor    INIT 0
   VAR StBase      INIT 0
   VAR StIVA       INIT 0
   VAR StAliquota  INIT 0
   VAR StValor     INIT 0
   METHOD CalculaImpostos()
   END CLASS

METHOD CalculaImpostos()

   ::IcmBase := ::Valor - ( Int( ::Valor * ::IcmReducao ) / 100 )
   ::IcmValor := Int( ::IcmBase * ::IcmAliquota ) / 100
   ::StBase := ::IcmBase + ( Int( ::IcmBase * ::StIVA / 100 ) )
   ::StValor := Max( 0, Int( ::StBase * ::StAliquota ) / 100 - ::IcmValor )
   SetPos( 11, 0 )
   ? "Icmbase:", ::IcmBase, "STBase", ::StBase
   return .T.
	
*****************************************************************************************************************
	
#include "hbclass.ch"
FUNCTION Main2
Local obj := myFirstClass1():New(3)
 
   ? obj:x       // 3
   ?
return Nil
 
CLASS myFirstClass1
   VAR   x
   METHOD New( n )   INLINE ( ::x := n, Self )
ENDCLASS

*****************************************************************************************************************
	
#include "hbclass.ch"
FUNCTION Main3
   Local obj1, obj2
 
   obj1 := mySecondClass():New( 10,"Alex" )
   ? "????? ???????? mySecondClass:", mySecondClass():nKolObj
   obj2 := mySecondClass():New( 11,"Mike" )
   ? "????? ???????? mySecondClass:", mySecondClass():nKolObj
   ? obj1:x, obj2:x
   ? 
return Nil
 
CLASS myFirstClass
   VAR   x
   METHOD New( n )   INLINE ( ::x := n, Self )
ENDCLASS
 
CLASS mySecondClass  FROM myFirstClass
HIDDEN:
   VAR   cStringS
 
EXPORTED:
   CLASS VAR  nKolObj     INIT 0
   VAR        cString1    INIT "Sample"
   METHOD New( n, s )
ENDCLASS
 
METHOD New( n, s ) CLASS mySecondClass
 
   Super:New( n )
   ::nKolObj ++
   ::cStringS := s
return Self

*****************************************************************************************************************

#include "hbclass.ch"
function Main4()
Local o1 := HSamp1():New()
Local o2 := HSamp2():New()
 
   ? o1:x, o2:x                        // 10       20
   ? o1:Calc( 2,3 ), o2:Mul( 2,3 )     // 60      120
   ? o1:Sum( 5 )                       // 15
   ?
 
return nil
 
CLASS HSamp1
 
   DATA x   INIT 10
   METHOD New()  INLINE Self
   METHOD Sum( y )  BLOCK {|Self,y|::x += y}
   METHOD Calc( y,z ) EXTERN fr1( y,z )
ENDCLASS
 
CLASS HSamp2
 
   DATA x   INIT 20
   METHOD New()  INLINE Self
   METHOD Mul( y,z ) EXTERN fr1( y,z )
ENDCLASS
 
Function fr1( y, z )
Local o := QSelf()
return o:x * y * z

*****************************************************************************************************************

#include "hbclass.ch"
FUNCTION Main5
   LOCAL oTable
 
   oTable := Table():Create( "sample.dbf", { {"F1","C",10,0}, {"F2","N",8,0} } )
   oTable:AppendRec()
   oTable:F1 := "FirstRec"
   oTable:F2 := 1
   oTable:AppendRec()
   ? oTable:nRec                // 2
   oTable:nRec := 1
   ? oTable:nRec                // 1
   ? oTable:F1, oTable:F2       // "FirstRec"     1
   ?
 
   return nil
 
CLASS Table
 
   METHOD Create( cName, aStru )
   METHOD AppendRec()   INLINE dbAppend()
   METHOD nRec( n )     SETGET
 
   ERROR HANDLER OnError( xParam )
ENDCLASS
 
METHOD Create( cName, aStru ) CLASS Table
 
   dbCreate( cName, aStru )
   USE (cName) NEW EXCLUSIVE
return Self
 
METHOD nRec( n ) CLASS Table
 
   if n != Nil
      dbGoTo( n )
   endif
return Recno()
 
METHOD OnError( xParam ) CLASS Table
Local cMsg := __GetMessage(), cFieldName, nPos
Local xValue
 
   if Left( cMsg, 1 ) == '_'
      cFieldName := Substr( cMsg,2 )
   else
      cFieldName := cMsg
   endif
   if ( nPos := FieldPos( cFieldName ) ) == 0
      Alert( cFieldName + " wrong field name!" )
   elseif cFieldName == cMsg
      return FieldGet( nPos )
   else
      FieldPut( nPos, xParam )
   endif
 
return Nil


*****************************************************************************************************************
// hash arrays

FUNCTION Main6
local harr := hb_Hash( "six", 6, "eight", 8, "eleven", 11 )
 
   harr[10] := "str1"
   harr[23] := "str2"
   harr["fantasy"] := "fiction"
 
   ? harr[10], harr[23]                                   // str1  str2
   ? harr["eight"], harr["eleven"], harr["fantasy"]       // 8       11  fiction
   ? len(harr)                                            // 6
   ?
 
   return nil
	
*****************************************************************************************************************

nTemp := 1
DO CASE
CASE nOpcao == nTemp++
CASE nOpcao == nTemp++
CASE nOpcao == nTemp++
CASE nOpcao == nTemp++
CASE nOpcao == nTemp++
CASE nOpcao == nTemp++
ENDCASE	
	