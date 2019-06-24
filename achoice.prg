#include "sci.ch"

FUNCTION AChoice( nTop, nLeft, nBottom, nRight, acItems, xSelect, xUserFunc, nPos, nHiLiteRow, lPageCircular)

   LOCAL nNumCols           // Number of columns in the window
   LOCAL nNumRows           // Number of rows in the window
   LOCAL nRowsClr           // Number of rows to clear
   LOCAL alSelect           // Select permission
   LOCAL nNewPos   := 0     // The next item to be selected
   LOCAL lFinished          // Is processing finished?
   LOCAL nKey      := 0     // The keystroke to be processed
   LOCAL nMode              // The current operating mode
   LOCAL nAtTop             // The number of the item at the top
   LOCAL nItems    := 0     // The number of items
   LOCAL nGap               // The number of lines between top and current lines
	
   // Block used to search for items
   LOCAL lUserFunc          // Is a user function to be used?
   LOCAL nUserFunc          // return value from user function
   LOCAL nSaveCsr
   LOCAL nFrstItem := 0
   LOCAL nLastItem := 0

   LOCAL bAction
   LOCAL cKey
   LOCAL nAux
	DEFAU lPageCircular TO .T.
	PRIVA oAchoice  := TAchoiceNew()
	
	//Afill((oAchoice:Color_pFore := Array(Len(acItems))), Cor(1)) // oAmbiente:CorMenu
	//Afill((oAchoice:Color_pBack := Array(Len(acItems))), Cor(5)) // oAmbiente:CorLightBar
	//Afill((oAchoice:Color_pUns  := Array(Len(acItems))), AscanCorHKLightBar( Cor(1)))
			
	hb_default( @nTop, 0)
   hb_default( @nBottom, 0)

   hb_default( @nLeft, 0 )
   hb_default( @nRight, 0 )

   if nRight > MaxCol()
      nRight := MaxCol()
   endif

   if nBottom > MaxRow()
      nBottom := MaxRow()
   endif

   if ! HB_ISARRAY( acItems ) .OR. Len( acItems ) == 0
      SetPos( nTop, nRight + 1 )
      return 0
   endif

   nSaveCsr := SetCursor( SC_NONE )
   ColorSelect( CLR_STANDARD )

   /* NOTE: Undocumented parameter passing handled. AChoice()
            is called in such way in rldialg.prg from RL tool
            supplied with Clipper 5.x. 6th parameter is the
            user function and 7th parameter is zero (empty I
            suppose). [vszakats] */
   if Empty( xUserFunc ) .AND. ValType( xSelect ) $ "CBS"
      xUserFunc := xSelect
      xSelect   := NIL
   endif

   lUserFunc := ! Empty( xUserFunc ) .AND. ValType( xUserFunc ) $ "CBS"

   if ! HB_ISARRAY( xSelect ) .AND. ! HB_ISLOGICAL( xSelect )
      xSelect := .T.               // Array or logical, what is selectable
   endif

   hb_default( @nPos, 1 )          // The number of the selected item
   hb_default( @nHiLiteRow, 0 )    // The row to be highlighted

   nNumCols := nRight - nLeft + 1
   nNumRows := nBottom - nTop + 1

   if HB_ISARRAY( xSelect )
         alSelect := xSelect
   else
      alSelect := Array( Len( acItems ) )
      AFill( alSelect, xSelect )
   endif

   if ( nMode := Ach_Limits( @nFrstItem, @nLastItem, @nItems, alSelect, acItems ) ) == AC_NOITEM
      nPos := 0
		oAchoice:CurElemento := nPos
   endif

   // Ensure hilighted item can be selected
   nPos := BETWEEN( nFrstItem, nPos, nLastItem )
	oAchoice:CurElemento := nPos
	
   // Force hilighted row to be valid
   nHiLiteRow := BETWEEN( 0, nHiLiteRow, nNumRows - 1 )

   // Force the topmost item to be a valid index of the array
   nAtTop := BETWEEN( 1, Max( 1, nPos - nHiLiteRow ), nItems )

   // Ensure as much of the selection area as possible is covered
   if ( nAtTop + nNumRows - 1 ) > nItems
      nAtTop := Max( 1, nItems - nNumrows + 1 )
   endif

   DispPage( acItems, alSelect, nTop, nLeft, nRight, nNumRows, nPos, nAtTop, nItems, nItems )

   lFinished := ( nMode == AC_NOITEM )
   if lFinished .AND. lUserFunc
	   Do( xUserFunc, nMode, nPos, nPos - nAtTop )
   endif

   DO WHILE !lFinished
		if nMode != AC_EXCEPT .AND. nMode != AC_NOITEM .AND. nMode != AC_CURELEMENTO
         nKey  := Inkey( 0 )
         nMode := AC_IDLE
      endif

      DO CASE
		CASE nMode = AC_CURELEMENTO
		   nNewPos := oAchoice:CurElemento
			DO WHILE !Ach_Select( alSelect, nNewPos )
            nNewPos--
         ENDDO
         if INRANGE( nAtTop, nNewPos, nAtTop + nNumRows - 1 )
            DispLine( acItems[ nPos ], nTop + nPos - nAtTop, nLeft, Ach_Select( alSelect, nPos ), .F., nNumCols, nPos )
            nPos := nNewPos
            DispLine( acItems[ nPos ], nTop + nPos - nAtTop, nLeft, Ach_Select( alSelect, nPos ), .T., nNumCols, nPos )
         else
            DispBegin()
            DispLine( acItems[ nPos ], nTop + nPos - nAtTop, nLeft, Ach_Select( alSelect, nPos ), .F., nNumCols, nPos )
            hb_Scroll( nTop, nLeft, nBottom, nRight, nNewPos - ( nAtTop + nNumRows - 1 ) )
            nAtTop := nNewPos
            nPos   := Max( nPos, nAtTop + nNumRows - 1 )
            DO WHILE nPos > nNewPos
               if nTop + nPos - nAtTop <= nBottom
                  DispLine( acItems[ nPos ], nTop + nPos - nAtTop, nLeft, Ach_Select( alSelect, nPos ), .F., nNumCols, nPos )
               endif
               nPos--
            ENDDO
            DispLine( acItems[ nPos ], nTop + nPos - nAtTop, nLeft, Ach_Select( alSelect, nPos ), .T., nNumCols, nPos )
            DispEnd()
         endif
		
      CASE ( bAction := SetKey( nKey ) ) != NIL
         Eval( bAction, ProcName( 1 ), ProcLine( 1 ), "" )
         if NextKey() == 0
            hb_keySetLast( 255 )
            nKey := 0
         endif

         nRowsClr := Min( nNumRows, nItems )
         if ( nMode := Ach_Limits( @nFrstItem, @nLastItem, @nItems, alSelect, acItems ) ) == AC_NOITEM
            nPos := 0
            nAtTop := Max( 1, nPos - nNumRows + 1 )
         else
            DO WHILE nPos < nLastItem .AND. ! Ach_Select( alSelect, nPos )
               nPos++
            ENDDO

            if nPos > nLastItem
               nPos := BETWEEN( nFrstItem, nPos, nLastItem )
            endif

            nAtTop := Min( nAtTop, nPos )
            if nAtTop + nNumRows - 1 > nItems
               nAtTop := BETWEEN( 1, nPos - nNumRows + 1, nItems - nNumRows + 1 )
            endif

            if nAtTop < 1
               nAtTop := 1
            endif
         endif

         DispPage( acItems, alSelect, nTop, nLeft, nRight, nNumRows, nPos, nAtTop, nItems, nRowsClr )

      CASE ( nKey == K_ESC .OR. nMode == AC_NOITEM ) .AND. ! lUserFunc

         if nPos != 0
            DispLine( acItems[ nPos ], nTop + nPos - nAtTop, nLeft, .T., .F., nNumCols, nPos )
         endif

         nMode     := AC_IDLE
         nPos      := 0
         lFinished := .T.

      CASE nKey == K_LDBLCLK .OR. nKey == K_LBUTTONDOWN
         nAux := HitTest( nTop, nLeft, nBottom, nRight, MRow(), MCol() )
         if nAux != 0 .AND. ( nNewPos := nAtTop + nAux - 1 ) <= nItems
            if Ach_Select( alSelect, nNewPos )
               DispLine( acItems[ nPos ], nTop + nPos - nAtTop, nLeft, Ach_Select( alSelect, nPos ), .F., nNumCols, nPos )
               nPos := nNewPos
               DispLine( acItems[ nPos ], nTop + nPos - nAtTop, nLeft, Ach_Select( alSelect, nPos ), .T., nNumCols, nPos )
               if nKey == K_LDBLCLK
                  hb_keyIns( K_ENTER )
               endif
            endif
         endif

