#include <sci.ch>
//#include "wvtwin.ch"
//#include "hbgtwvg.ch"
//#include "wvgparts.ch"

INIT FUNCTION AppSetup()
     REQUEST HB_LANG_PT
     REQUEST HB_CODEPAGE_PT850
     REQUEST HB_GT_GUI_DEFAULT
     REQUEST HB_GT_WVG
     REQUEST HB_GT_WVT
     REQUEST HB_GT_WGU
     HB_LANGSELECT("PT")
     HB_CDPSELECT( "PT850" )
     SET(_SET_DBFLOCKSCHEME,DB_DBFLOCK_DEFAULT)
     INICIAJANELA(00,00,24,80)
return Nil

function main()
	PRIVATE cNome1:="", cNome2:="", cMens:={"",""}   
	DO while( true ) 
		SET COLOR TO
		CLEAR
		@10,00 SAY "INICIAR"
		INKEY(0)
		if LastKey() = 27
			EXIT
		endif
		INICIAJANELA(00,00,40,110)
		//Cores()
		sColor()
		INICIAJANELA(00,00,24,80)
	ENDDO
	return Nil

FUNCTION Cores
LOCAL aPalette:=hb_gtInfo( HB_GTI_PALETTE )

   aPalette[ 8 ] := RGB( 255, 0, 0 ) //Vermelho

   hb_gtInfo( HB_GTI_PALETTE, aPalette )

return Nil

******************************************************************************
FUNCTION SColor
******************************************************************************
* Autor(es)     : Alexandre Simões                                           *
* Data          : Outubro/93                                                 *
*----------------------------------------------------------------------------*
* Objetivo      : Configuracao de cores a serem usadas no sistema            *
* Observacao    :                                                            *
* Cores Padroes : CorS01W      -> frente das caixas dos menus                *
* =============   CorS02W      -> fundo das caixas dos menus                 *
*                 CorS03W      -> frente dos dados dos menus                 *
*                 CorS04W      -> fundo dos dados dos menus                  *
*                 CorS05W      -> frente da barra de selecao                 *
*                 CorS06W      -> fundo da barra de selecao                  *
*                 CorSSombraW  -> cor da sombra das caixas                   *
*                 CorSFundoW   -> fundo da tela padrao (reticula)            *
*                 CorSMoldW    -> moldura da tela padrao                     *
*                 CorSTitW     -> titulo do sistema e mensagens da linha 22  *
*                 CorSOldMW    -> cor dos menus anteriores                   *
*                 CorSBMoldW   -> moldura das caixas de entrada de dados     *
*                 CorSBTitW    -> titulo dos campos das entradas de dados    *
*                 CorSBEntW    -> cor da entrada de dados                    *
*                 CorSBCMoldW  -> moldura das caixas de consultas            *
*                 CorSBCDadoW  -> dados das caixas de consultas              *
*                 CorSBExDadoW -> display de confirmacao em caixa            *
*                 CorSExDadoW  -> display de confirmacao fora da caixa       *
* Sintaxe       : SColor()                                                   *
* Parametros    :                                                            *
* Retorno       : .T.                                                        *
* Fun. chamadas : Masc()                                                     *
*                 SetC()                                                     *
*                 Box()                                                      *
*                 GetColor()                                                 *
*                 COLORWIN()                                                 *
*                 ReSetC()                                                   *
* Arquivo fonte : SColor.prg                                                 *
* Arq. de dados :                                                            *
* Veja tamb‚m   :                                                            *
******************************************************************************

LOCAL nPosicao, nConta,;
      cTelaAnt := SaveScreen(0, 0, MaxRow(), MaxCol())

RESTORE FROM BCOR000.SYS ADDITIVE

CorS01W     := CorS01W 
CorS02W     := CorS02W
CorS03W     := CorS03W
CorS04W     := CorS04W
CorS05W     := CorS05W
CorS06W     := CorS06W

CorSSombraW := CorSSombra
CorSFundoW  := CorSFundoW
CorSMoldW   := CorSMoldW
CorSTitW    := CorSTitW
CorSOldMW   := CorSOldMW
CorSBMoldW  := CorSBMoldW
CorSBTitW   := CorSBTitW
CorSBEntW   := CorSBEntW
CorSBCMoldW := CorSBCMold
CorSBCDadoW := CorSBCDado
CorSBExDadoW:= CorSBExDad
CorSExDadoW := CorSExDado

//if !Type(PRGV)=="U"
//endif

SET COLOR TO &corsfundow

SET COLOR TO &corsmoldw

@03,53 TO 35,53

TecValidW := Chr(4) + Chr(19) + Chr(5) + Chr(24) + Chr(18) + Chr(3) + Chr(13)

SET COLOR TO N/W

@00,00 SAY PADC('* DEFINI€ÇO DE CORES PARA SISTEMAS *',MaxCol()+1) COLOR "R+/W*"

SET COLOR TO

SetC(0,1)

@02,02 TO 36,51 COLOR "+W"

nCol:=3
nLin:=4

FOR FundoW:=0 TO 15

    ColW := (FundoW * 3) + nCol

    FOR FrenteW:=0 TO 15

        CorW:=Transform(FrenteW,'99') + '/' + Transform(FundoW,'99')

        SET COLOR TO &CorW

        if FrenteW = 0
           @nLin-1,ColW SAY '   '
        endif

        LinW := (FrenteW * 2) + nLin

        @LinW,  ColW SAY '  '

        @LinW+1,ColW SAY '   '

    NEXT

