#include "inkey.ch"
#include "hbclass.ch"
#include "hmg.ch"

def uno()
proc duo()
procedure tres()
func quatro()

FUNCTION Main()

   DEFINE WINDOW Form_1   ;
      AT 90,90            ;
      WIDTH 300           ;
      HEIGHT 200          ;
      TITLE "Giovanni"    ;
      MAIN
   END WINDOW

   DEFINE MAIN MENU OF Form_1
      DEFINE POPUP "File" 
         MENUITEM "Insert" ACTION none()
         SEPARATOR
         MENUITEM "Edit" ACTION none()
      END POPUP
   END MENU

   Form_1.Activate

   return NIL


FUNCTION none()

   return NIL



PROCEDURE Main6()

   LOCAL GetList := {}
   LOCAL cCity
	LOCAL n1 := 1
   LOCAL n2 := 896885789
	LOCAL k

   SetMode( 25, 80 )
	ft_DispMsg( { { "Printing Report", ;
   "Press [ESC] To Interrupt" }, ;
   { "W+/B*", "W/B", "GR+/B" } } )
	ft_DispMsg( { { "Press [D] To Confirm Deletion", ;
   "Or Any Other Key To Abort" }, ;
   { "W+/B", "W+/B", "GR+/B" } }, ;
   "D" )

// The next example displays a one-line message centered on row 5
// and returns to the calling procedure.

ft_DispMsg( { { "Please Do Not Interrupt" }, ;
   { "W+/B", "GR+/B" } }, ;
   , 5, )
	
	
	Inkey(0)
	ft_Adder()
	CLEAR SCREEN
	//ShowTime( 1, 70, .F. , "rg+/g" )
   cCity = "Pisa"
   @ 4, 4, 12, 20 GET cCity LISTBOX { "Milano", "Genova", "Roma", "Pisa", "Torino" }
   READ
	Main4()
   @ 14, 10 SAY "You have selected: " + cCity

   ? "Result=", udf()
  	? "The Sum from", n1, "to", n2, "is", somma( n1, n2 )
	? "The result is: ", multiply( 58, 37 )
	
	FOR k = 1 TO 10
      ? "A random number between 1 and 6 is: ", rnd( 6 )
   NEXT k
	Main2()
	Main3()
	Main4()
	
	
return
	

PROCEDURE Main2()

   LOCAL GetList := {}
   LOCAL cVar1, cVar2, cVar3

   CLEAR SCREEN
   cVar1 = Space( 10 )
   cVar2 = Space( 10 )
   cVar3 = Space( 10 )
   SET( _SET_EVENTMASK, INKEY_ALL )
   MSetCursor( .T. )
   @ 10, 20 SAY "Var 1:" GET cVar1
   @ 11, 20 SAY "Var 2:" GET cVar2
   @ 12, 20 SAY "Var 3:" GET cVar3
   READ

   return

	
   //         This program creates the Rectangle CLASS.
   //         It has the following instances:
   //         Top, Left, Bottom, Right, Border
   //         and the following methods:
   //         View()
   //         MoveRight() MoveUp() MoveLeft() MoveDown()
   //         Squeeze() Widen() Crush() Expand()


   //--------------------------------------------------------------------//

Function Main3()

   LOCAL oRect := Rectangle():New()
   LOCAL nKey

   SetMode( 25, 80 )
   CLEAR SCREEN
   
   oRect:Top := 5
   oRect:Left := 10
   oRect:Bottom := 20
   oRect:Right := 70
   oRect:Border := 2

   DO WHILE .T.

      oRect:View()

      nKey = Inkey( 0 )

      CLEAR SCREEN
      DO CASE
      CASE nKey = K_ESC
         CLEAR SCREEN
         return .T.
      CASE nKey = K_RIGHT
         oRect:MoveRight()
      CASE nKey = K_UP
         oRect:MoveUp()
      CASE nKey = K_LEFT
         oRect:MoveLeft()
      CASE nKey = K_DOWN
         oRect:MoveDown()
      CASE nKey = K_CTRL_LEFT
         oRect:Squeeze()
      CASE nKey = K_CTRL_RIGHT
         oRect:Widen()
      CASE nKey = K_CTRL_UP
         oRect:Crush()
      CASE nKey = K_CTRL_DOWN
         oRect:Expand()
      ENDCASE
   ENDDO
   return nil

   //--------------------------------------------------------------------//

CLASS Rectangle

   DATA Top, Left, Bottom, Right, Border
   METHOD View()
   METHOD MoveRight()
   METHOD MoveUp()
   METHOD MoveLeft()
   METHOD MoveDown()
   METHOD Squeeze()
   METHOD Widen()
   METHOD Crush()
   METHOD Expand()

ENDCLASS

METHOD View() CLASS Rectangle

   DO CASE
   CASE self:Border = 1
      @ self:Top, self:Left TO self:Bottom, self:Right
   CASE self:Border = 2
      @ self:Top, self:Left TO self:Bottom, self:Right DOUBLE
   ENDCASE

   return Self

METHOD MoveRight() CLASS Rectangle

   self:Left ++
   self:Right ++
   self:View()

   return Self

METHOD MoveUp() CLASS Rectangle

   self:Top --
   self:Bottom --
   self:View()

   return Self

METHOD MoveLeft() CLASS Rectangle

   self:Left --
   self:Right --
   self:View()

   return Self

METHOD MoveDown() CLASS Rectangle

   self:Top ++
   self:Bottom ++
   self:View()

   return Self

METHOD Squeeze() CLASS Rectangle

   self:Right --
   self:View()

   return Self

METHOD Widen() CLASS Rectangle

   self:Right ++
   self:View()

   return Self

METHOD Crush() CLASS Rectangle

   self:Bottom --
   self:View()

   return Self

METHOD Expand() CLASS Rectangle

   self:Bottom ++
   self:View()

   return Self

Function Main4()

   Wapi_PlaySound( "dog.wav" )
   
   return nil
