#include <sci.ch>

Local c := ""
LOCAL s := "abcdefghijk"

FOR EACH c IN @s
   if c $ "aei"
      c := UPPER( c )
   endif
	? c
NEXT
? s      // AbcdEfghIjk
? s      // alles

WITH OBJECT (o := Ts():new())
	:Um   := 1
	:Dois := 2
	? :Um
	? :Dois
	? :lTeste
	? :lNew
	? :Tres
	? :nQuatro
ENDWITH

SWITCH o:nQuatro
CASE 0
	? "FOUND: 0"
	EXIT
CASE 1
   ? "FOUND: 1"
	EXIT
CASE "2"
   ? "FOUND: 2"
	EXIT
OTHERWISE
   ? "other"
	EXIT
END

DemoCodeBlock()
DemoHashByRef()
DemoHash()
DemoThreadMainMain()

CLASS Ts
	DATA Um
	DATA Dois
	DATA Tres			AS STRING
	DATA nQuatro		AS INTEGER
	DATA lNew			AS LOGICAL
	CLASSDATA lTeste 	AS LOGICAL
	
	METHOD new CONSTRUCTOR

ENDCLASS

METHOD Ts:New()
	SELF:Um   := 1
	SELF:Dois := 2
	return self
	
*+------------------------------------------------------------- 	
	
Function DemoCodeBlock() 
   Local b1, b2
 
   b1 := Fnc1( Seconds() )
   ? Eval( b1 ) 
   ? "Press any key"
   inkey(1) 
	
   b2 := Fnc1( Seconds() )
   ? Eval( b2 ) 
   ? "Press any key"
   inkey(1) 
	
   ? Eval( b1,Seconds() ) 
   ? "Press any key"
   inkey(1) 
   
	? Eval( b1 )
   ?
 	return Nil

Function Fnc1( nSec )
    Local bCode := {|p1|
      Local tmp := nSec
      if p1 != Nil
         nSec := p1
      endif
      return tmp
   }
	return bCode	

*+------------------------------------------------------------- 	
	
function DemoHashByRef()
	Local arr := { 1,2,3 } 
 
   ? arr[1], arr[2], arr[3]   // 1   2   3
   p( @arr[2] )
   ? arr[1], arr[2], arr[3]   // 1  12   3
	return nil
 
Function p( x )
   x += 10
	return nil	

*+------------------------------------------------------------- 	

FUNCTION DemoHash()
//local harr := hb_Hash( "six", 6, "eight", 8, "eleven", 11 )
local harr := hb_Hash( 'six' => 6, 'eight' => 8, 'eleven' => 11 )
 
   harr[10] := "str1"
   harr[23] := "str2"
   harr["fantasy"] := "fiction"
 
   ? harr[10], harr[23]                                   // str1  str2
   ? harr["eight"], harr["eleven"], harr["fantasy"]       // 8       11  fiction
   ? len(harr)                                            // 6
   ?
 
   return nil

*+------------------------------------------------------------- 		
	
FUNCTION DemoThreadMainMain()
   LOCAL cVar := Space( 20 )
 
   CLEAR SCREEN
 
   if !hb_mtvm()
      ? "There is no support for multi-threading, clocks will not be seen."
      inkey(1)
   else
      hb_threadStart( @Show_Time() )
   endif
 
   @ 10, 10 SAY "Enter something:" GET cVar
   READ
   SetPos( 12, 0 )
   ? "You enter -> [" + cVar + "]"
   inkey(1)
 
   return Nil
	
FUNCTION Show_Time()
   LOCAL cTime
 
   DO WHILE .T.
      cTime := Dtoc( Date() ) + " " + Time()
      hb_dispOutAt( 0, MaxCol() - Len( cTime ) + 1, cTime, "GR+/N" )
      hb_idleSleep( 1 )
   ENDDO
 
   return nil	