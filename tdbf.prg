#include "sci.ch"  
#translate pause() => pausetdbf()
REQUEST HB_LANG_EN
REQUEST HB_LANG_PT

def AmbienteTDbf(cDbf)	
	PUBLIC oAmbiente := TAmbiente():New()
	PUBLic oIndice	  := TIndiceNew()	
	PUBLIC oMenu     := oAmbiente
	PUBLIC oIni 	  := TIniNew("TDBF.INI")
	PUBL aLpt1		  := {}
	PUBL aLpt2		  := {}
	PUBL aLpt3		  := {}	

	cls	
	oAmbiente:LetoIp   := '//127.0.0.1'
	oAmbiente:LetoPort := '2812'
	oIndice:ProgressoNtx := OK
	FechaTudo()
	if !AbreArquivo(cDbf)
		__quit()
	endif
	if !AbreArquivo("USUARIO")
		__quit()
	endif
	if !AbreArquivo("PRINTER")
		__quit()
	endif
	
	Fechatudo()
	return
	
def MainTDbf()	
   LOCAL e1
   LOCAL e2
   LOCAL e3
   LOCAL e4	
	LOCAL oDbf     
	LOCAL cDbf := "RECEBER"	

	hb_langSelect("pt")	
	AmbienteTDbf(cDbf)	
	oDbf := TDbf():New(cDbf)			
	oMenu:Limpa()
	alertaPy(' INFO: Nada encontrado nos parametros informados abaixo: ;-;;' + ;
								' Fatura: ' + "000" + ';' + ;				
            				' Codigo: ' + "000" + ';' + ;				
								'  Busca: ' + "000" + ';' + ;				
            				'   Data: ' + dToc(Date()), 31 , false)	
	pause()
	
	WITH OBJECT oDbf
		? "oDbf:DBF        =>", :dbf
		? "oDbf:Alias      =>", :Alias
		? "oDbf:Travados() =>", :Travados()
	// ? "oDbf:DbDelete() =>", :DbDelete()
		? "oDbf:aaField    =>", :addField()
		? "oDbf:Field      =>", len(:Field)
		
		pausetdbf()
		HSetCaseMatch( :Field,  .F. ) // desabilita o case-sensitive									
		
		/*
		for EACH e1 IN :Field
			? e1:__EnumIndex(), e1:__EnumKey(), e1:__EnumValue() 								
		next
		
		? :Field["CODI"], :Recno()
		
		:GetDados()
		? :Field["CODI"]
		? :Field["NOME"]	
				
		? :Field["CODI"] := "00001"
		? :Field["NOME"] := "VILMAR"
		
		pausetdbf()
		
		? :Recno()
		for EACH e1 IN :Field
			? e1:__EnumIndex(), e1:__EnumKey(), e1:__EnumValue() 								
		next
		
		? :Order(RECEBER_CODI)
		? :dbSeek("00001")		
		pausetdbf()
		
		? :Recno()
		for EACH e1 IN :Field
			? e1:__EnumIndex(), e1:__EnumKey(), e1:__EnumValue() 								
		next
		? :Field["CODI"]
		? :Field["NOME"]	
		
		pausetdbf()
		*/
		
		//? :dbgoto(100)		
		//? :Recno()
		// pausetdbf()
		/*
		for EACH e1 IN :Field
			? e1:__EnumIndex(), e1:__EnumKey(), e1:__EnumValue() 								
			for EACH e2 IN e1
				? "	", e2:__EnumIndex(), e2:__EnumKey(), e2:__EnumValue() 								
				//for EACH e3 IN e2
				//	? e3:__EnumIndex(), e3:__EnumKey(), e3:__EnumValue() 								
				//next
			next
			//pausetdbf()
		next
		*/
		cls
		// aKeys := hb_hKeys( oDbf:Field["CODI"]["NAME"])
		// achoice( 10, 10, 40, 70, aKeys)
	
	   /* 
		:FieldBlank()
		? ':Field["CODI"]["VALUE"]', :Field["CODI"]["VALUE"]
		? ':Field["NOME"]["VALUE"]', :Field["NOME"]["VALUE"]
		? ':Field["ENDE"]["VALUE"]', :Field["ENDE"]["VALUE"]
		? ':Field["ENDE"]["VALUE"]', :Field["CIDA"]["VALUE"]
		? ':Field["CODI"]["VALUE"]', :Field["CODI"]["VALUE"]	 := :ProxReg("CODI")
		? ':Field["NOME"]["VALUE"]', :Field["NOME"]["VALUE"]	 := 'EVILI'		
		? ':Field["ENDE"]["VALUE"]', :Field["ENDE"]["VALUE"]	 := 'AV CASTELO BRANCO'				
		? ':Field["DATA"]["VALUE"]', :Field["DATA"]["VALUE"]	 := :ProxReg("DATA")
		? ':Field["MEDIA"]["VALUE"]', :Field["MEDIA"]["VALUE"] := :ProxReg("MEDIA")
		:CommitNew()		
		
		? ':Field["CODI"]["VALUE"]', :Field["CODI"]["VALUE"]	:= :ProxReg("CODI")
		? ':Field["NOME"]["VALUE"]', :Field["NOME"]["VALUE"]	:= 'VILMAR'		
		? ':Field["ENDE"]["VALUE"]', :Field["ENDE"]["VALUE"]	:= 'AV CASTELO BRANCO'		
		? ':Field["CIDA"]["VALUE"]', :Field["CIDA"]["VALUE"]	:= 'PIMENTA BUENO'
		? ':Field["DATA"]["VALUE"]', :Field["DATA"]["VALUE"]	:= :ProxReg("DATA")
		? ':Field["MEDIA"]["VALUE"]', :Field["MEDIA"]["VALUE"]	:= :ProxReg("MEDIA")
		:CommitNew()		
		
		:DbGotop()
		:GetDados()
		? ':Field["CODI"]["VALUE"]', :Field["CODI"]["VALUE"]
		? ':Field["NOME"]["VALUE"]', :Field["NOME"]["VALUE"]
		? ':Field["ENDE"]["VALUE"]', :Field["ENDE"]["VALUE"]
		? ':Field["CIDA"]["VALUE"]', :Field["CIDA"]["VALUE"]
		? ':Field["DATA"]["VALUE"]', :Field["DATA"]["VALUE"]		
		? ':Field["MEDIA"]["VALUE"]', :Field["MEDIA"]["VALUE"]
		pause()		
		Browse()		
		:RollBack()		
		:DbGotop()
		Browse()	
		*/
		
		while( true )
			setcolor("")
			cls
			
			:FieldBlank()
			:Field["CODI"]["VALUE"] := :ProxReg("CODI")
			AlertaPy("Ooops!: Entre com o Codigo!",nil,nil,false)
			MaBox(09, 09, 18, 100, "INCLUSAO DE CLIENTES")
			@ 11, 11 Say ':Field["CODI" ]["VALUE"] ' GET :Field["CODI"]["VALUE"]  Valid if(Empty(:Field["CODI"]["VALUE"]), ( ErrorBeep(), AlertaPy("Ooops!, Entre com o Codigo", nil, nil, ), FALSO ), OK )
			@ 12, 11 Say ':Field["NOME" ]["VALUE"] ' GET :Field["NOME"]["VALUE"]  Valid if(Empty(:Field["NOME"]["VALUE"]), ( ErrorBeep(), AlertaPY("Ooops!, Entre com o Nome!"), FALSO ), OK )
			@ 13, 11 Say ':Field["ENDE" ]["VALUE"] ' GET :Field["ENDE"]["VALUE"]  Valid if(Empty(:Field["ENDE"]["VALUE"]), ( ErrorBeep(), AlertaPy("Ooops!, Entre com o Ende!"), FALSO ), OK )
			@ 14, 11 Say ':Field["CIDA" ]["VALUE"] ' GET :Field["CIDA"]["VALUE"]  Valid if(Empty(:Field["CIDA"]["VALUE"]), ( ErrorBeep(), AlertaPy("Ooops!, Entre com o Codigo!"), FALSO ), OK )
			@ 15, 11 Say ':Field["DATA" ]["VALUE"] ' GET :Field["DATA"]["VALUE"]  Valid if(Empty(:Field["DATA"]["VALUE"]), ( ErrorBeep(), AlertaPy("Ooops!, Entre com o Codigo!"), FALSO ), OK )
			@ 16, 11 Say ':Field["MEDIA"]["VALUE"] ' GET :Field["MEDIA"]["VALUE"] Valid if(Empty(:Field["MEDIA"]["VALUE"]), ( ErrorBeep(), AlertaPy("Ooops!, Entre com o Codigo!"), FALSO ), OK )
			Read
			if lastkey() = K_ESC
				if conf("Pegunta: Encerrar?")
					:FieldBlank()
					exit
				endif	
				loop
			endif					
			? ':Field["CODI"]["VALUE"]', :Field["CODI"]["VALUE"]
			? ':Field["NOME"]["VALUE"]', :Field["NOME"]["VALUE"]
			? ':Field["ENDE"]["VALUE"]', :Field["ENDE"]["VALUE"]
			? ':Field["CIDA"]["VALUE"]', :Field["CIDA"]["VALUE"]
			? ':Field["DATA"]["VALUE"]', :Field["DATA"]["VALUE"]		
			? ':Field["MEDIA"]["VALUE"]', :Field["MEDIA"]["VALUE"]		
			if conf("Pegunta: Deseja Salvar?")
				:CommitNew()		
			endif	
			browse()
		enddo
	ENDWITH	
	oDbf:Destroy()
	__quit()
	return nil
	
