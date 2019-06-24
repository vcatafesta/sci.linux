/*****
 *
 *   Application: RDD Demo
 *   Description: Browsing files using RDDs
 *     File Name: BROWRDD.PRG
 *        Author: Luiz Quintela
 *  Date created: 12-29-92
 *     Make File: BROWRDD.RMK
 *     Exec File: BROWRDD.EXE
 *     Copyright: 1993 by Computer Associates
 *
 */

#include "inkey.ch"
#include "setcurs.ch"
#include "error.ch"
#include "browrdd.ch"

/*****
 *
 *         Name: BroRDD()
 *  Description: Main Routine
 *       Author: Luiz Quintela
 * Date created: 12-29-92
 *    Copyright: Computer Associates
 *
 *    Arguments: cCreate - Whether to create files or not
 *               (This depends on conditional compilation)
 *
 */

#ifdef OPTION_TO_CREATE_DATABASES
PROCEDURE BroRDD(cCreate)
#else
PROCEDURE BroRdd()
#endif
   LOCAL aBrow[NO_OF_BROWSES]                    // Browse objects
   LOCAL aFile[NO_OF_BROWSES]                    // File aliases
   LOCAL aWho[NO_OF_BROWSES]                     // Which Drivers
   LOCAL aBlock[NO_OF_BROWSES, 2]
   LOCAL oCol                                    // Column object

   LOCAL nKey                                    // Key pressed
   LOCAL lContinue := .T.                        // Keep doing

   LOCAL bOldHandler                             // Default handler
   LOCAL oError                                  // Error Object

   LOCAL nCnt                                    // Loop counter
   LOCAL oCurrBrow                               // Current Browse
   LOCAL nCurrBrow                               // Ordinal
   LOCAL nRecNo

   // Save current status
   // Not quite necessary but just in case you want to
   // call this from another program...
   PushSets()
   PushScr()

#ifdef OPTION_TO_CREATE_DATABASES
   if cCreate != NIL
      DispBegin()
      Scroll()
      QOut(MSG_CREATE)
      DispEnd()
      CreateFiles()

   endif