NEXT

BoxNew(17,56,21,MaxCol()-2,CorSBCMoldW)

BoxNew(05,56,07,MaxCol()-2,CorSBCMoldW)

SET COLOR TO &CorSBCDadoW

@18,57 SAY ' SETAS       - Alterar padrÆo de cor    '

@19,57 SAY ' Pg Up/Pg Dn - Op‡äes                   '

@20,57 SAY ' ENTER       - Real‡ado / ESC - Termina '

SET COLOR TO

TelaCorW = SaveScreen(00,00,MaxRow(),54)

TelaAuxW = SaveScreen(00,60,MaxRow()-1,MaxCol())

LinW := 00

ColW := 00

OpW  := 1

IniW := .T.

Keyboard Chr(5)+Chr(24)

DO while( true )

   DO CASE
   CASE (OpW > 0 .AND. OpW < 6) .OR. OpW = 8
        ExibeCaixa()
   CASE OpW = 6 .OR. OpW = 7
        ExibeTit()
   CASE OpW = 9 .OR. OpW = 10 .OR. OpW = 11
        ExibeGet()
   CASE OpW = 12 .OR. OpW = 13
        ExibeCons()
   CASE OpW = 14
        ExibeMensC()
   CASE OpW = 15
        ExibeMens()
   ENDCASE

   if '+' $ GetColor(LinW+1,ColW+1)
      SET COLOR TO N*/W
      @10,56 SAY ' REALCADO '
      SET COLOR TO
   else
      SET COLOR TO &CorSFundoW
      @10,56 SAY Space(9) //'°°°°°°°°°°'
      SET COLOR TO
   endif

   Inkey(0)

   if LastKey() = 27
   
      if MsgNaoSim("Salvar Altera‡äes?", "Aten‡Æo")
      
         SET COLOR TO
         CLEAR
    
         nPosicao    := At(',',CorSBCDadoW)
    
         if nPosicao > 0
            CorSBCDadoW := Left(CorSBCDadoW,nPosicao - 1)
         endif
    
         cCorAux     := SubStr(CorSBCDadoW, At('/', CorSBCDadoW))
         CorSBCDadoW := CorSBCDadoW + ',n/w'
         CorSBrowseW := CorSBCDadoW + ',,' + CorSBCMoldW + ',r+' + cCorAux
          
         fErase("bcor000.ini")
         
         StrFile("CorS01W="     +'"'+CorS01W     +'"'+HB_EOL(),"bcor000.ini",.T.)
         StrFile("CorS02W="     +'"'+CorS02W     +'"'+HB_EOL(),"bcor000.ini",.T.)
         StrFile("CorS03W="     +'"'+CorS03W     +'"'+HB_EOL(),"bcor000.ini",.T.)
         StrFile("CorS04W="     +'"'+CorS04W     +'"'+HB_EOL(),"bcor000.ini",.T.)
         StrFile("CorS05W="     +'"'+CorS05W     +'"'+HB_EOL(),"bcor000.ini",.T.)
         StrFile("CorS06W="     +'"'+CorS06W     +'"'+HB_EOL(),"bcor000.ini",.T.)
         StrFile("CorSSombraW=" +'"'+CorSSombraW +'"'+HB_EOL(),"bcor000.ini",.T.)
         StrFile("CorSFundoW="  +'"'+CorSFundoW  +'"'+HB_EOL(),"bcor000.ini",.T.)
         StrFile("CorSMoldW="   +'"'+CorSMoldW   +'"'+HB_EOL(),"bcor000.ini",.T.)
         StrFile("CorSTitW="    +'"'+CorSTitW    +'"'+HB_EOL(),"bcor000.ini",.T.)
         StrFile("CorSOldMW="   +'"'+CorSOldMW   +'"'+HB_EOL(),"bcor000.ini",.T.)
         StrFile("CorSBMoldW="  +'"'+CorSBMoldW  +'"'+HB_EOL(),"bcor000.ini",.T.)
         StrFile("CorSBTitW="   +'"'+CorSBTitW   +'"'+HB_EOL(),"bcor000.ini",.T.)
         StrFile("CorSBEntW="   +'"'+CorSBEntW   +'"'+HB_EOL(),"bcor000.ini",.T.)
         StrFile("CorSBCMoldW=" +'"'+CorSBCMoldW +'"'+HB_EOL(),"bcor000.ini",.T.)
         StrFile("CorSBCDadoW=" +'"'+CorSBCDadoW +'"'+HB_EOL(),"bcor000.ini",.T.)
         StrFile("CorSBExDadoW="+'"'+CorSBExDadoW+'"'+HB_EOL(),"bcor000.ini",.T.)
         StrFile("CorSExDadoW=" +'"'+CorSExDadoW +'"'+HB_EOL(),"bcor000.ini",.T.)
    
         //SAVE ALL LIKE CorS* TO BCOR000.SYS
      endif
      EXIT 
   endif

   if ! Chr(LastKey()) $ TecValidW
      LOOP
   endif

   if LastKey() = 18 .AND. OpW > 1
      IniW:=.T.
      OpW--
      LOOP
   endif

   if LastKey() = 3 .AND. OpW < 15
      IniW:=.T.
      OpW++
      LOOP
   endif

   if LastKey() <> 13
      RestScreen(00,00,MaxRow(),54,TelaCorW)
   endif

   DO CASE
   CASE LastKey() = 19  .AND. ColW > 3
        ColW := ColW - 3
   CASE LastKey() = 4  .AND. ColW < 48
        ColW := ColW + 3
   CASE LastKey() = 5  .AND. LinW > 3
        LinW := LinW - 2
   CASE LastKey() = 24 .AND. LinW < 33
        LinW := LinW + 2
   ENDCASE

   
   CorW   := GetColor(LinW+1,ColW+1)

   //@MaxRow()-1,00 CLEAR TO MaxRow(),MaxCol()
   //@MaxRow()-1,00 SAY corw
   //@MaxRow()  ,00 SAY LinW
   //@MaxRow()  ,Col()+2 SAY ColW
   
   if ColW >= 27   
      CorW   := StrTran(CorW,"+","*")
      if LinW >= 19
         PosW  := At('*',CorW)
         CorW  = '+'+SubStr(CorW,PosW+1)
      endif
   endif

   @MaxRow(),00 SAY PADR(" Cor: "+CorW,MaxCol()+1) COLOR "B/W*"
   
   PosW   := At('/',CorW)

   CorFrW := Left(CorW,PosW - 1)

   CorFuW := SubStr(CorW,PosW + 1)

   if LastKey() = 13

      if ! '+' $ CorW
         CorFrW := '+' + CorFrW
      else
         CorFrW := SubStr(CorFrW,2)
      endif

      CorW := CorFrW + '/' + CorFuW
      
      COLORWIN(LinW+1,ColW+1,LinW+1,ColW+1,CorW)

   endif

   PosW  := At('/',CorW)
   
   CorAW := CorW
   
   if ColW < 47
      CorW  = 'W+' + SubStr(CorW,PosW)
   else
      CorW  = 'R+' + SubStr(CorW,PosW)
   endif

   SET COLOR TO &CorW
   
   @LinW,ColW TO LinW + 2, ColW + 2 color CorW

   DO CASE
      CASE OpW = 1
           CorS01W      :=Left(CorAW,PosW-1)
           CorS02W      :=SubStr(CorAW,PosW+1)
      CASE OpW = 2
           CorS03W      :=Left(CorAW,PosW-1)
           CorS04W      :=SubStr(CorAW,PosW+1)
      CASE OpW = 3
           CorS05W      :=Left(CorAW,PosW-1)
           CorS06W      :=SubStr(CorAW,PosW+1)
      CASE OpW = 4
           CorSSombraW  :=CorAW
      CASE OpW = 5
           CorSFundoW   :=CorAW
      CASE OpW = 6
           CorSMoldW    :=CorAW
      CASE OpW = 7
           CorSTitW     :=CorAW
      CASE OpW = 8
           CorSOldMW    :=CorAW
      CASE OpW = 9
           CorSBMoldW   :=CorAW
      CASE OpW = 10
           CorSBTitW    :=CorAW
      CASE OpW = 11
           CorSBEntW    :=CorAW
      CASE OpW = 12
           CorSBCMoldW  :=CorAW
      CASE OpW = 13
           CorSBCDadoW  :=CorAW
      CASE OpW = 14
           CorSBExDadoW :=CorAW
      CASE OpW = 15
           CorSExDadoW  :=CorAW
   ENDCASE