def pausetdbf()
	inkey(0)
	if lastkey() = 27
	   __quit()
	endif		
	retur nil

CLASS TDbf
   DATA Id    
	DATA Field  INIT {=>}
	DATA hField INIT {=>}
	DATA hStru  INIT {=>}
	DATA Dbf
	DATA Alias
	DATA nLastRecnoCommit
	
	METHOD new(cDbf) CONSTRUCTOR
	DESTRUCTOR Destroy() 
   METHOD Open   
	METHOD DbSkip(x) 
	METHOD DbSeek(x) 
	METHOD DbDelete(nrecno)
	METHOD DbDelete(nrecno)
	METHOD Destroy()
	
	METHOD GetDados()		
	METHOD Append()
	METHOD Libera()
	METHOD Travados()	
	METHOD addField()
	METHOD Fcount()
	METHOD DbStruct()
	METHOD GetFieldBlank(cType, nLen)	
	METHOD FieldBlank()
	METHOD Commit()
	METHOD CommitNew()
	METHOD RollBack(nLastRecnoCommit)
	METHOD ProxReg(cCampo)
	
	MESSAGE Create(cDbf) 	METHOD new(cDbf)
	MESSAGE Init(cDbf) 	   METHOD new(cDbf)
	MESSAGE Del(nrecno) 		METHOD DbDelete(nrecno)	
	MESSAGE Delete(nrecno)  METHOD DbDelete(nrecno)
	MESSAGE Close()     		INLINE (::Alias)->(DbCloseArea())	
	MESSAGE Recno()        	INLINE (::Alias)->(Recno())	
	MESSAGE Order(nindice)	INLINE (::Alias)->(Order(nindice))	
	MESSAGE Incluiu()			INLINE (::Alias)->(Incluiu())	
	MESSAGE DbGoTop()    	INLINE (::Alias)->(DbGotop())	
	MESSAGE DbGoBottom()   	INLINE (::Alias)->(DbGoBottom())	
	MESSAGE TravaReg()   	INLINE (::Alias)->(TravaReg())	
	MESSAGE DbGoto(nrecno) 	INLINE (::Alias)->(DbGoto(nrecno))	
	/*MESSAGE DbGoto(nrecno) 	INLINE Eval({|self, nrecno|
														(self:Alias)->(DbGoTo(nrecno))
														 self:GetDados()
														 return self:Recno()
													}, self, nrecno)*/
