// *****************************************************************************
// *
// HR FONTS   verzija 2.0                           *
// za CLIPPER 5.x                              *
// *
// ----------------------------------------------------------------------------*
// *
// DEMO.PRG  : primjer upotrebe HRFONTS.LIB                                 *
// *
// Prevodjenje/linkanje : CLIPPER demo /l /q                                *
// RTLINK FILE demo LIB hrfonts                      *
// (ako koristite BLINKER:                           *
// BLINKER FI demo LIB hrfonts)                     *
// *
// Autor:  Arminio Grgic - GrGa                                             *
// (c) m&g software, 1994-1996                                      *
// *
// *****************************************************************************

mrow := MaxRow() + 1
mcol := MaxCol() + 1
pocetni_set := GETCSET()
?
? 'Zapamtio sam trenutno aktivni set znakova (fukcija GETCSET() !!!) ...'
? 'Pritisni bilo sto ...'
Inkey( 0 )

CLS
!mode co80              // prebacimo se u VGA COLOR TEXT 25x80 pomocu DOS
// komande MODE
SET COLOR TO 'w/bg'
SET CONFIRM ON
CLS
@1, 25 SAY 'Primjer uporabe HRFONTS.LIB'
dane := 'D'
@20, 10 SAY 'Da li je vidljiva poruka u drugom redu ekrana (D/N) ?' COLOR 'n/bg' GET dane PICT '!'
READ
if dane != 'D'
graysc()        // ako ne vidimo tekst, konvertiramo paletu u
// nijanse sivog
endif
@20, 10
@20, 30 SAY 'Pritisni bilo sto ...'
@10, 3 SAY 'funkcija HRSCI852(25):    ^~]}[{\|@`   瑹弳骁研Η'
hrsci852( 25 )            // CROASCII i 852  - 25 redaka
Inkey( 0 )
@10, 3 SAY 'funkcija HR852(25):       ^~]}[{\|@`   瑹弳骁研Η'
hr852( 25 )               // 852 - samo HR   - 25 redaka
Inkey( 0 )
@10, 3 SAY 'funkcija CROASCII(25):    ^~]}[{\|@`   瑹弳骁研Η'
croascii( 25 )            // CROASCII - 25 redaka
Inkey( 0 )
@10, 3 SAY 'funkcija ROMFONT(25):     ^~]}[{\|@`   瑹弳骁研Η'
romfont( 25 )             // standardni DOS set - 25 redaka
Inkey( 0 )

SetMode ( 50, 80 )         // prelazimo u VGA TEXT 50x80
CLS
@1, 30 SAY 'Primjer uporabe HRFONTS.LIB'
if dane != 'D'
graysc()        // SETMODE() vraca standardnu paletu
// zato ponovo pozivamo GRAYSC()
endif
@10, 3 SAY 'funkcija HRSCI852(50):    ^~]}[{\|@`   瑹弳骁研Η'
hrsci852( 50 )            // CROASCII i 852  - 50 redaka
Inkey( 0 )
@10, 3 SAY 'funkcija HR852(50):       ^~]}[{\|@`   瑹弳骁研Η'
hr852( 50 )               // 852 - samo HR   - 50 redaka
Inkey( 0 )
@10, 3 SAY 'funkcija CROASCII(50):    ^~]}[{\|@`   瑹弳骁研Η'
croascii( 50 )            // CROASCII - 50 redaka
Inkey( 0 )
@10, 3 SAY 'funkcija ROMFONT(50):     ^~]}[{\|@`   瑹弳骁研Η'
romfont( 50 )             // standardni DOS set - 50 redaka
Inkey( 0 )

SET COLOR TO
cls
SetMode ( mrow, mcol )         // vratimo se u 25x80 i standardnu paletu
SETCSET( pocetni_set )
@10, 10 SAY 'Vratio sam pocetni set znakova (fukcija SETCSET() !!!) ...'

// ***** KRAJ *****
