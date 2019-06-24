// http://www.pctoledo.com.br/forum/viewtopic.php?f=4&t=14965


 SET DEFAULT TO                                // always needed 
 SET PRINTER TO LPT1 
 SET DEFAULT TO (cWhereItWas)      // only if necessary 
 SET DEVICE TO PRINT 
 SET CONSOLE OFF 
 SET PRINT ON 

// PrintFileRaw()
 
 
 FUNCTION SelectPrinter() 
LOCAL nPrn:=1 
LOCAL aPrn:= GetPrinters(.t.) 
IF EMPTY(aPrn) 
wvw_messagebox(,"N�o foi encontrada nenhuma Impressora Instalada!",48) 
Return 
ENDIF 
DO WHILE !EMPTY(nPrn) 
Setcolor("N/W") 
WVW_nOpenWindow("Escolha uma impressora",2,1,10,40) 
nPrn:= ACHOICE(2,1,10,40,getprinters(),.T.,,nPrn) 
IF nPrn == 0 
exit 
ENDIF 
wvw_messagebox(aPrn[nPrn][2],64) 
wvw_lclosewindow() 
ENDDO 
RETURN(NIL) 
 

//Returns an array of all available printers.
FUNCTION GetPrinters()

   local aPrn,  cText

   cText := StrTran(GetProfString("Devices"),Chr(0), chr(13)+chr(10))
   aPrn  := Array(Mlcount(cText, 250))
   Aeval(aPrn, {|v,e| aPrn[e] := Trim(Memoline(cText, 250, e)) } )

Return aPrn


FUNCTION ImpSpool( cFileTxt, cPorta, lErase )

    LOCAL CPRINTER

    LOCAL cImpPadrao := GetDefaultPrinter()   // � a impressora que esta como padr�o no momento anterior a vc setar onde quer imprimi

    //cPorta := PrnGetPort()
    HB_DEFAULT(@cPorta, Alltrim( PrnGetPort()))
	 HB_DEFAULT(@LErase, .t.)

    // cPrinter := PrinterPortToName( cPorta )

    IF EMPTY( cPrinter )

       cPrinter := PrinterPortToName( "USB002" )

       IF EMPTY( cPrinter )

          cPrinter := PrinterPortToName( "USB001" )

       ENDIF

    ENDIF
    
    IF .NOT. EMPTY( cPrinter )  // TEM USB

       PrintFileRaw( cPrinter, TrueName( "CUPOM.TXT" ), "Impress�o de Vendas" )

    ELSEIF LEN( cPorta ) <= 5 .and. Left( Upper(cPorta), 4 ) = "LPT1"

       //--- Spool Local - Matricial em LPT1
       cPorta:= "PRN"

       WAITRUN("COMMAND.COM /C COPY /B " + cFileTxt + " " + cPorta, 0 )

   // Impressao na PORTA COM 1 ou 2
   ELSEIF Left( Upper(cPorta),4) = "BEMA" .OR. Left( Upper(cPorta),3) = "COM"    // Impressao em impressoras de rede COM1/2

      Set Printer To ( cPorta ) // Somente para setar a impressora
      PrintFileRaw( cPorta , cFileTxt )
      Set Printer To ( cImpPadrao )

    ELSE

       //--- Spool Remoto - Matricial em LPT1
       WAITRUN("COMMAND.COM /C COPY /B " + cFileTxt + " " + cPorta, 0 )

    ENDIF

    IF lErase // Vem .T. da tela de vendas
       FERASE( cFileTxt )
    ENDIF

RETURN( .T. )


**********************************
Function Imprime(cArq,cPrint,cTit)
**********************************
*
*
Local oPrn, aPrn:=WIN_PRINTERLIST()
hb_default(@cPrint,win_PrinterGetDefault())
hb_default(@cTit,"PEDIDO")

If Empty(cArq)
   hwg_Msginfo('Informe algo p/ imprimir.')
   Return .F.
EndIf
If empty(aPrn)
   hwg_Msginfo('N�o h� impressoras instaladas')
   Return .F.
EndIf

 nRet := Win_PrintFileRaw(cPrint,cArq,cTit)
 if nRet < 1
    cMsg := 'Erro Imprimindo: '
   SWITCH nRet
      CASE -1
         cMsg += "Par�metro inv�lido passado" ; EXIT
      CASE -2
         cMsg += "WinAPI OpenPrinter() Falha na chamada"      ; EXIT
      CASE -3
         cMsg += "WinAPI StartDocPrinter() Falha na chamada"  ; EXIT
      CASE -4
         cMsg += "WinAPI StartPagePrinter() Falha na chamada" ; EXIT
      CASE -5
         cMsg += "WinAPI malloc() of memory failed"      ; EXIT
      CASE -6
         cMsg += "Arquivo " + cArq + " n�o Localizado"   ; EXIT
      //DEFAULT
      //   cMsg += cFile + " PRINTED OK!!!"
      END

     hwg_Msgstop(cMsg)
 EndIf

Return .T.

