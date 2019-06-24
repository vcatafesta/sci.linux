*
* String Class
*
* Copyright 2007-2018 Vilmar Catafesta [vcatafesta@gmail.com]
*
* ∞∞∞±±≤≤≤€€€
*
#include <sci.ch>

CLASS TString
	HIDDEN:
		DATA xbuffer 			INIT ''

	PROTECTED:
		VAR lChanged  			INIT .F.
		VAR buffer  			INIT ''
		VAR cWho     			INIT 'TTString'
		VAR cNome         		INIT ProcName()

	EXPORTED:
		VAR value  				INIT ''

	PUBLIC:
		METHOD new(xValue)  	CONSTRUCTOR
		METHOD len  			INLINE len(::buffer)
		METHOD capitalize		INLINE capitalize(::buffer)
		METHOD upcase			INLINE upper(::buffer)
		METHOD upper			INLINE upper(::buffer)
		METHOD toupper 			INLINE upper(::buffer)
		METHOD downcase			INLINE lower(::buffer)
		METHOD tolower 			INLINE lower(::buffer)
		METHOD lower 			INLINE lower(::buffer)
		METHOD type  			INLINE valtype(::buffer)
		METHOD Destroy()
		DESTRUCTOR Destroy()

	EXPORTED:
		ACCESS changed 			METHOD getChanged()
		ASSIGN changed 			METHOD setChanged( lChanged )
		ACCESS gets          	METHOD SetGet(xValue)
		ACCESS get           	METHOD SetGet(xValue)
		ASSIGN set           	METHOD SetGet(xValue)
		ASSIGN put           	METHOD SetGet(xValue)
ENDCLASS

METHOD new(xValue) CLASS TString
	::set   := xValue
	return self

METHOD Destroy() CLASS TString
	self := nil
	return self

METHOD setget(xValue) CLASS TString
   if HB_ISSTRING(xValue)
      ::buffer   := xValue
      ::value    := ::buffer
      ::lChanged := true
   endif
   return ::buffer

METHOD getChanged() CLASS TString
   return ::lChanged

METHOD setChanged(lChanged) CLASS TString
   if HB_ISLOGICAL(lChanged)
      return ::lChanged := lChanged
   endif
   return false
