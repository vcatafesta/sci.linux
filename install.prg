************************************************************************** *
* PROGRAMA....: INSTALL.PRG                                                *
* DATA........: 25.05.97                                                   *
* AUTHOR......: EDSON MELO DE SOUZA                                        *
* COPYRIGHT...: SOUKI SERVIÄOS EMPRESARIAIS LTDA                           *
* OBJETIVO....: INSTALAR PROGRAMAS COM SEGURANÄA NO HD                     *
* COMPILADO...: CLIPPER INSTALL                                            *
* LINKEDITADO.: RTLINK FI INSTALL OUTPUT INSTALL /PRELINK                  *
*               RTLINK FI INSTALL,MSGPOR /PLL:INSTALL                      *
****************************************************************************
//SETCANCEL(.F.)
CLS
SET DATE BRIT
SET KEY -2 TO SAIR
SEGURANCA()
TELA()
AVISO()
ESPACO()
CAD_REG()
COPIAS()
INSTALA()

******************************************************************************
STATIC FUNCTION CENTER(Arg1,Arg2)
@ Arg1,40 -LEN(Arg2)/2 SAY Arg2
return NIL
******************************************************************************
FUNCTION CAD_REG()
 CENTER(23,"[F3] - ABANDONA O SISTEMA")
 SET CURSOR OFF
 * Tela Superior
 SET COLOR TO B
 @  0, 0 CLEAR TO  24,79
 @01,01 TO 24,79 DOUB
 @ 12,39 SAY "˛"
 @ 12,39 SAY SPACE(1)
 Logo()
 SET CURSOR ON
 SET COLOR TO B+
 CENTER(3,"€€€€€€€∞                €€€€€€€∞                     ")
 CENTER(4,"€€∞                     €€∞                          ")
 CENTER(5,"€€∞       €€∞  €€€€€€∞  €€∞       €€€€€€€∞  €€€€€€€∞ ")
 CENTER(6,"€€€€€€€∞  €€∞  €€∞      €€∞       €€∞  €€∞  €€∞  €€∞ ")
 CENTER(7,"     €€∞  €€∞  €€€€€€∞  €€∞       €€∞  €€∞  €€€€€€∞  ")
 CENTER(8,"     €€∞  €€∞      €€∞  €€∞       €€∞  €€∞  €€∞  €€∞ ")
 CENTER(9,"€€€€€€€∞  €€∞  €€€€€€∞  €€€€€€€∞  €€€€€€€∞  €€€€€€€∞ ")
 SET COLOR TO
 @10,16 CLEAR TO 19,64
 CENTER(23,"[F3] - ABANDONA O SISTEMA")
 DISPBOX(10,14,19,63,2)
 CENTER(11,"TELA DE REGISTRO DO SISTEMA")
 CENTER(12,"ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ")
 TENT=0

 USE REG
 GO TOP
 USU:=USUARIO
 NSERIE:="SKSCB200597-1003/3"
 CENTER(23,"[F3] - ABANDONA O SISTEMA")
 if !EMPTY(USU)
    SET CURS OFF
    @14,16 SAY "Nome       : " + ALLTRIM(USU)
    @16,16 SAY "Nß de SÇrie: " + NSERIE   
    return
 endif

 DO WHILE TENT < 3
    NNOME:=SPACE(30)
    NSERIE:="SKSCB200597-1003/3"
    V_SERIE:=space(18)
    @14,16 SAY "Nome       : " get NNOME     pict '@!' valid!empty(NNOME)
    @16,16 SAY "Nß de SÇrie: " get V_SERIE  VALID!EMPTY(V_SERIE)
    READ
    if EMPTY(USU)
       USE REG
       REPL USUARIO WITH NNOME
       SAVE TO DADOS
       EXIT
    endif
    if USU <> NNOME .OR. V_SERIE <> NSERIE
       ALERT("DADOS INCORRETOS")
       TENT=TENT + 1
       LOOP
    endif
    return
 ENDDO
 if TENT=3 
    ALERT("NÈMERO DE TENTATIVAS ESGOTADAS!;;VOC“ REALMENTE SABE O Nß DE SêRIE ?")
    CLS
    QUIT
 endif