/*
/*
   Juntando v�rios exemplos do uso da classe Win32prn() deste F�rum, fiz v�rios 
   testes que, de uma ou outra forma, podem ser �teis aos colegas iniciantes.
   Cito os colegas Marcos Roberto, Marcelog, Sygecom e Angeiras, como fontes de 
   onde tirei exemplos para este exemplo.
   Basta compilar este arquivo, sem qualquer altera��o, rodar e ver os resultados.
   Todos os testes foram feitos em PDF.  Na minha impressora EPSON tive algumas 
   diverg�ncias na impress�o de ret�ngulos, c�rculos e elipses.
   Aos colegas que puderem e quiserem contribuir com mais exemplos pe�o entrarem 
   em contato comigo ou postarem ao final deste Post.
*/
*
*--------------------------------------------------------------------------------------
#define FORM_A4 9
#define RGB( nR,nG,nB ) ( nR + ( nG * 256 ) + ( nB * 256 * 256 ) ) 
#define PS_SOLID   0 
#define BLACK           RGB( 0x0 ,0x0 ,0x0 ) 
#define BLUE            RGB( 0x0 ,0x0 ,0x85 ) 
#define GREEN           RGB( 0x0 ,0x85,0x0 ) 
#define CYAN            RGB( 0x0 ,0x85,0x85 ) 
#define RED             RGB( 0x85,0x0 ,0x0 ) 
#define MAGENTA         RGB( 0x85,0x0 ,0x85 ) 
#define BROWN           RGB( 0x85,0x85,0x0 ) 
#define WHITE           RGB( 0xC6,0xC6,0xC6 ) 
*
*--------------------------------------------------------------------------------------
FUNCTION Main()
  LOCAL nPrn:=1
  LOCAL aPrn:= GetPrinters()
  CLS
  IF EMPTY(aPrn)
    Alert("No printers installed - Cannot continue")
    QUIT
  ENDIF
  DO WHILE !EMPTY(nPrn)
    CLS
    @ 0,0 SAY 'Programa de teste Classe WIN32PRN(). Escolha uma impressora. ESC' +;
              ' para sair.'
    @ 1,0 TO maxRow(),maxCol()
    nPrn:= ACHOICE(2,1,maxRow()-1,maxCol()-1,aPrn,.T.,,nPrn)
    IF !EMPTY(nPrn)
      PrnTest(aPrn[nPrn])
    ENDIF
  ENDDO
  *
  @ 22,00 say ""
  RETURN(NIL)
*
*--------------------------------------------------------------------------------------
STATIC FUNCTION PrnTest(cPrinter)
   LOCAL oPrinter:= WIN32PRN():New(cPrinter), aFonts, x, nColFixed, nColTTF, ;
                    nColCharSet, aForms
   oPrinter:Landscape:= .F.
   oPrinter:FormType := FORM_A4
   oPrinter:Copies   := 1
   *
   c_string := "Teste-" + LTRIM(STR(YEAR(DATE()))) + "-" + STRZERO(MONTH(DATE()),2) +;
                      "-" + LTRIM(STR(DAY(DATE()))) + "=" + TIME()
   *
   IF !oPrinter:Create()
      Alert("Cannot Create Printer")
   ELSE
      IF !oPrinter:startDoc( c_string )
           Alert("StartDoc() failed")
      ELSE
         nFont := 12
         oPrinter:SetFont('Courier New',12,{1,nFont}, 0, .F., .F.)
    
         FOR N = 1 TO 2
            oPrinter:NewLine()
         NEXT N
         *
         *-----------------------------------------------------------------------------
  
         *================================== Busca de informa��es =====================
   
         oPrinter:TextOut("Impressora: " + oPrinter:PrinterName + '             ' +;
                  'MaxRow() = '+ltrim(STR(oPrinter:MaxRow(),4)) +;
                  '              MaxCol() = '+ltrim(STR(oPrinter:MaxCol(),4)) , .t.)
   
         oPrinter:NewLine()
         oPrinter:SetFont('Courier New',12,{1,nFont}, 0, .F., .F.)
         
         oPrinter:Textout(STR(oprinter:LineHeight()    ) + "  -altura da linha",.t.)
         oPrinter:Textout(STR(oprinter:CharWidth()     ) + "  -largura da coluna",.T.)
         oPrinter:TextOut(STR(oPrinter:Prow()          ) + "  -N�mero da linha",.T.)
         oPrinter:TextOut(STR(oPrinter:GetCharWidth()  ) + "  -GetCharWidth",.T.)
         oPrinter:TextOut(STR(oPrinter:GetCharHeight() ) + "  -GetCharHeigth",.T.)
         oPrinter:Textout(STR(oprinter:Prow()          ) + "  -Posi��o atual da " +;
                          "linha",.T.)
/*
   Onde:
      oPrinter:TextOut("Texto a ser impresso",.T.)
      1-Texto;
      2-Opcional:  Avan�a linha automaticamente (.T.) ou n�o (.F.), 
                   sendo (.F.) o seu valor Default, quando suprimido.
*/
         *======================= Aqui come�a a impress�o da 1� p�gina ================

         oPrinter:NewLine()
         FOR nLinha = 1 TO 45
            oPrinter:SetPrc(oPrinter:Prow()+01, nLinha )
            oPrinter:Textout(ALLTRIM(STR(oPrinter:Prow()))+ "-linha linha linha " +;
                             "linha linha linha",.f.)
         NEXT nLinha
         *
         FOR nLinha = 46 TO 100 step 2
            oPrinter:SetPrc(oPrinter:Prow()+01, nLinha )
            oPrinter:Textout(ALLTRIM(STR(oprinter:Prow()))+ "-linha linha linha " +;
                             "linha linha linha",.f.)
         NEXT nLinha
