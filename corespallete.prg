
#include "hbgtinfo.ch"
#define RGB(r,g,b) ( r + ( g * 256 ) + ( b * 256 * 256 ) )
REQUEST HB_GT_WVT_DEFAULT

FUNCTION main
LOCAL aPalette:=hb_gtInfo( HB_GTI_PALETTE )
   aPalette[ 8 ] := RGB( 211, 237, 250 )
   ? hb_gtInfo( HB_GTI_PALETTE, aPalette )
	inkey(0)

return Nil