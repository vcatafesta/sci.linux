#include "minigui.ch"
#include "indent.ch"

Function IntroMain()
*******************		
	DEFINE WINDOW Trax_1 ;
      AT 0,0 ;
      WIDTH MIN( 800, GetDesktopWidth()) ;
      HEIGHT MIN( 600, GetDesktopHeight()) ;
      TITLE 'Macrosoft SCI for Windows' ;
      ICON 'OHS.ICO' ;
      MAIN NOMAXIMIZE NOSIZE ;		
      ON PAINT ( FillBlue( _HMG_MainHandle ), ;     // color the screen: MiniGUI contributed file
      TextPaint() )      
   
	ON KEY ESCAPE ACTION Trax_1.Release
   DEFINE STATUSBAR FONT "Consolas" SIZE 8
      STATUSITEM "Tabela EMPLOYE"
      KEYBOARD WIDTH 90
      DATE WIDTH 100
      CLOCK WIDTH 80
   END STATUSBAR
	
	END WINDOW
   CENTER WINDOW Trax_1

   if FILE( 'MTFLASH3.BMP' )
      DEFINE WINDOW MT_Splash ;
         AT 0, 0 ;
         WIDTH 365 HEIGHT 92 ;
         TOPMOST NOCAPTION ;
         ON INIT SplashDelay()
			
         if FILE('SCI.PNG' )
            @ -4, -4 IMAGE img_1 ;
               PICTURE 'SCI.PNG' ;
               WIDTH 365 ;
               HEIGHT 92
         endif

      END WINDOW
      CENTER WINDOW MT_Splash
      ACTIVATE WINDOW MT_Splash, Trax_1
   else
      ACTIVATE WINDOW Trax_1
   endif
		
		
FUNCTION SplashDelay
*------------------------------------------------------------*
   LOCAL iTime

   iTime := Seconds()
   While Seconds() - iTime < 1
   EndDo
   MT_Splash.Release

return NIL

*------------------------------------------------------------*
function TextPaint()
*------------------------------------------------------------*
   DRAW TEXT IN WINDOW Trax_1 AT 23, 27 ;
      VALUE "Macrosoft SCI   for Windows" ;
      FONT "Verdana" SIZE 24 BOLD ITALIC ;
      FONTCOLOR BLACK TRANSPARENT

   DRAW TEXT IN WINDOW Trax_1 AT 20, 24 ;
		VALUE "Macrosoft SCI   for Windows" ;
      FONT "Verdana" SIZE 24 BOLD ITALIC ;
      FONTCOLOR { 151, 223, 255 } TRANSPARENT

   DRAW TEXT IN WINDOW Trax_1 AT 28, 282 ;
      VALUE "TM" ;
      FONT "Verdana" SIZE 8 BOLD ITALIC ;
      FONTCOLOR BLACK TRANSPARENT

   DRAW TEXT IN WINDOW Trax_1 AT 26, 280 ;
      VALUE "TM" ;
      FONT "Verdana" SIZE 8 BOLD ITALIC ;
      FONTCOLOR { 151, 223, 255 } TRANSPARENT

   DRAW TEXT IN WINDOW Trax_1 AT Trax_1.Height - 80, Trax_1.Width - 360 ;
      VALUE "Macrosoft Sistemas de Informatica Ltda." ;
      FONT "Tahoma" SIZE 10 ITALIC ;
      FONTCOLOR { 151, 223, 255 } TRANSPARENT
return Nil

#pragma BEGINDUMP
   #include <windows.h>
   #include <commctrl.h>
   #include "hbapi.h"
   #include "hbvm.h"
   #include "hbstack.h"
   #include "hbapiitm.h"
   #include "winreg.h"
   #include "tchar.h"

   HB_FUNC( FILLBLUE )
   {
		HWND   hwnd;
      HBRUSH brush;
      RECT   rect;
      HDC    hdc;
      int    cx;
      int    cy;
      int    blue = 200;
      int    steps;
      int    i;

   hwnd  = (HWND) hb_parnl (1);
      hdc   = GetDC(hwnd);

   GetClientRect(hwnd, &rect);

   cx = rect.top;
      cy = rect.bottom + 1;
      steps = (cy - cx) / 3;
      rect.bottom = 0;

   for( i = 0 ; i < steps ; i++ )
   {
   rect.bottom += 3;
      brush = CreateSolidBrush( RGB(0, 0, blue) );
      FillRect(hdc, &rect, brush);
      DeleteObject(brush);
      rect.top += 3;
      blue -= 1;
      }

   ReleaseDC(hwnd, hdc);
      hb_ret();
      }
   
#pragma ENDDUMP