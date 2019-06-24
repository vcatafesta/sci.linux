/*
  ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
 Ý³																								 ?
 Ý³	Modulo.......: DIRETORI.PRG		  												 ?
 Ý³	Sistema......: AUXILIAR CONTROLE DE CONTROLE DE ESTOQUE	             ?
 Ý³	Aplicacao....: SCI - SISTEMA COMERCIAL INTEGRADO                      ?
 Ý³	Versao.......: 8.5.00							                            ?
 Ý³	Programador..: Vilmar Catafesta				                            ?
 Ý³   Empresa......: Macrosoft Informatica Ltda                             ?
 Ý³	Inicio.......: 12.11.1991 						                            ?
 Ý³   Ult.Atual....: 12.04.2018                                             ?
 Ý³   Compilador...: Harbour 3.2/3.4                                        ?
 Ý³   Linker.......: BCC/GCC/MSCV                                           ?
 Ý³	Bibliotecas..:  									                            ?
 ÝÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
 ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

#include <sci.ch>

*:==================================================================================================================================

Function Diretorio( nRowTop, nColumnTop, nRowBottom, cColorString, cDefaultPath )
*********************************************************************************
Local lSetScore
MEMVAR GetList
PUBL aFileMan, aFileList
PUBL hScrollBar, nMenuItem, nTagged
PUBL nEl, nRel, lReloadDir, nFileItem

   nMenuItem   := 1
   nTagged     := 0
   nFileItem   := 1
   nEl         := 1
   nRel        := 1
   lReloadDir  := .T.
   aFileMan    := {}
   aFileList   := {}
   aFileMan    := ARRAY( FM_ELEMENTS )
   if nRowTop  = NIL
      nRowTop  := 0

   else
      if nRowTop > (MaxRow() - 7)
         nRowTop := MaxRow() - 7

      endif
   endif
   aFileMan[ FM_ROWTOP ] := nRowTop
   if nColumnTop = NIL
      nColumnTop := 0

   else
      if nColumnTop > (MaxCol() - 52)
         nColumnTop := MaxRow() - 52

      endif

   endif
   aFileMan[ FM_COLTOP ] := nColumnTop

   if nRowBottom = NIL
      nRowBottom := 0

   else
      if nRowBottom > MaxRow()
         nRowBottom := MaxRow()

      endif
   endif
   aFileMan[ FM_ROWBOTTOM ] := nRowBottom
   aFileMan[ FM_COLBOTTOM ] := nColumnTop + 51

   if cColorString = NIL
      cColorString := SetColor()

   endif
   aFileMan[ FM_COLOR ] := cColorString

   if cDefaultPath = NIL
      cDefaultPath := FCURDIR() + "\*.*"
      cDefaultPath := STRTRAN( cDefaultPath, "\\", "\" )

   endif
   aFileMan[ FM_PATH ] := cDefaultPath
   aFileMan[ FM_OLDCOLOR ] := SetColor( aFileMan[ FM_COLOR ] )
   aFileMan[ FM_OLDSELECT ] := SELECT()
   lSetScore := SET( _SET_SCOREBOARD, .F. )
   aFileMan[ FM_OLDSCREEN ] := SaveScreen( aFileMan[ FM_ROWTOP    ], ;
                                           aFileMan[ FM_COLTOP    ], ;
                                           aFileMan[ FM_ROWBOTTOM ], ;
                                           aFileMan[ FM_COLBOTTOM ] )
   CreateScreen()
   GetFiles()

   RestScreen( aFileMan[ FM_ROWTOP    ], ;
               aFileMan[ FM_COLTOP    ], ;
               aFileMan[ FM_ROWBOTTOM ], ;
               aFileMan[ FM_COLBOTTOM ], ;
               aFileMan[ FM_OLDSCREEN ] )
   SetColor( aFileMan[ FM_OLDCOLOR ] )
   SET( _SET_SCOREBOARD, lSetScore )
   SELECT ( aFileMan[ FM_OLDSELECT ] )
   return( aFileMan[ FM_returnFILE ] )

Static Function GetFiles
************************
   Local lDone       := .F.
   Local nCurrent    := 0
   Local nLastKey    := 0

   DO WHILE !lDone
      if lReloadDir
         nEl   := 1
         nRel  := 1
         if !LoadFiles()
            ErrorBeep()
            Message( "Erro: Arquivos nao Encontrados!..." )
            InKey( 0 )
            if YesOrNo( "Mudar de path? (S/N)", "S" )
               GetNewPath( aFileMan[ FM_PATH ] )
               if LASTKEY() == K_ESC
                  lDone := .T.

               else
                  LOOP

               endif
            else
               lDone := .T.

            endif
         else
            lReloadDir := .F.

         endif
      endif
      TabUpdate( hScrollBar, nEl, LEN( aFileList ), .T. )
      nCurrent := ACHOICE( aFileMan[ FM_ROWTOP ] + 3, ;
                           aFileMan[ FM_COLTOP ] + 2, ;
                           aFileMan[ FM_ROWBOTTOM ] - 3, ;
                           aFileMan[ FM_COLBOTTOM ] - 4, ;
                           aFileList, .T., "ProcessKey", nEl, nRel )

      nFileItem := nCurrent
      nLastKey := LASTKEY()

      DO CASE
         CASE UPPER(CHR(nLastKey)) $ "LCRDPO"
            nMenuItem := AT( UPPER(CHR(nLastKey)), "LCRDPO" )
            DisplayMenu()

         CASE nLastKey == K_RIGHT
            nMenuItem++
            if nMenuItem > 6
               ErrorBeep()
               nMenuItem := 6

            endif
            DisplayMenu()

         CASE nLastKey == K_LEFT
            nMenuItem--
            if nMenuItem < 1
               ErrorBeep()
               nMenuItem := 1
            endif
            DisplayMenu()

         CASE nLastKey == K_ESC
            aFileMan[ FM_returnFILE ] := ""
            lDone := .T.

         CASE nLastKey == K_ENTER
            aFileMan[ FM_returnFILE ] := ;
                     SUBSTR( aFileMan[ FM_PATH ], 1, ;
                     RAT( "\", aFileMan[ FM_PATH ] ) ) + ;
                     TRIM( SUBSTR( aFileList[ nCurrent ], 1, 12 ) )

            DO CASE
               CASE nMenuItem == MN_LOOK
                  LookAtFile()

               CASE nMenuItem == MN_COPY
                  CopyFile()

               CASE nMenuItem == MN_RENAME
                  RenameFile()

               CASE nMenuItem == MN_DELETE
                  DeleteFile()

               CASE nMenuItem == MN_PRINT
                  PrintFile()

               CASE nMenuItem == MN_OPEN
                  if AT( '<DIR>', aFileList[ nFileItem ] ) = 0
                     lDone := .T.
                  else
                     LookAtFile()
                  endif

            ENDCASE

         CASE nLastKey == K_DEL
            DeleteFile()

         CASE nLastKey == K_F5
            TagAllFiles()

         CASE nLastKey == K_F6
            UnTagAllFiles()

         CASE nLastKey == K_SPACE
            if AT( "D", SUBSTR( aFileList[ nCurrent ], 43, 6 ) ) == 0
               if SUBSTR( aFileList[ nCurrent ], 14, 1 ) == " "
                  aFileList[ nCurrent ] := STUFF( aFileList[ nCurrent ], ;
                                           14, 1, FM_CHECK )
                  nTagged++
               else
                  aFileList[ nCurrent ] := STUFF( aFileList[ nCurrent ], ;
                                           14, 1, " " )
                  nTagged--
               endif
            endif

      ENDCASE
   ENDDO

   return NIL

Static Function LoadFiles
*************************
   Local aDirectory := {}
   Local nItem := 0
   Local lreturnValue := .T.
   Local nNumberOfItems := 0
   Local cFileString := ""

   Message( "Chamando o Diretorio Corrente..." )
   @ aFileMan[ FM_ROWTOP ] + 3, aFileMan[ FM_COLTOP ] + 2 CLEAR TO ;
     aFileMan[ FM_ROWBOTTOM ] - 3, aFileMan[ FM_COLBOTTOM ] - 4

   aDirectory := DIRECTORY( aFileMan[ FM_PATH ], "D" )
   nNumberOfItems := if( VALTYPE( aDirectory ) != "A", 0, LEN( aDirectory ) )
   aFileList := {}
   if nNumberOfItems < 1
      lreturnValue := .F.

   else
      Message( "Sorteando o Diretorio Corrente..." )
      ASORT( aDirectory,,, { | x, y | x[ F_NAME ] < y[ F_NAME ] } )
      Message( "Processando o Diretorio Corrente..." )
      FOR nItem := 1 TO nNumberOfItems
         AADD( aFileList, PADR( aDirectory[ nItem, F_NAME ], 15 ) + ;
                          if( SUBSTR( aDirectory[ nItem, F_ATTR ], ;
                          1, 1 ) == "D", "   <DIR>", ;
                          STR( aDirectory[ nItem, F_SIZE ], 8 ) ) + "  " + ;
                          DTOC( aDirectory[ nItem, F_DATE ] ) + "  " + ;
                          SUBSTR( aDirectory[ nItem, F_TIME ], 1, 5) + "  " + ;
                          SUBSTR( aDirectory[ nItem, F_ATTR ], 1, 4 ) + "  " )
      NEXT

   endif
   Message( aFileMan[ FM_PATH ] )
   return( lreturnValue )

Function ProcessKey( nStatus, nElement, nRelative )
***************************************************
   Local nreturnValue := AC_CONT
   nEl  := nElement
   nRel := nRelative
   DO CASE
   CASE nStatus == AC_IDLE
      TabUpdate( hScrollBar, nElement, LEN( aFileList ) )
      Message( aFileMan[ FM_PATH ] )

   CASE nStatus == AC_HITTOP .OR. nStatus == AC_HITBOTTOM
      ErrorBeep()

   CASE nStatus == AC_EXCEPT
      DO CASE
      CASE LASTKEY() == K_ESC
         nreturnValue := AC_ABORT

      CASE LASTKEY() == K_HOME
         KEYBOARD CHR( K_CTRL_PGUP )
         nreturnValue := AC_CONT

      CASE LASTKEY() == K_END
         KEYBOARD CHR( K_CTRL_PGDN )
         nreturnValue := AC_CONT

      CASE LASTKEY() == K_LEFT .OR. LASTKEY() == K_RIGHT
         nreturnValue := AC_SELECT

      CASE UPPER(CHR(LASTKEY())) $ ;
         "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890 " .OR. ;
         LASTKEY() == K_DEL .OR. LASTKEY() == K_ENTER .OR. ;
         LASTKEY() == K_F5 .OR. LASTKEY() == K_F6

         nreturnValue := AC_SELECT

      ENDCASE

   ENDCASE

   return (nreturnValue)

Static Function Message( cString )
**********************************
   Local cOldColor := SetColor( aFileMan[ FM_COLOR ] )
   ClearMessage()
   @ aFileMan[ FM_ROWBOTTOM ] - 1, aFileMan[ FM_COLTOP ] + 2 SAY ;
      SUBSTR( cString, 1, (aFileMan[FM_COLBOTTOM] - aFileMan[FM_COLTOP] - 6 ))

   SetColor( cOldColor )

   return NIL

Static Function GetNewPath( cPath )
***********************************
   Local cOldColor := SetColor( aFileMan[ FM_COLOR ] )
   ClearMessage()
   cPath := PADR( cPath, 45 )
   @ aFileMan[ FM_ROWBOTTOM ] - 1, aFileMan[ FM_COLTOP ] + 2 GET ;
     cPath PICTURE "@!@S45@K"
   READ

   cPath := LTRIM(TRIM(cPath))

   if RIGHT( cPath, 1 ) == "\"
      cPath += "*.*"
   endif
   if RIGHT( cPath, 1 ) == ":"
      cPath += "\*.*"
   endif

   aFileMan[ FM_PATH ] := cPath

   Message( cPath )

   SetColor( cOldColor )
   return( TRIM( cPath ) )

Static Function YesOrNo( cMessage, cDefault )
*********************************************
   Local cOldColor := SetColor( aFileMan[ FM_COLOR ] )
   Local lYesOrNo

   @ aFileMan[ FM_ROWBOTTOM ] - 1, aFileMan[ FM_COLTOP ] + 2 SAY ;
     TRIM( SUBSTR( cMessage, 1, ;
         (aFileMan[FM_COLBOTTOM] - aFileMan[FM_COLTOP] - 8 )) ) GET ;
         cDefault PICTURE "!"
   READ

   lYesOrNo := if( cDefault == "S", .T., .F. )
   SetColor( cOldColor )

   return (lYesOrNo)

Static Function ClearMessage
****************************
   Local cOldColor := SetColor( aFileMan[ FM_COLOR ] )
   @ aFileMan[ FM_ROWBOTTOM ] - 1, aFileMan[ FM_COLTOP ] + 2 CLEAR TO ;
     aFileMan[ FM_ROWBOTTOM ] - 1, aFileMan[ FM_COLBOTTOM ] - 4

   SetColor( cOldColor )

   return NIL

Static Function CreateScreen()
******************************
   Local cFrameType  := FM_SINGLEFRAME
   Local cBorderType := FM_SINGLEBORDER
   Local nRow        := 0

   @ aFileMan[ FM_ROWTOP ], aFileMan[ FM_COLTOP ] CLEAR TO ;
     aFileMan[ FM_ROWBOTTOM ], aFileMan[ FM_COLBOTTOM ]
   @ aFileMan[ FM_ROWTOP ], aFileMan[ FM_COLTOP ], ;
     aFileMan[ FM_ROWBOTTOM ], aFileMan[ FM_COLBOTTOM ] BOX cFrameType

   @ aFileMan[ FM_ROWTOP ] + 2, aFileMan[ FM_COLTOP ];
     SAY SUBSTR( cBorderType, FM_LEFT, 1 )
   @ aFileMan[ FM_ROWTOP ] + 2, aFileMan[ FM_COLBOTTOM ];
     SAY SUBSTR( cBorderType, FM_RIGHT, 1 )
   @ aFileMan[ FM_ROWTOP ] + 2, aFileMan[ FM_COLTOP ] + 1;
     SAY REPLICATE( SUBSTR( cFrameType, FM_HORIZONTAL, 1 ),;
         ( aFileMan[ FM_COLBOTTOM ] - aFileMan[ FM_COLTOP ] - 1 )  )

   FOR nRow := (aFileMan[ FM_ROWTOP ] + 3) TO (aFileMan[ FM_ROWBOTTOM ] - 1)
      @ nRow, aFileMan[ FM_COLBOTTOM ] - 2 ;
        SAY SUBSTR( cFrameType, FM_VERTICAL, 1 )
   NEXT
   @ aFileMan[ FM_ROWTOP ] + 2, aFileMan[ FM_COLBOTTOM ] - 2 SAY ;
     SUBSTR( cBorderType, FM_TOP, 1 )
   @ aFileMan[ FM_ROWBOTTOM ], aFileMan[ FM_COLBOTTOM ] - 2 SAY ;
     SUBSTR( cBorderType, FM_BOTTOM, 1 )

   @ aFileMan[ FM_ROWBOTTOM ] - 2, aFileMan[ FM_COLTOP ] ;
     SAY SUBSTR( cBorderType, FM_LEFT, 1 )
   @ aFileMan[ FM_ROWBOTTOM ] - 2, aFileMan[ FM_COLBOTTOM ] -2 ;
     SAY SUBSTR( cBorderType, FM_RIGHT, 1 )
   @ aFileMan[ FM_ROWBOTTOM ] - 2, aFileMan[ FM_COLTOP ] + 1 ;
     SAY REPLICATE( SUBSTR( cFrameType, FM_HORIZONTAL, 1 ), ;
         ( aFileMan[ FM_COLBOTTOM ] - aFileMan[ FM_COLTOP ] - 3 )  )

   hScrollBar := TabNew( aFileMan[ FM_ROWTOP ] + 3, ;
                         aFileMan[ FM_COLBOTTOM ] - 1, ;
                         aFileMan[ FM_ROWBOTTOM ] - 1, ;
                         aFileMan[ FM_COLOR ], 1 )
   TabDisplay( hScrollBar )

   DisplayMenu()

   return NIL

Static Function DisplayMenu
***************************
   Local cOldColor := SetColor(), nCol := aFileMan[ FM_COLTOP ] + 2
   Local cItemName

   @ aFileMan[ FM_ROWTOP ] + 1, aFileMan[ FM_COLTOP ] + 2 SAY ;
     "Abrir Copiar Renomear Deletar Imprimir  Tipo"
   SetColor( "I" )
   DO CASE
   CASE nMenuItem == MN_OPEN
      nCol := aFileMan[ FM_COLTOP ] + 2
      cItemName := "Abrir"

   CASE nMenuItem == MN_COPY
      nCol := aFileMan[ FM_COLTOP ] + 8
      cItemName := "Copiar"

   CASE nMenuItem == MN_RENAME
      nCol := aFileMan[ FM_COLTOP ] + 15
      cItemName := "Renomear"

   CASE nMenuItem == MN_DELETE
      nCol := aFileMan[ FM_COLTOP ] + 24
      cItemName := "Deletar"

   CASE nMenuItem == MN_PRINT
      nCol := aFileMan[ FM_COLTOP ] + 32
      cItemName := "Imprimir"

   CASE nMenuItem == MN_LOOK
      nCol := aFileMan[ FM_COLTOP ] + 42
      cItemName := "Tipo"

   ENDCASE

   @ aFileMan[ FM_ROWTOP ] + 1, nCol SAY cItemName
   Message( aFileMan[ FM_PATH ] )

   SetColor( cOldColor )

   return NIL


Static Function TabNew( nTopRow, nTopColumn, nBottomRow, ;
						cColorString, nInitPosition )
*****************************************************************************
   Local aTab := ARRAY( TB_ELEMENTS )

   aTab[ TB_ROWTOP ]	:= nTopRow
   aTab[ TB_COLTOP ]	:= nTopColumn
   aTab[ TB_ROWBOTTOM ] := nBottomRow
   aTab[ TB_COLBOTTOM ] := nTopColumn

   if cColorString == NIL
	  cColorString := "W/N"
   endif
   aTab[ TB_COLOR ] 	:= cColorString

   if nInitPosition == NIL
	  nInitPosition := 1
   endif
   aTab[ TB_POSITION ]	:= nInitPosition

   return aTab


Static Function TabDisplay( aTab )
*********************************
   Local cOldColor, nRow

   cOldColor := SetColor( aTab[ TB_COLOR ] )

   @ aTab[ TB_ROWTOP ], aTab[ TB_COLTOP ] SAY TB_UPARROW
   @ aTab[ TB_ROWBOTTOM ], aTab[ TB_COLBOTTOM ] SAY TB_DNARROW

   FOR nRow := (aTab[ TB_ROWTOP ] + 1) TO (aTab[ TB_ROWBOTTOM ] - 1)
	  @ nRow, aTab[ TB_COLTOP ] SAY TB_BACKGROUND
   NEXT

   SetColor( cOldColor )

   return aTab


Static Function TabUpdate( aTab, nCurrent, nTotal, lForceUpdate )
*****************************************************************
   Local cOldColor, nNewPosition
   Local nScrollHeight := (aTab[TB_ROWBOTTOM]-1)-(aTab[TB_ROWTOP])

   if nTotal < 1
	  nTotal := 1
   endif

   if nCurrent < 1
	  nCurrent := 1
   endif

   if nCurrent > nTotal
	  nCurrent := nTotal
   endif

   if lForceUpdate == NIL
	  lForceUpdate := .F.
   endif

   cOldColor := SetColor( aTab[ TB_COLOR ] )

   nNewPosition := ROUND( (nCurrent / nTotal) * nScrollHeight, 0 )

   nNewPosition := if( nNewPosition < 1, 1, nNewPosition )
   nNewPosition := if( nCurrent == 1, 1, nNewPosition )
   nNewPosition := if( nCurrent >= nTotal, nScrollHeight, nNewPosition )

   if nNewPosition <> aTab[ TB_POSITION ] .OR. lForceUpdate
	  @ (aTab[ TB_POSITION ] + aTab[ TB_ROWTOP ]), aTab[ TB_COLTOP ] SAY ;
		TB_BACKGROUND
	  @ (nNewPosition + aTab[ TB_ROWTOP ]), aTab[ TB_COLTOP ] SAY;
		TB_HIGHLIGHT
	  aTab[ TB_POSITION ] := nNewPosition
   endif

   SetColor( cOldColor )

   return aTab


Static Function UpPath( cPath )
*******************************
   Local cFileSpec

   cFileSpec := RIGHT( cPath, LEN( cPath ) - RAT( "\", cPath ) )
   cPath     := LEFT( cPath, RAT( "\", cPath ) - 1 )
   cPath     := LEFT( cPath, RAT( "\", cPath ) )
   cPath     += cFileSpec

   return (cPath)

Static Function LookAtFile
**************************
   Local cExtension := ""
   Local cOldScreen := SaveScreen( 0, 0, MaxRow(), MaxCol() )

   if AT( "D", SUBSTR( aFileList[ nFileItem ], 43, 6 ) ) <> 0
      DO CASE
      CASE SUBSTR( aFileList[ nFileItem ], 1, 3 ) == ".  "
         GetNewPath( aFileMan[ FM_PATH ] )

      CASE SUBSTR( aFileList[ nFileItem ], 1, 3 ) == ".. "
         GetNewPath( UpPath( aFileMan[ FM_PATH ]))

      OTHERWISE
         GetNewPath( SUBSTR( aFileMan[ FM_PATH ], 1, ;
            RAT( "\", aFileMan[ FM_PATH ])) + ;
            TRIM(SUBSTR(aFileList[nFileItem],1,12)) + "\*.*")
      ENDCASE
      lReloadDir := .T.
   else
      cExtension := GetFileExtension( SUBSTR(aFileList[nFileItem],1,12) )

      DO CASE
      CASE cExtension == "DBF"
         DBFViewer( aFileMan[ FM_returnFILE ] )

      OTHERWISE
         OlharGenerico( aFileMan[ FM_returnFILE ] )

      ENDCASE

      RestScreen( 0, 0, MaxRow(), MaxCol(), cOldScreen )

   endif
   return NIL

Static Function CopyFile
************************
   Local cNewName := ""
   Local cOldName := ""
   Local lKeepGoing := .F.
   Local cNewFile := ""
   Local nCurrent := 0
   Local cCurrentFile := ""
   Local nCount := 0
   Local cOldScreen := SaveScreen( aFileMan[ FM_ROWTOP ] + 3,;
                                   aFileMan[ FM_COLTOP ] + 2,;
                                   aFileMan[ FM_ROWTOP ] + 6,;
                                   aFileMan[ FM_COLTOP ] + 51 )
   if AT( "<DIR>", aFileList[ nFileItem ] ) = 0
      ErrorBeep()
      if nTagged > 0
         if YesOrNo( "Copiar Arquivos Marcados ? (S/N)", "N" )
            lKeepGoing := .T.

         endif
      else
         @ aFileMan[ FM_ROWTOP ] + 3 + nRel, aFileMan[ FM_COLTOP ] + 1 SAY;
           CHR( 16 )
         @ aFileMan[ FM_ROWTOP ] + 3 + nRel, aFileMan[ FM_COLBOTTOM ] - 3 SAY;
           CHR( 17 )
         if YesOrNo( "Copiar Este Arquivo ? (S/N)", "N" )
            lKeepGoing := .T.
         endif
      endif

      ClearMessage()

      @ aFileMan[ FM_ROWTOP ] + 3, aFileMan[ FM_COLTOP ] + 2, ;
        aFileMan[ FM_ROWTOP ] + 6, aFileMan[ FM_COLTOP ] + 51 BOX;
        FM_DOUBLEFRAME
      @ aFileMan[ FM_ROWTOP ] + 4, aFileMan[ FM_COLTOP ] + 3 CLEAR TO ;
        aFileMan[ FM_ROWTOP ] + 5, aFileMan[ FM_COLTOP ] + 50

      cNewName := cOldName := PADR( SUBSTR( aFileMan[ FM_PATH ], 1, ;
                              RAT( "\", aFileMan[ FM_PATH ] ) ) + ;
                              TRIM( SUBSTR( aFileList[ nFileItem ], 1, 12 ) ),;
                              45 )

      if lKeepGoing

         if nTagged > 0

            cNewName := PADR( SUBSTR( aFileMan[ FM_PATH ], 1, RAT( "\", ;
                                aFileMan[ FM_PATH ] ) ), 45 )
            DevPos( aFileMan[ FM_ROWTOP ]+4, aFileMan[ FM_COLTOP ] + 4 )
            DevOut("Copiar Arquivos Marcados Para...")
            @ aFileMan[ FM_ROWTOP ]+5, aFileMan[ FM_COLTOP ]+4 GET;
              cNewName PICTURE "@!@S46@K"
            READ
            if LASTKEY() <> K_ESC
               cNewName := TRIM( cNewName )
               if RIGHT( cNewName, 1 ) <> "\"
                  cNewName += "\"
               endif
               FOR nCurrent := 1 TO LEN( aFileList )
                  if SUBSTR( aFileList[ nCurrent ], 14, 1 ) == FM_CHECK
                     cCurrentFile := SUBSTR( aFileMan[ FM_PATH ], 1, ;
                                     RAT( "\", aFileMan[ FM_PATH ])) + ;
                                     TRIM( SUBSTR( aFileList[ nCurrent ], 1, 12))
                     cNewFile := cNewName + ;
                                 TRIM( SUBSTR( aFileList[ nCurrent ], 1, 12))
                     Message( "Copiando " + TRIM( cCurrentFile ) )
                     COPY FILE ( cCurrentFile ) TO ( cNewFile )
                     aFileList[ nCurrent ] := STUFF( aFileList[ nCurrent ], ;
                                              14, 1, " " )
                     nTagged--
                     nCount++
                     if InKey() = K_ESC
                        EXIT
                     endif
                  endif
               NEXT
               @ aFileMan[ FM_ROWTOP ] + 4, aFileMan[ FM_COLTOP ] + 3 CLEAR TO ;
                 aFileMan[ FM_ROWTOP ] + 5, aFileMan[ FM_COLTOP ] + 50
               @ aFileMan[ FM_ROWTOP ]+4, aFileMan[ FM_COLTOP ]+4 SAY;
                 LTRIM(STR( nCount )) + if( nCount > 1, " Arquivos Copiados.  ", ;
                                        " Arquivo Copiado.  " ) + "Tecle Algo..."
               InKey(0)
            endif
         else
            @ aFileMan[ FM_ROWTOP ]+4, aFileMan[ FM_COLTOP ]+4 SAY;
              "Copiar Arquivo Corrente Para..."
            @ aFileMan[ FM_ROWTOP ]+5, aFileMan[ FM_COLTOP ]+4 GET;
              cNewName PICTURE "@!@S46@K"
            READ
            if LASTKEY() <> K_ESC
               if RIGHT( cNewName, 1 ) == "\"
                  cNewName += TRIM( SUBSTR( cOldName, RAT( "\", cOldName) ;
                              + 1, 12 ))
               endif
               COPY FILE ( cOldName ) TO ( cNewName )
               @ aFileMan[ FM_ROWTOP ] + 4, aFileMan[ FM_COLTOP ] + 3 CLEAR TO ;
                 aFileMan[ FM_ROWTOP ] + 5, aFileMan[ FM_COLTOP ] + 50
               @ aFileMan[ FM_ROWTOP ]+4, aFileMan[ FM_COLTOP ]+4 SAY;
                 "1 Arquivo Copiado. Tecle Algo..."
               InKey(0)
            endif

         endif

         lReloadDir := .T.
      endif
   endif


   RestScreen( aFileMan[ FM_ROWTOP ] + 3, ;
               aFileMan[ FM_COLTOP ] + 2, ;
               aFileMan[ FM_ROWTOP ] + 6, ;
               aFileMan[ FM_COLTOP ] + 51,;
               cOldScreen )

   @ aFileMan[ FM_ROWTOP ] + 3 + nRel, aFileMan[ FM_COLTOP ] + 1 SAY;
     CHR( 32 )
   @ aFileMan[ FM_ROWTOP ] + 3 + nRel, aFileMan[ FM_COLBOTTOM ] - 3 SAY;
     CHR( 32 )

   return NIL

Static Function RenameFile
**************************
   Local cNewName := "", cOldName := ""
   Local cOldScreen := SaveScreen( aFileMan[ FM_ROWTOP ] + 3,;
                                   aFileMan[ FM_COLTOP ] + 2,;
                                   aFileMan[ FM_ROWTOP ] + 6,;
                                   aFileMan[ FM_COLTOP ] + 51 )

   if AT( "<DIR>", aFileList[ nFileItem ] ) = 0

      @ aFileMan[ FM_ROWTOP ] + 3, aFileMan[ FM_COLTOP ] + 2, ;
        aFileMan[ FM_ROWTOP ] + 6, aFileMan[ FM_COLTOP ] + 51 BOX;
        FM_DOUBLEFRAME
      @ aFileMan[ FM_ROWTOP ] + 4, aFileMan[ FM_COLTOP ] + 3 CLEAR TO ;
        aFileMan[ FM_ROWTOP ] + 5, aFileMan[ FM_COLTOP ] + 50

      cNewName := cOldName := PADR( SUBSTR( aFileMan[ FM_PATH ], 1, ;
                              RAT( "\", aFileMan[ FM_PATH ] ) ) + ;
                              TRIM( SUBSTR( aFileList[ nFileItem ], 1, 12 ) ),;
                              45 )

      ErrorBeep()
      @ aFileMan[ FM_ROWTOP ] + 4, aFileMan[ FM_COLTOP ] + 4 SAY "Renomear " +;
        SUBSTR( cNewName, 1, 38 )
      @ aFileMan[ FM_ROWTOP ] + 5, aFileMan[ FM_COLTOP ] + 4 SAY "Para" GET;
        cNewName PICTURE "@!@S43@K"
      READ

      if LASTKEY() <> K_ESC
         if FILE( cNewName )
            ErrorBeep()
            @ aFileMan[ FM_ROWTOP ] + 4, aFileMan[ FM_COLTOP ] + 3 CLEAR TO ;
              aFileMan[ FM_ROWTOP ] + 5, aFileMan[ FM_COLTOP ] + 50
            @ aFileMan[ FM_ROWTOP ] + 4, aFileMan[ FM_COLTOP ] + 4 SAY ;
              "Erro: Este Arquivo Ja Existe!"
            @ aFileMan[ FM_ROWTOP ] + 5, aFileMan[ FM_COLTOP ] + 4 SAY ;
               "Tecle Algo..."
            InKey( 0 )
         else
            lReloadDir := .T.
            RENAME ( TRIM( cOldName ) ) TO ( TRIM( cNewName ) )
         endif
      endif

   endif

   RestScreen( aFileMan[ FM_ROWTOP ] + 3, ;
               aFileMan[ FM_COLTOP ] + 2, ;
               aFileMan[ FM_ROWTOP ] + 6, ;
               aFileMan[ FM_COLTOP ] + 51,;
               cOldScreen )

   return NIL

Static Function DeleteFile
**************************
   Local nCurrentFile := 0
   Local cFile := ""
   ErrorBeep()
   if nTagged > 0
      if YesOrNo( "Deletar Arquivos Marcados ? (S/N)", "N" )
         lReloadDir := .T.
         FOR nCurrentFile := 1 TO LEN( aFileList )
            cFile := SUBSTR( aFileMan[ FM_PATH ], 1, ;
                     RAT( "\", aFileMan[ FM_PATH ] ) ) + ;
                     TRIM( SUBSTR( aFileList[ nCurrentFile ], 1, 12 ) )
            if SUBSTR( aFileList[ nCurrentFile ], 14, 1 ) == FM_CHECK
               ERASE ( cFile )
               Message( "Deletando... " + TRIM( cFile ) )
            endif
         NEXT
         Message( LTRIM( STR( nTagged ) ) + " Arquivo(s) Deletados... ")
         InKey( 0 )
         nTagged := 0
      endif
   else
      if AT( "<DIR>", aFileList[ nFileItem ] ) = 0
         cFile := SUBSTR( aFileMan[ FM_PATH ], 1, ;
                  RAT( "\", aFileMan[ FM_PATH ] ) ) + ;
                  TRIM( SUBSTR( aFileList[ nFileItem ], 1, 12 ) )
         @ aFileMan[ FM_ROWTOP ] + 3 + nRel, aFileMan[ FM_COLTOP ] + 1 SAY;
           CHR( 16 )
         @ aFileMan[ FM_ROWTOP ] + 3 + nRel, aFileMan[ FM_COLBOTTOM ] - 3 SAY;
           CHR( 17 )
         if YesOrNo( "Deletar Este Arquivo ? (S/N)", "N" )
            ERASE ( cFile )
            lReloadDir := .T.

         endif
      endif
   endif

   @ aFileMan[ FM_ROWTOP ] + 3 + nRel, aFileMan[ FM_COLTOP ] + 1 SAY;
     CHR( 32 )
   @ aFileMan[ FM_ROWTOP ] + 3 + nRel, aFileMan[ FM_COLBOTTOM ] - 3 SAY;
     CHR( 32 )
   Message( aFileMan[ FM_PATH ] )
   return NIL

Static Function PrintFile
*************************
   Local cFile := SUBSTR( aFileMan[ FM_PATH ], 1, ;
                  RAT( "\", aFileMan[ FM_PATH ] ) ) + ;
                  TRIM( SUBSTR( aFileList[ nFileItem ], 1, 12 ) )

   ErrorBeep()
   DevPos( aFileMan[ FM_ROWTOP ] + 3 + nRel, aFileMan[ FM_COLTOP ] + 1 )
   DevOut( Chr( 16 ) )
   DevPos( aFileMan[ FM_ROWTOP ] + 3 + nRel, aFileMan[ FM_COLBOTTOM ] - 3  )
   DevOut( Chr( 17 ) )
   if YesOrNo( "Imprimir Este Arquivo ?", "N" )
      if IsPrinter()
         Message( "Imprimindo " + TRIM( cFile ) )
         Copy File ( cFile ) To Prn
         __Eject()

      else
         ErrorBeep()
         Message( "ERRO: Impressora Nao Responde!" )
         InKey( 20 )

      endif

   endif

   ClearMessage()
   DevPos( aFileMan[ FM_ROWTOP ] + 3 + nRel, aFileMan[ FM_COLTOP ] + 1 )
   DevOut( Chr( 32 ) )
   DevPos( aFileMan[ FM_ROWTOP ] + 3 + nRel, aFileMan[ FM_COLBOTTOM ] - 3 )
   DevOut( Chr( 32 ) )
   Message( aFileMan[ FM_PATH ] )
   return Nil

Static Function DBFViewer( cDatabase )
**************************************
   Local cRecords := ""
   USE (cDatabase) ALIAS LookFile SHARED NEW READONLY
   if !NetErr()
      cRecords := "REGISTROS # " + LTRIM( STR( RECCOUNT()))
      StatusInf( cRecords, Trim( cDataBase ))
      MaBox( 0, 0, MaxRow() -1, MaxCol() )
      DbEdit( 1, 1, 22, 78 )
      Use
      Select ( aFileMan[ FM_OLDSELECT ] )
   endif
   return (cDatabase)

#define GV_BLOCKSIZE    50000

Static Function OlharGenerico( cFile )
*************************************
   Local cBuffer := ""
   Local nHandle := 0
   Local nBytes  := 0
   Local cScreen := SaveScreen()
 
   cBuffer := Space( GV_BLOCKSIZE )
   nHandle := Fopen( cFile )
   if Ferror() != 0
      cBuffer := "Erro Leitura Arquivo!"
   else
      nBytes = Fread( nHandle, @cBuffer, GV_BLOCKSIZE )
   endif
   Fclose( nHandle )
   cBuffer := RTRIM( cBuffer )
   StatusInf( Trim( cFile ), "USE " + Chr(27)+Chr(18)+Chr(26) + "?SC Sair")
   MaBox(0, 0, MaxRow()-1, MaxCol())
   DevPos( MaxRow(),  INT( (MaxCol( ) - 48 ) / 2) )
   MemoEdit( cBuffer, 1, 2, MaxRow() - 2, MaxCol() - 1, .F., "MemoUDF" , 300 )
   RestScreen(,,,, cScreen )
   return( cFile )

#undef GV_BLOCKSIZE

Function MemoUDF( Modo, Linha, Coluna )
***************************************
if Modo < 4
   return( ME_DEFAULT )
else
   return( ME_DEFAULT )
endif

Static Function TagAllFiles
***************************
   Local nCurrent

   nTagged := 0
   FOR nCurrent := 1 TO LEN( aFileList )
      if AT( "D", SUBSTR( aFileList[ nCurrent ], 43, 6 ) ) == 0
         aFileList[ nCurrent ] := STUFF( aFileList[ nCurrent ], ;
                                         14, 1, FM_CHECK )
         nTagged++
      endif
   NEXT
   return NIL

Static Function UnTagAllFiles
*****************************
   Local nCurrent
   nTagged := 0
   FOR nCurrent := 1 TO LEN( aFileList )
      aFileList[ nCurrent ] := STUFF( aFileList[ nCurrent ], 14, 1, " " )

   NEXT
   return NIL
