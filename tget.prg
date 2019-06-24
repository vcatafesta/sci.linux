*
* Tget Class
*
* Copyright 2007-2018 Vilmar Catafesta [vcatafesta@gmail.com]
*
* °°°±±²²²ÛÛÛ
*

#include "hbclass.ch"
#include "hblang.ch"

#include "color.ch"
#include "setcurs.ch"
#include "getexit.ch"
#include "inkey.ch"
#include "button.ch"

/* TOFIX: ::Minus [vszakats] */

#define GET_CLR_UNSELECTED      0
#define GET_CLR_ENHANCED        1
#define GET_CLR_CAPTION         2
#define GET_CLR_ACCEL           3

/* NOTE: In CA-Cl*pper, TGET class does not inherit from any other classes. */

CREATE CLASS Get

   PROTECTED:

   /* === Start of CA-Cl*pper compatible TGet instance area === */
   VAR bBlock                           /* 01. */
   VAR xSubScript                       /* 02. */
   VAR cPicture                         /* 03. */
   VAR bPostBlock                       /* 04. */
   VAR bPreBlock                        /* 05. */
   VAR xCargo                           /* 06. */
   VAR cName                            /* 07. */
   VAR cInternal1     HIDDEN            /* 08. U2Bin( ::nRow ) + U2Bin( ::nCol ) + trash. Not implemented in Harbour. */
   VAR xExitState                       /* 09. */
   VAR bReader                          /* 10. */
#ifdef HB_COMPAT_C53
   VAR oControl                         /* 11. CA-Cl*pper 5.3 only. */
   VAR cCaption                 INIT "" /* 12. CA-Cl*pper 5.3 only. */
   VAR nCapCol                  INIT 0  /* 13. CA-Cl*pper 5.3 only. */
   VAR nCapRow                  INIT 0  /* 14. CA-Cl*pper 5.3 only. */
   VAR cMessage                 INIT "" /* 15. CA-Cl*pper 5.3 only. */
   VAR nDispLen                         /* 16. CA-Cl*pper 5.3 places it here. */
#endif
   //VAR cType                            /* +1. Only accessible in CA-Cl*pper when ::hasFocus == .T. In CA-Cl*pper the field may contain random chars after the first one, which is the type. */
   VAR cBuffer                          /* +2. Only accessible in CA-Cl*pper when ::hasFocus == .T. */
   VAR xVarGet                          /* +3. Only accessible in CA-Cl*pper when ::hasFocus == .T. */
   /* === End of CA-Cl*pper compatible TGet instance area === */

   EXPORTED:
   VAR cType 
	VAR lHideInput     INIT .F.
   VAR cStyle         INIT "*" 
   VAR decPos         INIT 0   READONLY /* CA-Cl*pper NG says that it contains NIL, but in fact it contains zero. [vszakats] */
   VAR hasFocus       INIT .F. READONLY
   VAR original                READONLY
   VAR rejected       INIT .F. READONLY
   VAR typeOut        INIT .F. READONLY

   METHOD New( nRow, nCol, bVarBlock, cVarName, cPicture, cColorSpec ) /* NOTE: This method is a Harbour extension [vszakats] */

   METHOD assign()
   METHOD badDate()
   METHOD block( bBlock ) SETGET
   ACCESS buffer METHOD getBuffer()
   ASSIGN buffer METHOD setBuffer( cBuffer )

   ACCESS changed METHOD getChanged()
   ASSIGN changed METHOD setChanged( lChanged )

   ACCESS clear METHOD getClear()
   ASSIGN clear METHOD setClear( lClear )
   ACCESS col METHOD getCol()
   ASSIGN col METHOD setCol( nCol )
   METHOD colorDisp( cColorSpec )
   ACCESS colorSpec METHOD getColorSpec()
   ASSIGN colorSpec METHOD setColorSpec( cColorSpec )
   METHOD display()
#ifdef HB_COMPAT_C53
   METHOD hitTest( nMRow, nMCol )
   METHOD control( oControl ) SETGET    /* NOTE: Undocumented CA-Cl*pper 5.3 method. */
   METHOD message( cMessage ) SETGET    /* NOTE: Undocumented CA-Cl*pper 5.3 method. */
   METHOD caption( cCaption ) SETGET    /* NOTE: Undocumented CA-Cl*pper 5.3 method. */
   METHOD capRow( nCapRow ) 	SETGET    /* NOTE: Undocumented CA-Cl*pper 5.3 method. */
   METHOD capCol( nCapCol ) 	SETGET     /* NOTE: Undocumented CA-Cl*pper 5.3 method. */
#endif
   METHOD killFocus()
   ACCESS minus METHOD getMinus()
   ASSIGN minus METHOD setMinus( lMinus )
   METHOD name( cName ) SETGET
   METHOD picture( cPicture ) SETGET
   ACCESS pos METHOD getPos()
   ASSIGN pos METHOD setPos( nPos )
#ifdef HB_CLP_UNDOC
   METHOD reform()
#endif
   METHOD reset()
   ACCESS row METHOD getRow()
   ASSIGN row METHOD setRow( nRow )
   METHOD setFocus()
   METHOD type()
   METHOD undo()
   METHOD unTransform()
   METHOD updateBuffer()
   METHOD varGet()
   METHOD varPut( xValue )

   METHOD end()
   METHOD home()
   METHOD left()
   METHOD right()
   METHOD toDecPos()
   METHOD wordLeft()
   METHOD wordRight()

   METHOD backSpace()
   METHOD delete()
   METHOD delEnd()
   METHOD delLeft()
   METHOD delRight()
   METHOD delWordLeft()
   METHOD delWordRight()

   METHOD insert( cChar )
   METHOD overStrike( cChar )

   METHOD subScript( xValue ) SETGET
   METHOD postBlock( xValue ) SETGET
   METHOD preBlock( xValue ) SETGET
   METHOD cargo( xValue ) SETGET
   METHOD exitState( xValue ) SETGET
   METHOD reader( xValue ) SETGET

   PROTECTED:

#ifndef HB_COMPAT_C53
   VAR nDispLen                /* NOTE: This one is placed inside the instance area for CA-Cl*pper 5.3 [vszakats] */
#endif
   VAR cColorSpec
   VAR nPos           INIT 0
   VAR lChanged       INIT .F.
   VAR lClear         INIT .F.
   VAR nRow
   VAR nCol
   VAR lRejected      INIT .F.
   //VAR lHideInput     INIT .F.
   //VAR cStyle         INIT "*" /* NOTE: First char is to be used as mask character when :hideInput is .T. [vszakats] */
   VAR nMaxLen
   VAR lEdit          INIT .F.
   VAR nDispPos       INIT 1
   VAR nOldPos        INIT 0
   VAR nMaxEdit
   VAR lMinus         INIT .F.
   VAR lMinus2        INIT .F.
   VAR lMinusPrinted  INIT .F.
   VAR lSuppDisplay   INIT .F.

   VAR nPicLen
   VAR cPicMask       INIT ""
   VAR cPicFunc       INIT ""
   VAR lPicComplex    INIT .F.
   VAR lPicBlankZero  INIT .F.

   METHOD leftLow()
   METHOD rightLow()
   METHOD backSpaceLow()
   METHOD deleteLow()

   METHOD DeleteAll()
   METHOD IsEditable( nPos )
   METHOD Input( cChar )
   METHOD PutMask( xValue, lEdit )
   METHOD FirstEditable()
   METHOD LastEditable()

ENDCLASS

