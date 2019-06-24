/*****
 *
 *   Application: General Purpose Routine
 *   Description: AChoice()-style menu
 *     File Name: CHOICE.PRG
 *        Author: Luiz Quintela
 *  Date created: 12-30-92
 *     Copyright: 1992 by Computer Associates
 *
 */

#define BUTTOM_COLOR                "W+/N"
#define SCROLL_BAR_BGND_COLOR       "N/N"
#define BROW_DEFAULT_COLORS         "W+/W,W/N,W+/W"

#include "inkey.ch"
#include "setcurs.ch"

/*****
 *
 *         Name: AChoose()
 *  Description: AChoice() replacement
 *       Author: Luiz Quintela
 * Date created: 12-30-92
 *    Copyright: Computer Associates
 *
 *    Arguments: nTop
 *             : nLeft
 *             : nBottom
 *             : nRight  -  window coordinates
 *             : aItems  - Array with Menu Items
 *             : aLogic  - Array with .T. or .F. for each item in menu
 *             : aMsg    - Array with messages for each item in menu
 *             : nMsgRow - Line to display messages
 *             : bBlock  - Codeblock to be executed while waiting for a key
 *             : cClrStr - Color pattern (as a string)
 * return Value: nRet    - Subscript
 *
 */

FUNCTION AChoose( nTop, nLeft, nBottom, nRight, aItems, ;
      aLogic, aMsg, nMsgRow, bBlock, cClrStr )

   LOCAL oBrow, nKey, oCol
   LOCAL nNewPos, nLen, nInitPos, nWindow
   LOCAL lIsMsg, nWidth, cSaveClr
   LOCAL nSubs, nRet, nActually

   // Save
   PushScr()
   PushSets()

   SetCursor(SC_NONE)

   // Parameter checking
   nLen    := Len( aItems )
   cClrStr := if(cClrStr == NIL, BROW_DEFAULT_COLORS, cClrStr)

   lIsMsg := (ValType(aMsg) == "A")
   nMsgRow := if(nMsgRow == NIL, MaxRow(), nMsgRow)

   // No logical array so, create one!
   if ValType(aLogic) != "A"
      aLogic := Array(nLen)
      AFill( aLogic, .T. )

   endif

   nInitPos := 0
   nWindow  := nBottom - nTop
   nWidth   := nRight - nLeft - 1
   nRet     := 0

   bBlock := if(bBlock == NIL, {|| .F.}, bBlock)

   // Draw the Box and Gauge
   cSaveClr := SetColor(;
               Substr(cClrStr, 1, At(",",cClrStr) - 1))
   Scroll(nTop - 1, nLeft - 1, nBottom + 1, nRight + 1)
   DispBox(nTop - 1, nLeft - 1, nBottom + 1, nRight + 1)
   DispBox(nTop, nRight + 1, nBottom, nRight + 1, CHR(219),;
            SCROLL_BAR_BGND_COLOR)
   @ nTop,nRight + 1 SAY CHR(219) COLOR BUTTOM_COLOR

   oBrow := TBrowseNew( nTop, nLeft, nBottom, nRight )
   oBrow:colorSpec := cClrStr

   // nSubs is the array subscript
   nSubs := 1

   // Go Top and Go Bottom Blocks
   oBrow:goTopBlock    := {|| nSubs := 1 }
   oBrow:goBottomBlock := {|| nSubs := nLen }
   oBrow:skipBlock := {|nRequest| nActually := Iif(Abs(nRequest) >= ;
                          Iif(nRequest >= 0,;
                             nLen - nSubs, nSubs - 1),;
                                Iif(nRequest >= 0, nLen - nSubs,;
                                   1 - nSubs),nRequest),;
                                      nSubs += nActually, ;
                                         nActually }

   oCol := TBColumnNew(, {|| aItems[nSubs]})

   // Colors for Selectable and Unselectable Items
   oCol:colorBlock := {|| Iif(aLogic[nSubs], {1, 2}, {1, 3})}
   oCol:width      := nWidth
   //
   // About Column Width:
   //
   // When browsing array elements, you need to pay attention
   // to their size. This is very importante because TBcolumn
   // will work based in the size of the first element of
   // the array being being browsed.
   // We are assuming the width between left and right margins
   //
   oBrow:addColumn(oCol)

   WHILE .T.
      DispBegin()
      WHILE !oBrow:stabilize()
      END
      DispEnd()

      if (oBrow:hitTop .OR. oBrow:hitBottom )
         Tone(87.3,1)
         Tone(40,3.5)

      endif

      // Update Bar Gauge
      nNewPos := nWindow / (nLen / nSubs)
      if nSubs == 1
         nNewPos := 0

      elseif nSubs == nLen
         nNewPos := nWindow

      endif
      if ( nInitPos != nNewPos )
         @ nTop + nInitPos,nRight + 1 SAY CHR(219) ;
                                      COLOR SCROLL_BAR_BGND_COLOR
         @ nTop + nNewPos, nRight + 1 SAY CHR(219) ;
                                      COLOR BUTTOM_COLOR
         nInitPos := nNewPos

      endif
      // Messages?
      if lIsMsg
         @ nMsgRow, 0 SAY Space(MaxCol() + 1) COLOR ;
           Substr(cClrStr, RAt(",", cClrStr) + 1)
         @ nMsgRow, 0 SAY aMsg[nSubs] COLOR ;
           Substr(cClrStr, RAt(",", cClrStr) + 1)

      endif
      WHILE ((nKey := InKey(0.1)) == 0)
         // Evaluate a code block
         Eval(bBlock)

      END

      if !TBMoveCursor( nKey, oBrow )
         // Key was not handled there
         // Lets try here
         if ( nKey     == K_ESC )
            EXIT

         elseif ( nKey == K_ENTER )
            // Is the item selectable?
            if aLogic[nSubs]
               // if so, return array subscript for
               // the element
               nRet := nSubs
               EXIT

            endif

         endif

      endif

   END

   PopScr()
   PopSets()

   return (nRet)

// EOF - CHOICE.PRG //