return 
******************************************************************************

FUNCTION INSTALA() // ROTINA PARA INSTALAR OS ARQUIVOS NO DISCO
 CENTER(23,"[F3] - ABANDONA O SISTEMA")
 SET CURSOR OFF
 !C:
 !CD\
 !MD SISCOB10 >NUL
 !CD SISCOB10   >NUL
 CLS
 SET COLOR TO B+
 DISPBOX(00,00,24,79,2)
 CENTER(1,"€€€€€€€∞                €€€€€€€∞                     ")
 CENTER(2,"€€∞                     €€∞                          ")
 CENTER(3,"€€∞       €€∞  €€€€€€∞  €€∞       €€€€€€€∞  €€€€€€€∞ ")
 CENTER(4,"€€€€€€€∞  €€∞  €€∞      €€∞       €€∞  €€∞  €€∞  €€∞ ")
 CENTER(5,"     €€∞  €€∞  €€€€€€∞  €€∞       €€∞  €€∞  €€€€€€∞  ")
 CENTER(6,"     €€∞  €€∞      €€∞  €€∞       €€∞  €€∞  €€∞  €€∞ ")
 CENTER(7,"€€€€€€€∞  €€∞  €€€€€€∞  €€€€€€€∞  €€€€€€€∞  €€€€€€€∞ ")
 SET COLOR TO W+
 CENTER(9,"INSTALANDO ARQUIVOS DO SISTEMA")
 CENTER(10,"ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ")
 SET COLOR TO R+ 
 @12,25 SAY '0%'
 @12,51 SAY '100%'
 SET COLOR TO
 @13,25 say repl('˛',30) color 'r'
 SET COLOR TO 'W+'
 INKEY(1)
 !A:
 RUN REN FILESYS.DAT FILESYS.EXE >NUL
 RUN FILESYS.EXE A:\FILE1.SK_ C:\SISCOB10\SISCOB.PLL >NUL
 @15,13 SAY 'Descomprimindo de A:\SISCOB.PLL' 
 @16,13 SAY '                  C:\SISCOB10\SISCOB.PLL'
 INKEY(3)
 @13,25 SAY REPL('˛',5) COLOR 'GB+'
 X='1'
 @18,13 SAY 'Arquivos Descomprimidos : '
 TONE(1000)
 @18,39 SAY X

 RUN FILESYS.EXE A:\FILE2.SK_ C:\SISCOB10\SISCOB.EXE >NUL
 @15,13 CLEAR TO 16,70
 @15,13 SAY 'Descomprimindo de A:\SISCOB.EXE'
 @16,13 SAY '                  C:\SISCOB10\SISCOB.EXE'
 INKEY(3)
 @13,25 SAY REPL('˛',8) COLOR 'GB+'
 X:='2'
 @18,13 SAY 'Arquivos Descomprimidos : '
 TONE(1000)
 @18,39 SAY X

 RUN FILESYS.EXE A:\FILE3.SK_ C:\SISCOB10\SISREL.FRM >NUL
 @15,13 CLEAR TO 16,70
 @15,13 SAY 'Descomprimindo de A:\SISREL.FRM'
 @16,13 SAY '                  C:\SISCOB10\SISREL.FRM'
 INKEY(3)
 @13,25 SAY REPL('˛',10) COLOR 'GB+'
 X:='3'
 @18,013 SAY 'Arquivos Descomprimidos : '
 TONE(1000)
 @18,39 SAY X

 RUN FILESYS.EXE A:\FILE4.SK_ C:\SISCOB10\SIARQ.DBF >NUL
 @15,13 CLEAR TO 16,70
 @15,13 SAY 'Descomprimindo de A:\SIARQ.DBF'
 @16,13 SAY '                  C:\SISCOB10\SIARQ.DBF'
 INKEY(3)
 @13,25 SAY REPL('˛',13) COLOR 'GB+'
 X:='4'
 @18,13 SAY 'Arquivos Descomprimidos : '
 TONE(1000)
 @18,39 SAY X

 RUN FILESYS.EXE A:\FILE5.SK_ C:\SISCOB10\SIPER.DBF >NUL
 @15,13 CLEAR TO 16,70
 @15,13 SAY 'Descomprimindo de A:\SIPER.DBF'
 @16,13 SAY '                  C:\SISCOB10\SIPER.DBF'
 INKEY(3)
 @13,25 SAY REPL('˛',17) COLOR 'GB+'
 X:='5'
 @18,13 SAY 'Arquivos Descomprimidos : '
 TONE(1000)
 @18,39 SAY X

 RUN FILESYS.EXE A:\FILE6.SK_ C:\SISCOB10\SifAT.DBF >NUL
 @15,13 CLEAR TO 16,70
 @15,13 SAY 'Descomprimindo de A:\SifAT.DBF'
 @16,13 SAY '                  C:\SISCOB10\SifAT.DBF'
 INKEY(3)
 @13,25 SAY REPL('˛',20) COLOR 'GB+'
 X:='6'
 @18,13 SAY 'Arquivos Descomprimidos : '
 TONE(1000)
 @18,39 SAY X

 RUN FILESYS.EXE A:\FILE7.SK_ C:\SISCOB10\BKUP.DBF >NUL
 RUN FILESYS.EXE A:\FILER.SK_ C:\SISCOB10\REG1.DBF >NUL
 @15,13 CLEAR TO 16,70
 @15,13 SAY 'Descomprimindo de A:\BKUP.DBF'
 @16,13 SAY '                  C:\SISCOB10\BKUP.DBF'
 INKEY(3)
 @13,25 SAY REPL('˛',30) COLOR 'GB+'
 X:='7'
 @180,13 SAY 'Arquivos Descomprimidos : '
 TONE(1000)
 @18,39 SAY X
 INKEY(5)
 SET CURSOR ON
 SET COLOR TO W/N
 RUN REN FILESYS.EXE FILESYS.DAT >NUL
 !C:
 !CD\
 !CD C:\SISCOB10
 TONE(5000)
 TONE(5000)
 TONE(5000)
 ALERT("SISTEMA INSTALADO COM SUCESSO;EXECUTE O ARQUIVO < SISCOB.EXE >;NO DIRET‡RIO C:\SISCOB10")
 CLS