ENDCLASS

METHOD TDbf:New(cDbf)
	if cDbf = VOID
		alerta("Inicializacao sem o database")
	endif		
	::Dbf    := upper(cDbf) + '.DBF'
	::Alias  := upper(cDbf)
	::Open()
	::AddField()
	::DbStruct()	
	//::GetDados()
	return self
	
METHOD Destroy()
	(::Alias)->(DbCloseArea())
   self := nil	
	return nil
	
METHOD function TDbf:Fcount()
	return (::Alias)->(FCount())
	
METHOD function TDbf:ProxReg(cCampo)
	LOCAL nRecno := ::Recno()		
	LOCAL nPos   
	LOCAL nLen   
	LOCAL cType 	
	LOCAL cNewReg
	
	hb_default(@cCampo, "CODI")
	::DbGoBottom()	
	nPos   := (::Alias)->(FieldPos(cCampo))
	nLen   := (::Alias)->(FieldLen(nPos))		
	cType  := (::Alias)->(FieldType(nPos))		
	
	SWITCH cType
		case "C"  ; cNewReg := TrimStrZero(Val((::Alias)->(FieldGet(nPos)))+1 ,nLen); 	exit
		case "N"  ; cNewReg := (::Alias)->(FieldGet(nPos))+1 ; exit		
		case "D"  ; cNewReg := Date() ; exit
		otherwise ; cNewReg := (::Alias)->(FieldGet(nPos)) ; exit		
	ENDSWITCH
	::DbGoto(nRecno)
	return(cNewReg)

