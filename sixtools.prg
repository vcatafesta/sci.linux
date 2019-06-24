/*
 ีออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออธ
 ณ Source file: SIXTOOLS.PRG                                                ณÛ
 ณ Description: Some handy UDF's for use with the SIx Driver                ณÛ
 ณ Notice     : Copyright 1993-95 - SuccessWare 90, Inc.                    ณÛ
 ณ                                                                          ณÛ
 ณ Compile    : CLIPPER sixtools /n/w                                       ณÛ
 ณ                                                                          ณÛ
 รฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดÛ
 ณ                                                                          ณÛ
 ณ Odometer()     - For use with the INDEX ON command's OPTION clause.      ณÛ
 ณ                                                                          ณÛ
 ณ Sx_AddKeys()   - Adds an arrayful of keys for the current record to a    ณÛ
 ณ                  Multi-Keyed, Free-Format Index.                         ณÛ
 ณ                                                                          ณÛ
 ณ Sx_GetKeys()   - Returns an array containing all of the keys in a        ณÛ
 ณ                  Multi-Keyed, Free-Format Index for the current record.  ณÛ
 ณ                                                                          ณÛ
 ณ Dots()         - Also for use with the INDEX ON command's OPTION clause. ณÛ
 ณ                                                                          ณÛ
 ณ IndexBar()     - Another progress meter like Odometer() for indexing     ณÛ
 ณ                                                                          ณÛ
 ณ ShowIt()       - Yet another                                             ณÛ
 ณ                                                                          ณÛ
 ณ MyAlert()      - Modified Alert() function using black on yellow         ณÛ
 ณ                                                                          ณÛ
 ิออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออพÛ
   ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
*/

#include "inkey.ch"

#define TRUE  .T.
#define FALSE .F.

/*==========================================================================
  Odometer():

  This is a sample function designed to be used as an "odometer" with the
  OPTION clause when creating or re-creating indexes with the INDEX ON or
  REINDEX commands.

---------------------------------------------------------------------------*/

FUNC Odometer( nRecCount, nLineNum, nColNum )

LOCAL nPctDone := 0
STATIC nLine := 0
STATIC nRecs := 0
STATIC nRec := 0
STATIC nCol := 0
STATIC cScreen := ""

// BOF is TRUE on initial OPTION UDF call.  Do setup here.
IF BOF()
   nLine := IF(nLineNum == NIL, MaxRow()/2, Min( nLineNum, MaxRow() ))
   nRecs := IF(nRecCount == NIL, LastRec(), nRecCount)
   nCol  := IF(nColNum  == NIL, 15, Min( nColNum, 15 ))
   nRec := 0
   cScreen := SaveScreen( nLine-2, nCol-1, nLine+2, nCol+52 )

   Scroll( nLine-2, nCol-1, nLine+2, nCol+52 )  // Clear the display area
   @ nLine-2, nCol-1 TO nLine+2, nCol+52        // Draw a box for the odometer
   @ nLine-2, nCol+1 SAY Sx_I_IndexName()       // Show index name

   // If it's a compound index then show tag name
   IF (!(Sx_I_TagName() == Sx_I_IndexName()))   // compound index if no match
      @ nLine-2, nCol+50-Len( Sx_I_TagName()) SAY Sx_I_TagName()
   ENDIF

// If EOF is TRUE then the indexing has finished.  Clean up.
ELSEIF EOF()
   @ nLine-1, nCol+1 say Replicate(" ",47) + "100%"
   @ nLine, nCol+1 say Replicate("฿", 50)
   @ nLine+1,nCol say "Chaves Processadas #" +;
                     Left(LTrim(Str(nRecs))+Space(10),10)
   @ nLine+1,nCol+26 say " Chaves Incluidas #" +;
                     Left( LTrim( Str( Sx_KeysIncluded())) + Space(10),10)
   // Wait a second so they can see that the process is finished
   //Inkey(1)
   RestScreen( nLine-2, nCol-1, nLine+2, nCol+52, cScreen )

