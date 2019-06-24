/*
 * dbEdit() function
 *
 * Copyright 1999 {list of individual authors and e-mail addresses}
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2, or (at your option)
 * any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this software; see the file COPYING.txt.  if not, write to
 * the Free Software Foundation, Inc., 59 Temple Place, Suite 330,
 * Boston, MA 02111-1307 USA (or visit the web site https://www.gnu.org/).
 *
 * As a special exception, the Harbour Project gives permission for
 * additional uses of the text contained in its release of Harbour.
 *
 * The exception is that, if you link the Harbour libraries with other
 * files to produce an executable, this does not by itself cause the
 * resulting executable to be covered by the GNU General Public License.
 * Your use of that executable is in no way restricted on account of
 * linking the Harbour library code into it.
 *
 * This exception does not however invalidate any other reasons why
 * the executable file might be covered by the GNU General Public License.
 *
 * This exception applies only to the code released by the Harbour
 * Project under the name Harbour.  if you copy code from other
 * Harbour Project or Free Software Foundation releases into a copy of
 * Harbour, as the General Public License permits, the exception does
 * not apply to the code that you add in this way.  To avoid misleading
 * anyone as to the status of such modified files, you must delete
 * this exception notice from them.
 *
 * if you write modifications of your own for Harbour, it is your choice
 * whether to permit this exception to apply to your modifications.
 * if you do not wish that, delete this exception notice.
 *
 */

//#pragma -gc0

#include <sci.ch>
#include "dbedit.ch"

#Define	P_DEF(Par, Def)	 Par := if( Par = Nil, Def, Par )

/* NOTE: Extension: Harbour supports codeblocks and function pointers
         as the xUserFunc parameter. [vszakats] */
/* NOTE: Clipper is buggy and will throw an error if the number of
         columns is zero. (Check: dbEdit(0,0,20,20,{})) [vszakats] */
/* NOTE: Clipper will throw an error if there's no database open [vszakats] */
/* NOTE: The NG says that the return value is NIL, but it's not. [vszakats] */
/* NOTE: Harbour is multithreading ready and Clipper only reentrant safe
         [vszakats] */