ENDDO

ResetC()

RESTSCREEN(0, 0, MaxRow(), MaxCol(), cTelaAnt)

return Nil

FUNCTION InformaCor

   CorW   := GetColor(LinW+1,ColW+1)

   if ColW >= 27   
      CorW   := StrTran(CorW,"+","*")
      if LinW >= 19
         PosW  := At('*',CorW)
         CorW  = '+'+SubStr(CorW,PosW+1)
      endif
   endif

   @MaxRow(),00 SAY PADR(" Cor: "+CorW,MaxCol()+1) COLOR "B/W*"

return Nil

*
FUNCTION VerCor(A,B)
*
******************************************************************************
* Autor         : Alexandre Simões                                           *
* Data          : Outubro/93                                                 *
*----------------------------------------------------------------------------*
* Objetivo      : verifica cor atual do ponto indicado                       *
* Funcionamento : chamada pela procedure scolor()                            *
* Parametro(s)  :                                                            *
* Chamada       :                                                            *
******************************************************************************

CorAtuW := GetColor(A,B)

TeclaW := LastKey()

if TeclaW = 19 .OR. TeclaW = 4 .OR. TeclaW = 5 .OR. TeclaW = 24
   return .T.
endif

PosAtuW := At('/',CorAtuW)

CorFrW  := Left(CorAtuW,  PosAtuW - 1)

CorFuW  := SubStr(CorAtuW,PosAtuW + 1)

if '+' $ CorFrW
   //CorFrW:=SubStr(CorFrW,2)
   HW:=.T.
else
   HW:=.F.
endif

nLin:=3

