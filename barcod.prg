* Fun豫o BarCod()

**************************************************************************
* Program...: CODE39.PRG
* Version...: 1.0
* Function..: Prints 3 of 9 barcodes
*
* Source....: Clipper (Summer '87)
* Libraries.: CLIPPER.LIB (c) Nantucket Corporation (Summer '87)
* EXTEND.LIB (c) Nantucket Corporation (Summer '87)
*
* Author....: George T. Neill
* 2140 Main Street
* La Crosse, WI 54601
*
* Created...: May 5, 1988 at 10:21 am
* Copyright.: None, released to the public domain as is with no express
* or implied warranty as to suitability or accuracy of this
* program. The author shall not be held liable for any 
* damages, either direct or non-direct, arising from the use
* of this program. This program may be modified and/or
* included in any program without any consideration to the
* author.
***********************************************************
* Revisions:
* Date Time Who Change Description
* 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴?
*
***********************************************************
***********************************************************
***** CODE 3-of-9 BAR CODE GENERATOR *****
***** ******************************* *****
***** This program will generate standard 3-of-9 bar code *****
***** on any dot matrix printer which is compatable with *****
***** an Epson/IBM graphics printer or HP LaserJet. *****
***** ****************************** *****
***** - SPECifICATIONS - *****
** **
** W N **
** | Nominal Width | Nominal Width | Nominal Ratio **
** Density | of | of | of **
** (Characters/ | Narrow Bars and | Wide Bars and | Wide to Narrow **
** Inch) | Spaces (Inches) | Spaces (Inches)| Element Width **
** -------------+-----------------+----------------+---------------- **
** 5.730 | 0.0125 | 0.0315 | 2.52 **
** -------------+-----------------+----------------+---------------- **
** **
***** ****************************** *****
***** Code 3-of-9 was developed in 1974 by Dr. David C. Allais of *****
***** Interface Mechanisms, Inc. It has been adopted as the *****
***** standard bar code symbology of the Department of Defence *****
***** (MIL-STD-1189) and is the most widely used alphanumeric bar *****
***** code in use. Code 3-of-9 is so called because the original *****
***** concept provided for 39 data characters. The name also *****
***** describes the structure of the code which has 3 wide elements *****
***** out of a total of 9. *****
***** *****
***** This program was written solely for information purposes to *****
***** demonstrate the structure of code 3-of-9. The author is *****
***** not responsible for any damages incurred through the use of *****
***** this program. *****
***** *****
***** Bill Wood Milwaukee, WI 05/18/85 *****
***********************************************************
***********************************************************
***** *****
***** This dBase code originated from a basic program written by ***** 
***** Bill Wood of Milwaukee, WI in May of 1985. I have, of course,***** 
***** converted it to dBase and added support for the HP LaserJet. ***** 
***** *****
***** Because of the wide variety and quality of bar code readers *****
***** and barcode print quality when using a dot matrix printer, I *****
***** strongly recommend using a laser printer for your barcodes. *****
***** Also, the you will get 7 characters per inch on the laser as *****
***** opposed to 5.6 cpi on a dot matrix. *****
***** *****
***** The LaserJet barcodes are generated using the pattern fill *****
***** functions and do not require the use of any font cartridges *****
***** or soft fonts. The tricky part of using this method is *****
***** following the HP cusor location on the printed page. Please *****
***** refer to the HP LaserJet Technical Reference Manual for a *****
***** thorough explanation of this. Currently, the program is *****
***** setup to print at 6 lines per inch. That is, a height of 1 *****
***** is equal to one line. *****
***** *****
***** The program requires two functions, the printer setup, and *****
***** the barcode creation. The printer setup defines the *****
***** components of the barcode and the barcode creation builds *****
***** the barcode from a passed character string. Using this *****
***** program as an example you should be able to generate a *****
***** barcode routine for any printer or barcode symbology. *****
***** *****
***** Good Luck, *****
***** George T. Neill *****
***********************************************************


***** Program Setup *****

clear screen
public esc,null,printer,height

esc = chr(27)
null = ""

@ 01,01 say [Code 39 Barcode Generator]

***** get printer type *****
* default to two line LaserJet barcode
printer = "L"
height = 2

@ 03,01 say [Print on (E)pson or (L)aserJet?] ;
get m->PRINTER ;
picture '@!'; 
valid printer$'EL'

@ 04,01 say [Enter Height of Barcode (1-4)] ;
get m->HEIGHT ;
picture '9' ;
range 1,4
read

if printer = "L"
do setup_hp

elseif printer = "E"
do setup_epson

endif

***** Define CODE 3of9 Characer Set ***** 
do DEF_CODE39

***** Get text to print and print barcode *****
stay = .T.
do while stay
***** Create empty variable. The length is arbitrary as there is *****
***** no defined maximum length of a 3of9 barcode. *****
message = space(25)

@ 07,01 say [Enter text to print ] ;
get m->MESSAGE ;
picture '@K!'
read

if empty(m->MESSAGE)
***** exit on no message text
stay = .F.
loop
endif

***** Prepend and append required asterik's to trimmed message *****
m->MESSAGE = "*"+trim(m->MESSAGE)+"*"

set device to print
***** print barcoded m->MESSAGE *****
@ prow()+height,00 say barcode(m->MESSAGE)

***** Print message text below barcode *****
@ prow()+if(printer="L",height,0),int(len(m->MESSAGE)/4) say m->MESSAGE
set device to screen

***** Check for page eject *****
***** (necessary to see what you've done on a laserjet) *****
eject = .F.
@ 08,01 say [Eject?] get eject picture [Y]
read
if eject
eject
endif

enddo

return
***** End of File CODE39 *****


*****************
***
*** Function: Barcode()
*** Purpose: Creates Code39 barcode from character string
*** Parameters: Character String
*** returns: String converted to barcode
*** Notes: Requires the following variables:
*** : 
*** : All printers:
*** : nb = narrow bar character
*** : wb = wide bar character
*** : ns = narrow space
*** : ws = wide space
*** : 
*** : HP LaserJet:
*** : start = Beginning cursor position adjustment
*** : end = Ending cursor position adjustment
*** : 
*** : Epson/IBM Printers:
*** : height = height of barcode in lines
*** : n1 & n2 = calculated dot graphics length
*** : 
*****************
function barcode
parameters MESSAGE
code = ""

do case
case printer = "L"
* read message character at a time and build barcode
for i = 1 to len(m->MESSAGE)
letter = substr(m->MESSAGE,i,1)
code = code + if(at(letter,chars)=0,letter,char[at(letter,chars)]) + NS
next
code = start + code + end

case printer = "E"
for h = 1 to height
for i = 1 to len(m->MESSAGE)
letter = substr(m->MESSAGE,i,1)

* build barcoded string
code = if(at(letter,chars)=0,letter,char[at(letter,chars)]) + NS

* print barcode character at a time on Epson
printcode(esc + chr(76) + chr(N1) + chr(N2) + code)
next

* perform 23/216 line feed
printcode(esc+chr(74)+chr(23)+chr(13))
next

* perform 5/216 line feed
printcode(esc+chr(74)+chr(5)+chr(13))

* reset printer to turn off graphics and reset to 10cpi
printcode(esc+"@")

endcase

return code
***** End of Function(BARCODE) *****


*****************
***
*** Procedure: Setup_HP
*** Purpose: Defines characters for HP LaserJet
*** Parameters: None
*** returns: Initialized Public variables
***
*****************

procedure setup_hp
public nb,wb,ns,ws,start,end
*** define bars and spaces for HP LaserJet II
small_bar = 3 && number of points per bar
wide_bar = round(small_bar * 2.25,0) && 2.25 x small_bar
dpl = 50 && dots per line 300dpi/6lpi = 50dpl

nb = esc+"*c"+transform(small_bar,'99')+"a"+alltrim(str(height*dpl))+"b0P"+esc+"*p+"+transform(small_bar,'99')+"X"
wb = esc+"*c"+transform(wide_bar,'99')+"a"+alltrim(str(height*dpl))+"b0P"+esc+"*p+"+transform(wide_bar,'99')+"X"
ns = esc+"*p+"+transform(small_bar,'99')+"X"
ws = esc+"*p+"+transform(wide_bar,'99')+"X"

*** adjust cusor position to start at top of line and return to bottom of line
start = esc+"*p-50Y"
end = esc+"*p+50Y"

return
***** End of Procedure(SETUP_HP) *****

*****************
***
*** Procedure: Setup_Epson
*** Purpose: Defines characters for Espon or IBM Graphics printer
*** Parameters: None
*** returns: Initialized Public variables
***
*****************

procedure setup_epson
public nb,wb,ns,ws,n1,n2
***** define Epson bars and spaces
ns = chr(0) + chr(0)
ws = chr(0) + chr(0) + chr(0) + chr(0)
nb = chr(255)
wb = chr(255) + chr(255) + chr(255)

***** set printer to 2/216 lines per inch
printcode(esc+chr(51)+chr(2)) 

***** calculate N1 and N2 values for dot graphics command
cols = 21
N1 = cols % 256 && modulus 
N2 = INT(cols/256)

return 
***** End of Procedure(SETUP_EPSON) *****


*****************
***
*** Procedure: Def_Code39
*** Purpose: Define character set for CODE39
*** Parameters: None
*** returns: Initialized Public variables and array
***
*****************

procedure def_code39
public char[44], chars

chars = "1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ-. *$/+%"
CHAR[01] = WB+NS+NB+WS+NB+NS+NB+NS+WB && "1"
CHAR[02] = NB+NS+WB+WS+NB+NS+NB+NS+WB && "2"
CHAR[03] = WB+NS+WB+WS+NB+NS+NB+NS+NB && "3"
CHAR[04] = NB+NS+NB+WS+WB+NS+NB+NS+WB && "4"
CHAR[05] = WB+NS+NB+WS+WB+NS+NB+NS+NB && "5"
CHAR[06] = NB+NS+WB+WS+WB+NS+NB+NS+NB && "6"
CHAR[07] = NB+NS+NB+WS+NB+NS+WB+NS+WB && "7"
CHAR[08] = WB+NS+NB+WS+NB+NS+WB+NS+NB && "8"
CHAR[09] = NB+NS+WB+WS+NB+NS+WB+NS+NB && "9"
CHAR[10] = NB+NS+NB+WS+WB+NS+WB+NS+NB && "0"
CHAR[11] = WB+NS+NB+NS+NB+WS+NB+NS+WB && "A"
CHAR[12] = NB+NS+WB+NS+NB+WS+NB+NS+WB && "B"
CHAR[13] = WB+NS+WB+NS+NB+WS+NB+NS+NB && "C"
CHAR[14] = NB+NS+NB+NS+WB+WS+NB+NS+WB && "D"
CHAR[15] = WB+NS+NB+NS+WB+WS+NB+NS+NB && "E"
CHAR[16] = NB+NS+WB+NS+WB+WS+NB+NS+NB && "F"
CHAR[17] = NB+NS+NB+NS+NB+WS+WB+NS+WB && "G"
CHAR[18] = WB+NS+NB+NS+NB+WS+WB+NS+NB && "H"
CHAR[19] = NB+NS+WB+NS+NB+WS+WB+NS+NB && "I"
CHAR[20] = NB+NS+NB+NS+WB+WS+WB+NS+NB && "J"
CHAR[21] = WB+NS+NB+NS+NB+NS+NB+WS+WB && "K"
CHAR[22] = NB+NS+WB+NS+NB+NS+NB+WS+WB && "L"
CHAR[23] = WB+NS+WB+NS+NB+NS+NB+WS+NB && "M"
CHAR[24] = NB+NS+NB+NS+WB+NS+NB+WS+WB && "N"
CHAR[25] = WB+NS+NB+NS+WB+NS+NB+WS+NB && "O"
CHAR[26] = NB+NS+WB+NS+WB+NS+NB+WS+NB && "P"
CHAR[27] = NB+NS+NB+NS+NB+NS+WB+WS+WB && "Q"
CHAR[28] = WB+NS+NB+NS+NB+NS+WB+WS+NB && "R"
CHAR[29] = NB+NS+WB+NS+NB+NS+WB+WS+NB && "S"
CHAR[30] = NB+NS+NB+NS+WB+NS+WB+WS+NB && "T"
CHAR[31] = WB+WS+NB+NS+NB+NS+NB+NS+WB && "U"
CHAR[32] = NB+WS+WB+NS+NB+NS+NB+NS+WB && "V"
CHAR[33] = WB+WS+WB+NS+NB+NS+NB+NS+NB && "W"
CHAR[34] = NB+WS+NB+NS+WB+NS+NB+NS+WB && "X"
CHAR[35] = WB+WS+NB+NS+WB+NS+NB+NS+NB && "Y"
CHAR[36] = NB+WS+WB+NS+WB+NS+NB+NS+NB && "Z"
CHAR[37] = NB+WS+NB+NS+NB+NS+WB+NS+WB && "-"
CHAR[38] = WB+WS+NB+NS+NB+NS+WB+NS+NB && "."
CHAR[39] = NB+WS+WB+NS+NB+NS+WB+NS+NB && " "
CHAR[40] = NB+WS+NB+NS+WB+NS+WB+NS+NB && "*"
CHAR[41] = NB+WS+NB+WS+NB+WS+NB+NS+NB && "$"
CHAR[42] = NB+WS+NB+WS+NB+NS+NB+WS+NB && "/"
CHAR[43] = NB+WS+NB+NS+NB+WS+NB+WS+NB && "+"
CHAR[44] = NB+NS+NB+WS+NB+WS+NB+WS+NB && "%"

return
***** End of Procedure(DEF_CODE39) *****

*****************
***
*** Function: Printcode
*** Purpose: Sends escape codes to printer
*** Parameters: Character string or escape sequence
*** returns: Nothing
***
*****************

function printcode
parameters code
set console off
set print on
?? code
set print off
set console on
return null
***** End of Function(PRINTCODE) *****