#endif

   // Open all files
   bOldHandler := ErrorBlock({|oErr| Break(oErr)})

   BEGIN SEQUENCE
      DBUseArea( .T., "DbfNTX", "Test1" ); ordListAdd("Test1")
      DBUseArea( .T., "DbfCDX", "Test2" )
      ordListAdd("Test2"); ordSetFocus("LName")
      DBUseArea( .T., "DbfMDX", "Test3" )
      ordListAdd("Test3"); ordSetFocus("LName")
      DBUseArea( .T., "DbPx"  , "Test4" )

   RECOVER USING oError
      // Lazy man...
      //
      // You _might_ (SHOULD) want to change this
      if oError:genCode == EG_OPEN
         Tone(87.3,1)
         Tone(40,3.5)
         ErrMsg(ERR_DATABASE_OPEN, ,ERR_COLOR)
         PopScr(.F.)
         PopSets()
         return // QUIT?

      else
         Eval(bOldHandler, oError)
         QUIT

      endif

   END SEQUENCE

   // Repost default handler
   ErrorBlock(bOldHandler)

   DispBegin()

   BuildScrBgnd()                                // Screen backgrounds

   // Store names of database files in array
   aFile[NTX] := "test1"
   aFile[CDX] := "test2"
   aFile[MDX] := "test3"
   aFile[PDX] := "test4"

   // Store window's names in array
   aWho[NTX] := SCR_BROW1_TITLE
   aWho[CDX] := SCR_BROW2_TITLE
   aWho[MDX] := SCR_BROW3_TITLE
   aWho[PDX] := SCR_BROW4_TITLE

   // Store seek expressions in array
   // This is used by CopyReco() to avoid macros
   aBlock[NTX] := { {|| test1->LName}, {|xKey| test1->(DBSeek(xKey))} }
   aBlock[CDX] := { {|| test2->LName}, {|xKey| test2->(DBSeek(xKey))} }
   aBlock[MDX] := { {|| test3->LName}, {|xKey| test3->(DBSeek(xKey))} }
   aBlock[PDX] := { {|| test4->LName}, {|xKey| .F.}                   }

   // Create browse objects
   aBrow[NTX] := TBrowseDB(  2,  2, (MaxRow() / 2) - 4 ,;
       (MaxCol() / 2) - 5)
   aBrow[CDX] := TBrowseDB(  2, (MaxCol() / 2) + 3,;
      (MaxRow() / 2) - 4, MaxCol() - 5)
   aBrow[MDX] := TBrowseDB( (MaxRow() / 2) + 1,  2,;
      MaxRow() - 5, (MaxCol() / 2) - 5)
   aBrow[PDX] := TBrowseDB((MaxRow() / 2) + 1, (MaxCol() / 2) + 3 ,;
      MaxRow() - 5, MaxCol() - 5)

   // Create/Add Columns to each one of the Browse objects
   aBrow[NTX]:addColumn( TBColumnNew(FNAME, {|| test1->FName}) )
   aBrow[NTX]:addColumn( TBColumnNew(LNAME, {|| test1->LName}) )
   aBrow[NTX]:addColumn( TBColumnNew(DEPT , {|| test1->Dept} ) )

   aBrow[CDX]:addColumn( TBColumnNew(FNAME, {|| test2->FName}) )
   aBrow[CDX]:addColumn( TBColumnNew(LNAME, {|| test2->LName}) )
   aBrow[CDX]:addColumn( TBColumnNew(DEPT , {|| test2->Dept} ) )

   aBrow[MDX]:addColumn( TBColumnNew(FNAME, {|| test3->FName}) )
   aBrow[MDX]:addColumn( TBColumnNew(LNAME, {|| test3->LName}) )
   aBrow[MDX]:addColumn( TBColumnNew(DEPT , {|| test3->Dept} ) )

   aBrow[PDX]:addColumn( TBColumnNew(FNAME, {|| test4->FName}) )
   aBrow[PDX]:addColumn( TBColumnNew(LNAME, {|| test4->LName}) )
   aBrow[PDX]:addColumn( TBColumnNew(DEPT , {|| test4->Dept} ) )

   // Collor patterns for each browse object
   aBrow[NTX]:colorSpec := BRO_1_COLOR
   aBrow[CDX]:colorSpec := BRO_2_COLOR
   aBrow[MDX]:colorSpec := BRO_3_COLOR
   aBrow[PDX]:colorSpec := BRO_4_COLOR

   // Column/Heading separators for all browses
   FOR nCnt := 1 TO NO_OF_BROWSES
      aBrow[nCnt]:colSep  := BRO_COL_SEP
      aBrow[nCnt]:headSep := BRO_HEAD_SEP

   NEXT

   // Stabilize all Browses
   FOR nCnt := 1 TO NO_OF_BROWSES
      // You have to stabilize browsers in
      // their respective workareas
      DBSelectArea(aFile[nCnt])
      aBrow[nCnt]:ForceStable()
      // dehilite()'em all
      aBrow[nCnt]:deHilite()

   NEXT

   // Current browse
   DBSelectArea(aFile[NTX])
   nCurrBrow := NTX
   oCurrBrow := aBrow[NTX]

   DispEnd()

   // Main loop
   WHILE lContinue
      // Stabilize current browse
      oCurrBrow:ForceStable()

      // Keystroke handling
      nKey := InKey(0)
      if !TBMoveCursor(nKey, oCurrBrow)
         // It was not a cursor key, lets try here
         if nKey     == K_ESC
            lContinue:= .F.

         elseif nKey == K_F1
            AboutThis()

         elseif nKey == K_F2
            CopyReco(nCurrBrow, aFile, aBrow, aWho, aBlock)

         elseif nKey == K_TAB .OR. nKey == K_SH_TAB
            ShiftBrow(@oCurrBrow, @nCurrBrow, aFile, aBrow, nKey)

         endif

      endif

   END

   PopSets()
   PopScr(.F.)

   return