DO CASE
   CASE upper(CorFrW) == 'N'
        LinW:= nLin
   CASE upper(CorFrW) == 'B'
        LinW:= nLin+2
   CASE upper(CorFrW) == 'G'
        LinW:= nLin+4
   CASE upper(CorFrW) == 'BG'
        LinW:= nLin+6 
   CASE upper(CorFrW) == 'R'
        LinW:= nLin+8 
   CASE upper(CorFrW) == 'RB'
        LinW:= nLin+10
   CASE upper(CorFrW) == 'GR'
        LinW:= nLin+12
   CASE upper(CorFrW) == 'W'
        LinW:= nLin+14
   CASE upper(CorFrW) == '+N'
        CorFrW:="*N"
        LinW  := nLin+16
   CASE upper(CorFrW) == '+B'
        CorFrW:="*B"
        LinW  := nLin+18
   CASE upper(CorFrW) == '+G'
        CorFrW:="*G"
        LinW  := nLin+20
   CASE upper(CorFrW) == '+BG'
        CorFrW:='*BG'
        LinW  := nLin+22
   CASE upper(CorFrW) == '+R'
        CorFrW:='*R'
        LinW  := nLin+24
   CASE upper(CorFrW) == '+RB'
        CorFrW:='*RB'
        LinW  := nLin+26
   CASE upper(CorFrW) == '+GR'
        CorFrW:='*GR'
        LinW  := nLin+28
   CASE upper(CorFrW) == '+W'
        CorFrW:='*W'
        LinW  := nLin+30
ENDCASE

nCol:=3

DO CASE
   CASE upper(CorFuW) == 'N'
        ColW := nCol * 1
   CASE upper(CorFuW) == 'B'
        ColW := nCol * 2
   CASE upper(CorFuW) == 'G'
        ColW := nCol * 3
   CASE upper(CorFuW) == 'BG'
        ColW := nCol * 4
   CASE upper(CorFuW) == 'R'
        ColW := nCol * 5
   CASE upper(CorFuW) == 'RB'
        ColW := nCol * 6
   CASE upper(CorFuW) == 'GR'
        ColW := nCol * 7
   CASE upper(CorFuW) == 'W'
        ColW := nCol * 8
   CASE upper(CorFuW) == '+N'
        CorFuW:='*N'
        ColW  := nCol * 9
   CASE upper(CorFuW) == '+B'
        CorFuW:='*B'
        ColW  := nCol * 10
   CASE upper(CorFuW) == '+G'
        CorFuW:='*G'
        ColW  := nCol * 11
   CASE upper(CorFuW) == '+BG'
        CorFuW:='*BG'
        ColW  := nCol * 12
   CASE upper(CorFuW) == '+R'
        CorFuW:='*R'
        ColW  := nCol * 13
   CASE upper(CorFuW) == '+RB'
        CorFuW:='*RB'
        ColW  := nCol * 14
   CASE upper(CorFuW) == '+GR'
        CorFuW:='*GR'
        ColW  := nCol * 15
   CASE upper(CorFuW) == '+W'
        CorFuW:='*W'
        ColW  := nCol * 16
ENDCASE

if LastKey() <> 13
   RestScreen(00,00,MaxRow(),54,TelaCorW)
   SET COLOR TO W+/&CorFuW
   @LinW,ColW TO LinW + 2, ColW + 2
   SET COLOR TO
endif

if HW
   COLORWIN(LinW+1,ColW+1,LinW+1,ColW+1,'+' + CorFrW + '/' + CorFuW)
endif

return .T.
*
**********************
PROCEDURE ExibeCaixa
**********************
*
******************************************************************************
* Autor         : Alexandre Simões                                           *
* Data          : Outubro/93                                                 *
*----------------------------------------------------------------------------*
* Objetivo      : seleciona a cor da caixa                                   *
* Funcionamento : chamada pela procedure scolor()                            *
* Parametro(s)  :                                                            *
* Chamada       :                                                            *
******************************************************************************

RestScreen(00,60,MaxRow()-1,MaxCol(),TelaAuxW)

COLORWIN(09,66,16,95,CorSFundoW)

SET COLOR TO &CorS01W/&CorS02W

@10,70 TO 14,91

SET COLOR TO &CorS03W/&CorS04W

@11,71 CLEAR TO 13,90

@11,71 SAY '   DADOS  / MENU    '

SET COLOR TO &CorS05W/&CorS06W

@12,71 SAY '  BARRA DE SELE€ÇO  '

SET COLOR TO &CorS03W/&CorS04W

@13,71 SAY '   DADOS  / MENU    '

COLORWIN(15,72,15,93,CorSSombraW)

COLORWIN(11,92,15,93,CorSSombraW)

DO CASE
   CASE OpW = 1
        SET COLOR TO &CorSBCDadoW
        @06,58 SAY 'MOLDURA DAS CAIXAS'
        SET COLOR TO W+*
        @10,68 SAY chr(26)
        SET COLOR TO
        VerCor(10,72)
   CASE OpW = 2
        SET COLOR TO &CorSBCDadoW
        @06,58 SAY 'DADOS DA CAIXA'
        SET COLOR TO W+*
        @13,88 SAY chr(27)
        SET COLOR TO
        VerCor(11,71)
   CASE OpW = 3
        SET COLOR TO &CorSBCDadoW
        @06,58 SAY 'COR DA BARRA DE SELE€ÇO'
        SET COLOR TO W+*
        @11,90 SAY chr(25)
        SET COLOR TO
        VerCor(12,71)
   CASE OpW = 4
        SET COLOR TO &CorSBCDadoW
        @06,58 SAY 'COR DA SOMBRA'
        SET COLOR TO W+*
        @16,80 SAY chr(24)
        SET COLOR TO
        VerCor(15,72)
   CASE OpW = 5
        SET COLOR TO &CorSBCDadoW
        @06,58 SAY 'COR DO FUNDO'
        SET COLOR TO W+*
        @16,96 SAY chr(27)
        SET COLOR TO
        VerCor(16,66)
   CASE OpW = 8
        COLORWIN(10,70,14,91,CorSOldMW)
        COLORWIN(12,71,12,90,'n/w')
        SET COLOR TO &CorSBCDadoW
        @06,58 SAY 'COR DOS MENUS ANTERIORES'
        SET COLOR TO W+*
        @12,93 SAY chr(27)
        SET COLOR TO
        VerCor(10,70)