METHOD assign() CLASS Get

   LOCAL xValue

   if ::hasFocus
      xValue := ::unTransform()
      if ::cType == "C"
         xValue += SubStr( ::original, Len( xValue ) + 1 )
      endif
      ::varPut( xValue )
   endif

   return Self

METHOD updateBuffer() CLASS Get

   if ::hasFocus
      ::cBuffer := ::PutMask( ::varGet() )
      ::xVarGet := ::original
      ::display()
   else
      ::varGet()
   endif

   return Self

METHOD display() CLASS Get

   LOCAL nOldCursor := SetCursor( SC_NONE )
   LOCAL cBuffer
   LOCAL nDispPos
   LOCAL nRowPos
   LOCAL nColPos

#ifdef HB_COMPAT_C53
   LOCAL nPos
   LOCAL cCaption
#endif

   if ::hasFocus
      cBuffer   := ::cBuffer
   else
      ::cType   := ValType( ::xVarGet := ::varGet() )
      ::picture := ::cPicture
      cBuffer   := ::PutMask( ::xVarGet )
   endif

   ::nMaxLen := Len( cBuffer )
   ::nDispLen := iif( ::nPicLen == NIL, ::nMaxLen, ::nPicLen )

   if ::cType == "N" .AND. ::hasFocus .AND. ! ::lMinusPrinted .AND. ;
      ::decPos != 0 .AND. ::lMinus2 .AND. ;
      ::nPos > ::decPos .AND. Val( Left( cBuffer, ::decPos - 1 ) ) == 0

      /* Display "-." only in case when value on the left side of
         the decimal point is equal 0 */
      cBuffer := Stuff( cBuffer, ::decPos - 1, 2, "-." )
   endif

   if ::nDispLen != ::nMaxLen .AND. ::nPos != 0 /* has scroll? */
      if ::nDispLen > 8
         nDispPos := Max( 1, Min( ::nPos - ::nDispLen + 4       , ::nMaxLen - ::nDispLen + 1 ) )
      else
         nDispPos := Max( 1, Min( ::nPos - Int( ::nDispLen / 2 ), ::nMaxLen - ::nDispLen + 1 ) )
      endif
   else
      nDispPos := 1
   endif

#ifdef HB_COMPAT_C53

   /* Handle C5.3 caption. */

   if ! Empty( ::cCaption )

      cCaption := ::cCaption
      if ( nPos := At( "&", cCaption ) ) > 0
         if nPos == Len( cCaption )
            nPos := 0
         else
            cCaption := Stuff( cCaption, nPos, 1, "" )
         endif
      endif

      hb_DispOutAt( ::nCapRow, ::nCapCol, cCaption, hb_ColorIndex( ::cColorSpec, GET_CLR_CAPTION ) )
      if nPos > 0
         hb_DispOutAt( ::nCapRow, ::nCapCol + nPos - 1, SubStr( cCaption, nPos, 1 ), hb_ColorIndex( ::cColorSpec, GET_CLR_ACCEL ) )
      endif

      /* should we set fixed cursor position here?
       * The above code which can left cursor in the middle of shown screen
       * suggests that we shouldn't. if necessary please fix me.
       */
      /*
      nRowPos := ::nCapRow
      nColPos := ::nCapCol + Len( cCaption )
      */

   endif

#endif

   /* Display the GET */

   if ! ::lSuppDisplay .OR. nDispPos != ::nOldPos

      hb_DispOutAt( ::nRow, ::nCol, ;
                    iif( ::lHideInput, PadR( Replicate( Left( ::cStyle, 1 ), Len( RTrim( cBuffer ) ) ), ::nDispLen ), SubStr( cBuffer, nDispPos, ::nDispLen ) ), ;
                    hb_ColorIndex( ::cColorSpec, iif( ::hasFocus, GET_CLR_ENHANCED, GET_CLR_UNSELECTED ) ) )

      nRowPos := ::nRow
      nColPos := ::nCol + Min( ::nDispLen, Len( cBuffer ) )

      if Set( _SET_DELIMITERS ) .AND. ! ::hasFocus
#ifdef HB_COMPAT_C53
         hb_DispOutAt( nRowPos, ::nCol - 1, SubStr( Set( _SET_DELIMCHARS ), 1, 1 ), hb_ColorIndex( ::cColorSpec, GET_CLR_UNSELECTED ) )
         hb_DispOutAt( nRowPos, nColPos   , SubStr( Set( _SET_DELIMCHARS ), 2, 1 ), hb_ColorIndex( ::cColorSpec, GET_CLR_UNSELECTED ) )
#else
         /* NOTE: C5.2 will use the default color. We're replicating this here. [vszakats] */
         hb_DispOutAt( nRowPos, ::nCol - 1, SubStr( Set( _SET_DELIMCHARS ), 1, 1 ) )
         hb_DispOutAt( nRowPos, nColPos   , SubStr( Set( _SET_DELIMCHARS ), 2, 1 ) )
#endif
         ++nColPos
      endif
   endif

   if ::nPos != 0
      SetPos( ::nRow, ::nCol + ::nPos - nDispPos )
   elseif nRowPos != NIL
      SetPos( nRowPos, nColPos )
   endif

   ::nOldPos := nDispPos
   ::lSuppDisplay := .F.

   SetCursor( nOldCursor )

   return Self

/* ------------------------------------------------------------------------- */

METHOD colorDisp( cColorSpec ) CLASS Get

   ::colorSpec := cColorSpec
   ::display()

   return Self

METHOD end() CLASS Get

   LOCAL nLastCharPos
   LOCAL nPos
   LOCAL nFor

   if ::hasFocus
      nLastCharPos := Len( RTrim( ::cBuffer ) ) + 1
      /* check for spaces before non-template chars */
      if nLastCharPos > 2 .AND. ! ::IsEditable( nLastCharPos - 1 )
         FOR nFor := nLastCharPos - 2 TO ::FirstEditable() STEP -1
            if ::IsEditable( nFor )
               if Empty( SubStr( ::cBuffer, nFor, 1 ) )
                  nLastCharPos := nFor
               else
                  EXIT
               endif
            endif
         NEXT
      endif
      nLastCharPos := Min( nLastCharPos, ::nMaxEdit )
      if ::nPos < nLastCharPos .OR. ::nPos == ::LastEditable()
         nPos := nLastCharPos
      else
         nPos := ::nMaxEdit
      endif
      FOR nFor := nPos TO ::FirstEditable() STEP -1
         if ::IsEditable( nFor )
            ::pos := nFor
            EXIT
         endif
      NEXT
      ::lClear := .F.
      ::typeOut := ( ::nPos == 0 )
      ::lSuppDisplay := .T.
      ::display()
   endif

   return Self

METHOD home() CLASS Get

   if ::hasFocus
      ::pos := ::FirstEditable()
      ::lClear := .F.
      ::typeOut := ( ::nPos == 0 )
      ::lSuppDisplay := .T.
      ::display()
   endif

   return Self

METHOD reset() CLASS Get

   if ::hasFocus
      ::cBuffer  := ::PutMask( ::varGet(), .F. )
      ::xVarGet  := ::original
      ::cType    := ValType( ::xVarGet )
      ::pos      := ::FirstEditable() /* Simple 0 in CA-Cl*pper [vszakats] */
      ::lClear   := ( "K" $ ::cPicFunc .OR. ::cType == "N" )
      ::lEdit    := .F.
      ::lMinus   := .F.
      ::rejected := .F.
      ::typeOut  := !( ::type $ "CNDTL" ) .OR. ( ::nPos == 0 ) /* Simple .F. in CA-Cl*pper [vszakats] */
      ::display()
   endif

   return Self