/*
   Onde:
      oPrinter:SetPrc(nLinhas, nColunas)
      1-N�mero de linhas do topo da p�gina;
      2-N�mero de colunas da margem esquerda.
      oPrinter:Prow()      && Linha atual.
      oPrinter:Pcol()      && Coluna atual.
      *
      Observar que as linhas que n�o cabem na p�gina s�o descartadas, 
      e portanto, � necess�rio controlar esta situa��o via software.
      O mesmo acontece com as colunas que ultrapassam a largura da p�gina.
*/
         *======================= Aqui come�a a impress�o da 2� p�gina ================
   
         oPrinter:NewPage()
         oPrinter:NewLine()

         oPrinter:SetFont('Courier New',12,{1,12}, 0, .F., .F.)
/*
   Onde:
      oPrinter:SetFont('Courier New',12,{1,12}, 0, .F., .F.)
      1-Nome da fonte;
      2-Altura da fonte;
      3-Multiplicador da fonte (horizontal e vertical);
      4-Largura da fonte - CPI (12 character per inch);
      5-Controla o Negrito-Bold (700) ou normal (.F.);
      6-Controla o sublinhado (.T.) ou n�o (.F.);
      7-Controla o it�lico (.T.) ou n�o (.F.).
*/
         FOR nLinha = 1 TO 70
            
            IF nLinha = 1
               n_Col   := 0
               oPrinter:SetFont('Courier New',14,{1,14}, 0, .F., .F.)
               c_Linha := "-linha, fonte 14, {1,14} (teste 1)"

            ELSEIF nLinha = 04
               n_Col   := 0
               oPrinter:SetFont('Courier New',14,{2,14}, 0, .F., .F.)
               c_Linha := "-linha, fonte 14, {2,14} (teste 2)"

            ELSEIF nLinha = 08
               n_Col   := 0
               oPrinter:SetFont('Courier New',14,{3,14}, 0, .F., .F.)
               c_Linha := "-linha, fonte 14, {3,14} (teste 3)"

            ELSEIF nLinha = 12
               n_Col   := 0
               oPrinter:SetFont('Courier New',14,{4,14}, 0, .F., .F.)
               c_Linha := "-linha, fonte 14, {4,14} (teste 4)"

            ELSEIF nLinha = 16
               n_Col   := 0
               oPrinter:SetFont('Courier New',14,{5,14}, 0, .F., .F.)
               c_Linha := "-linha, fonte 14, {5,14} (teste 5)"

            ELSEIF nLinha = 20
               n_Col   := 0
               oPrinter:SetFont('Courier New',14,{0,14}, 0, .F., .F.)
               c_Linha := "-linha, fonte 14, {0,14} (teste 6)"

            ELSEIF nLinha = 24
               n_Col   := 0
               oPrinter:NewLine()
               oPrinter:SetFont('Courier New',14,{-1,14}, 0, .F., .F.)
               c_Linha := "-linha normal, fonte 14, {-1,14} (teste 7)"

            ELSEIF nLinha = 28
               n_Col   := 0
               oPrinter:SetFont('Courier New',14,{-2,14}, 0, .F., .F.)
               c_Linha := "-linha normal, fonte 14, {-2,14} (teste 8)"

            ELSEIF nLinha = 32
               n_Col   := 0
               oPrinter:SetFont('Courier New',14,{-3,14}, 0, .F., .F.)
               c_Linha := "-linha normal, fonte 14, {-3,14} (teste 9)"

            ELSEIF nLinha = 36
               n_Col   := 05
               oPrinter:NewLine()
               oPrinter:SetColor( BROWN ) 
               oPrinter:SetFont('Courier New',12,{1,12}, 0, .F., .F.)
               c_Linha := "-linha normal, fonte 12, {1,12} (teste 10)"

            ELSEIF nLinha = 40
               n_Col   := 08
               oPrinter:SetFont('Courier New',12,{1,12}, 0, .T., .F.)
               c_Linha := "-linha normal, fonte 12, {1,12} (teste 11)"

            ELSEIF nLinha = 44
               n_Col   := 11
               oPrinter:SetFont('Courier New',12,{1,12}, 0, .T., .T.)
               c_Linha := "-linha normal, fonte 12, {1,12} (teste 12)"

            ELSEIF nLinha = 48
               n_Col   := 14
               oPrinter:SetFont('Courier New',12,{1,12}, 0, .F., .T.)
               c_Linha := "-linha normal, fonte 12, {1,12} (teste 13)"

            ELSEIF nLinha = 52
               n_Col   := 20
               oPrinter:SetFont('Courier New',14,{1,14}, 0, .T., .F.)
               c_Linha := "-linha normal, fonte 14, {1,14} (teste 14)"

            ELSEIF nLinha = 56
               n_Col   := 24
               oPrinter:SetFont('Courier New',10,{1,14}, 0, .T., .F.)
               c_Linha := "-linha normal, fonte 10, {1,14} (teste 15)"

            ELSEIF nLinha = 60
               n_Col   := 28
               oPrinter:SetFont('Courier New',10,{0,14}, 0, .T., .F.)
               c_Linha := "-linha normal, fonte 10, {0,14} (teste 16)"

            ELSEIF nLinha = 64
               n_Col   := 36
               oPrinter:SetFont('Courier New',10,{-1,14}, 0, .T., .F.)
               c_Linha := "-linha normal, fonte 10, {-1,14} (teste 17)"

            ENDIF
            
            oPrinter:SetPrc(oPrinter:Prow()+01, n_Col )
            oPrinter:Textout(STRZERO(oPrinter:Prow(),02)+ c_Linha,.f.)

         NEXT nLinha
         oPrinter:Italic(.f.)