ENDCASE

return Nil
*
*********************
PROCEDURE ExibeCons
*********************
******************************************************************************
* Autor         : Alexandre Simões                                           *
* Data          : Outubro/93                                                 *
*----------------------------------------------------------------------------*
* Objetivo      : exibe a tela de consulta                                   *
* Funcionamento : chamada pela procedure scolor()                            *
* Parametro(s)  :                                                            *
* Chamada       :                                                            *
******************************************************************************
RestScreen(00,60,MaxRow()-1,MaxCol(),TelaAuxW)

SET COLOR TO &CorSBCMoldW

@10,70 TO 14,91

SET COLOR TO &CorSBCDadoW

@11,71 CLEAR TO 13,90

@11,71 SAY '       DADOS   '

@12,71 SAY '       DADOS   '

@13,71 SAY '       DADOS   '

SET COLOR TO

COLORWIN(15,72,15,93,CorSSombraW)

COLORWIN(11,92,15,93,CorSSombraW)

DO CASE
CASE OpW = 12
     SET COLOR TO &CorSBCDadoW
     @06,58 SAY 'MOLDURA DAS CAIXAS DE CONSULTA'
     SET COLOR TO W+*
     @10,68 SAY chr(26)
     SET COLOR TO
     VerCor(10,72)
CASE OpW = 13
     SET COLOR TO &CorSBCDadoW
     @06,58 SAY 'DADOS DAS CAIXAS'
     SET COLOR TO W+*
     @12,71 SAY chr(26)
     SET COLOR TO
     VerCor(12,72)
ENDCASE

return Nil
*
*******************
PROCEDURE ExibeGet
*******************
******************************************************************************
* Autor         : Alexandre Simões                                           *
* Data          : Outubro/93                                                 *
*----------------------------------------------------------------------------*
* Objetivo      : cor da entrada de dados                                    *
* Funcionamento : chamada pela procedure scolor()                            *
* Parametro(s)  :                                                            *
* Chamada       :                                                            *
******************************************************************************

RestScreen(00,60,MaxRow()-1,MaxCol(),TelaAuxW)

SET COLOR TO &CorSBMoldW

@10,70 TO 14,91

SET COLOR TO &CorSBTitW

@11,71 CLEAR TO 13,90

@11,71 SAY ' Campo 1 : '

@12,71 SAY ' Campo 2 : '

@13,71 SAY ' Campo 3 : '

SET COLOR TO &CorSBEntW

@11,83 SAY 'DADO 1'

@12,83 SAY 'DADO 2'

@13,83 SAY 'DADO 3'

SET COLOR TO

DO CASE
   CASE OpW = 9
        set color to &CorSBCDadoW
        @06,58 SAY 'MOLDURA DAS CAIXAS DE ENTRADA DE DADOS'
        set color to w+*
        @10,68 SAY chr(26)
        set color to
        VerCor(10,72)
   CASE OpW = 10
        set color to &CorSBCDadoW
        @06,58 SAY 'TITULO DO CAMPOS'
        set color to w+*
        @12,71 SAY chr(26)
        set color to
        VerCor(12,72)
   CASE OpW = 11
        set color to &CorSBCDadoW
        @06,58 SAY 'ENTRADA DE DADOS'
        set color to w+*
        @13,90 SAY chr(27)
        set color to
        VerCor(13,87)
ENDCASE

return Nil
*
**********************
PROCEDURE ExibeMens
**********************
******************************************************************************
* Autor         : Alexandre Simões                                           *
* Data          : Outubro/93                                                 *
*----------------------------------------------------------------------------*
* Objetivo      : display de confirmacao do dado digitado                    *
* Funcionamento : chamada pela procedure scolor()                            *
* Parametro(s)  :                                                            *
* Chamada       :                                                            *
******************************************************************************

RestScreen(00,60,MaxRow()-1,MaxCol(),TelaAuxW)

SET COLOR TO &CorSExDadoW

@ 12,76 SAY ' DESCRI€ÇO '

SET COLOR TO

SET COLOR TO &CorSBCDadoW

@06,58 SAY 'DESC. DO DADO DIGITADO (FORA DA CAIXA)'

SET COLOR TO w+*

@12,74 SAY chr(26)

SET COLOR TO

VerCor(12,76)

return Nil
*
***********************
PROCEDURE ExibeMensC
***********************
*
******************************************************************************
* Autor         : Alexandre Simões                                           *
* Data          : Outubro/93                                                 *
*----------------------------------------------------------------------------*
* Objetivo      : exibe mensagem dentro das caixas                           *
* Funcionamento : chamada pela procedure scolor()                            *
* Parametro(s)  :                                                            *
* Chamada       :                                                            *
******************************************************************************

RestScreen(00,60,MaxRow()-1,MaxCol(),TelaAuxW)