METHOD function TDbf:addField()
   LOCAL aCampos := {}
   LOCAL aGets   := {}
	LOCAL fLen := ::FCount()
	LOCAL x
	LOCAL cCampo
	LOCAL cGet
	LOCAL cType
	LOCAL nLen
	LOCAL nDec
	
	/*
	? (::Alias)->(DbStruct())[1][1] // CODI
	? (::Alias)->(DbStruct())[1][2] // C
	? (::Alias)->(DbStruct())[1][3] // 5
	? (::Alias)->(DbStruct())[1][4] // 0
	inkey(0)
	*/
	
	hCor   := { 'cor'   => ;
					{"corborda" => {"value" => 0},;
			  		 "cormenu"  => {"value" => 1},;
		  			 "corcabec" => {"value" => 2},;
					 "corfundo" => {"value" => 3},;
					 "corbarra" => {"value" => 4},;
					 "cor1"     => {"value" => 5}}}
	
	for x := 1 To fLen
		cCampo := (::Alias)->(FieldName(x))
		cGet   := (::Alias)->(FieldGet(x))
		cType  := (::Alias)->(FieldType(x))				
		nLen   := (::Alias)->(FieldLen(x))				
		nDec   := (::Alias)->(FieldDec(x))				
		
		aadd( aCampos, cCampo)
		aadd( aGets, cGet)		
		::Field[cCampo ] := Hash()  // {=>}				
		::Field[cCampo ]['NAME' ] := cCampo
		::Field[cCampo ]['TYPE' ] := cType
		::Field[cCampo ]['LEN'  ] := nLen
		::Field[cCampo ]['DEC'  ] := nDec		
		::Field[cCampo ]['RECNO'] := 0
		::Field[cCampo ]['VALUE'] := ::GetFieldBlank(cType, nLen)
	next			
	::hField := ::Field
	return len(::Field)

METHOD function TDbf:GetDados()
	LOCAL x
	LOCAL xLen := ::FCount()
	LOCAL cCampo
	LOCAL cGet
	LOCAL cType
	LOCAL nLen
	LOCAL nDec	
	
	for x := 1 To xLen
		cCampo := (::Alias)->(FieldName(x))
		cGet   := (::Alias)->(FieldGet(x))
		cType  := (::Alias)->(FieldType(x))				
		nLen   := (::Alias)->(FieldLen(x))				
		nDec   := (::Alias)->(FieldDec(x))
		::Field[cCampo ]['RECNO'] := ::Recno()
		::Field[cCampo ]['VALUE'] := cGet
	next	
	return len(::Field)
	