/*
             Observar que o SUBLINHADO das linhas com fonte 12 em negrito est� 
             suprimida por sobreposi��o da linha posterior (seguinte).  Ela esconde 
             a linha de acima.  Para contornar isto deve-se diminuir o tamanho da 
             fonte, dar um espa�o entre as linhas, ou ainda aumentar a altura da linha.
             Basta reduzir a altura da fonte para 10 e o sublinhado j� fica vis�vel.
             Vejam que o BOLD e o IT�LICO tamb�m influem no resultado.  Observe os 
             teste 14, 15, 16 e 17.
*/

         *======================= Aqui come�a a impress�o da 3� p�gina ================

         oPrinter:NewPage()
         oPrinter:NewLine()

         oPrinter:SetFont('Courier New',10,{-1,14}, 0, .F., .F.)

         FOR nLinha = 1 TO 70
            
            IF nLinha = 1
               n_Col   := 0
               oPrinter:SetColor( BLACK )
               c_Linha := "-linha normal, cor BLACK, fonte 10, {-1,14} (teste 1)"

            ELSEIF nLinha = 04
               n_Col   := 4
               oPrinter:SetColor( BLUE )
               c_Linha := "-linha normal, cor BLUE, fonte 10, {-1,14} (teste 2)"

            ELSEIF nLinha = 08
               n_Col   := 8
               oPrinter:SetColor( GREEN )
               c_Linha := "-linha normal, cor GREEN, fonte 10, {-1,14} (teste 3)"

            ELSEIF nLinha = 12
               n_Col   := 12
               oPrinter:SetColor( CYAN )
               c_Linha := "-linha normal, cor CYAN, fonte 10, {-1,14} (teste 4)"

            ELSEIF nLinha = 16
               n_Col   := 16
               oPrinter:SetColor( RED )
               c_Linha := "-linha normal, cor RED, fonte 10, {-1,14} (teste 5)"

            ELSEIF nLinha = 20
               n_Col   := 20
               oPrinter:SetColor( MAGENTA )
               c_Linha := "-linha normal, cor MAGENTA, fonte 10, {-1,14} (teste 6)"

            ELSEIF nLinha = 24
               n_Col   := 24
               oPrinter:SetColor( BROWN )
               c_Linha := "-linha normal, cor BROWN, fonte 10, {-1,14} (teste 7)"

            ELSEIF nLinha = 28
               n_Col   := 0
               oPrinter:SetColor( RED )
               oPrinter:SetFont('Courier New',10,{-1,14}, 0, .T., .F.)
               c_Linha := "-linha sublinhada, cor RED, fonte 10, {-1,14} (teste 8)"

            ELSEIF nLinha = 32
               n_Col   := 04
               oPrinter:SetColor( BROWN )
               oPrinter:SetFont('Courier New',10,{-1,14}, 700, .F., .F.)
               c_Linha := "-linha negrito, cor BROWN, fonte 10, {-1,14} (teste 9)"

            ELSEIF nLinha = 36
               n_Col   := 08
               oPrinter:SetColor( MAGENTA )
               oPrinter:SetFont('Courier New',10,{-1,14}, 0, .F., .T.)
               c_Linha := "-linha it�lico, cor MAGENTA, fonte 10, {-1,14} (teste 10)"

            ELSEIF nLinha = 40
               n_Col   := 12
               oPrinter:SetColor( CYAN )
               oPrinter:SetFont('Courier New',10,{-1,14}, 700, .T., .F.)
               c_Linha := "-linha negrito sublinhado, cor CYAN, fonte 10, {-1,14} " +;
                          "(teste 11)"

            ELSEIF nLinha = 44
               n_Col   := 16
               oPrinter:SetColor( GREEN )
               oPrinter:SetFont('Courier New',10,{-1,14}, 700, .T., .T.)
               c_Linha := "-linha negrito sublinhado it�lico, cor GREEN, fonte 10, " +;
                          "{-1,14} (teste 12)"

            ELSEIF nLinha = 48
               n_Col   := 20
               oPrinter:SetColor( BLACK )
               oPrinter:SetFont('Courier New',10,{-1,14})
               c_Linha := "-linha negrito sublinhado it�lico, cor BLACK, fonte 10, " +;
                          "{-1,14} (teste 13)"

            ELSEIF nLinha = 52
               n_Col   := 24
               oPrinter:Underline(.F.)
               oPrinter:Italic(.T.)
               oPrinter:Bold(0)
               c_Linha := "-linha normal, fonte 10, {-1,14} (teste 14)"

            ELSEIF nLinha = 56
               n_Col   := 28
               c_Linha := "-linha normal, fonte 10, {1,14} (teste 15)"

            ELSEIF nLinha = 60
               n_Col   := 32
               c_Linha := "-linha normal, fonte 10, {0,14} (teste 16)"

            ELSEIF nLinha = 64
               n_Col   := 36
               c_Linha := "-linha normal, fonte 10, {-1,14} (teste 17)"

            ENDIF
            
            oPrinter:SetPrc(oPrinter:Prow()+01, n_Col )
            oPrinter:Textout(STRZERO(oPrinter:Prow(),02)+ c_Linha,.f.)

         NEXT nLinha
         oPrinter:Italic(.f.)

         *======================= Aqui come�a a impress�o da 4� p�gina ================

         oPrinter:NewPage()
         oPrinter:NewLine()
         oPrinter:NewLine()

         nAltLin := oPrinter:LineHeight()   && Altura da linha.
         nLarCar := oPrinter:GetCharWidth()   && Largura da fonte em pixels.
         nAltCar := oPrinter:GetCharHeight()   && Altura da fonte em pixels.

         oPrinter:SetFont('Courier New',12,{1,nFont}, 0, .F., .F.)
         oPrinter:TextOut(STR(nLarCar) + "      " + STR(nAltCar) + "      " +;
                          STR(nAltLin), .t.)
         
         nRow := oPrinter:Prow() + 01
         oPrinter:TextOutAt( 01*nLarCar , nRow*nAltCar ,"Coluna: "+;
                  ALLTRIM(STR(oPrinter:Pcol()))+"- Linha: "+;
                  ALLTRIM(STR(oPrinter:Prow()))+"      -Seu texto vai aqui")

         *======================= Aqui come�a o uso do TextOutAt() ====================

         nRow := oPrinter:Prow() + 04
         nCol := 20
         oPrinter:TextOutAt( nCol*nLarCar , nRow*nAltCar ,"Coluna: "+;
                  ALLTRIM(STR(oPrinter:Pcol()))+"- Linha: "+;
                  ALLTRIM(STR(oPrinter:Prow()))+"      -A linha seguinte vai aqui")
         
         oPrinter:TextOutAt(oPrinter:MM_TO_POSX(010), oPrinter:MM_TO_POSY(040), +;
                  "Imprimindo a 10mm da borda esquerda e 40mm da borda superior da " +;
                  "folha.") 
         
         *======================= Aqui come�a o uso do TextAtFont() ===================

         oPrinter:TextAtFont(oPrinter:mm_to_posx(105),oPrinter:mm_to_posy(50), +;
                  "Imprimindo em negrito centralizado na horizontal","Courier New", +;
                   10,,700,,,,,,,2)

         oPrinter:TextAtFont(oPrinter:mm_to_posx(105),oPrinter:mm_to_posy(55), +;
                  "^ Sem negrito � direita do 105","Courier New",10,15,,,,,,,RED,0)

         oPrinter:TextAtFont(oPrinter:mm_to_posx(105),oPrinter:mm_to_posy(60), +;
                  "Em negrito � esquerda do 105 ^","Courier New",10,10,700,,,,,,BLUE,1)

         oPrinter:TextAtFont(oPrinter:mm_to_posx(105),oPrinter:mm_to_posy(65), +;
                  "Em negrito � esquerda do 105 ^","Courier New",10,10,700,.T.,,,,, +;
                  BLUE,1)

         oPrinter:TextAtFont(oPrinter:mm_to_posx(105),oPrinter:mm_to_posy(70), +;
                  "Em negrito � esquerda do 105 ^","Courier New",10,10,700,.T., +;
                  .T.,,,,BLUE,1)

         oPrinter:TextAtFont(oPrinter:mm_to_posx(105),oPrinter:mm_to_posy(75), +;
                  "Em negrito � esquerda do 105 ^","Courier New",10,10,700,.T.,.T.,0, +;
                  .T.,,RED,1)
