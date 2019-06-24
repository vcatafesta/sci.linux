// hbmk2 sample.prg -gtwvg -gui 
ANNOUNCE HB_GTSYS
REQUEST HB_GT_WVG
REQUEST HB_GT_WVG_DEFAULT
#INCLUDE "HBGTINFO.CH"

function main 
   //set color to "N/W,N/BG,,,N/W*" 
	setcolor("W+/b")
   cls 
  SETMODE(25,80)
   hb_gtInfo( HB_GTI_ICONFILE, "sci.ico" ) 
   hb_gtInfo( HB_GTI_WINTITLE, "Macrosoft SCI" ) 
   Hb_GtInfo( HB_GTI_SELECTCOPY,.T.) 
   Hb_GtInfo( HB_GTI_RESIZABLE, .T. ) 
   HB_GTINFO( HB_GTI_CLOSABLE, .T. )
   HB_GTINFO( HB_GTI_RESIZABLE, .T. )
   HB_GTINFO( HB_GTI_CODEPAGE, 255 )
   Hb_GTInfo( HB_GTI_MOUSESTATUS, 1 )
	
   screenHeight := HB_GTINFO( HB_GTI_SCREENWIDTH, HB_GTINFO( HB_GTI_DESKTOPWIDTH ) )
   screenWidth  := HB_GTINFO( HB_GTI_SCREENHEIGHT, HB_GTINFO( HB_GTI_DESKTOPHEIGHT ) - 50 )
   * SETMODE( GTINFO( GTI_DESKTOPROWS ) - 5, GTINFO( GTI_DESKTOPCOLS ) )
   HB_GTInfo(HB_GTI_FONTNAME, "Calibri")
   HB_GTInfo(HB_GTI_FONTQUALITY,HB_GTI_FONTQ_HIGH )
	
   if screenWidth >=  1920
		Hb_GtInfo( HB_GTI_FONTWIDTH, 21  )
		HB_GTInfo(HB_GTI_FONTSIZE, 40)
   elseif screenWidth >= 1600               // 1280 *960
		Hb_GtInfo( HB_GTI_FONTWIDTH, 18  )
      HB_GTInfo(HB_GTI_FONTSIZE, 32)
   elseif screenWidth >= 1280               // 1280 *960
		Hb_GtInfo( HB_GTI_FONTWIDTH, 13  )
      HB_GTInfo(HB_GTI_FONTSIZE, 20)                     // 15*80=1200   36*25=900
   elseif screenWidth >= 1024           // 1024*760
		Hb_GtInfo( HB_GTI_FONTWIDTH, 12.5  )
      HB_GTInfo(HB_GTI_FONTSIZE, 20)
   elseif screenWidth >= 800
		Hb_GtInfo( HB_GTI_FONTWIDTH, 10  )
      HB_GTInfo(HB_GTI_FONTSIZE, 18)
   else
      Hb_GtInfo( HB_GTI_FONTWIDTH, 14  )
      HB_GTInfo(HB_GTI_FONTSIZE, 8)
   endif
	? "teste"
	inkey(0)
   // another intresting
    // HB_GtInfo( HB_GTI_ISFULLSCREEN, .T. )
    // hb_gtInfo( HB_GTI_RESIZEMODE, HB_GTI_RESIZEMODE_FONT )
   
return 