// In progress... show current status.
ELSE
   // Increase record # by step count
   nRec += Sx_Step()
   // Calculate percentage done
   nPctDone := (nRec / nRecs) * 100
   @ nLine-1,nCol+1 say ;
     Replicate(" ", ((nPctDone-.5) / 2) -2) + Str(nPctDone,3)+"%"
   @ nLine,nCol+1 say ;
     Replicate("Ü", ((nPctDone-.5) / 2 )) + "ณ" +;
     Replicate("฿", ( 50 - (nPctDone / 2)))
   @ nLine+1,nCol say ;
     "Processando Chave # "+Left(LTrim(Str(MIN(nRec,nRecs))+Space(10)),10);
     +" de # "+Left(LTrim(Str(nRecs))+Space(10),10) + Space(6)
ENDIF

RETURN( TRUE )


/*==========================================================================
  Sx_AddKeys():

  This function is similar to the SIx Driver's standard Sx_AddKey() function.
  However, the third parameter in this function is an array containing key
  values to be added to the index for this record.  This allows you to store
  multiple keys at once into a Multi-Keyed, Free-Format Index.
---------------------------------------------------------------------------*/

FUNC Sx_AddKeys( cTag, nOrder, aKey2Add )

LOCAL nX := 1
LOCAL lRetVal := TRUE
LOCAL bKeys := {|| Sx_Keyadd( cTag, nOrder, aKey2Add[nX++]) }

IF ValType( aKey2Add ) == "A"
  AEval( aKey2Add, bKeys )
  lRetVal := IF( AScan( aKey2Add, NIL ) < 1, TRUE, FALSE )
ELSE
  lRetVal := Sx_KeyAdd( cTag, nOrder, aKey2Add )
ENDIF

RETURN(lRetVal)


/*==========================================================================
  Sx_GetKeys():

  This function returns an array containing all of the keys in a Multi-Keyed,
  Free-Format Index for the current record.

---------------------------------------------------------------------------*/

FUNC Sx_GetKeys()

LOCAL aReturn[1]
LOCAL nRecNo := RecNo()

IF Sx_FindRec( nRecNo )
  aReturn[1] := Sx_KeyData()
END
WHILE Sx_FindRec( nRecNo, TRUE )
  AAdd( aReturn, Sx_KeyData() )
END

GOTO nRecNo

RETURN( aReturn )


/*==========================================================================
  Dots():

  This is a sample function designed to be used with the OPTION clause when
  creating or re-creating indexes with the INDEX ON or REINDEX commands.  It
  simply displays a string of dots starting from the specified starting
  column (nStartCol) to the right edge of the screen, and then clears the
  dots from the right side back to the starting column again.

  This function does provide any specific information on what file or tag
  is being created, but it _does_ show that SOMETHING is being done.  And...
  it looks kinda slick!

  EXAMPLE:    USE test VIA "SIXNSX"
              ? "Creating TEST.NSX:"
              nCol := Col()
              INDEX ON last+first TAG name OPTION Dots( nCol ) STEP 10

--------------------------------------------------------------------------*/

FUNC Dots( nStartCol )

LOCAL nCol := Col()
STATIC lOut := TRUE

IF nCol == nStartCol
   lOut := TRUE
ELSEIF nCol == MaxCol()-2
   DevPos( Row(), nCol-1 )
   QQOut(" ")
   lOut := FALSE
ENDIF

IF lOut
   QQOut(".")
ELSE
   DevPos( Row(), nCol-2 )
   QQOut(" ")
ENDIF

Return(TRUE)


/*===================================================================//

  IndexBar():

    This function was provided to SuccessWare for inclusion with the
    SIx Driver RDD by it's author:

       Dr Ben Williams  -  Perth, Western Australia

    Based on ideas gathered from the Australian Clipper community.
    Ben can be contacted on CIS c/o STR Computers 100033,1424

----------------------------------------------------------------------*/

#define BOXTOP   8
#define BOXLEFT 10

FUNC IndexBar( nTotal )

STATIC aScrn, cSaveColor, nLast

LOCAL nRecs := Sx_KeysIncluded() , cStd := "GR+/B"