/*
    Onde:
      1-Imprime a 105mm da margem esquerda;
      2-Na linha 2;
      3-Texto;
      4-Fonte Courier New;
      5-Tamanho da fonte, 10;
      6-Divisor do tamanho da fonte;
      7-O valor 700 indice Bold (negrito) ou (.F.);
      8-Controla o sublinhado (.T.) ou (.F.);
      9-Controla o it�lico (.T.) ou (.F.);
      10-nCharSet;
      11-Nova linha (.T.) ou n�o (.F.)
      12-Atualiza PosX (.T.) ou n�o (.F.)
      13-Controla a cor de impress�o;
      14-O valor "2" indica impress�o centralizada, "0" o texto seria 
         impresso � esquerda da posi��o 105mm, e "1" o texto estaria � 
         direita do ponto 105 mm.
*/
         *======================= Aqui come�a a impress�o de n�meros ==================

         oPrinter:NewLine()
         nNum := 95350
         oPrinter:TextOut(TRANSFORM(nNum,"999,999.99"),.T.) 
         oPrinter:TextOut(STR(nNum),.T.) 

/*
   O sistema Win32prn n�o est� preparado para imprimir n�meros, portanto, 
   todos os n�meros dever�o sempre ser transformados em string.
*/
         *=============== Aqui come�a impress�o de linhas de alturas diversas =========

         oPrinter:SetFont('Courier New',7,{1,18})
         FOR nLinha = 1 TO 5
            oPrinter:Textout(ALLTRIM(STR(oprinter:Prow()))+ "-linha linha linha " +;
                             "linha linha linha 1",.T.)
         NEXT nLinha

         oPrinter:SetFont('Courier New',7,{2,18})
         FOR nLinha = 1 TO 5
            oPrinter:Textout(ALLTRIM(STR(oprinter:Prow()))+ "-linha linha linha " +;
                             "linha linha linha 2",.T.)
         NEXT nLinha

         oPrinter:SetFont('Courier New',10,{2,18})
         FOR nLinha = 1 TO 5
            oPrinter:Textout(ALLTRIM(STR(oprinter:Prow()))+ "-linha linha linha " +;
                             "linha linha linha 3",.T.)
         NEXT nLinha

         oPrinter:SetFont('Courier New',10,{3,50})
         FOR nLinha = 1 TO 5
            oPrinter:Textout(ALLTRIM(STR(oprinter:Prow()))+ "-linha linha linha " +;
                             "linha linha linha 4",.T.)
         NEXT nLinha

         oPrinter:SetFont('Courier New',16,{3,18})
         FOR nLinha = 1 TO 5
            oPrinter:Textout(ALLTRIM(STR(oprinter:Prow()))+ "-linha linha linha " +;
                             "linha linha linha 5",.T.)
         NEXT nLinha

         FOR nLinha = 1 TO 5
            oPrinter:SetPrc(oPrinter:Prow()+01, 05 )
            oPrinter:Textout(ALLTRIM(STR(oprinter:Prow()))+ "-linha linha linha " +;
                             "linha linha linha 6",.T.)
         NEXT nLinha

         oPrinter:SetFont('Courier New',20,{3,18})
         oPrinter:Bold(700)
         oPrinter:Underline(.T.)
         FOR nLinha = 1 TO 5
            oPrinter:SetPrc(oPrinter:Prow()+01, 02 )
            oPrinter:Textout(ALLTRIM(STR(oprinter:Prow()))+ "-linha linha linha " +;
                             "linha linha linha 7",.T.)
         NEXT nLinha
         
         *======================= Aqui come�a a impress�o da 5� p�gina ================

         oPrinter:NewPage()
         oPrinter:NewLine()

         oPrinter:SetFont('Lucida Console',18, 0)
         FOR nLinha = 1 TO 5
            oPrinter:SetPrc(oPrinter:Prow()+02, 02 )
            oPrinter:Textout(ALLTRIM(STR(oprinter:Prow()))+ "-linha linha linha " +;
                             "linha linha linha 1",.T.)
         NEXT nLinha

         oPrinter:SetFont('Times',30, {3,18})
         oPrinter:Underline(.F.)
         FOR nLinha = 1 TO 5
            oPrinter:SetPrc(oPrinter:Prow()+02, 02 )
            oPrinter:Textout(ALLTRIM(STR(oprinter:Prow()))+ "-linha linha linha " +;
                             "linha linha linha 2",.T.)
         NEXT nLinha

         oPrinter:Underline(.T.)
         FOR nLinha = 1 TO 5
            oPrinter:SetPrc(oPrinter:Prow()+02, 02 )
            oPrinter:Textout(ALLTRIM(STR(oprinter:Prow()))+ "-linha linha linha " +;
                             "linha linha linha 3",.T.)
         NEXT nLinha

         oPrinter:SetFont('Times New Roman',12,{1,nFont}, 0, .F., .F.)
         FOR nLinha = 1 TO 5
            oPrinter:Textout(ALLTRIM(STR(oprinter:Prow()))+ "-linha linha linha " +;
                             "linha linha linha 4",.T.)
         NEXT nLinha
