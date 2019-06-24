* Laserprt.PRG
* Program ...: Laserprt.PRG
* Author ....: James H. Chuang
* Date ......: May 1, 1988
* Version ...: dBASE III PLUS
* Note(s) ...: Sends escape codes to set the Hewlett Packard
*              LaserJet to print with various attributes.
*
SET TALK OFF
CLEAR
TEXT


          This program sends escape sequences to your Hewlett Packard
          LaserJet to change the printer's setup and typestyles. It
          will not work with other printers unless they emulate the
          Hewlett Packard LaserJet.
          
          Only the standard Courier and Line Printer fonts available
          on an unadorned LaserJet are supported. Line Printer
          may not be available in Portrait orientation
          without a font cartridge.


ENDTEXT
WAIT
esc       = CHR(27)
prtreset  = esc + "E"
portrait  = esc + "&l0O"
landscape = esc + "&l1O"
stdpitch  = esc + "(s10H"
compitch  = esc + "(s16.66H"
marginsd  = esc + "&a"
marginpg  = esc + "&l"
legal     = marginpg + "84P"
normal    = marginpg + "66P"
leftmrg   = "L"
rightmrg  = "M"
topmargin = "E"
textlen   = "F"
pgeject   = CHR(12)
CLEAR
@  1, 21  SAY "L A S E R   P R I N T E R   S E T U P"
@  5, 11  SAY "Print Orientation     (Portrait/Landscape)"
@  7, 11  SAY "Print Size            (Normal/Compressed)"
@  9, 11  SAY "Page Length           (Normal/Legal)"
@ 11, 11  SAY "Left Margin           (Number of Spaces)"
@ 13, 11  SAY "Right Margin          (Number of Spaces)"
@ 15, 11  SAY "Top Margin            (Number of Lines)"
@ 17, 11  SAY "Text Length           (Number of Lines)"
@  0,  0  TO  2, 79 DOUBLE
orient = " "
DO WHILE .NOT. orient $ "PL"
   orient = "P"
   @  5, 65  GET orient PICTURE "!"
   READ
ENDDO
prtsize = " "
DO WHILE .NOT. prtsize $ "CN"
   prtsize = "N"
   @  7, 65  GET prtsize PICTURE "!"
   READ
ENDDO
pglen = " "
DO WHILE .NOT. pglen $ "LN"
   pglen = "N"
   @  9, 65  GET pglen PICTURE "!"
   READ
ENDDO
lftmg = 10
rgtmg = 75
topmg =  3
txlen = Iif(pglen = "N", 60, 78)
@ 11, 64 GET lftmg PICTURE "99" RANGE  3, 99
@ 13, 64 GET rgtmg PICTURE "99" RANGE  3, 99
@ 15, 64 GET topmg PICTURE "99" RANGE  3, 60
@ 17, 64 GET txlen PICTURE "99" RANGE  1, 78
READ
okay = .T.
@ 22, 0 SAY "Send Codes to Printer? Y/N" GET okay PICTURE "Y"
READ
@ 22, 0
if okay
   prtcode = prtreset + Iif(orient = "L", landscape, portrait)
   prtcode = prtcode  + Iif(prtsize = "C", compitch, stdpitch)
   prtcode = prtcode  + Iif(pglen = "L", legal, normal)
   prtcode = prtcode  + marginsd + LTRIM(STR(lftmg, 2, 0)) + leftmrg
   prtcode = prtcode  + marginsd + LTRIM(STR(rgtmg, 2, 0)) + rightmrg
   prtcode = prtcode  + marginpg + LTRIM(STR(topmg, 2, 0)) + topmargin
   prtcode = prtcode  + marginpg + LTRIM(STR(txlen, 2, 0)) + textlen
   prtcode = prtcode  + pgeject
   SET PRINT ON
   SET CONSOLE OFF
   ?? prtcode
   SET CONSOLE ON
   SET PRINT OFF
   CLEAR
   @ 22, 0 SAY "Printer setup has been changed."
else
   @ 22, 0 SAY "Printer is unchanged."
endif
@ 23, 0 SAY "Type   ASSIST <return>   to return to the Assistant."
SET TALK ON
* EOP: Laserprt.PRG