/*****
 *
 *         Name: ShiftBrow()
 *  Description: Shift "focus" to another browse
 *       Author: Luiz Quintela
 * Date created: 12-29-92
 *    Copyright: Computer Associates
 *
 *    Arguments: oCurrBrow - Current obeject
 *             : nCurrBrow - Current ordinal
 *             : aFile     - File aliases
 *             : aBrow     - Array with browse objects
 *             : nKey      - Key pressed
 *
 */

STATIC PROCEDURE ShiftBrow(oCurrBrow, nCurrBrow, aFile,;
    aBrow, nKey)
    oCurrBrow:deHilite()

    if nKey == K_TAB
       nCurrBrow := ;
         Iif(nCurrBrow == NO_OF_BROWSES, 1, ++nCurrBrow)

    else
       nCurrBrow := ;
         Iif(nCurrBrow == 1, NO_OF_BROWSES, --nCurrBrow)

    endif

    DBSelectArea(aFile[nCurrBrow])
    oCurrBrow := aBrow[nCurrBrow]

    oCurrBrow:invalidate()
    oCurrBrow:hilite()
    return

/*****
 *
 *         Name: CopyReco()
 *  Description: Copies records from one database file to another
 *               It will not copy a record which key value
 *               is already there (Duplicate Key)
 *       Author: Luiz Quintela
 * Date created: 12-29-92
 *    Copyright: Computer Associates
 *
 *    Arguments: nCurrBrow - Current ordinal
 *             : aFile     - File aliases
 *             : aBrow     - Array with browse objects
 *             : aWho      - File format name
 *             : aBlock    - Codeblocks for key evaluation
 *
 */

STATIC PROCEDURE Copyreco(nCurrBrow, aFile, aBrow, aWho, aBlock)
   LOCAL aWho1 := {}
   LOCAL aReco := {}
   LOCAL nOrder
   LOCAL nChoice
   LOCAL xKey
   LOCAL lChanged := .F.

   // Screen coordinates will not change regardless
   // of selected video mode
   PushScr()

   SetColor(SCR_COPYRECO_COLOR)
   Shadow(  9,  9, 13, 65)
   Scroll(  8,  7, 12, 63)

   aWho1 := AClone(aWho)

   // Take current RDD name from array
   // Design choice!
   ADel(aWho1, nCurrBrow)
   ASize(aWho1, Len(aWho) - 1)
   // Case insensitive sort
   ASort(aWho1, , ,{|cParm1, cParm2| Lower(cParm1) < Lower(cParm2)})

   @ 10, 9 SAY SCR_COPYFROM + aWho[nCurrBrow] + SCR_TO
   nChoice := AChoose( 9, 39, 11, 60, aWho1,,,,, SCR_COPY_COLOR)

   if nChoice != 0
      nOrder := AScan(aWho, aWho1[nChoice])
      @ 10,39 SAY aWho1[nChoice]
      @ 11,24 SAY SCR_PLEASEWAIT

      // Brings up indexkey value
      xKey := Eval(aBlock[nCurrBrow, 1])

      if Eval(aBlock[nOrder, 2], xKey)
         // Duplicate keys are not allowed!
         // Be polite...
         Tone(87.3,1)
         Tone(40,3.5)
         ErrMsg(ERR_CANNOT_COPY_RECORD, ,ERR_COLOR)

      else
         // Append record to target database
         aReco := Array(FCount())
         Aeval(aReco, {|xExpr, nFld| aReco[nFld] := FieldGet(nFld)})

         // Area to be appended
         DBSelectArea(aFile[nOrder])
         DBAppend()
         AEval(aReco, {|xExpr, nFld| FieldPut(nFld, xExpr)})
         DBSelectArea(aFile[nCurrBrow])

         lChanged := .T.

      endif

   endif

   PopScr(.F.)

   if lChanged
      // Refresh browse
      DBSelectArea(aFile[nOrder])
      if !Empty(IndexKey())
         SeekIt(xKey, ,aBrow[nOrder])
         aBrow[nOrder]:deHilite()

      else
         aBrow[nOrder]:refreshAll()
         aBrow[nOrder]:ForceStable()
         aBrow[nOrder]:deHilite()

      endif
      DBSelectArea(aFile[nCurrBrow])

   endif

   return