/*
   Onde:
      1-Nome da Fonte;
      2-Tamanho vertical dos caracteres;
      3-Expans�o horizontal dos caracteres;
      4-Compress�o horizontal dos caracteres.
   OBS: Observar quando o tamanho da fonte � maior que altura da linha, a linha 
   atual se sobrep�e � linha anterior, apagando parte dela.  Dar 1 ou 2 linhas 
   em branco � uma das solu��es.
*/

/*
   oPrinter:SetPrintQuality(4)
   
   Para setar a qualidade de impress�o.  Este recurso n�o � igual para qualquer 
   impressora.
   H� necesidade de teste para cada uma.  Este comando deve ser inserido antes 
   da cria��o do documento, ou seja, antes de 'oPrinter:Create()'.
   Valores:
      1-Qualidade fotogr�fica;
      2-Qualidade carta;
      3-Qualidade m�dia;
      4-Qualidade rascunho.
*/

         *======================= Aqui come�a a impress�o da 6� p�gina ================

         oPrinter:NewPage()
         oPrinter:NewLine()

         *============ Impress�o do C�digos de Barras 'Bar Code' ======================

         oPrinter:SetColor( BLACK ) 

         oPrinter:SetPrc(oPrinter:Prow()+10, 05 )
         oPrinter:SetFont('Barcode Font', 28, 0 )
         oPrinter:TextOut(" *6920897718380*  " )
         oPrinter:SetFont('Courier New', 12, 0 )
         oPrinter:SetPrc(oPrinter:Prow(), 40 )
         oPrinter:TextOut("Barcode Font, 28, 0")

         oPrinter:NewLine()
         oPrinter:NewLine()
         oPrinter:NewLine()
         oPrinter:SetFont('Code39 Regular', 18, 0 )
         oPrinter:TextOut(" *6920897718380*  " )
         oPrinter:SetFont('Courier New', 12, 0 )
         oPrinter:SetPrc(oPrinter:Prow(), 40 )
         oPrinter:TextOut("Code39 Regular, 18, 0")

         oPrinter:NewLine()
         oPrinter:NewLine()
         oPrinter:NewLine()
         oPrinter:SetFont('Code39 Regular', 18, 5 )
         oPrinter:TextOut(" *6920897718380*  " )
         oPrinter:SetFont('Courier New', 12, 0 )
         oPrinter:SetPrc(oPrinter:Prow(), 40 )
         oPrinter:TextOut("Code39 Regular, 18, 5")