FUNCTION dbEdit( nTop, nLeft, nBottom, nRight, ;
      acColumns, xUserFunc, ;
      xColumnSayPictures, xColumnHeaders, ;
      xHeadingSeparators, xColumnSeparators, ;
      xFootingSeparators, xColumnFootings )

   LOCAL nOldCUrsor, nKey, nKeyStd, lContinue, nPos, nAliasPos, nColCount
   LOCAL lDoIdleCall, lAppend, lFlag
   LOCAL cHeading, cBlock
   LOCAL bBlock
   LOCAL oBrowse
   LOCAL oColumn
   LOCAL aCol

   if ! Used()
      return .F.
   elseif Eof()
      dbGoBottom()
   endif

   if ! HB_ISNUMERIC( nTop ) .OR. nTop < 0
      nTop := 0
   endif
   if ! HB_ISNUMERIC( nLeft ) .OR. nLeft < 0
      nLeft := 0
   endif
   if ! HB_ISNUMERIC( nBottom ) .OR. nBottom > MaxRow() .OR. nBottom < nTop
      nBottom := MaxRow()
   endif
   if ! HB_ISNUMERIC( nRight ) .OR. nRight > MaxCol() .OR. nRight < nLeft
      nRight := MaxCol()
   endif

   oBrowse := TBrowseDB( nTop, nLeft, nBottom, nRight )
   oBrowse:headSep   := iif( HB_ISSTRING( xHeadingSeparators ), xHeadingSeparators, hb_UTF8ToStrBox( "═╤═" ) )
   oBrowse:colSep    := iif( HB_ISSTRING( xColumnSeparators ), xColumnSeparators, hb_UTF8ToStrBox( " │ " ) )
   oBrowse:footSep   := hb_default( @xFootingSeparators, "" )
   oBrowse:skipBlock := {| nRecs | Skipped( nRecs, lAppend ) }
   oBrowse:autoLite  := .F.  /* Set to .F. just like in CA-Cl*pper. [vszakats] */

   if HB_ISARRAY( acColumns )
      nColCount := 0
      FOR EACH aCol IN acColumns
         if HB_ISSTRING( aCol ) .AND. ! Empty( aCol )
            nColCount++
         else
            EXIT
         endif
      NEXT
   else
      nColCount := FCount()
   endif

   if nColCount == 0
      return .F.
   endif

   /* Generate the TBrowse columns */

   FOR nPos := 1 TO nColCount

      if HB_ISARRAY( acColumns )
         cBlock := acColumns[ nPos ]
         if ( nAliasPos := At( "->", cBlock ) ) > 0
            cHeading := Left( cBlock, nAliasPos - 1 ) + "->;" + ;
               SubStr( cBlock, nAliasPos + 2 )
         else
            cHeading := cBlock
         endif
      else
         cBlock := FieldName( nPos )
         cHeading := cBlock
      endif

      /* Simplified logic compared to CA-Cl*pper. In the latter there
         is logic to detect several typical cBlock types (memvar,
         aliased field, field) and using MemVarBlock()/FieldWBlock()/FieldBlock()
         calls to create codeblocks for them if possible. In Harbour,
         simple macro compilation will result in faster code for all
         situations. As Maurilio Longo has pointed, there is no point in
         creating codeblocks which are able to _assign_ values, as dbEdit()
         is a read-only function. [vszakats] */

      bBlock := iif( Type( cBlock ) == "M", {|| "  <Memo>  " }, hb_macroBlock( cBlock ) )

      DO CASE
      CASE HB_ISARRAY( xColumnHeaders ) .AND. Len( xColumnHeaders ) >= nPos .AND. HB_ISSTRING( xColumnHeaders[ nPos ] )
         cHeading := xColumnHeaders[ nPos ]
      CASE HB_ISSTRING( xColumnHeaders )
         cHeading := xColumnHeaders
      ENDCASE

      oColumn := TBColumnNew( cHeading, bBlock )

      DO CASE
      CASE HB_ISARRAY( xColumnSayPictures ) .AND. nPos <= Len( xColumnSayPictures ) .AND. HB_ISSTRING( xColumnSayPictures[ nPos ] ) .AND. ! Empty( xColumnSayPictures[ nPos ] )
         oColumn:picture := xColumnSayPictures[ nPos ]
      CASE HB_ISSTRING( xColumnSayPictures ) .AND. ! Empty( xColumnSayPictures )
         oColumn:picture := xColumnSayPictures
      ENDCASE

      DO CASE
      CASE HB_ISARRAY( xColumnFootings ) .AND. nPos <= Len( xColumnFootings ) .AND. HB_ISSTRING( xColumnFootings[ nPos ] )
         oColumn:footing := xColumnFootings[ nPos ]
      CASE HB_ISSTRING( xColumnFootings )
         oColumn:footing := xColumnFootings
      ENDCASE

      if HB_ISARRAY( xHeadingSeparators ) .AND. nPos <= Len( xHeadingSeparators ) .AND. HB_ISSTRING( xHeadingSeparators[ nPos ] )
         oColumn:headSep := xHeadingSeparators[ nPos ]
      endif

      if HB_ISARRAY( xColumnSeparators ) .AND. nPos <= Len( xColumnSeparators ) .AND. HB_ISSTRING( xColumnSeparators[ nPos ] )
         oColumn:colSep := xColumnSeparators[ nPos ]
      endif

      if HB_ISARRAY( xFootingSeparators ) .AND. nPos <= Len( xFootingSeparators ) .AND. HB_ISSTRING( xFootingSeparators[ nPos ] )
         oColumn:footSep := xFootingSeparators[ nPos ]
      endif

      oBrowse:addColumn( oColumn )
   NEXT

   nOldCUrsor := SetCursor( SC_NONE )

   /* Go into the processing loop */

   lAppend := .F.
   lFlag := .T.
   lDoIdleCall := .T.
   lContinue := .T.

   DO WHILE lContinue

      DO while( true )
         nKeyStd := hb_keyStd( Inkey(, hb_bitOr( Set( _SET_EVENTMASK ), HB_INKEY_EXT ) ) )
         if oBrowse:stabilize()
            EXIT
         endif
