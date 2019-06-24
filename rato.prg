#include "hbgtinfo.ch"
#include "inkey.ch"

PROCEDURE Main

   LOCAL nOpc := 1, acOptions := { "primeira", "segunda", "terceira", "quarta" }, oElement, nKey
	
   hb_gtInfo( HB_GTI_INKEYFILTER, { | nKey | MyInkeyFilter( nKey ) } )
   SET EVENTMASK TO INKEY_ALL
   //SetMode( 25, 80 )
   CLS

   DO WHILE .T.
      FOR EACH oElement IN acOptions
         @ oElement:__EnumIndex, 5 SAY oElement COLOR iif( nOpc == oElement:__EnumIndex, "N/W", "W/N" )
      NEXT
      nKey := Inkey(0)
      DO CASE
      CASE nKey == K_ESC    ; EXIT
      CASE nKey == K_ENTER  ; EXIT
      CASE nKey == K_UP     ; nOpc := iif( nOpc == 1, Len( acOptions ), nOpc - 1 )
      CASE nKey == K_DOWN   ; nOpc := iif( nOpc == Len( acOptions ), 1, nOpc + 1 )
      ENDCASE
   ENDDO

   return

FUNCTION HB_GTSYS()

   REQUEST HB_GT_WVT_DEFAULT

   return NIL

FUNCTION MyInkeyFilter( nKey )

   STATIC nMouseRow

   if nMouseRow == NIL
      nMouseRow := MRow()
   endif

   SWITCH nKey
   CASE HB_K_CLOSE     ; return K_ESC
   CASE K_MWBACKWARD   ; return K_DOWN
   CASE K_MWFORWARD    ; return K_UP
   CASE K_MOUSEMOVE
      if MRow() < nMouseRow
         nMouseRow := MRow()
         return K_UP
      endif
      if MRow() > nMouseRow
         nMouseRow := MRow()
         return K_DOWN
      endif
   END SWITCH

   return nKey