return
******************************************************************************
FUNCTION SEGURANCA()
  !VOL>"TESTVOL.TXT"
  DLL_MEM:=MEMOREAD("TESTVOL.TXT")
  VOLUME:=VAR_VOL:=RIGHT(MEMOLINE(DLL_MEM,40,3),9)
  if !FILE ('TESTVOL.MEM')
     SAVE  ALL LIKE VOLUME TO TESTVOL
   else
     RESTORE FROM TESTVOL.MEM ADDITIVE
  endif        
  A:=VOLUME
******************************************************************************
* ROTINA PARA CRIPTOGRAFAR O Nß DO VOLUME E GRAVAR NO DBF

  ENCRYPTA=CHR(ASC(SUBSTR(A,1,1)) +  122)       +;
           CHR(ASC(SUBSTR(A,2,1)) -  152)       +;
           CHR(ASC(SUBSTR(A,3,1)) +  180)       +;
           CHR(ASC(SUBSTR(A,4,1)) -  157)       +;
           CHR(ASC(SUBSTR(A,5,1)) +  108)       +;
           CHR(ASC(SUBSTR(A,6,1)) +  248)       +;
           CHR(ASC(SUBSTR(A,7,1)) +  318)       +;
           CHR(ASC(SUBSTR(A,8,1)) +  110)       +;
           CHR(ASC(SUBSTR(A,9,1)) +  200)
           V_DATAINST=CTOD('01/06/97')

           if DATE() < V_DATAINST
              ALERT("DATA DO SISTEMA INVµLIDA;RETORNE AO PROMPT E;UTILIZE O COMANDO DATE PARA ATUALIZAR A DATA")
              CLS
           endif

           USE REG && ABRE O ARQUIVO E VERifICA SE Jµ EXISTE DADOS NO CAMPO
           GO TOP
           if EMPTY(SENHA)
              REPL SENHA    WITH ENCRYPTA
              REPL DI WITH V_DATAINST
           endif

