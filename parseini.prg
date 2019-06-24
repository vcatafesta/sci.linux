/* Test for .ini file reading/writing by Giancarlo Niccolai */

PROCEDURE Main( cName )

   LOCAL hIni, aSect, cIni
   LOCAL cSection
   LOCAL cKey
   LOCAL nRow := 1

   SetColor( "W+/B" )
   CLS
   @ nRow++, 20 SAY "Harbour - .ini file parser test"
   @ nRow++, 5 SAY "Call from command-line using a .ini filename as the only parameter"
   nRow++

   if Empty( cName )
      cName := "parseini.ini"
      @ nRow++, 5 SAY "Using default parseini.ini file"
   endif

   @ nRow, 0

   ? "Content of", cName

   if Empty( hIni := hb_iniRead( cName ) )
      ? "Not a valid .ini file!"
   else
      FOR EACH cSection IN hIni:Keys
         ?
         ? "Section [" + cSection + "]"
         aSect := hIni[ cSection ]

         FOR EACH cKey IN aSect:Keys
            ? cKey, "=", aSect[ cKey ]
         NEXT
      NEXT
   endif

   ?
   ? "Adding section 'Added', with key NEW := new"
   hIni[ "Added" ] := { => }
   hIni[ "Added" ][ "NEW" ] := "new"

   ? "Writing output to parseini_out.ini"
   if hb_iniWrite( "parseini_out.ini", hIni, "#Generated file; don't touch", "#End of file" )
      ? "File written"
   else
      ? "Could not write file"
   endif
   ?
   WAIT

   nRow := 3
   @ nRow, 0 CLEAR
   ?
   ? "REPEATING TESTS WITHOUT AUTOMATIC MAIN SECTION"
   ?
   ? "Content of", cName

   if Empty( hIni := hb_iniRead( cName, ;
                                 /* default case */, ;
                                 /* default key indicators */, .F. ) )
      ? "Not a valid .ini file!"
   else
      FOR EACH cSection IN hIni:Keys
         /* Now (without automatic main), toplevel options may be in the root hash */
         aSect := hIni[ cSection ]

         if HB_ISHASH( aSect )
            /* It's a section */
            ?
            ? "Section [" + cSection + "]"

            FOR EACH cKey IN aSect:Keys
               ? cKey, "=", aSect[ cKey ]
            NEXT
         else
            /* It's a toplevel option */
            ? "TOPLEVEL option:", cSection, "=", aSect
         endif
      NEXT
   endif

   ?
   ? "Adding section 'Added', with key NEW := new"
   hIni[ "Added" ] := { => }
   hIni[ "Added" ][ "NEW" ] := "new"

   ? "Writing output to parseini_out1.ini"
   if hb_iniWrite( "parseini_out1.ini", hIni, ;
                   "#Generated file without main auto section; don't touch", "#End of file", ;
                   .F. )
      ? "File written"
   else
      ? "Could not write file"
   endif
   ?
   WAIT

   nRow := 3
   @ nRow, 0 CLEAR
   ?
   ? "WRITING INI TO A STRING"
   ?

   cIni := hb_iniWriteStr( hIni )

   ? "Content of hIni:"
   ?
   ? cIni
   ?
   WAIT

   nRow := 3
   @ nRow, 0 CLEAR
   ?
   ? "READING INI FILE FROM A STRING"
   ?
   ? "Content:"

   if Empty( hIni := hb_iniReadStr( cIni, ;
                                    /* default case */, ;
                                    /* default key indicators */, .F. ) )
      ? "Not a valid .ini file!"
   else
      FOR EACH cSection IN hIni:Keys
         /* Now (without automatic main), toplevel options may be in the root hash */
         aSect := hIni[ cSection ]

         if HB_ISHASH( aSect )
            /* It's a section */
            ?
            ? "Section [" + cSection + "]"

            FOR EACH cKey IN aSect:Keys
               ? cKey, "=", aSect[ cKey ]
            NEXT
         else
            /* It's a toplevel option */
            ? "TOPLEVEL option:", cSection, "=", aSect
         endif
      NEXT
   endif

   ?
   WAIT

   nRow := 3
   @ nRow, 0 CLEAR
   ?
   ? "WRITING INI FILE TO A STRING"
   ?

   cIni := hb_iniWriteStr( hb_iniRead( cName ) )

   ? "Content of", cName
   ?
   ? cIni
   ?
   WAIT

   return