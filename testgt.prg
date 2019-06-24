ANNOUNCE HB_GT_SYS 
REQUEST HB_GT_STD
REQUEST HB_GT_CGI
REQUEST HB_GT_WVT
REQUEST HB_GT_WIN
REQUEST HB_GT_GUI
REQUEST HB_GT_WIN_DEFAULT

#INCLUDE "HBGTINFO.CH" 

FUNCTION MAIN() 
	cls
	? HB_GTVERSION(), HB_GTVERSION(1) 
    TONE( 200, 3) 
    TONE( 300, 3) 
    TONE( 500, 3) 
    INKEY( 5 ) 
	 MAIN2()
	 MAIN3()
	 
    return NIL
  
      /* end 

      Now run the programs three times, like this:
      t
      t //GTWIN
      t //GTWVT
		
		*/
		
		

PROC main2() 
 cls
 hb_gtInfo( HB_GTI_FONTSEL, "Calibri") 
 Hb_GtInfo( HB_GTI_FONTWIDTH, 10 ) 
 HB_GTInfo( HB_GTI_FONTSIZE, 18) 
 Name=space(30) 
 @ 2,2 SAY "Name" GET name
 Read 
 @ 3,2 SAY "Hello "+name 
 INKEY( 0 ) 
 return		
 
proc main3()

      local cFont := xFontSel() 
		cls
		hb_gtInfo( HB_GTI_FONTSEL, cFont := xFontSel() )
      alert( "What do you think about it???;;" + cFont )
		return

 function xfontsel()
      local hProcess, hStdOut, cFontSel, n
      hProcess := hb_processOpen( "xfontsel -print",, @hStdOut )
      if hProcess != -1
         cFontSel := space( 256 )
         n := fread( hStdOut, @cFontSel, len( cFontSel ) )
         cFontSel := left( cFontSel, n )
         hb_processClose( hProcess )
         fclose( hStdOut )
      endif
   return cFontSel