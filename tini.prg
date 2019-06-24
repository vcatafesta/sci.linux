#include <sci.ch>

//ANNOUNCE Profile

class TIni
	export:
		VAR File	 		INIT ""
		VAR Handle		INIT 0
		VAR Aberto		INIT false
		VAR Separador	INIT ""
		VAR Ferror     INIT 0 
		VAR FileExist 	INIT false
		VAR WriteOpen 	INIT 0
		VAR WriteCount	INIT 0
	export:
		METHOD New
		METHOD ReadBool
		METHOD ReadInteger
		METHOD ReadString
		METHOD ReadDate
		METHOD WriteIni
		METHOD Close
		METHOD Open
		METHOD ShowVar
		
		MESSAGE Write	    	METHOD WriteIni
		MESSAGE WriteBool    METHOD WriteIni
		MESSAGE WriteInteger METHOD WriteIni
		MESSAGE WriteString  METHOD WriteIni
		MESSAGE WriteDate    METHOD WriteIni	
		MESSAGE Free         METHOD Close
		MESSAGE Create       METHOD New	 	 
endclass
	
METHOD ShowVar()	
	AlertaPy(;
		"Variaveis TINI;-;" + ;
		"::file      # " + ::file + ';' + ;
		"::handle    # " + formatavar(::Handle)	+ ';' + ;
		"::aberto    # " + formatavar(::Aberto)	+ ';' + ;		
		"::ferror    # " + formatavar(::Ferror) 	+ ';' + ;
		"::fileexist # " + formatavar(::FileExist)+ ';' + ;
		"::writeopen # " + formatavar(::WriteOpen)+ ';' + ;
		"::writecount# " + formatavar(::WriteCount)+ ';' + ;
		"::separator # " + formatavar(::Separador), 31, false ;		
	)	
	return self
	
	
METHOD New( cFile )
*******************
	::File      := cFile
	::Separador := ';'
	if rat( ".", ::File ) == 0
		::File := alltrim( cFile ) + ".ini"
	endif
	::Open()
	//::Close()
	return self

METHOD Close()
*****************
	ms_swap_fclose(::Handle)
	::Ferror := ms_swap_ferror()
	::Aberto := false
	return( ::Ferror == 0 )

METHOD Open()
***************
	
	if (::Handle := ms_swap_fopen( ::File, FO_READWRITE + FO_SHARED) ) == F_ERROR
		::Ferror := ms_swap_ferror()
	endif
	
	if ::Ferror == FERROR_FILENOTFOUND .OR. !(ms_swap_file(::File))
		::Handle := ms_swap_Fcreate( ::File, 0 )
		::Ferror := ms_swap_ferror()
	endif	
	::FileExist := ms_swap_file(::File)	
	::Aberto    := true 
	return(::Aberto)

METHOD WriteIni( cSection, cKey, xValue )
*****************************************	
	LOCAL lRetCode,      ; // Function's return code
			cType,         ; // Data type of the value
			cOldValue,     ; // Current value
			cNewValue,     ; // New value to be written
			cBuffer,       ; // Buffer for the read
			nFileLen,      ; // Length of the file in bytes
			nSecStart,     ; // Start position in the file of the section
			nSecEnd,       ; // Ending position in the file of the section
			nSecLen,       ; // Initial length of the section
			cSecBuf,       ; // Section subtring
			nKeyStart,     ; // Start position in the file of the key
			nKeyEnd,       ; // Ending position in the file of the key
			nKeyLen,       ; // Initial length of the key
			lProceed,      ; // .T. if proceeding with the change
			cChar            // Single character read from file
	
	if LEFT( cSection, 1 ) <> "["
		cSection := "[" + cSection
	endif
	
	if RIGHT( cSection, 1 ) <> "]"
		cSection += "]"
	endif
		
	lProceed := lRetCode := false
	nSecLen  := 0
	cType    := VALTYPE( xValue )
	DO CASE
		CASE cType == "C"
			cNewValue := xValue
		CASE cType == "N"
			cNewValue := ALLTRIM( STR( xValue ))
		CASE cType == "L"
			cNewValue := if( xValue, "1", "0" )
		CASE cType == "D"
			cNewValue := DTOS( xValue )
		OTHERWISE
			cNewValue := ""
	ENDCASE	
	if !(::Aberto)
		::Open()
		::Aberto := true
	endif	
	if ::Handle > 0 	
		::WriteOpen++
		nFileLen := ms_swap_fseek( ::Handle, 0, FS_END )
		ms_swap_fseek( ::Handle, 0 , FS_SET )
		cBuffer := Space( nFileLen )
		if ms_swap_fread( ::Handle, @cBuffer, nFileLen ) == nFileLen
			nSecStart := AT( cSection, cBuffer )
			if nSecStart > 0
				nSecStart += LEN( cSection ) + 2 // Length of cSection + CR/LF
				cSecBuf   := RIGHT( cBuffer, nFileLen - nSecStart + 1 )
				if !EMPTY( cSecBuf )
					nSecEnd := AT( "[", cSecBuf )
					if nSecEnd > 0
						cSecBuf := LEFT( cSecBuf, nSecEnd - 1 )
					endif
					nSecLen   := LEN( cSecBuf )
					nKeyStart := AT( cKey, cSecBuf )
					if nKeyStart > 0
						nKeyStart += LEN( cKey ) + 1
						nKeyEnd   := nKeyStart
						cOldValue := cChar := ""
						while cChar <> CHR(13)
							cChar := SUBSTR( cSecBuf, nKeyEnd, 1 )
							if cChar <> CHR(13)
								cOldValue += cChar
								++ nKeyEnd
							endif
						enddo
						nKeyLen  := LEN( cOldValue )
						cSecBuf  := STUFF( cSecBuf, nKeyStart, nKeyLen, cNewValue )
						lProceed := .T.
					else
						cSecBuf  := cKey + "=" + cNewValue + _CRLF + cSecBuf
						lProceed := .T.
					endif
				endif
			else
				cSecBuf  := cSection + _CRLF + cKey + "=" + cNewValue + _CRLF + _CRLF
				lProceed := .T.
			endif
		endif
		if lProceed
			if nSecStart == 0
				nSecStart := LEN( cBuffer )
			endif
			cBuffer := STUFF( cBuffer, nSecStart, nSecLen, cSecBuf )
			ms_swap_fseek( ::Handle, 0 , FS_SET )
		  
			//if !FTruncate( ::Handle )
			//   ::Close()
			//   ::Handle := ms_swap_Fcreate( ::File, 0 )
			//endif
		  
			if ms_swap_fwrite( ::Handle, cBuffer ) == LEN( cBuffer )				
				::WriteCount++
				lRetCode := .T.
			endif
		endif	
	endif	
	//::Close()
	return lRetCode