#ifdef HB_CLP_STRICT
      CASE nKey == K_UP
#else
      CASE nKey == K_UP .OR. nKey == K_MWFORWARD
#endif
			nNewPos := nPos - 1
			if nNewPos < nFrstItem
				nPos    := nLastItem
				nAtTop  := Max( 1, nPos - nNumRows + 1 )
				nNewPos := nPos
				DispPage( acItems, alSelect, nTop, nLeft, nRight, nNumRows, nPos, nAtTop, nItems )
				nMode   := AC_HITBOTTOM
			endif
         
            DO WHILE ! Ach_Select( alSelect, nNewPos )
               nNewPos--
            ENDDO
            if INRANGE( nAtTop, nNewPos, nAtTop + nNumRows - 1 )
               DispLine( acItems[ nPos ], nTop + nPos - nAtTop, nLeft, Ach_Select( alSelect, nPos ), .F., nNumCols, nPos )
               nPos := nNewPos
               DispLine( acItems[ nPos ], nTop + nPos - nAtTop, nLeft, Ach_Select( alSelect, nPos ), .T., nNumCols, nPos )
            else
               DispBegin()
               DispLine( acItems[ nPos ], nTop + nPos - nAtTop, nLeft, Ach_Select( alSelect, nPos ), .F., nNumCols, nPos )
               hb_Scroll( nTop, nLeft, nBottom, nRight, nNewPos - ( nAtTop + nNumRows - 1 ) )
               nAtTop := nNewPos
               nPos   := Max( nPos, nAtTop + nNumRows - 1 )
               DO WHILE nPos > nNewPos
                  if nTop + nPos - nAtTop <= nBottom
                     DispLine( acItems[ nPos ], nTop + nPos - nAtTop, nLeft, Ach_Select( alSelect, nPos ), .F., nNumCols, nPos )
                  endif
                  nPos--
               ENDDO
               DispLine( acItems[ nPos ], nTop + nPos - nAtTop, nLeft, Ach_Select( alSelect, nPos ), .T., nNumCols, nPos )
               DispEnd()
            endif
         