METHOD undo() CLASS Get

   if ::hasFocus
      if ::original != NIL
         ::varPut( ::original )
      endif
      ::reset()
      ::lChanged := .F.
   endif

   return Self

METHOD setFocus() CLASS Get

   LOCAL xVarGet

   if ! ::hasFocus

      xVarGet := ::xVarGet := ::varGet()

      ::hasFocus := .T.
      ::rejected := .F.

      ::original := xVarGet
      ::cType    := ValType( xVarGet )
      ::picture  := ::cPicture
      ::cBuffer  := ::PutMask( xVarGet, .F. )

      ::lChanged := .F.
      ::lClear   := ( "K" $ ::cPicFunc .OR. ::cType == "N" )
      ::lEdit    := .F.
      ::pos      := 1

      ::lMinusPrinted := .F.
      ::lMinus        := .F.

      if ::cType == "N"
         ::decPos := At( iif( "E" $ ::cPicFunc, ",", "." ), ::cBuffer )
         if ::decPos == 0
            ::decPos := Len( ::cBuffer ) + 1
         endif
         ::lMinus2 := ( ::xVarGet < 0 )
      else
         ::decPos := 0 /* CA-Cl*pper NG says that it contains NIL, but in fact it contains zero. [vszakats] */
      endif

      ::display()
   endif

   return Self

METHOD killFocus() CLASS Get

   LOCAL lHadFocus := ::hasFocus

   ::hasFocus := .F.
   ::nPos     := 0
   ::lClear   := .F.
   ::lMinus   := .F.
   ::lChanged := .F.
   ::decPos   := 0 /* CA-Cl*pper NG says that it contains NIL, but in fact it contains zero. [vszakats] */
   ::typeOut  := .F.

   if lHadFocus
      ::display()
   endif

   ::xVarGet  := NIL
   ::original := NIL
   ::cBuffer  := NIL

   return Self

METHOD varPut( xValue ) CLASS Get

   LOCAL aSubs
   LOCAL nLen
   LOCAL i
   LOCAL aValue

   if HB_ISEVALITEM( ::bBlock ) .AND. ValType( xValue ) $ "CNDTLU"
      aSubs := ::xSubScript
      if HB_ISARRAY( aSubs ) .AND. ! Empty( aSubs )
         nLen := Len( aSubs )
         aValue := Eval( ::bBlock )
         FOR i := 1 TO nLen - 1
            if HB_ISNUMERIC( aSubs[ i ] ) .OR. ;
               ( HB_ISHASH( aValue ) .AND. ValType( aSubs[ i ] ) $ "CDT" )
               aValue := aValue[ aSubs[ i ] ]
            else
               EXIT
            endif
         NEXT
         if HB_ISNUMERIC( aSubs[ i ] ) .OR. ;
            ( HB_ISHASH( aValue ) .AND. ValType( aSubs[ i ] ) $ "CDT" )
            aValue[ aSubs[ i ] ] := xValue
         endif
      else
         Eval( ::bBlock, xValue )
      endif
   else
      xValue := NIL
   endif

   return xValue

METHOD varGet() CLASS Get

   LOCAL aSubs
   LOCAL nLen
   LOCAL i
   LOCAL xValue

   if HB_ISEVALITEM( ::bBlock )
      aSubs := ::xSubScript
      if HB_ISARRAY( aSubs ) .AND. ! Empty( aSubs )
         nLen := Len( aSubs )
         xValue := Eval( ::bBlock )
         FOR i := 1 TO nLen
            if HB_ISNUMERIC( aSubs[ i ] ) .OR. ;
               ( HB_ISHASH( xValue ) .AND. ValType( aSubs[ i ] ) $ "CDT" )
               xValue := xValue[ aSubs[ i ] ]
            else
               EXIT
            endif
         NEXT
      else
         xValue := Eval( ::bBlock )
      endif
   else
      xValue := ::xVarGet
   endif

   return xValue

/* NOTE: CA-Cl*pper will corrupt memory if cChar contains
         multiple chars. [vszakats] */

METHOD overStrike( cChar ) CLASS Get

   if ::hasFocus .AND. HB_ISSTRING( cChar )

      if ::cType == "N" .AND. ! ::lEdit .AND. ::lClear
         ::pos := ::FirstEditable()
      endif

      if ::pos <= ::nMaxEdit

         cChar := ::Input( Left( cChar, 1 ) )

         if cChar == ""
            ::rejected := .T.
         else
            ::rejected := .F.

            if ::lClear .AND. ::nPos == ::FirstEditable()
               ::DeleteAll()
               ::lClear := .F.
            endif

            ::lEdit := .T.

            if ::nPos == 0
               ::pos := 1
            endif

            DO WHILE ! ::IsEditable( ::nPos ) .AND. ::nPos <= ::nMaxEdit .AND. ! ::typeOut
               ::pos++
            ENDDO

            if ::nPos > ::nMaxEdit
               ::pos := ::FirstEditable()
            endif
            ::cBuffer := Stuff( ::cBuffer, ::nPos, 1, cChar )

            ::lChanged := .T.

            ::rightLow()
         endif
      endif

      ::display()
   endif

   return Self

/* NOTE: CA-Cl*pper will corrupt memory if cChar contains
         multiple chars. [vszakats] */

METHOD insert( cChar ) CLASS Get

   LOCAL nFor
   LOCAL nMaxEdit

   if ::hasFocus .AND. HB_ISSTRING( cChar )

      nMaxEdit := ::nMaxEdit

      if ::cType == "N" .AND. ! ::lEdit .AND. ::lClear
         ::pos := ::FirstEditable()
      endif

      if ::nPos <= ::nMaxEdit

         cChar := ::Input( Left( cChar, 1 ) )

         if cChar == ""
            ::rejected := .T.
         else
            ::rejected := .F.

            if ::lClear .AND. ::nPos == ::FirstEditable()
               ::DeleteAll()
               ::lClear := .F.
            endif

            ::lEdit := .T.

            if ::nPos == 0
               ::pos := 1
            endif

            DO WHILE ! ::IsEditable( ::nPos ) .AND. ::nPos <= ::nMaxEdit .AND. ! ::typeOut
               ::pos++
            ENDDO

            if ::nPos > ::nMaxEdit
               ::pos := ::FirstEditable()
            endif

            if ::lPicComplex
               /* Calculating different nMaxEdit for ::lPicComplex */
               FOR nFor := ::nPos TO nMaxEdit
                  if ! ::IsEditable( nFor )
                     EXIT
                  endif
               NEXT
               nMaxEdit := nFor
               ::cBuffer := Left( Stuff( Left( ::cBuffer, nMaxEdit - 2 ), ::nPos, 0, cChar ) + ;
                                  SubStr( ::cBuffer, nMaxEdit ), ::nMaxLen )
            else
               ::cBuffer := Left( Stuff( ::cBuffer, ::nPos, 0, cChar ), ::nMaxEdit )
            endif

            ::lChanged := .T.

            ::rightLow()
         endif
      endif

      ::display()
   endif

   return Self

METHOD right() CLASS Get

   if ::hasFocus .AND. ;
      ::rightLow()

      ::lSuppDisplay := .T.
      ::display()
   endif

   return Self

METHOD left() CLASS Get

   if ::hasFocus .AND. ;
      ::leftLow()

      ::lSuppDisplay := .T.
      ::display()
   endif

   return Self