METHOD ReadString( cSection, cKey, cDefault, nPos )
***************************************************
	LOCAL cString, cBuffer, nFileLen, nSecPos
	LOCAL cSecBuf, nKeyPos, cChar
	LOCAL xTemp
	LOCAL lRetCode := false

	if LEFT( cSection, 1 ) <> "["
		cSection := "[" + cSection
	endif
	
	if RIGHT( cSection, 1 ) <> "]"
		cSection += "]"
	endif
	
	if cDefault == NIL
		cDefault := ""
	endif
	
	cString := cDefault
	if !(::Aberto)
		::Open()
		::Aberto := true
	endif	
	
	if ::Handle > 0 
		nFileLen := ms_swap_fseek(::Handle, 0, FS_END )
		ms_swap_fseek( ::Handle, 0 , FS_SET )
		cBuffer := SPACE( nFileLen )
		if ms_swap_fread( ::Handle, @cBuffer, nFileLen ) == nFileLen
			nSecPos := AT( cSection, cBuffer )
			if nSecPos > 0
				cSecBuf := RIGHT( cBuffer, nFileLen - ( nSecPos + LEN( cSection )))
				if !EMPTY( cSecBuf )
					nSecPos := AT( "[", cSecBuf )
					if nSecPos > 0
						cSecBuf := LEFT( cSecBuf, nSecPos - 1 )
					endif
					nKeyPos := AT( cKey, cSecBuf )
					if nKeyPos > 0
						nKeyPos += LEN( cKey ) + 1
						cString := cChar := ""
						DO WHILE cChar <> CHR(13)
							cChar := SUBSTR( cSecBuf, nKeyPos, 1 )
							if cChar <> CHR(13)
								cString += cChar
								++ nKeyPos
							endif
						ENDDO				
					endif
				endif
			endif			
		endif
		//::Close()
	endif
	if nPos = NIL .OR. nPos = 0
		lRetCode := true
		return cString
	else
		xTemp := StrExtract( cString, ::Separador, nPos )
		if Empty( xTemp )
			return( cDefault )
		endif
		return( xTemp )
	endif

METHOD ReadBool( cSection, cKey, lDefault, nPos )
*************************************************
	LOCAL cValue, cDefault, nValue

	if lDefault == NIL
		lDefault := FALSO
	endif
	cValue   := ::ReadString( cSection, cKey, nPos )
	if EMPTY( cValue )
		return( lDefault )
	endif
	return ( nValue := VAL( cValue )) == 1

METHOD ReadDate( cSection, cKey, dDefault, nPos )
*******************************************
	LOCAL cDateFmt, cValue, cDefault, dDate

	if VALTYPE( dDefault ) <> "D"
		dDefault := CTOD( "" )
	endif
	dDate    := dDefault
	cDefault := ALLTRIM( DTOS( dDefault ))
	cValue   := ::ReadString( cSection, cKey, cDefault, nPos )
	if !EMPTY( cValue )
		dDate := CTOD( cValue )
		if EMPTY( dDate )
			cDateFmt := SET(_SET_DATEFORMAT, "mm/dd/yy" )
			dDate := CTOD( SUBSTR( cValue, 5, 2 ) + "/" + RIGHT( cValue, 2 ) + "/" + LEFT( cValue, 4 ))
			SET(_SET_DATEFORMAT, cDateFmt )
		endif
	endif
	return dDate


METHOD ReadInteger( cSection, cKey, nDefault, nPos )
****************************************************
	LOCAL cValue, cDefault, nValue

	if nDefault == NIL
		nDefault := 0
	endif
	nValue   := nDefault
	cDefault := ALLTRIM( STR( nDefault ))
	cValue   := ::ReadString( cSection, cKey, cDefault, nPos )
	if !EMPTY( cValue )
		nValue := VAL( cValue )
	endif
	return nValue

Function TIniNew( cFile )
*************************
	return( TIni():New( cFile ))