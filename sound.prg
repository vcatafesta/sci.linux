lok := .f.
if lOk   // Good Sound
   Tone(  500, 1 )
   Tone( 4000, 1 )
   Tone( 2500, 1 )
else     // Bad Sound
   Tone(  300, 1 )
   Tone(  499, 5 )
   Tone(  700, 5 )
endif
inkey(0)
//
Tone( 800, 1 )                         // same as ? Chr( 7 )
Tone( 32000, 200 )                     // any dogs around yet?
Tone( 130.80, 1 )                      // musical note - C
Tone( 400, 0 )                         // short beep
Tone( 700 )                            // short beep
Tone( 10, 18.2 )                       // 1 second delay
Tone( -1 )                             // 1/18.2 second delay
Tone()       