#ifdef HB_CLP_STRICT
      CASE nKey == K_DOWN
#else
      CASE nKey == K_DOWN .OR. nKey == K_MWBACKWARD
#endif

         // Find the next selectable item to display
            nNewPos := nPos + 1
				if nNewPos > nLastItem
					nPos    := nFrstItem					
					nAtTop  := nPos
					nNewPos := nPos
					DispPage( acItems, alSelect, nTop, nLeft, nRight, nNumRows, nPos, nAtTop, nItems )
					nMode   := AC_HITTOP
				endif
				
            DO WHILE ! Ach_Select( alSelect, nNewPos )
               nNewPos++
            ENDDO

            if INRANGE( nAtTop, nNewPos, nAtTop + nNumRows - 1 )
               DispLine( acItems[ nPos ], nTop + nPos - nAtTop, nLeft, Ach_Select( alSelect, nPos ), .F., nNumCols, nPos )
               nPos := nNewPos
               DispLine( acItems[ nPos ], nTop + nPos - nAtTop, nLeft, Ach_Select( alSelect, nPos ), .T., nNumCols, nPos )
            else
               DispBegin()
               DispLine( acItems[ nPos ], nTop + nPos - nAtTop, nLeft, Ach_Select( alSelect, nPos ), .F., nNumCols, nPos )
               hb_Scroll( nTop, nLeft, nBottom, nRight, nNewPos - ( nAtTop + nNumRows - 1 ) )
               nAtTop := nNewPos - nNumRows + 1
               nPos   := Max( nPos, nAtTop )
               DO WHILE nPos < nNewPos
                  DispLine( acItems[ nPos ], nTop + nPos - nAtTop, nLeft, Ach_Select( alSelect, nPos ), .F., nNumCols, nPos )
                  nPos++
               ENDDO
               DispLine( acItems[ nPos ], nTop + nPos - nAtTop, nLeft, Ach_Select( alSelect, nPos ), .T., nNumCols, nPos )
               DispEnd()
            endif
								
         //endif

      CASE nKey == K_CTRL_PGUP .OR. ( nKey == K_HOME .AND. ! lUserFunc )

         if nPos == nFrstItem
				if lPageCircular
					nPos    := nLastItem
					nAtTop  := Max( 1, nPos - nNumRows + 1 )
					nNewPos := nPos
					DispPage( acItems, alSelect, nTop, nLeft, nRight, nNumRows, nPos, nAtTop, nItems )
					nMode   := AC_HITBOTTOM
				else
					if nAtTop == Max( 1, nPos - nNumRows + 1 )
						nMode := AC_HITTOP
					else
						nAtTop := Max( 1, nPos - nNumRows + 1 )
						DispPage( acItems, alSelect, nTop, nLeft, nRight, nNumRows, nPos, nAtTop, nItems )
					endif
				endif	
         else
            nPos   := nFrstItem
            nAtTop := nPos
            DispPage( acItems, alSelect, nTop, nLeft, nRight, nNumRows, nPos, nAtTop, nItems )
         endif

      CASE nKey == K_CTRL_PGDN .OR. ( nKey == K_END .AND. ! lUserFunc )

         if nPos == nLastItem
				if lPageCircular
					nPos    := nFrstItem					
					nAtTop  := nPos
					nNewPos := nPos
					DispPage( acItems, alSelect, nTop, nLeft, nRight, nNumRows, nPos, nAtTop, nItems )
					nMode   := AC_HITTOP
				else	
					if nAtTop == Min( nLastItem, nItems - Min( nItems, nNumRows ) + 1 )
						nMode   := AC_HITTOP
						nMode := AC_HITBOTTOM
					else
						nAtTop := Min( nLastItem, nItems - nNumRows + 1 )
						DispPage( acItems, alSelect, nTop, nLeft, nRight, nNumRows, nPos, nAtTop, nItems )
					endif
				endif	
         else
            if INRANGE( nAtTop, nLastItem, nAtTop + nNumRows - 1 )
               DispLine( acItems[ nPos ], nTop + nPos - nAtTop, nLeft, Ach_Select( alSelect, nPos ), .F., nNumCols, nPos )
               nPos := nLastItem
               DispLine( acItems[ nPos ], nTop + nPos - nAtTop, nLeft, Ach_Select( alSelect, nPos ), .T., nNumCols, nPos )
            else
               nPos   := nLastItem
               nAtTop := Max( 1, nPos - nNumRows + 1 )
               DispPage( acItems, alSelect, nTop, nLeft, nRight, nNumRows, nPos, nAtTop, nItems )
            endif
         endif

      CASE nKey == K_CTRL_HOME

         if nPos == nFrstItem
            if nAtTop == Max( 1, nPos - nNumRows + 1 )
               nMode := AC_HITTOP
            else
               nAtTop := Max( 1, nPos - nNumRows + 1 )
               DispPage( acItems, alSelect, nTop, nLeft, nRight, nNumRows, nPos, nAtTop, nItems )
            endif
         else
            nNewPos := nAtTop
            DO WHILE ! Ach_Select( alSelect, nNewPos )
               nNewPos++
            ENDDO
            if nNewPos != nPos
               DispLine( acItems[ nPos ], nTop + nPos - nAtTop, nLeft, Ach_Select( alSelect, nPos ), .F., nNumCols, nPos )
               nPos := nNewPos
               DispLine( acItems[ nPos ], nTop + nPos - nAtTop, nLeft, Ach_Select( alSelect, nPos ), .T., nNumCols, nPos )
            endif
         endif

      CASE nKey == K_CTRL_END

         if nPos == nLastItem
            if nAtTop == Min( nPos, nItems - Min( nItems, nNumRows ) + 1 ) .OR. nPos == nItems
               nMode := AC_HITBOTTOM
            else
               nAtTop := Min( nPos, nItems - nNumRows + 1 )
               DispPage( acItems, alSelect, nTop, nLeft, nRight, nNumRows, nPos, nAtTop, nItems )
            endif
         else
            nNewPos := Min( nAtTop + nNumRows - 1, nItems )
            DO WHILE ! Ach_Select( alSelect, nNewPos )
               nNewPos--
            ENDDO
            if nNewPos != nPos
               DispLine( acItems[ nPos ], nTop + nPos - nAtTop, nLeft, Ach_Select( alSelect, nPos ), .F., nNumCols, nPos )
               nPos := nNewPos
               DispLine( acItems[ nPos ], nTop + nPos - nAtTop, nLeft, Ach_Select( alSelect, nPos ), .T., nNumCols, nPos )
            endif
         endif

      CASE nKey == K_PGUP

         if nPos == nFrstItem
				if lPageCircular
					nPos    := nLastItem
					nAtTop  := Max( 1, nPos - nNumRows + 1 )
					nNewPos := nPos
					DispPage( acItems, alSelect, nTop, nLeft, nRight, nNumRows, nPos, nAtTop, nItems )
					nMode   := AC_HITBOTTOM
				else
					nMode := AC_HITTOP
					if nAtTop > Max( 1, nPos - nNumRows + 1 )
						nAtTop := Max( 1, nPos - nNumRows + 1 )
						DispPage( acItems, alSelect, nTop, nLeft, nRight, nNumRows, nPos, nAtTop, nItems )
					endif
				endif	
         else
            if INRANGE( nAtTop, nFrstItem, nAtTop + nNumRows - 1 )
               // On same page as nFrstItem
               nPos   := nFrstItem
               nAtTop := Max( nPos - nNumRows + 1, 1 )
            else
               if ( nPos - nNumRows + 1 ) < nFrstItem
                  nPos   := nFrstItem
                  nAtTop := nFrstItem
               else
                  nPos   := Max( nFrstItem, nPos - nNumRows + 1 )
                  nAtTop := Max( 1, nAtTop - nNumRows + 1 )
                  DO WHILE nPos > nFrstItem .AND. ! Ach_Select( alSelect, nPos )
                     nPos--
                     nAtTop--
                  ENDDO
                  nAtTop := Max( 1, nAtTop )
                  if nAtTop < nNumRows .AND. nPos < nNumRows
                     nPos := nNumRows
                     nAtTop := 1
                  endif
               endif
            endif
            DispPage( acItems, alSelect, nTop, nLeft, nRight, nNumRows, nPos, nAtTop, nItems )
         endif

      CASE nKey == K_PGDN

         if nPos == nLastItem
				if lPageCircular
					nPos    := nFrstItem					
					nAtTop  := nPos
					nNewPos := nPos
					DispPage( acItems, alSelect, nTop, nLeft, nRight, nNumRows, nPos, nAtTop, nItems )
					nMode   := AC_HITTOP
				else
					nMode := AC_HITBOTTOM
					if nAtTop < Min( nPos, nItems - nNumRows + 1 )
						nAtTop := Min( nPos, nItems - nNumRows + 1 )
						DispPage( acItems, alSelect, nTop, nLeft, nRight, nNumRows, nPos, nAtTop, nItems )
					endif
				endif	
         else
            if INRANGE( nAtTop, nLastItem, nAtTop + nNumRows - 1 )
               // On the same page as nLastItem
               DispLine( acItems[ nPos ], nTop + nPos - nAtTop, nLeft, Ach_Select( alSelect, nPos ), .F., nNumCols, nPos )
               nPos := nLastItem
               DispLine( acItems[ nPos ], nTop + nPos - nAtTop, nLeft, Ach_Select( alSelect, nPos ), .T., nNumCols, nPos )
            else
               nGap := nPos - nAtTop
               nPos := Min( nLastItem, nPos + nNumRows - 1 )
               if ( nPos + nNumRows - 1 ) > nLastItem
                  // On the last page
                  nAtTop := nLastItem - nNumRows + 1
                  nPos   := Min( nLastItem, nAtTop + nGap )
               else
                  // Not on the last page
                  nAtTop := nPos - nGap
               endif
               // Make sure that the item is selectable
               DO WHILE nPos < nLastItem .AND. ! Ach_Select( alSelect, nPos )
                  nPos++
                  nAtTop++
               ENDDO
               // Don't leave blank space on the page
               DO WHILE ( nAtTop + nNumRows - 1 ) > nItems
                  nAtTop--
               ENDDO
               DispPage( acItems, alSelect, nTop, nLeft, nRight, nNumRows, nPos, nAtTop, nItems )
            endif
         endif

      CASE nKey == K_ENTER .AND. ! lUserFunc

         if nPos != 0
            DispLine( acItems[ nPos ], nTop + nPos - nAtTop, nLeft, .T., .F., nNumCols, nPos )
         endif

         nMode     := AC_IDLE
         lFinished := .T.

      CASE nKey == K_RIGHT .AND. ! lUserFunc

         if nPos != 0
            DispLine( acItems[ nPos ], nTop + nPos - nAtTop, nLeft, .T., .F., nNumCols, nPos )
         endif

         nPos      := 0
         lFinished := .T.

      CASE nKey == K_LEFT .AND. ! lUserFunc

         if nPos != 0
            DispLine( acItems[ nPos ], nTop + nPos - nAtTop, nLeft, .T., .F., nNumCols, nPos )
         endif

         nPos      := 0
         lFinished := .T.

      CASE ( ! lUserFunc .OR. nMode == AC_EXCEPT ) .AND. ;
           ! ( cKey := Upper( hb_keyChar( nKey ) ) ) == ""

         // Find next selectable item
         FOR nNewPos := nPos + 1 TO nItems
            if Ach_Select( alSelect, nNewPos ) .AND. LeftEqI( acItems[ nNewPos ], cKey )
               EXIT
            endif
         NEXT
         if nNewPos == nItems + 1
            FOR nNewPos := 1 TO nPos - 1
               if Ach_Select( alSelect, nNewPos ) .AND. LeftEqI( acItems[ nNewPos ], cKey )
                  EXIT
               endif
            NEXT
         endif

         if nNewPos != nPos
            if INRANGE( nAtTop, nNewPos, nAtTop + nNumRows - 1 )
               // On same page
               DispLine( acItems[ nPos ], nTop + nPos - nAtTop, nLeft, Ach_Select( alSelect, nPos ), .F., nNumCols, nPos )
               nPos := nNewPos
               DispLine( acItems[ nPos ], nTop + nPos - nAtTop, nLeft, Ach_Select( alSelect, nPos ), .T., nNumCols, nPos )
            else
               // On different page
               nPos   := nNewPos
               nAtTop := BETWEEN( 1, nPos - nNumRows + 1, nItems )
               DispPage( acItems, alSelect, nTop, nLeft, nRight, nNumRows, nPos, nAtTop, nItems )
            endif
         endif

         nMode := AC_IDLE

      CASE nMode == AC_EXCEPT
		   nPos := oAchoice:CurElemento
         // Handle keypresses which don't translate to characters
         nMode := AC_IDLE
			
		CASE nMode == AC_CURELEMENTO
			nPos := oAchoice:CurElemento
			if nPos != 0
				DispLine( acItems[ nPos ], nTop + nPos - nAtTop, nLeft, .T., .F., nNumCols, nPos )
         endif
			nMode := AC_IDLE
         
      CASE nMode != AC_NOITEM
         nMode := iif( nKey == 0, AC_IDLE, AC_EXCEPT )

      ENDCASE

      if lUserFunc
         if HB_ISNUMERIC( nUserFunc := Do( xUserFunc, nMode, nPos, nPos - nAtTop ) )

            SWITCH nUserFunc
            CASE AC_ABORT
					lFinished := .T.
					nPos      := 0
               EXIT
					
				CASE AC_CURELEMENTO
					nPos := oAchoice:CurElemento
					if nPos != 0
						DispLine( acItems[ nPos ], nTop + nPos - nAtTop, nLeft, .T., .F., nNumCols, nPos )
					endif
					lFinished := .F.
               LOOP
				
				CASE AC_REDRAW  /* QUESTION: Is this correct? */
               if nPos != 0
                  DispLine( acItems[ nPos ], nTop + nPos - nAtTop, nLeft, .T., .F., nNumCols, nPos )
               endif
               lFinished := .T.
               nPos      := 0
               EXIT
            CASE AC_SELECT
               if nPos != 0
                  DispLine( acItems[ nPos ], nTop + nPos - nAtTop, nLeft, .T., .F., nNumCols, nPos )
               endif
               lFinished := .T.
               EXIT
            CASE AC_CONT
               // Do nothing
					nMode := AC_IDLE
               EXIT
            CASE AC_GOTO
               // Do nothing. The next keystroke won't be read and
               // this keystroke will be processed as a goto.
               nMode := AC_EXCEPT
               EXIT
            ENDSWITCH

            if nPos > 0 .AND. nMode != AC_EXCEPT