/*
   Onde:
      1-Nome da Fonte;
      2-Tamanho vertical da fonte;
      3-Tamanho horizontal da fonte;
*/
         *============ Impress�o do C�digos de Barras '3 de 9 Barcode' ================

         oPrinter:TextAtFont( oPrinter:MM_TO_POSX( 30 ) , oPrinter:MM_TO_POSY(100 ), +;
                              '1234567890', '3 of 9 Barcode', 28, 05 )
         oPrinter:TextAtFont( oPrinter:MM_TO_POSX( 120 ) , +;
                  oPrinter:MM_TO_POSY(100 ),'3 of 9 Barcode, 28, 05', +;
                  'Courier New', 12, 0 )

         oPrinter:TextAtFont( oPrinter:MM_TO_POSX( 30 ) , oPrinter:MM_TO_POSY(120 ), +;
                              '1234567890', '3 of 9 Barcode', 40, 0 )
         oPrinter:TextAtFont( oPrinter:MM_TO_POSX( 120 ) , +;
                  oPrinter:MM_TO_POSY(120 ),'3 of 9 Barcode, 40, 0', +;
                  'Courier New', 12, 0 )

         oPrinter:TextAtFont( oPrinter:MM_TO_POSX( 30 ) , oPrinter:MM_TO_POSY(140 ), +;
                              '1234567890', '3 of 9 Barcode', 40, 10 )
         oPrinter:TextAtFont( oPrinter:MM_TO_POSX( 120 ) , oPrinter:MM_TO_POSY(140 ), +;
                              '3 of 9 Barcode, 40, 10','Courier New', 12, 0 )

         *============ Impress�o do C�digos de Barras 'Barcoding' =====================

         oPrinter:TextAtFont( oPrinter:MM_TO_POSX( 30 ) , oPrinter:MM_TO_POSY(160 ), +;
                              '1234567890', 'Barcoding', 40, 0 ) 
         oPrinter:TextAtFont( oPrinter:MM_TO_POSX( 120 ) , +;
                  oPrinter:MM_TO_POSY(160 ),'Barcoding, 40, 0','Courier New', 12, 0 ) 

         oPrinter:TextAtFont( oPrinter:MM_TO_POSX( 30 ) , oPrinter:MM_TO_POSY(180 ), +;
                              '1234567890', 'Barcoding', 40, 5 ) 
         oPrinter:TextAtFont( oPrinter:MM_TO_POSX( 120 ) , oPrinter:MM_TO_POSY(180 ), +;
                              'Barcoding, 40, 5','Courier New', 12, 0 ) 

         oPrinter:TextAtFont( oPrinter:MM_TO_POSX( 30 ) , oPrinter:MM_TO_POSY(200 ), +;
                              '1234567890', 'Barcoding', 40, 10 ) 
         oPrinter:TextAtFont( oPrinter:MM_TO_POSX( 120 ) , +;
                  oPrinter:MM_TO_POSY(200 ),'Barcoding, 40, 10','Courier New', 12, 0 ) 

         oPrinter:TextAtFont( oPrinter:MM_TO_POSX( 30 ) , oPrinter:MM_TO_POSY(220 ), +;
                              '1234567890', 'Barcoding', 40, 15 )
         oPrinter:TextAtFont( oPrinter:MM_TO_POSX( 120 ) , +;
                  oPrinter:MM_TO_POSY(220 ),'Barcoding, 40, 15','Courier New', 12, 0 ) 
         oPrinter:TextAtFont( oPrinter:MM_TO_POSX( 20 ) , oPrinter:MM_TO_POSY(240 ), +;
                              'As fontes dos diversos C�digos de Barra podem ser ' +;
                              'baixados de:','Courier New', 12, 0 ) 
         oPrinter:TextAtFont( oPrinter:MM_TO_POSX( 20 ) , oPrinter:MM_TO_POSY(245 ), +;
                              'http://www.netfontes.com.br/fontes.php/categ_7.10' +;
                              '.htm','Courier New', 12, 0 ) 
/*
   Onde:
      1-Coordenada horizontal em mm;
      2-Coordenada vertical em mm;
      3-Texto;
      4-Nome da Fonte;
      5-Tamanho da fonte;
      6-Divisor da largura da Barra.

        As Fontes dos C�digos de Barras podem ser baixadas de:
      http://www.netfontes.com.br/fontes.php/categ_7.10.htm
*/

         *======================= Aqui come�a a impress�o da 7� p�gina ================

         oPrinter:NewPage()

         oPrinter:Box(  300,  200,  800, 1000 )
         oPrinter:Box(  600, 1200, 1500, 2000 )
         oPrinter:Box(  600, 2200, 1500, 3000, 200, 600 )

         oPrinter:SetFont('Courier New', 10, 0 )
         oPrinter:SetPrc( 04 , 20 )
         oPrinter:TextOut("X(coluna) -> 300 , Y(linha) -> 200   x   " +;
                          "X(coluna) -> 800 , Y(linha) -> 1000",.T.)
         oPrinter:SetPrc( 09 , 20 )
         oPrinter:TextOut("X(coluna) -> 600 , Y(linha) -> 1200   x   " +;
                          "X(coluna) -> 1500 , Y(linha) -> 2000",.T.)
         oPrinter:SetPrc( 13 , 20 )
         oPrinter:TextOut("X(coluna) -> 600 , Y(linha) -> 1200   x   " +;
                          "X(coluna) -> 1500 , Y(linha) -> 2000",.T.)
         oPrinter:SetPrc( 14 , 20 )
         oPrinter:TextOut("Arred. hor. 200, Arred. vert. 600",.T.)