******************************************************************************
* INICIALIZA A COMPARAÄ«O COM A VARIµVEL DE MEM‡RIA E ARQUIVO DBF

  if VOLUME # VAR_VOL
     AVISO_PIRATARIA()
  endif

  USE REG
  GO TOP 
  PRIVATE A:=SENHA
  D_ENCRYPTA=CHR(ASC(SUBSTR(A,1,1)) -  122)       +;
             CHR(ASC(SUBSTR(A,2,1)) +  152)       +;
             CHR(ASC(SUBSTR(A,3,1)) -  180)       +;
             CHR(ASC(SUBSTR(A,4,1)) +  157)       +;
             CHR(ASC(SUBSTR(A,5,1)) -  108)       +;
             CHR(ASC(SUBSTR(A,6,1)) -  248)       +;
             CHR(ASC(SUBSTR(A,7,1)) -  318)       +;
             CHR(ASC(SUBSTR(A,8,1)) -  110)       +;
             CHR(ASC(SUBSTR(A,9,1)) -  200)

  if VOLUME # D_ENCRYPTA
     AVISO_PIRATARIA()
  endif
return

******************************************************************************
FUNCTION AVISO_PIRATARIA() && EMITE AVISO DE QUE O PROGRAMA ê PIRATA
     @00,00 CLEAR
     FOR L:=1 TO 3
      TONE(900,05)
     ENDFOR

     FOR LL:=1 TO 3
      TONE(800,0.5)
     ENDFOR

     FOR LLL:=1 TO 23
      @01,30 SAY '     COPIA PIRATA' COLOR 'r+*'
      SET COLOR TO
      @LLL,30 SAY '     COPIA PIRATA' COLOR 'r+'
      TONE(700,0.5)
     ENDFOR

     @24,30 SAY '     COPIA PIRATA' COLOR 'r+*'
     SET COLOR TO
     FOR LLLL:=1 TO 10
      TONE(600,0.5)
     ENDFOR

     FOR LLLLL:=1 TO 3
      TONE(500,0.5)
     ENDFOR

     PIRATA:=0
     DO WHILE PIRATA < 1
        TONE(800,8)
        TONE(750,0.9)
        TONE(700,1)
        PIRATA++
      ENDDO
      SETCOLOR('N/N')
      DBCLOSEALL()
      !DEL *.PLL >NUL
      SET COLOR TO
      CLS
      SET COLOR TO G+/N
      TONE(1000,5)
      TONE(2000,5)
      TONE(350,5)
      TONE(400,5)
      ? ""
      ? ""
      ? ""
      ? "                  ØØ REALMENTE ESTE FOI O FIM DE SEU SISTEMA  ÆÆ"
      ? ""
      ? ""
      SET COLOR TO GB+
      ? "                   JAMAIS FAÄA C‡PIA PIRATA, PIRATARIA ê CRIME"
      ? ""
      ? ""
      ? ""
      SET CURS ON
      SET COLOR TO
      QUIT
return

******************************************************************************

FUNCTION ESPACO() && VERifICA O ESPACO EXISTENTE EM DISCO
 X:=DISKSPACE(3)
 N=5000000
 if X < 5000000
    @10,16 CLEAR TO 19,64
    DISPBOX(10,14,19,63,2)
    @11,16 SAY "      ESPAÄO INSUFICIENTE PARA INSTALAÄ«O" color 'GB+'
    @12,22 SAY REPL('ƒ',36)
    @13,16 say ''
    @14,16 SAY "ESPAÄO NECESSµRIO : " + TRANSFORM(N,"9,999,999,999")
    @14,49 SAY " bytes       "
    @15,16 SAY "ESPAÄO EM DISCO   : " + TRANSFORM(X,"9,999,999,999")
    @15,49 SAY " bytes livres"
    @17,18 SAY "REMOVA ALGUNS ARQUIVOS E INSTALE NOVAMENTE" COLOR 'G+'
    INKEY(0)
    SET COLOR TO 
    CLS
    QUIT
  endif