// BOF() is TRUE on first call to OPTION UDF.  Use this for setup.
IF Bof()
  nLast := iif( nTotal == NIL, LastRec(), nTotal )
  cSaveColor := SetColor( "GR+/B,R+/W" )
  aScrn := { BOXTOP, BOXLEFT, BOXTOP + 11, BOXLEFT + 60 ,;
            SaveScreen( BOXTOP, BOXLEFT, BOXTOP + 11, BOXLEFT + 60 ) }
  DispBox( BOXTOP, BOXLEFT, BOXTOP + 11, BOXLEFT + 60 , 2 )
  Scroll( BOXTOP + 1, BOXLEFT + 1, BOXTOP + 10, BOXLEFT + 59 )
  SetPos( BOXTOP + 2, BOXLEFT + 5)
  DevOut( "Creating Index      :               ")
  SetPos( BOXTOP + 3, BOXLEFT + 5)
  DevOut( "Tag name            :               ")
  SetPos( BOXTOP + 4, BOXLEFT + 5)
  DevOut( "Total Records       :               ")
  SetPos( BOXTOP + 5, BOXLEFT + 5)
  DevOut( "Current Record      :               ")
  SetPos( BOXTOP + 6, BOXLEFT + 5)
  DevOut( "Percentage complete :               ")
  SetPos( BOXTOP + 8, BOXLEFT + 5)
  DevOut( "0% ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ 50% ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ 100%")

  // Clear the area, create the guage
  Scroll(BOXTOP + 2, BOXLEFT  + 27, BOXTOP + 11 - 5, BOXLEFT + 60 - 1, 0 )
  SetPos( BOXTOP + 2, BOXLEFT  + 28)
  DevOut( Sx_I_IndexName())
  SetPos( BOXTOP + 3, BOXLEFT  + 28)
  DevOut( Sx_I_TagName()  )
  SetPos( BOXTOP + 4, BOXLEFT  + 28)
  DevOut( LTrim( Transform( nLast,"999,999,999")) )
  aReplicate( BOXTOP + 9, BOXLEFT + 5, chr(219), 50, "N/N" )

ELSEIF Eof()
  SetColor( cSaveColor )
  RestScreen( aScrn[1], aScrn[2], aScrn[3], aScrn[4], aScrn[5] )

ELSE
  // Show how many keys have been included so far
  SetPos( BOXTOP + 5, BOXLEFT + 28)
  DevOut( LTrim( Transform( nRecs ,  "999,999,999")), cStd )
  SetPos( BOXTOP + 6, BOXLEFT + 28)
  DevOut( LTrim( Transform( ( nRecs / nLast) * 100 ,  "999")),cStd )

  // Show how far we have got
  aReplicate( BOXTOP + 9, BOXLEFT + 5, chr(219),;
              int(( nRecs / nLast) * 50 ), "GR+/W" )
ENDIF

Return(TRUE)


FUNC aReplicate( nR, nC, cSt, nLen, cColor )

SetPos( nR, nC )
DevOut( Replicate( cSt, nLen ), cColor )

Return(NIL)

/*==================================================================//

  ShowIt():

  Yet another progress display UDF for use with the INDEX command's
  OPTION clause.  This one does a neat spinning bar effect.

-------------------------------------------------------------------*/

#include "box.ch"

FUNCTION ShowIt()

LOCAL aBogus := { "-", "\", "|", "/" }
STATIC nCount, cColor, lBlink, cScreen, nRow, nCol

IF Bof()
  cScreen := SaveScreen( 0,0,MaxRow(),MaxCol() )
  lBlink := SetBlink(FALSE)
  cColor := SetColor("b/w*")
  DispBox(11,20,13,59,B_SINGLE+" ")
  @11,35 SAY " Working   "
  nCount := 0
  nRow := Row()
  nCol := Col()
ELSEIF Eof()
  SetColor( cColor )
  SetBlink( lBlink )
  RestScreen( 0,0,MaxRow(),MaxCol(),cScreen )
  DevPos( nRow, nCol )
ELSE
  nCount++
  @ 11,44 SAY aBogus[ nCount ]
  @ 12,25 SAY Sx_I_IndexName() + " : " + Sx_I_TagName()
  nCount := iif( nCount == 4, 0, nCount )
ENDIF

Return(TRUE)

/*==================================================================//

 MyAlert():

  Friendly looking Alert() replacement

  Uses undocumented third parameter to Clipper's Alert() function to
  specify a color for the alert box.

-------------------------------------------------------------------*/

FUNC MyAlert( cText, aOptions )

LOCAL nRetVal := 0
LOCAL lBlink := SetBlink(.F.)

nRetVal := Alert( cText, aOptions, "n/gr*" )
SetBlink( lBlink )

Return( nRetVal )


