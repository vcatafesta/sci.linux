/*
PROGRAMA    : TONS.PRG
AUTOR          : Pablo César
COMENTARIO : Muda a cor das cores padr”es do Clipper
             Clipper 5.2 + CT.LIB
*/

if !FILE("TONS.CFG")
   TONACOR := {{00,00,00,00,42,42,42,42,21,21,21,21,63,63,63,63},{00,00,42,42,00,00,21,42,21,21,63,63,21,21,63,63},{00,42,00,42,00,42,00,42,21,63,21,63,21,63,21,63}}
else
   TONACOR := {{},{},{}}
   VAR := MEMOREAD( "TONS.CFG" )
   FOR I=1 TO 16
       AADD(TONACOR[1], VAL(SUBSTR( VAR, ((I*6)-5), 2 )) )
       AADD(TONACOR[2], VAL(SUBSTR( VAR, ((I*6)-3), 2 )) )
       AADD(TONACOR[3], VAL(SUBSTR( VAR, ((I*6)-1), 2 )) )
   NEXT
endif
FOR I=1 TO 16
    VGAPALETTE(I-1,TONACOR[1,I],TONACOR[2,I],TONACOR[3,I])
NEXT
VQCOR:=SETCOLOR()
TELA_PRI:=SAVESCREEN(01, 00, 23, 79)
SETCOLOR( "W" )
VL := 04; VC := 3
SET CURSOR OFF
SET MESSAGE TO 23
VC_B:={12,10,09}
VCOR="N/N,B+/N*,N/N,N/N,N/W"
OP_COR=0
DO WHILE .T.
   @ 24,00 SAY PADC("Use teclas <"+CHR(24)+"> e <"+CHR(25)+"> escolher a cor de vai mudar",80) COLOR "N/W"
   FOR I = 0 TO 15
       @ I+VL+1, VC SAY REPLICATE("Û",16) COLOR NTOCOLOR(I,.T.)
       @ I+VL+1, VC PROMPT "" MESSAGE {||FEC(ROW(),COL())}
   NEXT
   TELA_C=SAVESCREEN(03,02,21,20)
   MENU TO OP_COR
   if LASTKEY()=27
      EXIT
   endif
   @ 24,00 SAY PADC("Use <"+CHR(27)+">, <"+CHR(26)+">, <"+CHR(24)+"> e <"+CHR(25)+"> para mudar a tonalidade |  retorna cor original",80) COLOR "N/W"
   SETCOLOR(NTOCOLOR((OP_COR-1),.T.))
   FOR I=2 TO 23
       @ I,00 SAY REPLICATE(CHR(219),80)
   NEXT
   if OP_COR=1
      SET COLOR TO W/N
   endif
   if !(OP_COR=13)
      R_OLD:=STRZERO(GETVGAPAL(12,"R"),2,0)+STRZERO(GETVGAPAL(12,"G"),2,0)+STRZERO(GETVGAPAL(12,"B"),2,0)
      VGAPALETTE(12,63,0,0)
   endif
   if !(OP_COR=11)
      V_OLD:=STRZERO(GETVGAPAL(10,"R"),2,0)+STRZERO(GETVGAPAL(10,"G"),2,0)+STRZERO(GETVGAPAL(10,"B"),2,0)
      VGAPALETTE(10,0,63,0)
   endif
   if !(OP_COR=10)
      A_OLD:=STRZERO(GETVGAPAL(09,"R"),2,0)+STRZERO(GETVGAPAL(09,"G"),2,0)+STRZERO(GETVGAPAL(09,"B"),2,0)
      VGAPALETTE(09,0,0,63)
   endif
   FOR I=0 TO 10  STEP +5
       @ I+6,06 SAY " 0    5   10   15   20   25   30   35   40   45   50   55   60  63 " COLOR NTOCOLOR(VC_B[((I/5)+1)],.T.)
       @ I+7,06 SAY "ÚÙ....³....³....³....³....³....³....³....³....³....³....³....³..ÀÄ¿" COLOR NTOCOLOR(VC_B[((I/5)+1)],.T.)
       @ I+8,06 SAY "³ °°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°° ³" COLOR NTOCOLOR(VC_B[((I/5)+1)],.T.)
       @ I+9,06 SAY "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ" COLOR NTOCOLOR(VC_B[((I/5)+1)],.T.)
       @ I+8,08 SAY REPLICATE(CHR(219),TONACOR[(I/5)+1,OP_COR])
   NEXT
   T_L=1
   T_C=TONACOR[T_L,OP_COR]
   VMUDA=.F.
   DO WHILE .T.
      if T_C=0
         @ (T_L*5)+3,07 SAY CHR(175) COLOR "W+/N*"
      else
         @ (T_L*5)+3,07 SAY " "+REPLICATE(CHR(219),T_C) COLOR "W+/N*"
      endif
      TECLA := INKEY( 0 )
      if TECLA=1
         TON_OLD := {{00,00,00,00,42,42,42,42,21,21,21,21,63,63,63,63},{00,00,42,42,00,00,21,42,21,21,63,63,21,21,63,63},{00,42,00,42,00,42,00,42,21,63,21,63,21,63,21,63}}
         TONACOR[1,OP_COR]=TON_OLD[1,OP_COR]
         TONACOR[2,OP_COR]=TON_OLD[2,OP_COR]
         TONACOR[3,OP_COR]=TON_OLD[3,OP_COR]
         T_C:=TON_OLD[T_L,OP_COR]
         RELEASE TON_OLD
      endif
      if TECLA = 5
         T_L += -1
         VMUDA=.T.
      else
         if TECLA = 24
            T_L += 1
            VMUDA=.T.
         else
            T_L += 0
            VMUDA=.F.
         endif
      endif
      T_L = Iif( T_L < 1, 3, Iif( T_L > 3, 1, T_L ) )
      if VMUDA=.T.
         T_C=TONACOR[(T_L),OP_COR]
         VMUDA=.F.
      endif
      T_C += Iif( TECLA = 19, -1, Iif( TECLA = 4, 1, 0 ) )
      T_C = Iif( T_C < 0, 63, Iif( T_C > 63, 0, T_C ) )
      TONACOR[T_L,OP_COR]:=T_C
      @ 08,07 SAY " "+REPLICATE(CHR(176),63) COLOR NTOCOLOR(VC_B[1],.T.)
      @ 13,07 SAY " "+REPLICATE(CHR(176),63) COLOR NTOCOLOR(VC_B[2],.T.)
      @ 18,07 SAY " "+REPLICATE(CHR(176),63) COLOR NTOCOLOR(VC_B[3],.T.)

      @ 08,08 SAY REPLICATE(CHR(219),TONACOR[1,OP_COR])
      @ 13,08 SAY REPLICATE(CHR(219),TONACOR[2,OP_COR])
      @ 18,08 SAY REPLICATE(CHR(219),TONACOR[3,OP_COR])
      DO CASE
         CASE T_L=1
              VGAPALETTE((OP_COR)-1,T_C,TONACOR[2,OP_COR],TONACOR[3,OP_COR])
         CASE T_L=2
              VGAPALETTE((OP_COR)-1,TONACOR[1,OP_COR],T_C,TONACOR[3,OP_COR])
         CASE T_L=3
              VGAPALETTE((OP_COR)-1,TONACOR[1,OP_COR],TONACOR[2,OP_COR],T_C)
      ENDCASE
      if TECLA = 27 .OR. TECLA = 13
         if !(OP_COR=13)
            VGAPALETTE(12,VAL(SUBSTR(R_OLD,1,2)),VAL(SUBSTR(R_OLD,3,2)),VAL(SUBSTR(R_OLD,5,2)))
         endif
         if !(OP_COR=11)
            VGAPALETTE(10,VAL(SUBSTR(V_OLD,1,2)),VAL(SUBSTR(V_OLD,3,2)),VAL(SUBSTR(V_OLD,5,2)))
         endif
         if !(OP_COR=10)
            VGAPALETTE(09,VAL(SUBSTR(A_OLD,1,2)),VAL(SUBSTR(A_OLD,3,2)),VAL(SUBSTR(A_OLD,5,2)))
         endif
         RESTSCREEN(01, 00, 23, 79,TELA_PRI)
         EXIT
      endif
    ENDDO
