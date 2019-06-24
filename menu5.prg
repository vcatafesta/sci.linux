// Declare arrays
Function Main()
     LOCAL aColors  := {}
     LOCAL aBar     := { " Sair ", " Relatorios ", " Video " }

     // Include the following two lines of code in your program, as is.
     // The first creates aOptions with the same length as aBar.  The
     // second assigns a three-element array to each element of aOptions.
     LOCAL aOptions[ LEN( aBar ) ]
	  Cls
	    
     AEVAL( aBar, { |x,i| aOptions[i] := { {},{},{} } } )

     // fill color array
     // Box Border, Menu Options, Menu Bar, Current Selection, Unselected
     aColors := {"W+/G", "N/G", "N/G", "N/W", "N+/G"}

  // array for first pulldown menu
  FT_FILL( aOptions[1], 'A. Execute A Dummy Procedure' , {|| FuBar()}, .t. )
  FT_FILL( aOptions[1], 'B. Enter Daily Charges'       , {|| .t.},     .f. )
  FT_FILL( aOptions[1], 'C. Enter Payments On Accounts', {|| .t.},     .t. )

  // array for second pulldown menu
  FT_FILL( aOptions[2], 'A. Print Member List'         , {|| .t.},     .t. )
  FT_FILL( aOptions[2], 'B. Print Active Auto Charges' , {|| .t.},     .t. )

  // array for third pulldown menu
  FT_FILL( aOptions[3], 'A. Transaction Totals Display', {|| .t.},     .t. )
  FT_FILL( aOptions[3], 'B. Display Invoice Totals'    , {|| .t.},     .t. )
  FT_FILL( aOptions[3], 'C. Exit To DOS'               , {|| .f.},     .t. )

    // Call FT_FILL() once for each item on each pulldown menu, passing it
    // three parameters:

   // CALL FT_MENU1
     FT_MENU1( aBar, aOptions, aColors, 0 )

	  
	  Function Fubar()
	  return .t.
	  
	  
	  