/*****
 *
 *         Name: BuildScrBgnd()
 *  Description: Background screen stuff
 *       Author: Luiz Quintela
 * Date created: 12-29-92
 *    Copyright: Computer Associates
 *
 *    Arguments: VOID
 *
 */

STATIC PROCEDURE BuildScrBgnd()
   SetBlink(.F.)
   SetCursor(SC_NONE)

   // Screen background
   SetColor(SCR_MAIN_BGND_COLOR)
   Scroll()

   // Pseudo shadows
   Shadow(  2,  4, (MaxRow() / 2) - 3, (MaxCol() / 2) - 3 )
   Shadow(  2, (MaxCol() / 2) + 5,;
      (MaxRow() / 2) - 3, MaxCol() - 3)
   Shadow( (MaxRow() / 2) + 1,  4,;
      MaxRow() - 4, (MaxCol() / 2) - 3)
   Shadow( (MaxRow() / 2) + 1,  (MaxCol() / 2) + 5,;
      MaxRow() - 4, MaxCol() - 3)
   Shadow( MaxRow() - 1, 4, MaxRow() - 1, MaxCol() - 3)

   // Window's Titles
   SetColor(BRO_1_COLOR)
   Scroll(  1,  2, (MaxRow() / 2) - 4 , (MaxCol() / 2) - 5 )
   @  1, 4 SAY SCR_BROW1_TITLE
   SetColor(BRO_2_COLOR)
   Scroll(  1, (MaxCol() / 2) + 3,;
      (MaxRow() / 2) - 4, MaxCol() - 5)
   @ 1, (MaxCol() / 2) + 6 SAY SCR_BROW2_TITLE
   SetColor(BRO_3_COLOR)
   Scroll( (MaxRow() / 2),  2,;
      MaxRow() - 5, (MaxCol() / 2) - 5)
   @ (MaxRow() / 2),  4 SAY SCR_BROW3_TITLE
   SetColor(BRO_4_COLOR )
   Scroll( (MaxRow() / 2), (MaxCol() / 2) + 3 ,;
      MaxRow() - 5, MaxCol() - 5)
   @ (MaxRow() / 2), (MaxCol() / 2) + 6 SAY SCR_BROW4_TITLE
   SetColor(SCR_OPTIONS_COLOR)
   Scroll( MaxRow() - 2, 2, MaxRow() - 2, MaxCol() - 5)
   @ MaxRow() - 2, 4 SAY SCR_OPTIONS_TITLE

   return

/*****
 *
 *         Name: AboutThis()
 *  Description: Blah, blah, blah
 *       Author: Luiz Quintela
 * Date created: 12-29-92
 *    Copyright: Computer Associates
 *
 *    Arguments: VOID
 *
 */

STATIC PROCEDURE AboutThis()
   // This function is a little "dirty"
   // but it is not an important part
   // of the program, anyway
   LOCAL nRow :=  2
   LOCAL nCol := 25

   PushScr()
   DispBegin()

   Shadow(nRow + 1, nCol + 2, nRow + 14, nCol + 37)
   SetColor(SCR_ABOUT_COLOR)
   Scroll(nRow, nCol, nRow + 13, nCol + 35)
   DevPos(nRow, nCol + 2)

   @ nRow++, nCol + 2 SAY "CA-Clipper 5.2 - RDD Demo"
   @ nRow++, nCol + 2 SAY ""
   @ nRow++, nCol + 2 SAY "Luiz Quintela - 8 March 1993"
   @ nRow++, nCol + 2 SAY ""
   @ nRow++, nCol + 2 SAY "This program shows the usage"
   @ nRow++, nCol + 2 SAY "of the replaceable database"
   @ nRow++, nCol + 2 SAY "drivers (RDDs)."
   @ nRow++, nCol + 2 SAY ""
   @ nRow++, nCol + 2 SAY "Drivers available from CA:"
   @ nRow++, nCol + 2 SAY "Clipper, dBASE (III and IV),"
   @ nRow++, nCol + 2 SAY "FoxPro and Paradox. For further"
   @ nRow++, nCol + 2 SAY "information: 1-800-DIAL-CAI."
   @ nRow++, nCol + 2 SAY ""
   @ nRow++, nCol + 2 SAY "Press any key to continue..."

   DispEnd()
   InKey(TIME_TO_WAIT_ON_HELP_SCREEN)
   PopScr(.F.)
   return