METHOD wordLeft() CLASS Get

   LOCAL nPos

   if ::hasFocus

      ::lClear := .F.

      if ::nPos == ::FirstEditable()
         ::typeOut := .T.
      else
         ::typeOut := .F.

         nPos := iif( SubStr( ::cBuffer, ::nPos, 1 ) == " ", ::nPos, ::nPos - 1 )

         DO WHILE nPos > 1 .AND. SubStr( ::cBuffer, nPos, 1 ) == " "
            nPos--
         ENDDO
         DO WHILE nPos > 1 .AND. !( SubStr( ::cBuffer, nPos, 1 ) == " " )
            nPos--
         ENDDO

         ::pos := iif( nPos > 1, nPos + 1, 1 )

         ::lSuppDisplay := .T.
         ::display()
      endif
   endif

   return Self

METHOD wordRight() CLASS Get

   LOCAL nPos

   if ::hasFocus

      ::lClear := .F.

      if ::nPos == ::nMaxEdit
         ::typeOut := .T.
      else
         ::typeOut := .F.

         nPos := ::nPos

         DO WHILE nPos < ::nMaxEdit .AND. !( SubStr( ::cBuffer, nPos, 1 ) == " " )
            nPos++
         ENDDO
         DO WHILE nPos < ::nMaxEdit .AND. SubStr( ::cBuffer, nPos, 1 ) == " "
            nPos++
         ENDDO

         ::pos := nPos

         ::lSuppDisplay := .T.
         ::display()
      endif
   endif

   return Self

METHOD toDecPos() CLASS Get

   if ::hasFocus

      if ::lClear
         ::delEnd()
      endif

      ::cBuffer := ::PutMask( ::unTransform(), .F. )
      ::pos := ::decPos
      ::lChanged := .T.

      if ::type == "N" .AND. ::lMinus .AND. ::unTransform() == 0
         ::backSpace()
         ::overStrike( "-" )
      endif

      ::display()
   endif

   return Self

METHOD backSpace() CLASS Get

   if ::hasFocus .AND. ;
      ::backSpaceLow()

      ::display()
   endif

   return Self

METHOD delete() CLASS Get

   if ::hasFocus
      ::deleteLow()
      ::display()
   endif

   return Self

METHOD delEnd() CLASS Get

   LOCAL nPos

   if ::hasFocus

      nPos := ::nPos
      ::pos := ::nMaxEdit

      ::deleteLow()
      DO WHILE ::nPos > nPos
         ::backSpaceLow()
      ENDDO

      ::display()
   endif

   return Self

METHOD delLeft() CLASS Get

   ::leftLow()
   ::deleteLow()
   ::right()

   return Self

METHOD delRight() CLASS Get

   ::rightLow()
   ::deleteLow()
   ::left()

   return Self

/* ::wordLeft()
   ::delWordRight() */

METHOD delWordLeft() CLASS Get

   if ::hasFocus

      if !( SubStr( ::cBuffer, ::nPos, 1 ) == " " )
         if SubStr( ::cBuffer, ::nPos - 1, 1 ) == " "
            ::backSpaceLow()
         else
            ::wordRight()
            ::left()
         endif
      endif

      if SubStr( ::cBuffer, ::nPos, 1 ) == " "
         ::deleteLow()
      endif

      DO WHILE ::nPos > 1 .AND. !( SubStr( ::cBuffer, ::nPos - 1, 1 ) == " " )
         ::backSpaceLow()
      ENDDO

      ::display()
   endif

   return Self

METHOD delWordRight() CLASS Get

   if ::hasFocus

      ::lClear := .F.

      if ::nPos == ::nMaxEdit
         ::typeOut := .T.
      else
         ::typeOut := .F.

         DO WHILE ::nPos <= ::nMaxEdit .AND. !( SubStr( ::cBuffer, ::nPos, 1 ) == " " )
            ::deleteLow()
         ENDDO

         if ::nPos <= ::nMaxEdit
            ::deleteLow()
         endif

         ::display()
      endif
   endif

   return Self

/* The METHOD ColorSpec and VAR cColorSpec allow to replace the
 * property ColorSpec for a function to control the content and
 * to carry out certain actions to normalize the data.
 * The particular case is that the function receives a single color and
 * be used for GET_CLR_UNSELECTED and GET_CLR_ENHANCED.
 */

METHOD getColorSpec() CLASS Get
   return ::cColorSpec

METHOD setColorSpec( cColorSpec ) CLASS Get

   LOCAL nClrUns
   LOCAL nClrOth

   if HB_ISSTRING( cColorSpec )

#ifdef HB_COMPAT_C53
      ::cColorSpec := hb_NToColor( nClrUns := Max( hb_ColorToN( hb_ColorIndex( cColorSpec, GET_CLR_UNSELECTED ) ), 0 ) ) + ;
                      "," + hb_NToColor( iif( ( nClrOth := hb_ColorToN( hb_ColorIndex( cColorSpec, GET_CLR_ENHANCED ) ) ) != -1, nClrOth, nClrUns ) ) + ;
                      "," + hb_NToColor( iif( ( nClrOth := hb_ColorToN( hb_ColorIndex( cColorSpec, GET_CLR_CAPTION  ) ) ) != -1, nClrOth, nClrUns ) ) + ;
                      "," + hb_NToColor( iif( ( nClrOth := hb_ColorToN( hb_ColorIndex( cColorSpec, GET_CLR_ACCEL    ) ) ) != -1, nClrOth, nClrUns ) )
#else
      ::cColorSpec := hb_NToColor( nClrUns := Max( hb_ColorToN( hb_ColorIndex( cColorSpec, GET_CLR_UNSELECTED ) ), 0 ) ) + ;
                      "," + hb_NToColor( iif( ( nClrOth := hb_ColorToN( hb_ColorIndex( cColorSpec, GET_CLR_ENHANCED ) ) ) != -1, nClrOth, nClrUns ) )
#endif

   /* NOTE: CA-Cl*pper oddity. [vszakats] */
   elseif ValType( cColorSpec ) $ "UNDTBA"

      return NIL

#ifdef HB_COMPAT_C53
   /* NOTE: This code doesn't seem to make any sense, but seems to
            replicate some original C5.3 behaviour. */
   else
      if Set( _SET_INTENSITY )
         ::cColorSpec := ;
            hb_ColorIndex( SetColor(), CLR_UNSELECTED ) + "," + ;
            hb_ColorIndex( SetColor(), CLR_ENHANCED ) + "," + ;
            hb_ColorIndex( SetColor(), CLR_STANDARD ) + "," + ;
            hb_ColorIndex( SetColor(), CLR_BACKGROUND )
      else
         ::cColorSpec := ;
            hb_ColorIndex( SetColor(), CLR_STANDARD ) + "," + ;
            hb_ColorIndex( SetColor(), CLR_STANDARD ) + "," + ;
            hb_ColorIndex( SetColor(), CLR_STANDARD ) + "," + ;
            hb_ColorIndex( SetColor(), CLR_STANDARD )
      endif
#endif
   endif

   return cColorSpec

METHOD getPos() CLASS Get
   return ::nPos