#ifdef HB_COMPAT_C53
         if nKeyStd != 0 .AND. nKeyStd != K_MOUSEMOVE
            EXIT
         endif
#else
         if nKeyStd != 0
            EXIT
         endif
#endif
      ENDDO

      if nKeyStd == 0
         if lDoIdleCall
            lContinue := CallUser( oBrowse, xUserFunc, 0, @lAppend, @lFlag )
            oBrowse:forceStable()
         endif
         if lContinue .AND. lFlag
            oBrowse:hiLite()
#ifdef HB_COMPAT_C53
            DO WHILE ( nKeyStd := hb_keyStd( nKey := Inkey( 0, hb_bitOr( Set( _SET_EVENTMASK ), HB_INKEY_EXT ) ) ) ) == K_MOUSEMOVE
            ENDDO
#else
            nKeyStd := hb_keyStd( nKey := Inkey( 0, hb_bitOr( Set( _SET_EVENTMASK ), HB_INKEY_EXT ) ) )
#endif
            oBrowse:deHilite()
            if ( bBlock := SetKey( nKey ) ) != NIL .OR. ;
               ( bBlock := SetKey( nKeyStd ) ) != NIL
               Eval( bBlock, ProcName( 1 ), ProcLine( 1 ), "" )
               LOOP
            endif
         else
            lFlag := .T.
         endif
      endif

      lDoIdleCall := .T.

      if nKeyStd != 0
#ifdef HB_CLP_UNDOC
         if lAppend
            SWITCH nKeyStd
            CASE K_DOWN
            CASE K_PGDN
            CASE K_CTRL_PGDN
               oBrowse:hitBottom := .T.
               LOOP
            CASE K_UP
            CASE K_PGUP
            CASE K_CTRL_PGUP
               oBrowse:hitTop := .T.
               LOOP
            ENDSWITCH
         endif
#endif
         SWITCH nKeyStd
#ifdef HB_COMPAT_C53
         CASE K_LBUTTONDOWN
         CASE K_LDBLCLK
            TBMouse( oBrowse, MRow(), MCol() )
            EXIT
#endif
         CASE K_DOWN          ; oBrowse:down()     ; EXIT
         CASE K_UP            ; oBrowse:up()       ; EXIT
         CASE K_PGDN          ; oBrowse:pageDown() ; EXIT
         CASE K_PGUP          ; oBrowse:pageUp()   ; EXIT
         CASE K_CTRL_PGUP     ; oBrowse:goTop()    ; EXIT
         CASE K_CTRL_PGDN     ; oBrowse:goBottom() ; EXIT
         CASE K_RIGHT         ; oBrowse:right()    ; EXIT
         CASE K_LEFT          ; oBrowse:left()     ; EXIT
         CASE K_HOME          ; oBrowse:home()     ; EXIT
         CASE K_END           ; oBrowse:end()      ; EXIT
         CASE K_CTRL_LEFT     ; oBrowse:panLeft()  ; EXIT
         CASE K_CTRL_RIGHT    ; oBrowse:panRight() ; EXIT
         CASE K_CTRL_HOME     ; oBrowse:panHome()  ; EXIT
         CASE K_CTRL_END      ; oBrowse:panEnd()   ; EXIT
         OTHERWISE
            lContinue := CallUser( oBrowse, xUserFunc, nKeyStd, @lAppend, @lFlag )
            lDoIdleCall := .F.
         ENDSWITCH
      endif
   ENDDO

   SetCursor( nOldCUrsor )

   return .T.


