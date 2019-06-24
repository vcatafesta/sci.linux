Function Main()

 CLS
      SET MESSAGE TO MAXROW()/2 CENTER
      SET WRAP ON
      @ 0,         0           PROMPT "1. Upper left"   MESSAGE " One "
      @ 0,         MAXCOL()-16 PROMPT "2. Upper right"  MESSAGE " Two "
      @ MAXROW()-1,MAXCOL()-16 PROMPT "3. Bottom right" MESSAGE "Three"
      @ MAXROW()-1,0           PROMPT "4. Bottom left"  MESSAGE "Four "
      MENU TO nChoice
      SETPOS ( MAXROW()/2, MAXCOL()/2 - 10 )
      if nChoice == 0
         ?? "Esc was pressed"
      else
         ?? "Selected option is", nChoice
      endif
