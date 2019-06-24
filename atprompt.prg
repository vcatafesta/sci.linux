// let the user select favorite day
		cls
      SET MESSAGE TO 24 CENTER
      @ 10, 2 PROMPT "Sunday" MESSAGE "This is the 1st item"
      @ 11, 2 PROMPT "Monday" MESSAGE "Now we're on the 2nd item"
      MENU TO nChoice
      DO CASE
         CASE nChoice == 0           // user press Esc key
              QUIT
         CASE nChoice == 1           // user select 1st menu item
              ? "Guess you don't like Mondays"
         CASE nChoice == 2           // user select 2nd menu item
              ? "Just another day for some"
      ENDCASE