SET COLOR TO &CorSBMoldW

@10,70 TO 14,91

SET COLOR TO &CorSBTitW

@11,71 CLEAR TO 13,90

@11,71 SAY ' Campo 1 : '

@12,71 SAY ' Campo 2 : '

@13,71 SAY ' Campo 3 : '

set color to &CorSBExDadoW

@11,83 SAY 'DADO 1'

@12,83 SAY 'DADO 2'

@13,83 SAY 'DADO 3'

SET COLOR TO

COLORWIN(15,72,15,93,CorSSombraW)

COLORWIN(11,92,15,93,CorSSombraW)

SET COLOR TO &CorSBCDadoW

@06,58 SAY 'DESCRI€ÇO DO DADO DIGITADO  (NA CAIXA)'

SET COLOR TO w+*

@13,90 SAY chr(27)

SET COLOR TO

VerCor(13,87)

return Nil
*
*********************
PROCEDURE ExibeTit
*********************
*
******************************************************************************
* Autor         : Alexandre Simões                                           *
* Data          : Outubro/93                                                 *
*----------------------------------------------------------------------------*
* Objetivo      : exibe o titulo selecionado                                 *
* Funcionamento : chamada pela procedure scolor()                            *
* Parametro(s)  :                                                            *
* Chamada       :                                                            *
******************************************************************************

RestScreen(00,60,MaxRow()-1,MaxCol(),TelaAuxW)

SET COLOR TO &CorSMoldW

@11,70 TO 14,91 DOUBLE

SET COLOR TO &CorSTitW

@12,71 CLEAR TO 13,90

@12,71 SAY ' TITULO DO SISTEMA  '

@13,71 SAY ' LINHA DE MENSAGEM  '

DO CASE
CASE OpW = 6
     SET COLOR TO &CorSBCDadoW
     @06,58 SAY 'MOLDURA DA TELA PRINCIPAL'
     SET COLOR TO w+*
     @11,68 SAY chr(26)
     SET COLOR TO
     VerCor(11,72)
CASE OpW = 7
     SET COLOR TO &CorSBCDadoW
     @06,58 SAY 'TITULO DO SISTEMA E LINHA DE MENSAGEM'
     SET COLOR TO W+*
     @12,90 SAY chr(27)
     SET COLOR TO
     VerCor(13,71)
ENDCASE

return Nil
*
*---------------------------------------------------------------------------*
*---------------------------------------------------------------------------*

FUNCTION MsgNaoSim(cMensagem,cTitulo)
DEFAULT cTitulo TO "Aviso do Sistema"
return MsgNoYes(HB_OemToAnsi(cMensagem),Hb_OemToAnsi(cTitulo))

FUNCTION MsgSimNao(cMensagem,cTitulo)
DEFAULT cTitulo TO "Aviso do Sistema"
return MsgYesNo(HB_OemToAnsi(cMensagem),Hb_OemToAnsi(cTitulo))

FUNCTION MsgSimNaoCancela(cMensagem,cTitulo)
DEFAULT cTitulo TO "Aviso do Sistema"
return MsgYesNoCancel(HB_OemToAnsi(cMensagem),Hb_OemToAnsi(cTitulo))

FUNCTION Info(cMensagem,cTitulo)
DEFAULT cTitulo TO "Aviso do Sistema"
return MsgInfo(HB_OemToAnsi(cMensagem),Hb_OemToAnsi(cTitulo))

FUNCTION Pare(cMensagem,cTitulo)
DEFAULT cTitulo TO "Aviso do Sistema"
return MsgStop(HB_OemToAnsi(cMensagem),Hb_OemToAnsi(cTitulo))

FUNCTION Exclama(cMensagem,cTitulo)
DEFAULT cTitulo TO "Aviso do Sistema"
return MsgExclamation(HB_OemToAnsi(cMensagem),Hb_OemToAnsi(cTitulo))

FUNCTION MsgOkCancela(cMensagem,cAviso)
DEFAULT cMensagem TO "",;
        cAviso    TO "Aviso do Sistema"
return MsgOkCancel(HB_OemToAnsi(cMensagem),HB_OemToAnsi(cAviso))

******************************************************************************
STATIC FUNCTION GetColor
******************************************************************************
* Autor(es)     : Alexandre Simões                                           *
* Data          :                                                            *
*----------------------------------------------------------------------------*
* Objetivo      : Retorna a cor de uma posicao da tela                       *
* Observacao    :                                                            *
* Sintaxe       : GetColor(nLin, nCol)                                       *
* Parametros    :  - Numero da linha na tela                           *
*                  - Numero da coluna na tela                          *
* Retorno       :  - String de cor da posicao da tela informada        *
* Fun. chamadas :                                                            *
* Arquivo fonte : GetColor()                                                 *
* Arq. de dados :                                                            *
* Veja tamb‚m   :                                                            *
******************************************************************************

Parameters nLin, nCol
Private cPosicao

cPosicao = SaveScreen(nLin,nCol,nLin,nCol)

return HexCor(DecHex(Asc(SubStr(cPosicao,2,1))))