METHOD setPos( nPos ) CLASS Get

   LOCAL tmp

   if HB_ISNUMERIC( nPos )

      nPos := Int( nPos )

      if ::hasFocus

         DO CASE
         CASE nPos > ::nMaxLen

            ::nPos := iif( ::nMaxLen == 0, 1, ::nMaxLen )
            ::typeOut := .T.

         CASE nPos > 0

            /* NOTE: CA-Cl*pper has a bug where negative nPos value will be translated to 16bit unsigned int,
                     so the behaviour will be different in this case. [vszakats] */

            FOR tmp := nPos TO ::nMaxLen
               if ::IsEditable( tmp )
                  ::nPos := tmp
                  return nPos
               endif
            NEXT
            FOR tmp := nPos - 1 TO 1 STEP -1
               if ::IsEditable( tmp )
                  ::nPos := tmp
                  return nPos
               endif
            NEXT

            ::nPos := ::nMaxLen + 1
            ::typeOut := .T.

         ENDCASE
      endif

      return nPos
   endif

   return 0

/* The METHOD Picture and VAR cPicture allow to replace the
 * property Picture for a function to control the content and
 * to carry out certain actions to normalize the data.
 * The particular case is that the Picture is loaded later on
 * to the creation of the object, being necessary to carry out
 * several tasks to adjust the internal data of the object.
 */

METHOD picture( cPicture ) CLASS Get

   LOCAL nAt
   LOCAL nFor
   LOCAL cNum
   LOCAL cChar

   if PCount() > 0

      if cPicture != NIL

         ::cPicture      := cPicture
         ::nPicLen       := NIL
         ::cPicFunc      := ""
         ::cPicMask      := ""
         ::lPicBlankZero := .F.

         if HB_ISSTRING( cPicture )

            cNum := ""

            //if hb_LeftEq( cPicture, "@" )
				if Left( cPicture, 1 ) = "@"

               if ( nAt := At( " ", cPicture ) ) == 0
                  ::cPicFunc := hb_asciiUpper( cPicture )
                  ::cPicMask := ""
               else
                  ::cPicFunc := hb_asciiUpper( Left( cPicture, nAt - 1 ) )
                  ::cPicMask := SubStr( cPicture, nAt + 1 )
               endif

               if "D" $ ::cPicFunc

                  ::cPicMask := Set( _SET_DATEFORMAT )
                  FOR EACH cChar IN "yYmMdD"
                     ::cPicMask := StrTran( ::cPicMask, cChar, "9" )
                  NEXT

               elseif "T" $ ::cPicFunc

                  ::cPicMask := Set( _SET_TIMEFORMAT )
                  FOR EACH cChar IN "yYmMdDhHsSfF"
                     ::cPicMask := StrTran( ::cPicMask, cChar, "9" )
                  NEXT

               endif

               if ( nAt := At( "S", ::cPicFunc ) ) > 0
                  FOR nFor := nAt + 1 TO Len( ::cPicFunc )
                     if IsDigit( SubStr( ::cPicFunc, nFor, 1 ) )
                        cNum += SubStr( ::cPicFunc, nFor, 1 )
                     else
                        EXIT
                     endif
                  NEXT
                  if Val( cNum ) > 0
                     ::nPicLen := Val( cNum )
                  endif
                  ::cPicFunc := Left( ::cPicFunc, nAt - 1 ) + SubStr( ::cPicFunc, nFor )
               endif

               if "Z" $ ::cPicFunc
                  ::lPicBlankZero := .T.
                  ::cPicFunc := StrTran( ::cPicFunc, "Z" )
               endif

               if ::cPicFunc == "@"
                  ::cPicFunc := ""
               elseif "R" $ ::cPicFunc .AND. "E" $ ::cPicFunc
                  ::cPicFunc := StrTran( ::cPicFunc, "R" )
               endif
            else
               ::cPicMask := cPicture
            endif

            if ::cType == "D" .OR. ::cType == "T"
               ::cPicMask := LTrim( ::cPicMask )
            endif
         endif
      endif

      /* Generate default picture mask if not specified. */

      if ::cType != NIL .AND. ( Empty( ::cPicMask ) .OR. ::cPicture == NIL .OR. ::cType == "D" )

         SWITCH ::cType
         CASE "D"

            ::cPicMask := Set( _SET_DATEFORMAT )
            FOR EACH cChar IN "yYmMdD"
               ::cPicMask := StrTran( ::cPicMask, cChar, "9" )
            NEXT
            EXIT

         CASE "T"

            ::cPicMask := Set( _SET_DATEFORMAT ) + " " + Set( _SET_TIMEFORMAT )
            FOR EACH cChar IN "yYmMdDhHsSfF"
               ::cPicMask := StrTran( ::cPicMask, cChar, "9" )
            NEXT
            EXIT

         CASE "N"

            if ::xVarGet != NIL
               cNum := Str( ::xVarGet )
               if ( nAt := At( ".", cNum ) ) > 0
                  ::cPicMask := Replicate( "9", nAt - 1 ) + "."
                  ::cPicMask += Replicate( "9", Len( cNum ) - Len( ::cPicMask ) )
               else
                  ::cPicMask := Replicate( "9", Len( cNum ) )
               endif
            endif
            EXIT

         CASE "C"

            if ::xVarGet != NIL
               if ::cPicFunc == "@9"
                  ::cPicMask := Replicate( "9", Len( ::xVarGet ) )
                  ::cPicFunc := ""
               endif
            endif
            EXIT

         ENDSWITCH

      endif

      /* To verify if it has non-modifiable embedded characters in the group. */

      ::lPicComplex := .F.
      if ! Empty( ::cPicMask )
         FOR EACH cChar IN hb_asciiUpper( ::cPicMask )
            if !( cChar $ "!ANX9#" )
               ::lPicComplex := .T.
               EXIT
            endif
         NEXT
      endif
   endif

   return ::cPicture

METHOD PutMask( xValue, lEdit ) CLASS Get

   LOCAL cChar
   LOCAL cBuffer
   LOCAL cPicFunc := ::cPicFunc
   LOCAL cPicMask := ::cPicMask
   LOCAL nFor

   hb_default( @lEdit, ::hasFocus )

   if !( ValType( xValue ) $ "CNDTL" )
      xValue := ""
   endif

   if ::hasFocus
      cPicFunc := StrTran( cPicfunc, "B" )
      if cPicFunc == "@"
         cPicFunc := ""
      endif
   endif
   if lEdit .AND. ::lEdit
      if "*" $ cPicMask .OR. ;
         "$" $ cPicMask
         cPicMask := hb_StrReplace( cPicMask, "*$", "99" )
      endif
   endif

   cBuffer := Transform( xValue, ;
                         iif( Empty( cPicFunc ), ;
                              iif( ::lPicBlankZero .AND. ! ::hasFocus, "@Z ", "" ), ;
                              cPicFunc + iif( ::lPicBlankZero .AND. ! ::hasFocus, "Z"  , "" ) + " " ) + ;
                         cPicMask )

   if ::cType == "N"
      if ( "(" $ cPicFunc .OR. ")" $ cPicFunc ) .AND. xValue >= 0
         cBuffer += " "
      endif

      if ( ( "C" $ cPicFunc .AND. xValue <  0 ) .OR. ;
           ( "X" $ cPicFunc .AND. xValue >= 0 ) ) .AND. ;
           !( "X" $ cPicFunc .AND. "C" $ cPicFunc )
         cBuffer += "   "
      endif

      ::lMinusPrinted := ( xValue < 0 )
   endif

   ::nMaxLen  := Len( cBuffer )
   ::nMaxEdit := ::nMaxLen

   if lEdit .AND. ::cType == "N" .AND. ! Empty( cPicMask )
      FOR nFor := 1 TO ::nMaxLen
         cChar := SubStr( cPicMask, nFor, 1 )
         if cChar $ ",." .AND. SubStr( cBuffer, nFor, 1 ) $ ",." // " " TOFIX
            if "E" $ cPicFunc
               cChar := iif( cChar == ",", ".", "," )
            endif
            cBuffer := Stuff( cBuffer, nFor, 1, cChar )
         endif
      NEXT
      if ::lEdit .AND. Empty( xValue )
         cBuffer := StrTran( cBuffer, "0", " " )
      endif
   endif

   if ::cType == "N"
      if "(" $ ::cPicFunc .OR. ")" $ ::cPicFunc
         ::nMaxEdit--
      endif
      if "C" $ ::cPicFunc .OR. "X" $ ::cPicFunc
         ::nMaxEdit -= 3
      endif
   endif

   if ( ::cType == "D" .OR. ::cType == "T" ) .AND. ::badDate
      cBuffer := ::cBuffer
   endif

   ::nMaxLen := Len( cBuffer )

   return cBuffer