/*
   Onde temos valores em pixels:
      Box(nX1,    nY1,   nX2,    nY2,   nWidth, nHeight);
          coluna, linha, coluna, linha, nWidth, nHeight;
      exemplificando o tamanho do BOX acima:
      500 x 800, ou seja,  800-300=300(largura)  x  1000- 200=800(altura);
      900 x 800, ou seja, 1500-600=900(largura)  x  2000-1500=800(altura);
      nWidth  -> arredondamento na linha horizontal;
      nHeight -> arredondamento na linha vertical.
*/
         nPosY := oPrinter:PosY
         nPosX := oPrinter:PosX
         oPrinter:SetPrc( 18 , 05 )
         oPrinter:TextOut("'oPrinter:posY' determina a posi��o atual da coordenada " +;
                          "Y -> linha)", .T.)
         oPrinter:SetPrc( 19 , 05 )
         oPrinter:TextOut("'oPrinter:posX' determina a posi��o atual da coordenada " +;
                          "X -> coluna)", .T.)

         nPosCol := 100            && In�cio horizontal do BOX;
         nLin    := 700            && Altura do BOX;
         nCol    := 300            && Largura do BOX.
         nX1     := oPrinter:PosX + nPosCol
         nY1     := oPrinter:PosY
         nX2     := nX1 + nCol
         nY2     := nY1 + nLin
         oPrinter:SetPrc( 23 , 10 )
         oPrinter:TextOut("Coordenadas:  " + str(nX1) + str(nY1) + str(nX2) + ;
                          str(nY2), .T.)
         oPrinter:Box(  nX1 ,  nY1 ,  nX2,  nY2 )

         *======================= Aqui come�a a impress�o ARC =========================

         oPrinter:Arc(      600, oPrinter:PosY+200,  800, oPrinter:PosY+700)
         oPrinter:SetPrc( 27 , 10 )
         oPrinter:TextOut("Coordenadas:  " + str(600) + str(oPrinter:PosY+200) + ;
                          str(800) + str(oPrinter:PosY+700), .T.)

         *======================= Aqui come�a a impress�o ELLIPSE =====================

         oPrinter:Ellipse( 1000, oPrinter:PosY+200, 1600, oPrinter:PosY+500)
         oPrinter:SetPrc( 30 , 20 )
         oPrinter:TextOut("Coordenadas:  " + str(1000) + str(oPrinter:PosY+200) +;
                          str(1600) + str(oPrinter:PosY+500), .T.)

         *======================= Aqui come�a a impress�o FILLTEXT ====================

         oPrinter:FillRect(2000, oPrinter:PosY+200, 3000, oPrinter:PosY+600, RED)
         oPrinter:SetPrc( 33 , 35 )
         oPrinter:TextOut("Coordenadas:  " + str(2000) + str(oPrinter:PosY+200) +;
                          str(3000) + str(oPrinter:PosY+600), .T.)

/*
   Notar que os RET�NGULOS, ELIPSES, etc. desta �ltima p�gina podem necessitar
   de alguns acertos nas coordenadas, visto que foram estabelecidas para documento 
   PDF.   Para minha impressora EPSON n�o produziu o mesmo resultado.
*/

        *======================= Aqui come�a a impress�o de Imagens ===================

         oBmp      := Win32Prn():new()
         cFileName := "E:\xHarbour\samples\pegged\recurses\marked.bmp"
         oBmp      := Win32Bmp():new()
         IF .NOT. oBmp:loadFile( cFileName )
           Alert( cFileName + " N�o encontrado..." )
         ELSE
           oBmp:draw( oPrinter,  { 1200, 7500, 1800, 1500 } )
           oPrinter:SetFont('Courier New',14,{1,14}, 0, .F., .F.)
           oPrinter:SetPrc(oPrinter:Prow()+08, 40 )
           oPrinter:TextOut("�cone impresso nas coordenadas:  horizontal 1200,  vertical 7500", .T.)
           oPrinter:SetPrc(oPrinter:Prow()+01, 40 )
           oPrinter:TextOut("Tamanho do �cone:                horizontal 1800,  vertical 1500", .T.)
         ENDIF

         *======================  Usando sub-rotina para a impress�o da imagem  ========
         
         cBmpFile := "E:\xHarbour\samples\pegged\recurses\help.bmp"
         PrintBitMap( oPrinter, cBMPFile )

      oPrinter:EndDoc()
    ENDIF
    oPrinter:Destroy()
  ENDIF

RETURN(NIL)
*
*------------------------------------------------------------------------------
procedure PrintBitMap( oPrn, cBitFile ) 
LOCAL oBMP 

IF EMPTY( cBitFile ) 

            && Pode-se incluir aqui uma imagem alternativa.

ELSEIF !FILE( cBitFile ) 
   Alert( "Arquivo " + cBitFile + " n�o encontrado." )
ELSE 
   oBMP:= Win32BMP():new() 
   IF oBmp:loadFile( cBitFile ) 
      oBmp:Draw( oPrn, { 200,10000, 1000, 750 } )
      
            && Esta alternativa abaixo que tamb�m pode ser usada.
      
      oBmp:Rect:= { 2000,10000, 1000, 750 } 
      oPrn:DrawBitMap( oBmp ) 

   ENDIF 
   oBMP:Destroy() 
ENDIF 
RETURN 
*
*---------------------------------------------------------------------------------------------------