******************************************************************************
STATIC FUNCTION DecHex
******************************************************************************
* Autor(es)     : Alexandre Simões                                           *
* Data          :                                                            *
*----------------------------------------------------------------------------*
* Objetivo      : Converte decimal para hexa                                 *
* Observacao    :                                                            *
* Sintaxe       : DecHex(nNumero)                                            *
* Parametros    :  - Numero decimal                                 *
* Retorno       :  - Numero hexadecimal                             *
* Fun. chamadas :                                                            *
* Arquivo fonte : GetColor.prg                                               *
* Arq. de dados :                                                            *
* Veja tamb‚m   :                                                            *
******************************************************************************

Parameters nNumero
Private nInt, nDec, cInt, cDec

nInt = Int(nNumero / 16)
nDec = (nNumero / 16) - nInt
nDec = nDec * 16

cInt = if(nInt < 10,str(nInt,1),chr(55 + nInt))
cDec = if(nDec < 10,str(nDec,1),chr(55 + nDec))

return cInt + cDec

******************************************************************************
STATIC FUNCTION HexCor
******************************************************************************
* Autor(es)     : Alexandre Simões                                           *
* Data          :                                                            *
*----------------------------------------------------------------------------*
* Objetivo      : Converte valor hexa para string de cor                     *
* Observacao    :                                                            *
* Sintaxe       : HexCor(cNumero)                                            *
* Parametros    :  - Numero hexadecimal                             *
* Retorno       :  - String de cor                                     *
* Fun. chamadas :                                                            *
* Arquivo fonte :                                                            *
* Arq. de dados :                                                            *
* Veja tamb‚m   :                                                            *
******************************************************************************

Parameters cNumero
Private cBac, cFor, cCor

cFor = right(cNumero,1)
cBac = Left(cNumero ,1)

return ConvCor(cFor) + '/' + ConvCor(cBac)

******************************************************************************
STATIC FUNCTION ConvCor
******************************************************************************
* Autor(es)     : Alexandre Simões                                           *
* Data          :                                                            *
*----------------------------------------------------------------------------*
* Objetivo      : Acha as cores para um determinda valor                     *
* Observacao    :                                                            *
* Sintaxe       : ConvCor(cVal)                                              *
* Parametros    :  - Valor da cor                                      *
* Retorno       :  - Cor                                               *
* Fun. chamadas :                                                            *
* Arquivo fonte : GetColor()                                                 *
* Arq. de dados :                                                            *
* Veja tamb‚m   :                                                            *
******************************************************************************

Parameters cVal
Private cDec, nVal, cCor, nDec

nVal = val(cVal)
nDec = if(nVal <> 0 .OR. cVal = '0',nVal,asc(cVal) - 55)

DO CASE

   CASE nDec = 0
        cCor = 'n'
   CASE nDec = 1
        cCor = 'b'
   CASE nDec = 2
        cCor = 'g'
   CASE nDec = 3
        cCor = 'bg'
   CASE nDec = 4
        cCor = 'r'
   CASE nDec = 5
        cCor = 'rb'
   CASE nDec = 6
        cCor = 'gr'
   CASE nDec = 7
        cCor = 'w'
   CASE nDec = 8
        cCor = '+n'
   CASE nDec = 9
        cCor = '+b'
   CASE nDec = 10
        cCor = '+g'
   CASE nDec = 11
        cCor = '+bg'
   CASE nDec = 12
        cCor = '+r'
   CASE nDec = 13
        cCor = '+rb'
   CASE nDec = 14
        cCor = '+gr'
   CASE nDec = 15
        cCor = '+w'
ENDCASE

return cCor

******************************************************************************
FUNCTION BoxNew
******************************************************************************
* Autor(es)     : Alexandre Simões                                           *
* Data          : Outubro/93                                                 *
*----------------------------------------------------------------------------*
* Ojetivo       : Exibicao de caixa com simulacao de sombra e explosao       *
*                 movimentada                                                *
* Observacao    :                                                            *
* Sintaxe       : BoxNew(nLl,nCI,nLF,nCF,[cCor], [lMold])                       *
* Parametros    :    - Linha Inicial                                    *
*                    - Coluna Inicial                                   *
*                    - Linha Final                                      *
*                    - Coluna Final                                     *
*                   - Cor (OPCIONAL)                                   *
*                  - .T. para moldura dupla e .F. para simples        *
*                           (DEFAULT: .F.)                                   *
* Retorno       : .T.                                                        *
* Fun. chamadas : COLORWIN()                                                 *
* Arquivo fonte : Box.prg                                                    *
* Arq. de dados :                                                            *
* Veja tamb‚m   :                                                            *
******************************************************************************

*---------------------------------------------------------------------------*
Parameters li, ci, lf, cf, Co, Mo
*---------------------------------------------------------------------------*

DEFAULT Mo to .F.

TelaTempW := SaveScreen()

CAuxW  = setcolor()

if type('TESTATEMPOW') <> 'N'
   public TestaTempoW
   TestaTempoW = 70
endif

if type('LQIW') <> 'N' .or. type('LQFW') <> 'N' .or. type('CQIW') <> 'N' .or. type('CQFW') <> 'N'
   public LQIW, LQFW, CQIW, CQFW
   LQIW  = 0
   LQFW  = 0
   CQIW  = 0
   CQFW  = 0
endif