METHOD unTransform() CLASS Get

   LOCAL cBuffer
   LOCAL xValue
   LOCAL nFor
   LOCAL lMinus
   LOCAL lHasDec

   if ::hasFocus

      cBuffer := ::cBuffer

      if HB_ISSTRING( cBuffer ) .AND. ::cType != NIL

         SWITCH ::cType
         CASE "C"

            if "R" $ ::cPicFunc
               xValue := ""
               FOR nFor := 1 TO Len( ::cPicMask )
                  if hb_asciiUpper( SubStr( ::cPicMask, nFor, 1 ) ) $ "ANX9#!LY"
                     xValue += SubStr( cBuffer, nFor, 1 )
                  endif
               NEXT
            else
               xValue := cBuffer
            endif
            EXIT

         CASE "N"

            lMinus := .F.
            if "X" $ ::cPicFunc .AND. Right( cBuffer, 2 ) == "DB"
               lMinus := .T.
            endif
            if ! lMinus
               FOR nFor := 1 TO ::nMaxLen
                  if ::IsEditable( nFor ) .AND. IsDigit( SubStr( cBuffer, nFor, 1 ) )
                     EXIT
                  endif
                  if SubStr( cBuffer, nFor, 1 ) $ "-(" .AND. !( SubStr( cBuffer, nFor, 1 ) == SubStr( ::cPicMask, nFor, 1 ) )
                     lMinus := .T.
                     EXIT
                  endif
               NEXT
            endif
            cBuffer := Space( ::FirstEditable() - 1 ) + SubStr( cBuffer, ::FirstEditable(), ::LastEditable() - ::FirstEditable() + 1 )

            /* Readd leading decimal point, if any */
            if ::decPos <= ::FirstEditable() - 1
               cBuffer := Left( cBuffer, ::decPos - 1 ) + "." + SubStr( cBuffer, ::decPos + 1 )
            endif

            if "D" $ ::cPicFunc .OR. ;
               "T" $ ::cPicFunc
               FOR nFor := ::FirstEditable() TO ::LastEditable()
                  if ! ::IsEditable( nFor )
                     cBuffer := Left( cBuffer, nFor - 1 ) + Chr( 1 ) + SubStr( cBuffer, nFor + 1 )
                  endif
               NEXT
            else
               if "E" $ ::cPicFunc
                  cBuffer := Left( cBuffer, ::FirstEditable() - 1 ) + ;
                             hb_StrReplace( SubStr( cBuffer, ::FirstEditable(), ::LastEditable() - ::FirstEditable() + 1 ), ".,", " ." ) + ;
                             SubStr( cBuffer, ::LastEditable() + 1 )
               else
                  cBuffer := Left( cBuffer, ::FirstEditable() - 1 ) + ;
                             StrTran( SubStr( cBuffer, ::FirstEditable(), ::LastEditable() - ::FirstEditable() + 1 ), ",", " " ) + ;
                             SubStr( cBuffer, ::LastEditable() + 1 )
               endif

               lHasDec := .F.
               FOR nFor := ::FirstEditable() TO ::LastEditable()
                  if ::IsEditable( nFor )
                     if lHasDec .AND. SubStr( cBuffer, nFor, 1 ) == " "
                        cBuffer := Left( cBuffer, nFor - 1 ) + "0" + SubStr( cBuffer, nFor + 1 )
                     endif
                  else
                     if SubStr( cBuffer, nFor, 1 ) == "."
                        lHasDec := .T.
                     else
                        cBuffer := Left( cBuffer, nFor - 1 ) + Chr( 1 ) + SubStr( cBuffer, nFor + 1 )
                     endif
                  endif
               NEXT
            endif

            cBuffer := StrTran( cBuffer, Chr( 1 ) )

            cBuffer := hb_StrReplace( cBuffer, ;
               "$*-()", ;
               "     " )

            cBuffer := PadL( StrTran( cBuffer, " " ), Len( cBuffer ) )

            if lMinus
               FOR nFor := 1 TO Len( cBuffer )
                  if IsDigit( SubStr( cBuffer, nFor, 1 ) ) .OR. SubStr( cBuffer, nFor, 1 ) == "."
                     EXIT
                  endif
               NEXT
               nFor--
               if nFor > 0
                  cBuffer := Left( cBuffer, nFor - 1 ) + "-" + SubStr( cBuffer, nFor + 1 )
               else
                  cBuffer := "-" + cBuffer
               endif
            endif

            //xValue := hb_Val( cBuffer )
				xValue := Val( cBuffer )

            EXIT

         CASE "L"

            cBuffer := Upper( cBuffer )
            xValue := "T" $ cBuffer .OR. ;
                      "Y" $ cBuffer .OR. ;
                      hb_langMessage( HB_LANG_ITEM_BASE_TEXT + 1 ) $ cBuffer
            EXIT

         CASE "D"

            if "E" $ ::cPicFunc
               cBuffer := SubStr( cBuffer, 4, 3 ) + SubStr( cBuffer, 1, 3 ) + SubStr( cBuffer, 7 )
            endif
            xValue := CToD( cBuffer )
            EXIT

         CASE "T"

            xValue := hb_CToT( cBuffer )
            EXIT

         ENDSWITCH

      else
         ::lClear  := .F.
         ::decPos  := 0
         ::nPos    := 0
         ::typeOut := .F.
      endif
   endif

   return xValue

METHOD type() CLASS Get
   return ::cType := ValType( iif( ::hasFocus, ::xVarGet, ::varGet() ) )

/* The METHOD Block and VAR bBlock allow to replace the
 * property Block for a function to control the content and
 * to carry out certain actions to normalize the data.
 * The particular case is that the Block is loaded later on
 * to the creation of the object, being necessary to carry out
 * several tasks to adjust the internal data of the object
 * to display correctly.
 */

METHOD block( bBlock ) CLASS Get

   if PCount() == 0 .OR. bBlock == NIL
      return ::bBlock
   endif

   ::bBlock   := bBlock
   ::xVarGet  := ::original
   ::cType    := ValType( ::xVarGet )

   return bBlock

METHOD firstEditable() CLASS Get

   LOCAL nFor

   if ::nMaxLen != NIL

      if ::IsEditable( 1 )
         return 1
      endif

      FOR nFor := 2 TO ::nMaxLen
         if ::IsEditable( nFor )
            return nFor
         endif
      NEXT
   endif

   return 0

METHOD lastEditable() CLASS Get

   LOCAL nFor

   if ::nMaxLen != NIL

      FOR nFor := ::nMaxLen TO 1 STEP -1
         if ::IsEditable( nFor )
            return nFor
         endif
      NEXT
   endif

   return 0