#if 0
               /* TOVERifY: Disabled nRowsClr DispPage().
                  Please verify it, I do not know why it was added but
                  it breaks code which adds dynamically new acItems positions */
               nRowsClr := Min( nNumRows, nItems )
#endif
               if ( nMode := Ach_Limits( @nFrstItem, @nLastItem, @nItems, alSelect, acItems ) ) == AC_NOITEM
                  nPos := 0
                  nAtTop := Max( 1, nPos - nNumRows + 1 )
               else
                  DO WHILE nPos < nLastItem .AND. ! Ach_Select( alSelect, nPos )
                     nPos++
                  ENDDO

                  if nPos > nLastItem
                     nPos := BETWEEN( nFrstItem, nPos, nLastItem )
                  endif

                  nAtTop := Min( nAtTop, nPos )

                  if nAtTop + nNumRows - 1 > nItems
                     nAtTop := BETWEEN( 1, nPos - nNumRows + 1, nItems - nNumRows + 1 )
                  endif

                  if nAtTop < 1
                     nAtTop := 1
                  endif
               endif

               DispPage( acItems, alSelect, nTop, nLeft, nRight, nNumRows, nPos, nAtTop, nItems /*, nRowsClr */ )
            endif
         else
            if nPos != 0
               DispLine( acItems[ nPos ], nTop + nPos - nAtTop, nLeft, .T., .F., nNumCols, nPos )
            endif
            nPos      := 0
            lFinished := .T.
         endif
      endif
   ENDDO
   SetCursor( nSaveCsr )
   return nPos