if LQIW <> Li .or. LQFW <> Lf .or. CQIW <> Ci .or. CQFW <> Cf

   do case
      case TestaTempoW <= 70
           FatorW = 4
      case TestaTempoW <= 120
           FatorW = 3
      case TestaTempoW <= 180
           FatorW = 2
      otherwise
           FatorW = 1
   endcase

   LQIW  = int((Li + Lf) / 2)
   CQIW  = int((Ci + Cf) / 2)
   LQFW  = LQIW
   CQFW  = CQIW
   LQIAW = LQIW
   LQFAW = LQFW

   if Co = NIL
      set color to &CorS03W/&CorS04W,&CorS05W/&CorS06W
   else
      set color to &Co
  endif

   do while( true )

      if Mo
         @LQIAW,CQIW to LQFAW,CQFW double
      else
         @LQIAW,CQIW to LQFAW,CQFW
      endif

      @LQIAW,CQIW clear to LQFAW,CQFW

      if LQIAW > Li
         LQIW  = LQIW - (0.2 * FatorW)
         LQIAW = int(LQIW)
      endif

      if LQFW < Lf
         LQFW  = LQFW + (0.2 * FatorW)
         LQFAW = int(LQFW)
      endif

      if CQIW > Ci
         CQIW = CQIW - FatorW
      endif

      if CQFW < Cf
         CQFW = CQFW + FatorW
      endif

      if LQIAW <= Li .and. LQFAW >= Lf .and. CQIW <= Ci .and. CQFW >= Cf
         exit
      endif

   enddo

endif

restore screen from TelaTempW

if Co = NIL
   set color to &CorS03W/&CorS04W,&CorS05W/&CorS06W
else
   set color to &Co
endif

@li,ci clear to lf,cf

if Co = NIL
   set color to &CorS01W/&CorS02W
endif

if Mo
   @li,ci to lf,cf double
else
   @li,ci to lf,cf
endif

COLORWIN(LF+1,CI+2,LF+1,CF+2,"N+/N")
COLORWIN(LI+1,CF+1,LF+1,CF+2,"N+/N")

set color to &CAuxW

return .T.

******************************************************************************
FUNCTION ReSetC
******************************************************************************
* Autor(es)     : Alexandre Simões                                           *
* Data          : Outubro/93                                                 *
*----------------------------------------------------------------------------*
* Ojetivo       : Retorna o cursor ao Status anterior ao ultimo "SetC"       *
* Observacao    :                                                            *
* Sintaxe       : ReSetC()                                                   *
* Parametros    :                                                            *
* Retorno       : .T.                                                        *
* Fun. chamadas :                                                            *
* Arquivo fonte : Cursor.prg                                                 *
* Arq. de dados :                                                            *
* Veja tamb‚m   : SetC()                                                     *
******************************************************************************
if type('PilhaCurW') <> 'A' .or. type('IDXCURSORW') <> 'N'
   Public PilhaCurW[30], IdxCursorW
   afill(PilhaCurW,0)
   IdxCursorW = 1
endif

IDXCursorW = IDXCursorW - if(IDXCursorW > 1,1,0)

if PilhaCurW[IDXCursorW] = 0
   set cursor off
else
   set cursor on
endif

return .T.

******************************************************************************
FUNCTION SetC
******************************************************************************
* Autor(es)     : Alexandre Simões                                           *
* Data          : Outubro/93                                                 *
*----------------------------------------------------------------------------*
* Ojetivo       : Seta o cursor                                              *
* Observacao    : Para o correto funcionamento da funcao, o cursor deve ser  *
*                 setado para OFF no inicio do programa                      *
* Sintaxe       : SetC(nLiga, nStatus)                                       *
* Parametros    :  - 1 -> Liga cursor, 0 -> Desliga cursor            *
*                  - 0 -> Inicializa a pilha com o novo Status;     *
*                             1 -> Acrescenta Status `a pilha;               *
*                             2 -> Substitui status atual                    *
* Retorno       : .T.                                                        *
* Fun. chamadas :                                                            *
* Arquivo fonte : Cursor.prg                                                 *
* Arq. de dados :                                                            *
* Veja tamb‚m   : ReSetC()                                                   *
******************************************************************************
Parameters A, B

if type('PilhaCurW') <> 'A' .or. type('IDXCURSORW') <> 'N'
   Public PilhaCurW[30], IdxCursorW
   afill(PilhaCurW,0)
   IdxCursorW = 1
endif

if A = 1
   set cursor on
else
   set cursor off
endif

do case
   case B = 0
        IDXCursorW = 1
        PilhaCurW[IDXCursorW] = A
   case B = 1
        IDXCursorW = IDxCursorW + 1
        PilhaCurW[IDXCursorW] = A
   otherwise
        PilhaCurW[IDXCursorW] = A
endcase

return .T.



FUNCTION IniciaJanela(nLi,nCi,nLf,nCf)
LOCAL oCrt
DEFAULT nLi TO 0,;
        nCi TO 0,;
        nLf TO MaxRow(),;
        nCf TO MaxCol()  
    
     oCrt := WvgCrt():New( , , { nLi,nCi }, { nLf,nCf}, , .T. )
     oCrt:lModal := .F.
     oCrt:icon := "HARB_WIN.ICO"
     oCrt:create()
     oCrt:resizable :=.F.
     WVT_SetFont("Lucida Console")
     WVT_SetTitle("Sistema de Cores")
     WVT_SetAltF4Close(.F. )
     HB_gtInfo( HB_GTI_SPEC, HB_GTS_WNDSTATE, HB_GTS_WS_MAXIMIZED )
     hb_gtInfo( HB_GTI_COMPATBUFFER, .T. )
return Nil 