METHOD function TDbf:Commit()
	LOCAL x
	LOCAL xLen := ::FCount()
	LOCAL cCampo
	LOCAL cGet
	LOCAL cType
	LOCAL nLen
	LOCAL nDec	
	
	if ::TravaReg()
		for x := 1 To xLen
			cCampo := (::Alias)->(FieldName(x))
			cGet   := (::Alias)->(FieldGet(x))
			cType  := (::Alias)->(FieldType(x))				
			nLen   := (::Alias)->(FieldLen(x))				
			nDec   := (::Alias)->(FieldDec(x))			
			(::Alias)->( FieldPut( x, ::Field[cCampo ]['VALUE']))
		next	
		::Libera()
		return true
	endif	
	return false
	
METHOD function TDbf:CommitNew()
	LOCAL x
	LOCAL xLen := ::FCount()
	LOCAL cCampo
	LOCAL cGet
	LOCAL cType
	LOCAL nLen
	LOCAL nDec	
	
	if ::Incluiu()
		for x := 1 To xLen
			cCampo := (::Alias)->(FieldName(x))
			cGet   := (::Alias)->(FieldGet(x))
			cType  := (::Alias)->(FieldType(x))				
			nLen   := (::Alias)->(FieldLen(x))				
			nDec   := (::Alias)->(FieldDec(x))			
			(::Alias)->( FieldPut( x, ::Field[cCampo ]['VALUE']))
		next	
		::nLastRecnoCommit := ::Recno()
		::Libera()
		return true
	endif	
	return false	
	
METHOD function TDbf:RollBack(nLastRecnoCommit)
	hb_default(@nLastRecnoCommit, ::nLastRecnoCommit)
	if nLastRecnoCommit != nil
      return( ::DbDelete(nLastRecnoCommit))
	endif
	return false

METHOD function TDbf:GetFieldBlank(cType, nLen)		
	LOCAL hBranco := {"C" => Space(nLen), "N" => 0, "D" => cTod("//"), "L" => false }
	LOCAL cGet    := hBranco[cType]
	return cGet

METHOD function TDbf:FieldBlank()
	LOCAL x
	LOCAL xLen := ::FCount()
	LOCAL cCampo
	LOCAL cGet
	LOCAL cType
	LOCAL nLen
	LOCAL nDec	
	
	for x := 1 To xLen
		cCampo := (::Alias)->(FieldName(x))
		cGet   := (::Alias)->(FieldGet(x))
		cType  := (::Alias)->(FieldType(x))				
		nLen   := (::Alias)->(FieldLen(x))				
		nDec   := (::Alias)->(FieldDec(x))
		::Field[cCampo ]['RECNO'] := 0
		::Field[cCampo ]['VALUE'] := ::GetFieldBlank(cType, nLen)
	next	
	::hField := ::Field
	return len(::Field)	
	
METHOD function TDbf:DbStruct()	
	::hStru := {=>}			
	/*
	? (::Alias)->(DbStruct())[1][1] // CODI
	? (::Alias)->(DbStruct())[1][2] // C
	? (::Alias)->(DbStruct())[1][3] // 5
	? (::Alias)->(DbStruct())[1][4] // 0
	inkey(0)
	*/
	::hStru[::Alias] := (::Alias)->(DbStruct())
	return len(::hStru)
	
METHOD TDbf:Open()		
	cls
	? ::Alias
	inkey(0)
	if !UsaArquivo((::Alias))
		MensFecha()	
	endif
	::alias := Alias()
	return self
	
METHOD TDbf:Travados()	
	LOCAL nRecno
	LOCAL aRecno := (::Alias)->(dbRLockList())
	
	for EACH nRecNo IN aRecno
		// ? nRecNo
	next
	return aRecno

METHOD def TDbf:DbDelete(nrecno)
   hb_default(@nrecno, ::Recno())
   ::DbGoto(nrecno) 	
	if (::Alias)->(TravaReg())
		(::Alias)->(DbDelete())
		::Libera()
		::DbSkip(0)
		return true		
   endif
	return false
	