STATIC FUNCTION HitTest( nTop, nLeft, nBottom, nRight, mRow, mCol )

   if mCol >= nLeft .AND. ;
      mCol <= nRight .AND. ;
      mRow >= nTop .AND. ;
      mRow <= nBottom
      return mRow - nTop + 1
   endif

   return 0

STATIC PROCEDURE DispPage( acItems, alSelect, nTop, nLeft, nRight, nNumRows, nPos, nAtTop, nArrLen, nRowsClr )

   LOCAL nCntr
   LOCAL nRow       // Screen row
   LOCAL nIndex     // Array index

   hb_default( @nRowsClr, nArrLen )

   DispBegin()
   FOR nCntr := 1 TO Min( nNumRows, nRowsClr )

      nRow   := nTop + nCntr - 1
      nIndex := nCntr + nAtTop - 1

      if INRANGE( 1, nIndex, nArrLen )
         DispLine( acItems[ nIndex ], nRow, nLeft, Ach_Select( alSelect, nIndex ), nIndex == nPos, nRight - nLeft + 1, nIndex )
      else		
         ColorSelect( CLR_STANDARD )
         hb_DispOutAt( nRow, nLeft, Space( nRight - nLeft + 1 ) )
      endif
   NEXT
   DispEnd()
   return

STATIC PROCEDURE DispLine( cLine, nRow, nCol, lSelect, lHiLite, nNumCols, nCurElemento )
	
	//nSetColor( oAchoice:Color_pFore[nCurElemento], oAchoice:Color_pBack[nCurElemento], oAchoice:Color_pUns[nCurElemento])
	ColorSelect( iif( lSelect .AND. HB_ISSTRING( cLine ), iif( lHiLite, CLR_ENHANCED, CLR_STANDARD ), CLR_UNSELECTED ))	
	   hb_DispOutAt( nRow, nCol, iif( HB_ISSTRING(cLine), PadR(' ' + cLine + ' ', nNumCols ), Space( nNumCols ) ) )	   
   if lHiLite
      //hb_DispOutAt( nRow, nCol, iif( HB_ISSTRING(cLine), PadR(chr(16) + cLine + chr(17) + chr(32)+ chr(251), nNumCols ), Space( nNumCols ) ) )	   
      hb_DispOutAt( nRow, nCol, iif( HB_ISSTRING(cLine), PadR(chr(16) + cLine + chr(17), nNumCols ), Space( nNumCols ) ) )	   
      SetPos( nRow, nCol )
   endif	
   ColorSelect( CLR_STANDARD )
   return

