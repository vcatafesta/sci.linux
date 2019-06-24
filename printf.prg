#include <color.ch>
#XCOMMAND DEFAU   <v1> TO <x1> [, <vn> TO <xn> ]   =>	if <v1> == NIL ; <v1> := <x1> ; END	[; if <vn> == NIL ; <vn> := <xn> ; END ]

Function main
	printf(AllTrim(Os()), 75)


Function printf(string, attrib)
*******************************
	LOCAL Color_Ant := SetColor()
	DEFAU attrib  TO ColorStrToInt(Color_Ant)

	SetColor(ColorIntToStr(attrib))
	//DevPos(row(), col()) ; DevOut(string)
	hb_DispOutAt( row(), col(), string)
	SetColor( Color_Ant)
	return NIL


Function ColorIntToStr(xColor)
****************************
LOCAL cColor
//return(cColor := hb_NToColor(xColor))
return(cColor := FT_n2Color(xColor))

//******************************************************************************

Function ColorStrToInt(xColor)
****************************
LOCAL nColor
//return (nColor := hb_ColorToN(xColor()))
return( nColor := FT_Color2n(xColor))
