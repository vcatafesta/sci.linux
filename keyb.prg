#include "inkey.ch"

   LOCAL cVar1 := Space(10), nVar := 2500, ;
         cVar2 := Space(10)
   CLEAR
   @ 09, 10 GET cVar1
   @ 10, 10 GET cVar2 WHEN PickList()
   @ 11, 10 GET nVar
   READ
   return

   FUNCTION PickList
      STATIC aList := { "First", "Second", ;
         "Three", "Four" }
      LOCAL cScreen, nChoice, nKey := LastKey()
      cScreen := SaveScreen(10, 10, 14, 20)
      @ 10, 10 TO 14, 20 DOUBLE
      if (nChoice := AChoice(11, 11, 13, 19, aList)) != 0
         KEYBOARD CHR(K_CTRL_Y) + aList[nChoice] + ;
               Chr(nKey)

      endif
      RestScreen(10, 10, 14, 20, cScreen)
      return .T.