/*****
 *
 *          Name: AppendRecos()
 *   Description: Append records to file
 *        Author: Luiz Quintela
 *  Date created: 03-05-93
 *     Copyright: Computer Associates
 *
 *    Parameters: aArray1 - Array with test's data
 *      See Also:
 *
 */

STATIC PROCEDURE AppendRecos(aArray1)
   Local nCnt

   FOR nCnt := 1 to Len(aArray1)
      DBAppend()
      FIELD->LName := aArray1[nCnt,1]
      FIELD->FName := aArray1[nCnt,2]
      FIELD->Dept  := aArray1[nCnt,3]

   NEXT
   return

/*****
 *
 *          Name: CreateFiles()
 *   Description: Creates all sample files
 *                (This is the default compiling)
 *        Author: Luiz Quintela
 *  Date created: 03-05-93
 *     Copyright: Computer Associates
 *
 *    Parameters: VOID
 *
 */

#ifdef OPTION_TO_CREATE_DATABASES
STATIC PROCEDURE CreateFiles()
#else
INIT PROCEDURE CreateFiles()
#endif
   Local aArray1 := {}
   Local nCnt

   aArray1 := { {"LName", "C", 15, 0} ,;
                {"FName", "C", 15, 0} ,;
                {"Dept" , "C", 10, 0} }

   // Create all files
   DBCreate( "Test4", aArray1, "DbPx"   )
   DBCreate( "Test3", aArray1, "DbfMdx" )
   DBCreate( "Test2", aArray1, "DbfCdx" )
   DBCreate( "Test1", aArray1, "DbfNtx" )

   DBUseArea( .F., "DbPx"  , "Test4" )
   aArray1 := { {"Shafe"    , "Amir"  , "Tech Supp"} ,;
                {"Miller"   , "Bob"   , "Personnel"} ,;
                {"Krickhahn", "Debra" , "Tech Supp"} ,;
                {"Nakamura" , "Paul"  , "MIS"      } ,;
                {"Sherman"  , "Jim"   , "Personnel"}  }
   AppendRecos(aArray1)
   // We are not indexing this database
   DBCloseArea()

   DBUseArea( .F., "DbfMDX", "Test3" )
   aArray1 := { {"Allin"  , "Steve"  , "Develop"  } ,;
                {"Ho"     , "Fleming", "Test"     } ,;
                {"Chang"  , "Tom"    , "Test"     } ,;
                {"Bell"   , "Ed"     , "Tech Supp"} ,;
                {"Bradley", "Robert" , "Tech Supp"}  }
   AppendRecos(aArray1)
   // Creates a dBASE IV production index
   // (DBF name == MDX name)
   // This enables automatic opening of the index file
   // when you open the database file
   INDEX ON test3->LName TAG LName TO Test3
   DBCloseArea()

   DBUseArea( .F., "DbfCDX", "Test2" )
   aArray1 := { {"Lyon"    , "David", "Tech Supp"} ,;
                {"McIntosh", "Rose" , "Tech Supp"} ,;
                {"McConnel", "Terry", "Develop"  } ,;
                {"McIntosh", "Scott", "Develop"  } ,;
                {"Morgan"  , "David", "App Dev"  } }
   AppendRecos(aArray1)
   // Same as above for FoxPro
   INDEX ON test2->LName TAG LName TO Test2
   DBCloseArea()

   DBUseArea( .F., "DbfNTX", "Test1" )
   aArray1 := { {"Quintela"  , "Luiz"  , "App Dev"}   ,;
                {"Silverwood", "Steve" , "Tech Supp"} ,;
                {"Ridolfo"   , "Debbie", "Doc"      } ,;
                {"Sillimon"  , "Steph" , "Test"     } ,;
                {"Usher"     , "Phil"  , "Test"     } }
   AppendRecos(aArray1)
   INDEX ON test1->LName TO Test1
   DBCloseArea()

   return

// EOF - BROWRDD.PRG //