/* NOTE: CA-Cl*pper uses intermediate function CallUser()
         to execute user function. We're replicating this behavior
         for code which may check ProcName() results in user function */
STATIC FUNCTION CallUser( oBrowse, xUserFunc, nKeyStd, lAppend, lFlag )

   LOCAL nPrevRecNo

   LOCAL nAction
   LOCAL nMode := ;
      iif( nKeyStd != 0,                DE_EXCEPT, ;
      iif( ! lAppend .AND. IsDbEmpty(), DE_EMPTY, ;
      iif( oBrowse:hitBottom,           DE_HITBOTTOM, ;
      iif( oBrowse:hitTop,              DE_HITTOP, DE_IDLE ) ) ) )

   oBrowse:forceStable()

   nPrevRecNo := RecNo()

   /* NOTE: CA-Cl*pper won't check the type of the return value here,
            and will crash if it's a non-NIL, non-numeric type. We're
            replicating this behavior. */
   nAction := ;
      iif( HB_ISEVALITEM( xUserFunc ), Eval( xUserFunc, nMode, oBrowse:colPos ), ;
      iif( HB_ISSTRING( xUserFunc ) .AND. ! Empty( xUserFunc ), &xUserFunc( nMode, oBrowse:colPos ), ;  /* NOTE: Macro operator! */
      iif( nKeyStd == K_ENTER .OR. nKeyStd == K_ESC, DE_ABORT, DE_CONT ) ) )

   if ! lAppend .AND. Eof() .AND. ! IsDbEmpty()
      dbSkip( -1 )
   endif

	
#ifdef HB_CLP_UNDOC

   P_DEF( nAction, 1)  // Evitar a merda de erro de retorno
   if nAction == DE_APPEND

      if ( lAppend := !( lAppend .AND. Eof() ) )
         dbGoBottom()
         oBrowse:down()
      else
         oBrowse:refreshAll():forceStable()
      endif
      lFlag := .F.
      return .T.
   endif
#endif

   if nAction == DE_REFRESH .OR. nPrevRecNo != RecNo()

      if nAction != DE_ABORT

         lAppend := .F.

         if ( Set( _SET_DELETED ) .AND. Deleted() ) .OR. ;
            ( ! Empty( dbFilter() ) .AND. ! Eval( hb_macroBlock( dbFilter() ) ) )
            dbSkip()
         endif
         if Eof()
            dbGoBottom()
         endif

         nPrevRecNo := RecNo()
         oBrowse:refreshAll():forceStable()
         DO WHILE nPrevRecNo != RecNo()
            oBrowse:Up():forceStable()
         ENDDO

         lFlag := .F.

      endif
   else
      oBrowse:refreshCurrent()
   endif

   return nAction != DE_ABORT


/* helper function to detect empty tables. It's not perfect but
   it functionally uses the same conditions as CA-Cl*pper */
STATIC FUNCTION IsDbEmpty()
   return LastRec() == 0 .OR. ;
      ( Bof() .AND. ( Eof() .OR. RecNo() == LastRec() + 1 ) )

/* Helper function: TBrowse skipBlock */
STATIC FUNCTION Skipped( nRecs, lAppend )

   LOCAL nSkipped := 0

   if LastRec() != 0
      DO CASE
      CASE nRecs == 0
         if Eof() .AND. ! lAppend
            dbSkip( -1 )
            nSkipped := -1
         else
            dbSkip( 0 )
         endif
      CASE nRecs > 0 .AND. RecNo() != LastRec() + 1
         DO WHILE nSkipped < nRecs
            dbSkip()
            if Eof()
               if lAppend
                  nSkipped++
               else
                  dbSkip( -1 )
               endif
               EXIT
            endif
            nSkipped++
         ENDDO
      CASE nRecs < 0
         DO WHILE nSkipped > nRecs
            dbSkip( -1 )
            if Bof()
               EXIT
            endif
            nSkipped--
         ENDDO
      ENDCASE
   endif

   return nSkipped
