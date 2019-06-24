? AscanCor(11)	 


Function AllColors() 
********************
LOCAL aPattern := {}
LOCAL x

For x:= 0 To 255 step 16   
	nBlack         := x + 00
	nBlue          := x + 01
	nGreen         := x + 02
	nCyan          := x + 03
	nRed           := x + 04
	nMagenta       := x + 05
	nBrown         := x + 06
	nWhite         := x + 07
	nGray          := x + 08
	nBrightBlue    := x + 09
	nBrightGreen   := x + 10
	nBrightCyan    := x + 11
	nBrightRed     := x + 12
	nBrightMagenta := x + 13	
	nYellow        := x + 14
	nBrightWhite   := x + 15
   Aadd( aPattern, { /* 01 */ nBlack,;
							/* 02 */ nBlue,;          
							/* 03 */ nGreen,;        
							/* 04 */ nCyan,;          
							/* 05 */ nRed,;           						
							/* 06 */ nMagenta,;
							/* 07 */ nBrown,;         
							/* 08 */ nWhite,;         
							/* 09 */ nGray,;          
							/* 10 */ nBrightBlue,;    
							/* 11 */ nBrightGreen,;   
							/* 12 */ nBrightCyan,;    
							/* 13 */ nBrightRed,;     
							/* 14 */ nBrightMagenta,; 
							/* 15 */ nYellow,;        
							/* 16 */ nBrightWhite})
next
return ( aPattern )

Function AscanCor(nPos)	  
***********************
LOCAL aPattern := AllColors()
LOCAL xCor     := 0
LOCAL nCor     := int(xCor/16) + 1 
LOCAL nX
LOCAL nY

//nX := Ascan( aPattern, {|aPattern|aPattern[11] == xCor })
return aPattern[nCor, nPos]

/*
for nX := 1 To 16
	for nY := 1 To 16
		if nCor = aPattern[nX,nY] 
			return( aPattern[nX,nPos])
		endif
	next
next
return( 0 )
*/

proc teste
	LOCAL aArr:={}
	LOCAL aPattern := AllColors()
        AADD(aArr,{"one","two"})
        AADD(aArr,{"three","four"})
        AADD(aArr,{"five","six"})
        ? "aArr     ", ASCAN(aArr,     {|aArr| aArr[1] == "one"})         // returns 2
		  ? "aPattern ", ASCAN(aPattern, {|aArr| aArr[8] == 23 })           // returns 2

		  
 aArray := { "Tom", "Mary", "Sue" }
        ? ASCAN(aArray, "Mary")               // Result: 2
        ? ASCAN(aArray, "mary")               // Result: 0
        ? ASCAN(aArray, { |x| UPPER(x) == "MARY" })                    // Result: 2		  
				  
				  
				  
				  
				  
				  
				  
				  
				  
				  
				  
				  