ENDDO
SETCOLOR(VQCOR)
RESTSCREEN(01, 00, 23, 79,TELA_PRI)
VAR := ""
FOR I=1 TO 16
    VAR += STRZERO(TONACOR[1,I],2,0)
    VAR += STRZERO(TONACOR[2,I],2,0)
    VAR += STRZERO(TONACOR[3,I],2,0)
NEXT
MEMOWRIT( "TONS.CFG", VAR )

FUNCTION FEC(VA,VB)
FOR I = 0 TO 15
    DO CASE
       CASE I<(VA-5)
            @ I+VL, VC SAY REPLICATE("Û",16) COLOR NTOCOLOR(I,.T.)
       CASE I=(VA-5)
            @ I+VL+1, VC SAY REPLICATE("Û",16) COLOR NTOCOLOR(I,.T.)
       CASE I>(VA-5)
            @ I+VL+2, VC SAY REPLICATE("Û",16) COLOR NTOCOLOR(I,.T.)
    ENDCASE
NEXT
@ VL-1, VB-1, VL+18, VB+16 BOX "Û" COLOR "09/01"
if VA=5
   @ VA-1,VB-1 TO VA+1,VB+16 COLOR "N/W"
else
   @ VA-1,VB-1 TO VA+1,VB+16 COLOR NTOCOLOR((VA-5),.T.)
endif
return ""