METHOD badDate() CLASS Get

   LOCAL xValue

   if ::hasFocus
      SWITCH ::type
      CASE "D"
         return ( xValue := ::unTransform() ) == hb_SToD() .AND. ;
                !( ::cBuffer == Transform( xValue, ::cPicture ) )
      CASE "T"
         return ( xValue := ::unTransform() ) == hb_SToT() .AND. ;
                !( ::cBuffer == Transform( xValue, ::cPicture ) )
      ENDSWITCH
   endif

   return .F.

#ifdef HB_CLP_UNDOC

METHOD reform() CLASS Get

   if ::hasFocus
      ::cBuffer := ::PutMask( ::unTransform(), .F. )
      ::nDispLen := iif( ::nPicLen == NIL, ::nMaxLen, ::nPicLen ) // ?
   endif

   return Self

#endif

#ifdef HB_COMPAT_C53

METHOD hitTest( nMRow, nMCol ) CLASS Get

   if HB_ISOBJECT( ::oControl )
      return ::oControl:hitTest( nMRow, nMCol )
   else
      DO CASE
      CASE nMRow == ::nRow .AND. ;
           nMCol >= ::nCol .AND. ;
           nMCol < ::nCol + iif( ::nDispLen == NIL, 0, ::nDispLen )
         return HTCLIENT
      CASE nMRow == ::nCapRow .AND. ;
           nMCol >= ::nCapCol .AND. ;
           nMCol < ::nCapCol + Len( ::cCaption ) /* NOTE: C5.3 doesn't care about the shortcut key. */
         return HTCAPTION
      ENDCASE
   endif

   return HTNOWHERE

METHOD control( oControl ) CLASS Get

   if PCount() == 1 .AND. ( oControl == NIL .OR. HB_ISOBJECT( oControl ) )
      ::oControl := oControl
   endif

   return ::oControl

METHOD caption( cCaption ) CLASS Get

   if HB_ISSTRING( cCaption )
      ::cCaption := cCaption
   endif

   return ::cCaption

METHOD capRow( nCapRow ) CLASS Get

   if HB_ISNUMERIC( nCapRow )
      ::nCapRow := Int( nCapRow )
   endif

   return ::nCapRow

METHOD capCol( nCapCol ) CLASS Get

   if HB_ISNUMERIC( nCapCol )
      ::nCapCol := Int( nCapCol )
   endif

   return ::nCapCol

METHOD message( cMessage ) CLASS Get

   if HB_ISSTRING( cMessage )
      ::cMessage := cMessage
   endif

   return ::cMessage

#endif

/* ------------------------------------------------------------------------- */

METHOD rightLow() CLASS Get

   LOCAL nPos

   ::typeOut := .F.
   ::lClear  := .F.

   if ::nPos == ::nMaxEdit
      ::typeOut := .T.
      return .F.
   endif

   nPos := ::nPos + 1

   DO WHILE ! ::IsEditable( nPos ) .AND. nPos <= ::nMaxEdit
      nPos++
   ENDDO

   if nPos <= ::nMaxEdit
      ::pos := nPos
   else
      ::typeOut := .T.
   endif

   return .T.

METHOD leftLow() CLASS Get

   LOCAL nPos

   ::typeOut := .F.
   ::lClear  := .F.

   if ::nPos == ::FirstEditable()
      ::typeOut := .T.
      return .F.
   endif

   nPos := ::nPos - 1

   DO WHILE ! ::IsEditable( nPos ) .AND. nPos > 0
      nPos--
   ENDDO

   if nPos > 0
      ::pos := nPos
   else
      ::typeOut := .T.
   endif

   return .T.

METHOD backSpaceLow() CLASS Get

   LOCAL nMinus
   LOCAL nPos := ::nPos

   if nPos > 1 .AND. nPos == ::FirstEditable() .AND. ::lMinus2

      /* To delete the parenthesis (negative indicator) in a non editable position */

      if ( nMinus := At( "(", Left( ::cBuffer, nPos - 1 ) ) ) > 0 .AND. ;
         !( SubStr( ::cPicMask, nMinus, 1 ) == "(" )

         ::cBuffer := Stuff( ::cBuffer, nMinus, 1, " " )

         ::lEdit := .T.
         ::lChanged := .T.

         return .T.
      endif
   endif

   ::left()

   if ::nPos < nPos
      ::deleteLow()
      return .T.
   endif

   return .F.

METHOD deleteLow() CLASS Get

   LOCAL nMaxLen := ::nMaxLen
   LOCAL n

   ::lClear := .F.
   ::lEdit := .T.

   if ::lPicComplex
      /* Calculating different nMaxLen for ::lPicComplex */
      FOR n := ::nPos TO nMaxLen
         if ! ::IsEditable( n )
            EXIT
         endif
      NEXT
      nMaxLen := n - 1
   endif

   if ::cType == "N" .AND. SubStr( ::cBuffer, ::nPos, 1 ) $ "(-"
      ::lMinus2 := .F.
   endif

   ::cBuffer := PadR( Stuff( Stuff( ::cBuffer, ::nPos, 1, "" ), nMaxLen, 0, " " ), ;
                      ::nMaxLen )

   ::lChanged := .T.

   return NIL

METHOD DeleteAll() CLASS Get

   LOCAL xValue

   if ::hasFocus

      ::lEdit := .T.

      SWITCH ::cType
      CASE "C"
         xValue := Space( ::nMaxlen )
         EXIT
      CASE "N"
         xValue := 0
         ::lMinus2 := .F.
         EXIT
      CASE "D"
         xValue := hb_SToD()
         EXIT
      CASE "T"
         xValue := hb_SToT()
         EXIT
      CASE "L"
         xValue := .F.
         EXIT
      ENDSWITCH

      ::cBuffer := ::PutMask( xValue )
      ::pos     := ::FirstEditable()
   endif

   return Self

METHOD IsEditable( nPos ) CLASS Get

   LOCAL cChar

   if Empty( ::cPicMask )
      return .T.
   endif

   /* This odd behaviour helps to be more compatible with CA-Cl*pper in some rare situations.
      xVar := 98 ; o := _GET_( xVar, "xVar" ) ; o:SetFocus() ; o:picture := "99999" ; o:UnTransform() -> result
      We're still not 100% compatible in slighly different situations because the CA-Cl*pper
      behaviour is pretty much undefined here. [vszakats] */
   if nPos > Len( ::cPicMask ) .AND. nPos <= ::nMaxLen
      return .T.
   endif

   if ::cType != NIL
      cChar := SubStr( ::cPicMask, nPos, 1 )
      SWITCH ::cType
      CASE "C" ; return hb_asciiUpper( cChar ) $ "!ANX9#LY"
      CASE "N" ; return cChar $ "9#$*"
      CASE "D"
      CASE "T" ; return cChar == "9"
      CASE "L" ; return hb_asciiUpper( cChar ) $ "LY#" /* CA-Cl*pper 5.2 undocumented: # allow T,F,Y,N for Logical [ckedem] */
      ENDSWITCH
   endif

   return .F.

