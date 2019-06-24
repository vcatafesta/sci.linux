// COMPILADO COM HBMK2 CORGT -GUI -GTWVT   

#include "hbgtinfo.ch"
REQUEST HB_GT_WVT_DEFAULT

/*
B   = 1
G   = 2
BG  = 3
R   = 4
BR  = 5
GR  = 6
W   = 7
N+  = 8
B+  = 9
G+  = 10
BG+ = 11
R+  = 12
BR+ = 13
GR+ = 14
W+  = 15
N   = 16
*/

FUNCTION MAIN()

SetColor("")
CLEAR
//SET COLOR TO W+/B
? "teste"
P1 = 211
P2 = 237
P3 = 250
//SET COLOR TO R/W+*
aPalette    := hb_gtinfo( HB_GTI_PALETTE )
aPalette[1] := RGB(255,255,255) 
? "teste"
inkey(0)

do while .t.
    CORES(P1,P2,P3)
    @ 1,1 SAY REPL("Û",80)
    @ 2,1 SAY 'R='+str(P1,3)+' tecla a '
    @ 3,1 SAY 'G='+str(P2,3)+' tecla b '
    @ 4,1 SAY 'B='+str(P3,3)+' tecla c '
    @ 24,0 SAY 'Pressione Q para encerrar ...'
    INKEY(0)

    //
    if LASTKEY()=65 .or. LASTKEY()=97 // A
	   if p1 == 255
			loop
		endif
       P1++
    elseif LASTKEY()=66 .OR. LASTKEY()=98 // B
	 if p2 == 255
			loop
		endif
       P2++
    elseif LASTKEY()=67 .OR. LASTKEY()=99 // C
	 if p3 == 255
			loop
		endif
       P3++
    elseif LASTKEY()=81 .OR. LASTKEY()=113 // Q
       QUIT
    endif
enddo
return

FUNCTION CORES(P1,P2,P3)
	LOCAL aPaletteAntes := hb_gtinfo( HB_GTI_PALETTE )
	LOCAL aPalette      := hb_gtinfo( HB_GTI_PALETTE )

	aPalette[8]   := RGB( P1,P2,P3 )
	//RN_T          := HB_GTINFO( HB_GTI_PALETTE, aPaletteAntes )
   cTitulo       := "Macrosoft Teste de Cores RGB em Harbour"
   HB_GTINFO(HB_GTI_WINTITLE, cTitulo)
   return aPalette

FUNCTION RGB( R,G,B )
	return R + ( G * 256 ) + ( B * 256 * 256 )