return
******************************************************************************

FUNCTION AVISO() // TELA DE INFORMAÄ«O
 CENTER(23,"[F3] - ABANDONA O SISTEMA")
 TONE(4000,5)
 TONE(3000,5)
 TONE(3500,5)
 TONE(2000,5)
 AVISO:=SAVESCREEN(00,00,34,79)
 SETCOLOR('N/N')
 @00,00 CLEAR TO 24,79
 SET DATE  BRIT
 SET INTEN ON
 SET COLOR TO 'W+'
 DISPBOX(04,15,19,63,2,15)
 @02,17 SAY "                  ATENÄ«O"
 @03,35 SAY REPL('Õ',07)
 @06,17 SAY '1- N«O  EFETUE O SCANDISK.EXE OU O CHKDSK /F,'
 @07,17 SAY 'NO  DISCO  DE  INSTALAÄAO  ( A:\ ou B:\ ) '
 @8,17 SAY 'POIS O SISTEMA SERµ  INUTILIZADO, PERDENDO'
 @9,17 SAY 'ASSIM A GARANTIA DO SOFTWARE.             ' 
 @10,17 SAY ''
 @11,17 SAY '2-' 
 @11,20 SAY 'N«O  FAÄA  C‡PIA  DE  BACKUP  PELO MS-DOS' COLOR 'R+'
 @11,61 SAY ','
 @12,17 SAY 'UTILIZE A ROTINA DE BACKUP CONTIDA DENTRO'
 @13,17 SAY 'DO PROGRAMA. ( SISCOB.EXE )' 
 SET COLOR TO 'GB+'
 CENTER(15,"D£vidas pelo Telefone 283-3962")
 CENTER(16,"Souki Serviáos Empresariais Ltda")
 SET COLOR TO 'R+'
 CENTER(22,"Pressione qq. tecla para continuar...")
 INKEY(0)
 RESTSCREEN(00,00,24,79,AVISO)
 CLS
return
******************************************************************************

FUNCTION COPIAS()  && VERifICA O Nß DE C‡PIAS DISPON÷VEIS P/ INSTALAÄ«O

 SET CURSOR OFF

 CENTER(22,"Pressione algo para continuar")
 CENTER(23,"[F3] - ABANDONA O SISTEMA")
 N_SERIE:="SKSCB200597-1003/3"

 USE REG
 GO TOP
 NNOME:=USUARIO
 INST='˛'

 if INST1='Ù' .AND. INST2='Ù' .AND. INST3='Ù'
    @14,16 say space(47)
    @14,16 SAY "Registrado para         : " + alltrim(NNOME) 
    @16,16 SAY "Nß de SÇrie             : " + N_SERIE
    @18,16 SAY "Instalaá‰es Dispon°veis : 3 "
    INKEY(0)
    REPL INST1 WITH INST
    return
 endif
 
 if INST1='˛' .AND. INST2='Ù' .AND. INST3='Ù'
    @14,16 say space(47)
    @14,16 SAY "Registrado para         : " + alltrim(NNOME) 
    @16,16 SAY "Nß de SÇrie             : " + N_SERIE
    @18,16 SAY "Instalaá‰es Dispon°veis : 2 "
    INKEY(0)
    REPL INST2 WITH INST
    return
 endif

 if INST1='˛' .AND. INST2='˛' .AND. INST3='Ù'
    @14,16 say space(47)
    @14,16 SAY "Registrado para         : " + alltrim(NNOME) 
    @16,16 SAY "Nß de SÇrie             : " + N_SERIE
    @18,16 SAY "Instalaá‰es Dispon°veis : 1 "
    INKEY(0)
    REPL INST3 WITH INST
    return
 endif

 if INST1='˛' .AND. INST2='˛' .AND. INST3='˛'
    TONE(5000,5)
    ALERT("NÈMERO DE INSTALAÄÂES ESGOTADAS;;ENTRE EM CONTATO COM O FORNECEDOR!")
    SET COLOR TO W/N
    CLS
    QUIT
 endif
 SET CURSOR ON