METHOD Input( cChar ) CLASS Get

   LOCAL cPic

   if ::cType != NIL

      SWITCH ::cType
      CASE "N"

         DO CASE
         CASE cChar == "-"
            ::lMinus2 := .T.  /* The minus symbol can be written in any place */
            ::lMinus := .T.

         CASE cChar $ ".,"
            ::toDecPos()
            return ""

         CASE !( cChar $ "0123456789+" )
            return ""
         ENDCASE
         EXIT

      CASE "D"

         if !( cChar $ "0123456789" )
            return ""
         endif
         EXIT

      CASE "T"

         if !( cChar $ "0123456789" )
            return ""
         endif
         EXIT

      CASE "L"

         if !( Upper( cChar ) $ "YNTF" )
            return ""
         endif
         EXIT

      ENDSWITCH
   endif

   if ! Empty( ::cPicFunc )
      cChar := Left( Transform( cChar, ::cPicFunc ), 1 ) /* Left needed for @D */
   endif

   if ! Empty( ::cPicMask )
      cPic  := hb_asciiUpper( SubStr( ::cPicMask, ::nPos, 1 ) )

      //    cChar := Transform( cChar, cPic )
      // Above line eliminated because some get picture template symbols for
      // numeric input not work in text input. eg: $ and *

      DO CASE
      CASE cPic == "A"
         if ! IsAlpha( cChar )
            cChar := ""
         endif

      CASE cPic == "N"
         if ! IsAlpha( cChar ) .AND. ! IsDigit( cChar )
            cChar := ""
         endif

      CASE cPic == "9"
         if ! IsDigit( cChar ) .AND. ! cChar $ "-+"
            cChar := ""
         endif
         if !( ::cType == "N" ) .AND. cChar $ "-+"
            cChar := ""
         endif

      /* Clipper 5.2 undocumented: # allow T,F,Y,N for Logical [ckedem] */
      CASE cPic == "L" .OR. ( cPic == "#" .AND. ::cType == "L" )
         if !( Upper( cChar ) $ "YNTF" + ;
                                hb_langMessage( HB_LANG_ITEM_BASE_TEXT + 1 ) + ;
                                hb_langMessage( HB_LANG_ITEM_BASE_TEXT + 2 ) )
            cChar := ""
         endif

      CASE cPic == "#"
         if ! IsDigit( cChar ) .AND. !( cChar == " " ) .AND. !( cChar $ ".+-" )
            cChar := ""
         endif

      CASE cPic == "Y"
         cChar := Upper( cChar )
         if !( cChar $ "YN" )
            cChar := ""
         endif

      CASE ( cPic == "$" .OR. cPic == "*" ) .AND. ::cType == "N"
         if ! IsDigit( cChar ) .AND. !( cChar == "-" )
            cChar := ""
         endif
      OTHERWISE
         cChar := Transform( cChar, cPic )
      ENDCASE
   endif

   return cChar

/* ------------------------------------------------------------------------- */

METHOD getBuffer() CLASS Get
   return ::cBuffer

METHOD setBuffer( cBuffer ) CLASS Get
   return iif( ::hasFocus, ::cBuffer := cBuffer, cBuffer )

/* NOTE: In contrary to CA-Cl*pper docs, this var is assignable. [vszakats] */

METHOD getChanged() CLASS Get
   return ::lChanged

METHOD setChanged( lChanged ) CLASS Get

   if HB_ISLOGICAL( lChanged )
      return iif( ::hasFocus, ::lChanged := lChanged, lChanged )
   endif

   return .F.

METHOD getClear() CLASS Get
   return ::lClear

METHOD setClear( lClear ) CLASS Get

   if HB_ISLOGICAL( lClear )
      return iif( ::hasFocus, ::lClear := lClear, lClear )
   endif

   return .F.

METHOD getMinus() CLASS Get
   return ::lMinus

METHOD setMinus( lMinus ) CLASS Get

   if HB_ISLOGICAL( lMinus )
      return iif( ::hasFocus, ::lMinus := lMinus, lMinus )
   endif

   return .F.

/* NOTE: CA-Cl*pper has a bug where negative nRow value will be translated to 16bit unsigned int,
         so the behaviour will be different in this case. [vszakats] */

METHOD getRow() CLASS Get
   return ::nRow

METHOD setRow( nRow ) CLASS Get
   return ::nRow := iif( HB_ISNUMERIC( nRow ), Int( nRow ), 0 )

/* NOTE: CA-Cl*pper has a bug where negative nCol value will be translated to 16bit unsigned int,
         so the behaviour will be different in this case. [vszakats] */

METHOD getCol() CLASS Get
   return ::nCol

METHOD setCol( nCol ) CLASS Get
   return ::nCol := iif( HB_ISNUMERIC( nCol ), Int( nCol ), 0 )

METHOD name( cName ) CLASS Get

   if PCount() > 0 .AND. cName != NIL
      ::cName := cName
   endif

   return ::cName

METHOD SubScript( xValue ) CLASS Get

   if xValue != NIL
      ::xSubScript := xValue
   endif

   return ::xSubScript

METHOD PostBlock( xValue ) CLASS Get

   if xValue != NIL
      ::bPostBlock := xValue
   endif

   return ::bPostBlock

METHOD PreBlock( xValue ) CLASS Get

   if xValue != NIL
      ::bPreBlock := xValue
   endif

   return ::bPreBlock

METHOD Cargo( xValue ) CLASS Get

   if xValue != NIL
      ::xCargo := xValue
   endif

   return ::xCargo

METHOD ExitState( xValue ) CLASS Get

   if xValue != NIL
      ::xExitState := xValue
   endif

   return ::xExitState

METHOD Reader( xValue ) CLASS Get

   if xValue != NIL
      ::bReader := xValue
   endif

   return ::bReader

/* ------------------------------------------------------------------------- */

METHOD New( nRow, nCol, bVarBlock, cVarName, cPicture, cColorSpec ) CLASS Get

   if nRow == NIL
      nRow := Row()
   endif
   if nCol == NIL
      nCol := Col() + iif( Set( _SET_DELIMITERS ), 1, 0 )
   endif
   __defaultNIL( @cVarName, "" )
   if bVarBlock == NIL
      bVarBlock := iif( HB_ISSTRING( cVarName ), MemVarBlock( cVarName ), NIL )
   endif
   if cColorSpec == NIL
      cColorSpec := SetColor()
#ifdef HB_COMPAT_C53
      cColorSpec := ;
         hb_ColorIndex( cColorSpec, iif( Set( _SET_INTENSITY ), CLR_UNSELECTED, CLR_STANDARD ) ) + "," + ;
         hb_ColorIndex( cColorSpec, iif( Set( _SET_INTENSITY ), CLR_ENHANCED, CLR_STANDARD ) ) + "," + ;
         hb_ColorIndex( cColorSpec, CLR_STANDARD ) + "," + ;
         iif( IsDefColor(), iif( Set( _SET_INTENSITY ), "W+/N", "W/N" ), ;
            hb_ColorIndex( cColorSpec, iif( Set( _SET_INTENSITY ), CLR_BACKGROUND, CLR_STANDARD ) ) )
#else
      cColorSpec := ;
         hb_ColorIndex( cColorSpec, iif( Set( _SET_INTENSITY ), CLR_UNSELECTED, CLR_STANDARD ) ) + "," + ;
         hb_ColorIndex( cColorSpec, iif( Set( _SET_INTENSITY ), CLR_ENHANCED, CLR_STANDARD ) )
#endif
   endif

   ::nRow      := nRow
   ::nCol      := nCol
   ::bBlock    := bVarBlock
   ::cName     := cVarName
   ::picture   := cPicture
   ::colorSpec := cColorSpec

   return Self

FUNCTION GetNew( nRow, nCol, bVarBlock, cVarName, cPicture, cColor )
   return Get():New( nRow, nCol, bVarBlock, cVarName, cPicture, cColor )