METHOD function TDbf:Append()
	return((::Alias)->(Incluiu()))
	
METHOD function TDbf:Libera()
	(::Alias)->(Libera())
	return self	
	
METHOD TDbf:DbSkip(x) 
	(::Alias)->(DbSkip(x))
	::GetDados()
	return self
	
METHOD function TDbf:DbSeek(x)
	LOCAL lresult := (::Alias)->(DbSeek(x))
	if lresult
		::GetDados()
	endif	
	return lresult

Function TDbfNew(cDbf)
**********************
	return( TDbf():New(cDbf))

CLASS bar
	VAR name INIT 'BAR'
ENDCLASS

WITH OBJECT foo():new()
	? :name                 //prints 'FOO'
	? :__withobject:name    //also prints 'FOO'
	? :__withobject := bar():new()
	? :name                 //prints 'BAR'
ENDWITH		
	
def footeste()
	o := foo():foo:_1()
	o := foo():foo:_2()
	o := foo():foo:_3()
	
CLASS foo
   method _1()
   method _2()
   method _3()
	VAR name INIT 'FOO'
ENDCLASS

method _1() class foo
	aHash := {=>}
	aHash['Nome'] := 'Jose Manoel'
	aHash['Hoje'] := DATE()
	aHash[Date()] := "Esta chave � uma data"
	aHash[12]     := .T.

	// Para exibir os valores, use:
	? aHash['Nome']
	? aHash['Hoje']
	? aHash[date()]
	? aHash[12]

	pausetdbf()

method _2() class foo
	aHash := {=>}
	HSetCaseMatch( aHash, .F. ) // desabilita o case-sensitive
	aHash['Nome'] := 'Jose Carlos'
	? aHash['nOme'] // irá exibir "Jose Carlos" e ñ mais 1 erro	
	pausetdbf()


method _3() class foo
	aHash := {=>}
	HSetCaseMatch( aHash, .F. )
	aHash['Nome'] := 'Joao Manoel'
	aHash['Hoje'] := DATE()
	aHash[Date()] := "Chave data"
	aHash[12] := .T.

	FOR i := 1 TO Len( aHash )
		? HGetKeyAt( aHash, i ) // exibimos a chave
		? HGetValueAt( aHash, i )// exibimos o valor!
	END

	** Procura a posição onde 'NOME' estiver dentro do HASH.
	nPos := HGetPos( aHash, 'Nome' )
	if nPos != 0
	** Ele achou? Exibimos o valor!
		? HGetValueAt( aHash, nPos )
	End	
	pausetdbf()