STATIC FUNCTION Ach_Limits( /* @ */ nFrstItem, /* @ */ nLastItem, /* @ */ nItems, alSelect, acItems )

   LOCAL nCntr

   nFrstItem := nLastItem := nItems := 0

   FOR nCntr := 1 TO Len( acItems )
      if HB_ISSTRING( acItems[ nCntr ] ) .AND. Len( acItems[ nCntr ] ) > 0
         nItems++
         if Ach_Select( alSelect, nCntr )
            if nFrstItem == 0
               nFrstItem := nLastItem := nCntr
            else
               nLastItem := nItems
            endif
         endif
      else
         EXIT
      endif
   NEXT

   if nFrstItem == 0
      nLastItem := nItems
      return AC_NOITEM
   endif

   return AC_IDLE

STATIC FUNCTION Ach_Select( alSelect, nPos )

   LOCAL sel
	
   if nPos >= 1 .AND. nPos <= Len( alSelect )
      sel := alSelect[ nPos ]
      if HB_ISEVALITEM( sel )
         sel := Eval( sel )
      elseif HB_ISSTRING( sel ) .AND. ! Empty( sel )
         sel := Eval( hb_macroBlock( sel ) )
      endif
      if HB_ISLOGICAL( sel )
         return sel
      endif
   endif

   return .T.

Function LeftEqI( string, cKey )	
	LOCAL nLen := Len( cKey )
	return( Iif(Left(string, nLen ) == cKey, .T., .F.))
	
	
CLASS TAchoice from TReceposi
	VAR cWho
	VAR cNome	
	VAR aDefault       INIT {}
	VAR CurElemento    INIT 1
	VAR Color_pFore 	 INIT {}
	VAR Color_pBack    INIT {}
	VAR Color_pUns     INIT {}	
	METHOD New CONSTRUCTOR
	METHOD Hello	
ENDCLASS 

Method New() class TAchoice
	Self:cWho	  := "TTAchoice"
	Self:cNome	  := ProcName()	
return self	

METHOD Hello class TAchoice
  ? "Hello",Self:cWho
  ? "Hello",::cNome
return self

Function TAchoiceNew()
	return(TAchoice():New())

