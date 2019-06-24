ASORT( { 3, 1, 4, 42, 5, 9 } )     // result: { 1, 3, 4, 5, 9, 42 }

      // sort character strings in descending lexical order
      aKeys := { "Ctrl", "Alt", "Delete" }
      bSort := {| x, y | UPPER( x ) > UPPER( y ) }
      ASORT( aKeys,,, bSort )      // result: { "Delete", "Ctrl", "Alt" }

      // sort two-dimensional array according to 2nd element of each pair
      aPair :=   { {"Sun",8}, {"Mon",1}, {"Tue",57}, {"Wed",-6} }
      ASORT( aPair,,, {| x, y | x[2] < y[2] } )
      // result: { {"Wed",-6}, {"Mon",1}, {"Sun",8}, {"Tue",57} }