def TesteNew()	
	public oAmbiente := TAmbienteNew()	
	cls
	a := 'A'
   b := 'B'
   FOR EACH a, b IN { 1, 2, 3, 4 }, "abcd"
      ? a, b   //prints: 1 a
               //        2 b
               //        3 c
               //        4 d
   NEXT
   ? a, b   //prints: A B

   // you can use EXIT statement inside the loop
   FOR EACH a IN { 1, 2, 3, 4 }
      if a:__enumindex == 3
         ? a
         EXIT
      endif
   NEXT

   arr := { 1, 2, 3 }
   str := "abc"
	? [arr := { 1, 2, 3 }]
   ? [str := "abc"]
   ? [FOR EACH a, b IN arr, str]
	
   FOR EACH a, b IN arr, str	   		
      ? 'a=>',  a *= 2,     arr[a:__enumindex], a:__enumvalue, a:__enumkey
		? 'b=>',  b := Upper( b ), b:__enumindex,  b:__enumvalue, b:__enumkey		
   NEXT
   // now 'arr' stores { 2, 4, 6 }
   // howerer 'str' still stores "abc"
	//pausetdbf()
	
	hCores := { 'Cores' => {0 , 1 , 2 , 3 , 4 , 5 , 6 , 7 , 8 , 9 , 10 , 11 , 12 , 13 , 14 , 15 }}	
	hDays  := { 'Days'  => {"Mon", "Tue", "Wed", "Thu", "Fri", "Sat" }}
	hCor   := { 'cor'   => ;
					{"corborda" => {"value" => 0},;
			  		 "cormenu"  => {"value" => 1},;
		  			 "corcabec" => {"value" => 2},;
					 "corfundo" => {"value" => 3},;
					 "corbarra" => {"value" => 4},;
					 "cor1"     => {"value" => 5}}}
   myHash := Hash()
   myHash[ "cor" ] := Hash()
   HSetCaseMatch( myHash, .F. )

   myHash[ "cor" ][ "corborda" ] := Hash()
	myHash[ "cor" ][ "corborda" ]["value"] := 0
	
   myHash[ "cor" ][ "cormenu"  ] := Hash()
	myHash[ "cor" ][ "cormenu"  ]["value"] := 1
	
   myHash[ "cor" ][ "corcabec" ] := Hash()
	myHash[ "cor" ][ "corcabec" ]["value"] := 2
	
   myHash[ "cor" ][ "corfundo" ] := Hash()
	myHash[ "cor" ][ "corfundo" ]["value"] := 3
	
   myHash[ "cor" ][ "corbarra" ] := Hash()
	myHash[ "cor" ][ "corbarra" ]["value"] := 4
	
	myHash[ "cor" ][ "cor1"     ] := Hash()
	myHash[ "cor" ][ "cor1"     ]["value"] := 5

   ? HHasKey( myHash[ "cor" ] , "corborda" )
   ? HHasKey( myHash[ "cor" ] , "cormenu" )		
	
	? myHash[ "COR"]["cormenu"]["value"]
	
	//pausetdbf()
									
	HSetCaseMatch( hCor,   .F. ) // desabilita o case-sensitive									
	HSetCaseMatch( hCores, .F. ) // desabilita o case-sensitive									
	HSetCaseMatch( hDays,  .F. ) // desabilita o case-sensitive									
	
	a := nil
	b := nil
	c := nil		
	FOR EACH a IN hDays['Days']
      ? a, hDays['Days'][a:__enumindex], a:__enumvalue, a:__enumkey, a:__enumBase		
   NEXT
	//pausetdbf()
	
	a := nil
	b := nil
	c := nil

	newH := {}
		
	//FOR EACH c IN myHash
	FOR EACH a IN hCor
		?
		?
		//? a, a:__enumkey, a:__enumValue
			FOR EACH b IN a
				//? b, b:__enumKey, b:__enumBase
				FOR EACH c IN b						
						?? a:__enumKey + '.'
						?? b:__enumKey + '.'
						?? c:__enumKey + '=' + trimstr(c:__enumValue)
						aadd(newH, a:__enumKey + '.' + b:__enumKey + '.' + trimstr(c:__enumValue))
				next
				?
			next
   NEXT
	pausetdbf()
	cls
	mabox(10,10,20,40)
	achoice(11, 11, 19, 39, newH)
	__quit()
	
def DemoHb_IsString()

   LOCAL cBigString
   LOCAL cFirst
   LOCAL cString := Space( 20 )   // Create an character memory variable
                                  // with length 20
   ? Len( cString )  // --> 20
   cBigString := Space( 100000 )  // Create a memory variable with 100000
                                  // blank spaces
   ? Len( cBigString )
   USE receber NEW
   cFirst := MakeEmpty( 1 )
   ? Len( cFirst )
	pause()

   return

STATIC FUNCTION MakeEmpty( xField )

   LOCAL nRecord
   LOCAL xRetValue

   if ! Alias() == ""
      nRecord := RecNo()
      dbGoto( 0 )
      if HB_ISSTRING( xField )
         xField := AScan( dbStruct(), {| aFields | aFields[ DBS_NAME ] == Upper( xField ) } )
      else
         hb_default( @xField, 0 )
         if xField < 1 .OR. xField > FCount()
            xField := 0
         endif
      endif
      if xField != 0
         xRetValue := FieldGet( xField )
      endif
      dbGoto( nRecord )
   endif

   return xRetValue	
	
	