return
******************************************************************************
FUNCTION TELA() // MONTA A TELA DE ABERTURA PARA INICIO DA INSTALAÄ«O ***
 SET CURSOR OFF
 * Tela Superior
 SET COLOR TO B
 @  0, 0 CLEAR TO  24,79
 @ 12,39 SAY "˛"
 INKEY(.06)
 @ 12,39 SAY SPACE(1)
 tLN= 7
 tLP=15
 tCN=36
 tCP=42
 DO WHILE tLN>=2
    @ tLN,tCN TO tLP,tCP
    INKEY(.02)
    @ tLN,tCN CLEAR TO tLP,tCP
    tLN=tLN-1
    tLP=tLP+1
    tCN=tCN-6
    tCP=tCP+6
 ENDDO
 @ tLN,tCN+1 TO tLP,tCP DOUBLE
 
 LOGO()
 MOVER()
 
 FUNCTION Logo()
 SET CURSOR ON
 SET COLOR TO B+
 CENTER(3,"€€€€€€€∞                €€€€€€€∞                     ")
 CENTER(4,"€€∞                     €€∞                          ")
 CENTER(5,"€€∞       €€∞  €€€€€€∞  €€∞       €€€€€€€∞  €€€€€€€∞ ")
 CENTER(6,"€€€€€€€∞  €€∞  €€∞      €€∞       €€∞  €€∞  €€∞  €€∞ ")
 CENTER(7,"     €€∞  €€∞  €€€€€€∞  €€∞       €€∞  €€∞  €€€€€€∞  ")
 CENTER(8,"     €€∞  €€∞      €€∞  €€∞       €€∞  €€∞  €€∞  €€∞ ")
 CENTER(9,"€€€€€€€∞  €€∞  €€€€€€∞  €€€€€€€∞  €€€€€€€∞  €€€€€€€∞ ")
 SET COLOR TO
 
 FUNCTION MOVER()
 tLA=12
 tCA=50
 tLB=22
 tCB=30
 tSKI=1
 tRZ="SOUKI Servicos Empresariais Ltda"
 SET CURSOR OFF
 SET COLOR TO R+
 DO WHILE .T.
 ** Move Nome do Sistema
    SET COLOR TO GB+
    @ tLA,tCA SAY "SISTEMA DE COBRANÄA "
    @ tLA,51 SAY SPACE(27)
    @ tLA, 2 SAY SPACE(28)
    INKEY(.08)
    tCA=tCA-1
    if tCA=2
       tCA=50
    endif
    SET COLOR TO B+
    CENTER(13,"Vers∆o 1.0")
 ** Move Razao Social
    SET COLOR TO N+
    @ 21,27 SAY " Tecle       para continuar "
    SET COLOR TO W+
    @ 21,34 SAY "ENTER"
    SET COLOR TO w+/n
    USE REG
    GO TOP

    if !EMPTY(USUARIO)
       CENTER(10,"** PROGRAMA DE INSTALAÄ«O **")
       CENTER(15,"REGISTRADO PARA: " + ALLTRIM(USUARIO)) 
       CENTER(16,"Nß DE SêRIE: SKSCB200597-1003/3")
       SET COLOR TO B+
     else
       CENTER(10,"** PROGRAMA DE INSTALAÄ«O **")
       SET COLOR TO B+
    endif

    @ 19,24 SAY LEFT(tRZ,tSKI)
    tSKI=tSKI+1
    if tSKI=38
       tSKI=1
       @ 19,24 SAY SPACE(38)
    endif
    if LASTKEY()=13
       SET COLOR TO GB+
       CENTER(12,"                                 ")
       CENTER(12,"SISTEMA DE COBRANÄA")
       CENTER(19,"Souki Serviáos Empresariais Ltda")
       INKEY(3)
       return
    endif
ENDDO
return
******************************************************************************
PROCEDURE SAIR
CLS
QUIT
