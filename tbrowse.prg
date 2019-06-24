#include <sci.ch>

CLASS MsBrowse FROM TBrowse
		Export:
         Var Titulo
         Var Topo
         Var Esquerda
         Var Baixo
         Var Direita
         Var PreDoGet
         Var PosDoGet
         Var PreDoDel
         Var PosDoDel
         Var KeyHotKey
         Var Registro
         Var Deletado
         Var Alterado
			Var LinhaHelpTecla1 init ""
			Var LinhaHelpTecla2 init ""

		Export:
        METHOD  New CONSTRUCTOR
		  METHOD  Processa
		  METHOD  Doget
		  METHOD  FreshOrder
		  METHOD  Skipped
		  METHOD  Show
        METHOD  ExitKey
        METHOD  TrocaChave
        METHOD  SeekChave
        METHOD  FiltraChave
        METHOD  ForceStable
        METHOD  InsToggle
        Message Add METHOD TAdd
        METHOD  HotKey
		  METHOD  DupReg(cAlias, cCampo, nOrder)
		  METHOD  Duplica(cAlias)
End Class

METHOD New( nLint, nColt, nLinB, nColb )
*****************************************
   LOCAL cFrame2     := SubStr( oAmbiente:Frame, 2, 1 )
   LOCAL cFrame3     := SubStr( oAmbiente:Frame, 3, 1 )
   LOCAL cFrame4     := SubStr( oAmbiente:Frame, 4, 1 )
   LOCAL cFrame6     := SubStr( oAmbiente:Frame, 6, 1 )

   ::Titulo    := "CONSULTA/ALTERACAO"
   ::Topo      := 00
   ::Esquerda  := 00
   ::Baixo     := MaxRow()-4
   ::Direita   := MaxCol()
   ::PreDoGet  := NIL         // Procedimento do Usuario Antes de Editar o Registro
   ::PosDoGet  := NIL         // Procedimento do Usuario Apos Editar o Registro
   ::PreDoDel  := NIL         // Procedimento do Usuario Antes de Excluir o Registro
   ::PosDoDel  := NIL         // Procedimento do Usuario Apos Excluir o Registro
   ::KeyHotKey := NIL         // Procedimento do Usuario Para Tecla de Atalho
   ::nTop      := if( nLint = NIL, ::Topo+1,     nLint )
   ::nLeft     := if( nColt = NIL, ::Esquerda+1, nColt )
   ::nRight    := if( nColb = NIL, ::Direita-1,  nColb )
   ::nBottom   := if( nLinb = NIL, ::Baixo-1,    nLinb )
   ::HeadSep   := cFrame2 + cFrame3 + cFrame2
   ::ColSep    := Chr(032) + cFrame4 + Chr(032)
   ::FootSep   := cFrame2  + cFrame2 + cFrame2
   ::Topo      := ::nTop
   ::Esquerda  := ::nLeft
   ::Baixo     := ::nBottom
   ::Direita   := ::nRight
   ::Registro  := 0
   ::Deletado  := NIL
   ::Alterado  := NIL
return( Self )

METHOD Show
************
   LOCAL pfore 	:= oAmbiente:Cormenu
	LOCAL pback    := oAmbiente:CorLightBar	
	LOCAL cCor     := oAmbiente:CorLightBar
	LOCAL pUns     := Roloc( pFore )
   
   nSetColor( pfore, pback, pUns )
   ::cColorSpec := cSetColor( SetColor())   
   MaBox( ::Baixo+2, ::Esquerda-1, ::Baixo+5, ::Direita+1, "OPCOES")
   Write( ::Baixo+3, 01, "[_+]Alterar  [F2]Localizar [F3]Filtrar  [CTRL+INSERT]Ins Campo [A-Z]Localizar " + ::LinhaHelpTecla1)
   Write( ::Baixo+4, 01, "[ESC]Encerrar [F6]Ordem     [F4]Duplicar [CTRL+DELETE]Esc Campo [DEL]Excluir   " + ::LinhaHelpTecla2)
   MaBox( ::Topo-1, ::Esquerda-1, ::Baixo+1, ::Direita+1, ::Titulo )
   Seta1( ::Baixo+1 )
return( Self )

METHOD TAdd( cNome, cField, cPicture, cAlias )
**********************************************
   LOCAL oCol

   if Valtype( cField ) = 'B'
      oCol := TBColumnNew( cNome, cField )
   else
      if cAlias = NIL
         oCol := TBColumnNew( cNome,  FieldBlock( FieldName( FieldPos( cField ))))
      else         
         // oCol := TBColumnNew( cNome,  FieldWBlock( FieldName( FieldPos( cField )), Select( cAlias )))
         oCol := TBColumnNew( cNome,  FieldWBlock(cField, Select(cAlias)))
      endif
   endif
   if cPicture != NIL
      oCol:Picture := cPicture
   endif
   ::AddColumn( oCol )
return( Self )

METHOD Processa()
*****************
   LOCAL cScreen  := SaveScreen()
   LOCAL Local3   := OK
   LOCAL Local5   := FALSO
   LOCAL Local6   := FALSO
   LOCAL LOCAL8   := Setcursor(0)
   LOCAL LOCAL9   := FALSO
   LOCAL aCampos  := {}
   LOCAL nKey
   LOCAL cCombinado := ""

   ::skipBlock( { |x| ::Skipped( x, Local5 ) })
   ::ForceStable()
   if ( LastRec() == 0 )
      nKey := 24
      LOCAL9 := .T.
   else
      LOCAL9 := .F.
   endif
   LOCAL3 := .T.
   Do While ( LOCAL3 )
      if ( !LOCAL9 )
         ::ForceStable()
      endif
      if ( !LOCAL9 )
         if ( ::Hitbottom() .AND. ( !LOCAL5 .OR. RecNo()  !=  LastRec() + 1 ) )
            if ( LOCAL5 )
               ::Refreshcurrent()
               ::ForceStable()
               Goto Bottom
            else
               LOCAL5 := .T.
               Setcursor(Iif( Readinsert(), 2, 1 ))
            endif
            ::Down()
            ::ForceStable()
            ::Colorrect({::Rowpos(), 1, ::Rowpos(), ::Colcount()}, {2, 2})
         endif
         ::ForceStable()
         nKey := InKey(0)
         if ( ( cRotina := SetKey(nKey) )  !=  Nil )
            Eval( cRotina, Procname(1), Procline(1), "")
            Loop
         endif
         if ::KeyHotKey != NIL
            nHot := Len( ::KeyHotKey )
            if ( nPos := Ascan( ::KeyHotKey, { |oBloco|oBloco[1] = nKey })) != 0
               Eval( ::KeyHotKey[nPos,2])
               Loop
            endif
         endif
      else
         LOCAL9 := .F.
      endif
      do case
      case nKey == K_F6
         ::TrocaChave()
         ::refreshCurrent():forceStable()
         ::up():forceStable()
         ::Freshorder()

      case nKey == K_F2
         SetCursor(1)
         ::SeekChave()
         ::FreshOrder()
         SetCursor(0)

      case nKey == K_F3
         SetCursor(1)
         ::FiltraChave()
         ::FreshOrder()
         SetCursor(0)

      case nKey == K_CTRL_INS .or. nKey = 418 // Alt_Ins
         cTela := SaveScreen()
         oMenu:Limpa()
         M_Title("INSERIR COLUNAS")
         nChoice := FazMenu( 10, 10, {" Individual", " Combinado", " Todos " })
         nLen  := FCount()
         if nChoice = 0
            ResTela( cTela )
            Loop
         elseif nChoice = 1
            For i := 1 To nLen
               cString := FieldName( i )
               Aadd( aCampos, cString )
            Next
            oMenu:Limpa()
            MaBox( 01, 10, 23, 50, "ESCOLHA O CAMPO",, Roloc( Cor()))
            n  := Achoice( 02, 11, 22, 39, aCampos )
            if n = 0
               ResTela( cTela )
               Loop
            endif
            oColuna := TBColumnNew( field( n ), FieldWBlock( field( n ), select() ) )
            ::InsColumn( ::ColPos, oColuna )

         elseif nChoice = 2
            SetCursor(1)
            oMenu:Limpa()
            cCombinado := Space(50)
            MaBox( 10, 05, 13, 70, "ENTRE COM A SEQUENCIA",, Roloc( Cor()))
            @ 12, 06 Say "Combinacao :" Get cCombinado
            Read
            if !LastKey() = ESC
               oColuna := TBColumnNew( AllTrim( cCombinado ) , {|| &cCombinado. })
               ::InsColumn( ::ColPos, oColuna )
            endif
            SetCursor(0)

         elseif nChoice = 3
            For i := 1 To nLen
               oColuna := TBColumnNew( field( i ), FieldWBlock( field( i ), select() ) )
               ::InsColumn( ::ColPos, oColuna )
            Next
          endif
          ResTela( cTela )

      case nKey == K_CTRL_DEL
         ErrorBeep()
         if ::ColCount = 1
            Alerta("Erro: Nao se pode Excluir a Ultima Coluna")
         else
            if Conf("Pergunta: Esconder a Coluna ?" )
               oPos := ::ColPos
               ::DelColumn( ::ColPos )
            endif
        endif

      case nKey == K_F10
         ::Freeze := ::ColPos

      Case nKey == 24
         if ( LOCAL5 )
            ::Hitbottom(.T.)
         else
            ::Down()
         endif
      Case nKey == 5
         if ( LOCAL5 )
            LOCAL6 := .T.
         else
            ::Up()
         endif
      Case nKey == 3
         if ( LOCAL5 )
            ::Hitbottom(.T.)
         else
            ::Pagedown()
         endif
      Case nKey == 18
         if ( LOCAL5 )
            LOCAL6 := .T.
         else
            ::Pageup()
         endif

      Case nKey == K_CTRL_PGUP
		   DbGotop()     // 07.08.2016
		   if ( LOCAL5 )
            LOCAL6 := .T.
         else
            ::Gotop()
         endif
      Case nKey == K_CTRL_PGDN
		   DbGoBottom() // 07.08.2016
		   if ( LOCAL5 )
            LOCAL6 := .T.
         else
            ::Gobottom()
         endif
			
		Case nKey == 4
         ::Right()
      Case nKey == 19
         ::Left()
      Case nKey == 1
         ::Home()
      Case nKey == 6
         ::End()
      Case nKey == 26
         ::Panleft()
      Case nKey == 2
         ::Panright()
      Case nKey == 29
         ::Panhome()
      Case nKey == 23
         ::Panend()
      Case nKey == 22
         if ( LOCAL5 )
            Eval( CURSOR )
         endif
      Case nKey == K_DEL
         if !PodeExcluir()
            ErrorBeep()
            Alerta("Erro: Exclusao nao Permitida")
            Loop
         endif
         if ::PreDoDel != NIL
            if !Eval( ::PreDoDel )
               Loop
            endif
         endif
         if PodeExcluir()
            ErrorBeep()
            if Conf("Pergunta: Excluir Registro Sob o Cursor ?")
               if TravaReg()
                  if ( RecNo()  !=  LastRec() + 1 )
                     if ( Deleted() )
                        ::Deletado := NIL
                        DbRecall()
                     else
                        ::Deletado := OK
                        DbDelete()
                     endif
                     ::refreshCurrent():forceStable()
                     ::up():forceStable()
                     ::Freshorder()
                     Libera()
                  endif
               endif
            endif
         endif
         if ::PosDoDel != NIL
            Eval( ::PosDoDel )
         endif

      Case nKey == K_ENTER
         oCol := ::getColumn( ::colPos )
			//xValue := Eval( oCol:block )
			//cType  := ValType( xValue )
			
			if oCol:Heading = "ID"
			   ErrorBeep()
            Alerta("ERRO;;Campo de autoincremento.;Alteracao nao Permitida!")
            Loop
         endif
			
         if !PodeAlterar()
            ErrorBeep()
            Alerta("Erro: Alteracao nao Permitida")
            Loop
         endif
         if ( LOCAL5 .OR. RecNo()  !=  LastRec() + 1 )
            SetCursor(1)
            nKey    := ::Doget( LOCAL5)
            LOCAL9  := nKey  !=  0
            SetCursor(0)
         else
            nKey := 24
            LOCAL9 := .T.
         endif

      Case nKey == 27
         LOCAL3 := .F.
      Otherwise
         if ( nKey >= 32 .AND. nKey <= 255 )
            SetCursor(1)
            Keyb Chr(nKey)
            ::SeekChave()
            ::FreshOrder()
            SetCursor(0)
            //Keyboard Chr(13) + Chr(nKey)
         endif
      EndCase
      if ( LOCAL6 )
         LOCAL6 := .F.
         LOCAL5 := .F.
         ::Freshorder()
         Setcursor(0)
      endif
   EndDo
   Setcursor(LOCAL8)
   RestScreen( cScreen )
return( Self )

METHOD TrocaChave()
*******************
   LOCAL cScreen := SaveScreen()
   LOCAL aArray  := {}
   LOCAL nX      := 1
   LOCAL nChoice := 0
   LOCAL nMaximo := OrdCount() //12
   LOCAL cString := ""
   LOCAL nAntigo := IndexOrd()

   For nX := 1 To nMaximo
      if !Empty(( cIndice := IndexKey( nX )))
         Aadd( aArray, Upper(IndexKey( nX )))
      endif
   Next
   Aadd( aArray, "Natural" )
   M_Title("ESCOLHA A ORDEM")
   nChoice := FazMenu( 02, 02, aArray, Cor())
   if nChoice = 0
      Order( nAntigo )
      ResTela( cScreen )
      return
   endif
   cString := aArray[ nChoice ]
   if cString = "Natural"
      Order( 0 )
   else
      Order( nChoice )
   endif
   ResTela( cScreen )
return( Self )

METHOD SeekChave()
******************
   LOCAL cScreen  := SaveScreen()
	LOCAL cPicture := "@K!"
   LOCAL cProcura
	LOCAL xCampo
	LOCAL nField
	
   if Empty( IndexKey())
      ErrorBeep()
      Alert("Erro: Escolha um indice antes.")
      return
   endif
   MaBox( 10, 10, 12, 70,,, Roloc(Cor()))
	nField   := FieldPos(IndexKey())
	xCampo   := FieldName( nField )
   cProcura := FieldGet(nField)	
	if xCampo == "FONE" .OR. xCampo == "FAX"
		cPicture := PIC_FONE
	endif	
   if cProcura = NIL
      cProcura := Space(40)
   endif
   @ 11, 11 Say "Procurar por : " Get cProcura Pict cPicture
   Read
   if LastKey() = ESC
      ResTela( cScreen )
      return
   endif
   if ValType( cProcura ) = "C"
      cProcura := AllTrim( cProcura )
   endif
   DbSeek( cProcura )
   Restela( cScreen )
return( Self )

METHOD FiltraChave()
********************
   LOCAL cScreen := SaveScreen()
   LOCAL cProcura

   if Empty( IndexKey())
      ErrorBeep()
      Alert("Erro: Escolha um indice antes.")
      return
   endif
   MaBox( 10, 10, 12, 70,,, Roloc(Cor()))
   cProcura := FieldGet(FieldPos( IndexKey()))
   if cProcura = NIL
      cProcura := Space(40)
   endif
   @ 11, 11 Say "Filtrar por : " Get cProcura Pict "@K!"
   Read
   if LastKey() = ESC
      ResTela( cScreen )
      return
   endif
   if ValType( cProcura ) = "C"
      cProcura := AllTrim( cProcura )
   endif
   Sx_SetScope( S_TOP, cProcura)
   Sx_SetScope( S_BOTTOM, cProcura )
   DbGoTop()
return( Self )

METHOD DupReg(cAlias, cCampo, nOrder)
*************************************
	LOCAL cScreen := SaveScreen()
	LOCAL oCol	  := ::getColumn( ::colPos )
	LOCAL Arq_Ant := Alias()
	LOCAL Ind_Ant := IndexOrd()
	LOCAL Handle  := FTempMemory()
	LOCAL xAlias  := FTempMemory()
	LOCAL aStru   := (cAlias)->(DbStruct())
	LOCAL nConta  := (cAlias)->(FCount())
	LOCAL lAdmin  := TIniNew(oAmbiente:xUsuario + ".INI"):ReadBool('permissao','usuarioadmin', FALSO)
	LOCAL xLen
	LOCAL cRegisto
	LOCAL xRegistro
	LOCAL xRegLocal
	LOCAL cType
	LOCAL xCampo
	LOCAL xType   

	if !lAdmin
		if !PodeIncluir()
			return(OK)
		endif
	endif
	ifnil(nOrder, NATURAL)
	ErrorBeep()
	if !Conf('Pergunta: Duplicar registro sob o cursor ?')
		return( OK )
	endif
	xRegistro := (cAlias)->(Recno())
	
	xAlias := ms_mem_dbCreate(Handle, aStru)	
	(xAlias)->(DbAppend())	
	
	for nField := 1 To nConta
		xType  := (xAlias)->(FieldType( nField ))
		// xCampo := (xAlias)->(FieldName( nField ))
		// if xCampo != "ID"
		if xType != "+"
			(xAlias)->(FieldPut( nField, (cAlias)->(FieldGet( nField ))))
		endif	
	next
	
	if (cAlias)->(Incluiu())
		for nField := 1 To nConta
			xType  := (xAlias)->(FieldType( nField ))
			// xCampo := (xAlias)->(FieldName( nField ))
			// if xCampo != "ID"
			if xType != "+"
				(cAlias)->(FieldPut( nField, (xAlias)->(FieldGet( nField ))))
			endif	
		next
		xRegLocal := (cAlias)->(Recno())
		(cAlias)->(Libera())
		(cAlias)->(Order( nOrder))
		(cAlias)->(DbGoBottom())
		
		cType := ValType((cAlias)->&(cCampo))	   
		if cType == "C"
			xLen  := Len((cAlias)->&(cCampo))
			CRegistro := StrZero(Val((cAlias)->&(cCampo)) + 1 , xLen)
		elseif cType == "N"
			CRegistro := (cAlias)->&(cCampo) + 1
		else
			CRegistro := (cAlias)->&(cCampo)
		endif
		(cAlias)->(DbGoto( xRegistro ))
		if (cAlias)->(TravaReg())
			(cAlias)->&(cCampo) := cRegistro
			(cAlias)->(Libera())
		endif
		
	endif
	(xAlias)->(DbCloseArea())
	FecharTemp(Handle)		   
	AreaAnt( Arq_Ant, Ind_Ant )
	(cAlias)->(DbGoto( xRegistro ))
	::FreshOrder()
	(cAlias)->(DbGoto( xRegistro ))
	return( OK )

METHOD Duplica( cAlias )
************************
	LOCAL cScreen := SaveScreen()
	LOCAL oCol	  := ::getColumn( ::colPos )
	LOCAL Arq_Ant := Alias()
	LOCAL Ind_Ant := IndexOrd()
	LOCAL Handle  := FTempMemory()
	LOCAL xAlias  := FTempMemory()	
	LOCAL lAdmin  := TIniNew(oAmbiente:xUsuario + ".INI"):ReadBool('permissao','usuarioadmin', FALSO)
	LOCAL xLen
	LOCAL cRegisto
	LOCAL xRegistro
	LOCAL xRegLocal
	LOCAL cType
	LOCAL xCampo
   LOCAL xType
	LOCAL aStru   
	LOCAL nConta  
	LOCAL nOrder := Ind_Ant
	DEFAU cAlias TO Alias()

	if !lAdmin
		if !PodeIncluir()
			return(OK)
		endif
	endif
	
	ErrorBeep()
	if !Conf('Pergunta: Duplicar registro sob o cursor ?')
		return( OK )
	endif
	
	aStru     := (cAlias)->(DbStruct())
	nConta    := (cAlias)->(FCount())
	xRegistro := (cAlias)->(Recno())	
	xAlias    := ms_mem_dbCreate(Handle, aStru)		

	(xAlias)->(DbAppend())
	for nField := 1 To nConta
      xType  := (xAlias)->(FieldType( nField ))
		// xCampo := (xAlias)->(FieldName( nField ))
		// if xCampo != "ID"
		if xType != "+"
			(xAlias)->(FieldPut( nField, (cAlias)->(FieldGet( nField ))))
		endif	
	next
	
	if (cAlias)->(Incluiu())
		for nField := 1 To nConta
			xType  := (xAlias)->(FieldType( nField ))
			// xCampo := (xAlias)->(FieldName( nField ))
			// if xCampo != "ID"
			if xType != "+"
				(cAlias)->(FieldPut( nField, (xAlias)->(FieldGet( nField ))))
			endif	
		next
		xRegLocal := (cAlias)->(Recno())
		(cAlias)->(Libera())
		(cAlias)->(Order( nOrder))
		(cAlias)->(DbGoBottom())
	endif
	(xAlias)->(DbCloseArea())
	FecharTemp(Handle)		   
	AreaAnt( Arq_Ant, Ind_Ant )
	(cAlias)->(DbGoto( xRegistro ))
	::FreshOrder()
	(cAlias)->(DbGoto( xRegistro ))
	return( OK )

METHOD DOGET(  ARG2 )
*********************
	LOCAL Local1
	LOCAL LOCAL2
	LOCAL LOCAL3
	LOCAL oCol
	LOCAL LOCAL6
	LOCAL LOCAL8
	LOCAL LOCAL9
	LOCAL Local10
	LOCAL Local11
	LOCAL Local12
	LOCAL nIndice
	LOCAL oGet
	LOCAL xValue

	::Hittop(.F.)
	::ForceStable()

	if ::PreDoGet != NIL
		if !Eval( ::PreDoGet )
			return( 0 )
		endif
	endif

	LOCAL2  := Set(_SET_SCOREBOARD, .F.)
	LOCAL3  := Set(_SET_EXIT, .T.)
	Local1  := SetKey(K_INS, CURSOR )
	Local10 := Setcursor(Iif( Readinsert(), 2, 1 ))
	nIndice := Indexkey(0)
	if ( !Empty( nIndice ))
		LOCAL8 := &nIndice
	endif
	oCol	 := ::Getcolumn(::Colpos())
	xValue := Eval( oCol:Block )
	//cCor1  := AttrToa( 79 )
	cCor1  := AttrToa( Cor(1))
	if oCol:Picture = NIL
		Do case
		Case ISCHAR( xValue )
			oCol:picture    := repl( "!", len( xValue ) )
		Case ISDATE( xValue )
			oCol:picture    := "##/##/##"
		EndCase
	endif
	Local11 := Eval(oCol:Block())
	oGet	  := Getnew(Row(), Col(), { | _1 | Iif( PCount() == 0, Local11, Local11 := _1 ) }, "mGetVar", oCol:Picture, ::Colorspec )
	oGet:ColorDisp( cCor1 )
	LOCAL9 := .F.
	if ::PreDoGet != NIL
		if Eval( ::PreDoGet )
			if ( LOCAL9 )
				::Freshorder()
				LOCAL6 := 0
			else
				::Refreshcurrent()
				LOCAL6 := ::Exitkey(ARG2)
			endif
			if ( ARG2 )
				::Colorrect({::Rowpos(), 1, ::Rowpos(), ::Colcount()}, {2, 2})
			endif
			Setcursor(Local10)
			Set Scoreboard (LOCAL2)
			Set(_SET_EXIT, LOCAL3)
			SetKey(K_INS, Local1)
		endif
	endif
	if TravaReg()
		if ReadModal({oGet})
			if ( ARG2 .AND. RecNo() == LastRec() + 1 )
				if PodeIncluir()
					if Incluiu()
					endif
				endif
			endif
			Eval( oCol:Block(), Local11)
			if ( !ARG2 .AND. !Empty(Local12 := Ordfor(Indexord())) .AND. !&Local12 )
			  DbGoTop()
			endif
			if ( !ARG2 .AND. !Empty(nIndice) .AND. LOCAL8  !=  &nIndice )
				LOCAL9 := .T.
			endif
		endif
		if ::PosDoGet != NIL
			Eval( ::PosDoGet )
		endif
		::Alterado := OK
		_Field->Atualizado := Date()
		Libera()
	endif
	if ( LOCAL9 )
		::Freshorder()
		LOCAL6 := 0
	else
		::Refreshcurrent()
		LOCAL6 := ::Exitkey(ARG2)
	endif
	if ( ARG2 )
		::Colorrect({::Rowpos(), 1, ::Rowpos(), ::Colcount()}, {2, 2})
	endif
	Setcursor(Local10)
	Set Scoreboard (LOCAL2)
	Set(_SET_EXIT, LOCAL3)
	SetKey(K_INS, Local1)
	return LOCAL6

METHOD EXITKEY( ARG1 )
**********************
	Local nKey

	nKey := LastKey()
	Do Case
	Case nKey == 3
		if ( ARG1 )
			nKey := 0
		else
			nKey := 24
		endif
	Case nKey == 18
		if ( ARG1 )
			nKey := 0
		else
			nKey := 5
		endif
	Case nKey == 13 .OR. nKey >= 32 .AND. nKey <= 255
		nKey := 4
	Case nKey  !=	5 .AND. nKey  !=	24
		nKey := 0
	EndCase
	return nKey

METHOD FreshOrder()
*******************
	LOCAL nRecno := RecNo()
	::Refreshall()
	::ForceStable()
	if ( nRecno  !=  LastRec() + 1 )
		Do While ( RecNo()  !=	nRecno .AND. !BOF() )
			::Up()
			::ForceStable()
		EndDo
	endif
	return( Self )

METHOD SKIPPED( ARG1, ARG2 )
****************************
	Local oBrowse
	oBrowse := 0
	if ( LastRec()  !=  0 )
		if ( ARG1 == 0 )
			Skip 0
		elseif ( ARG1 > 0 .AND. RecNo()	!=  LastRec() + 1 )
			Do While ( oBrowse < ARG1 )
				Skip
				if ( EOF() )
					if ( ARG2 )
						oBrowse++
					else
						Skip -1
					endif
					Exit
				endif
				oBrowse++
			EndDo
		elseif ( ARG1 < 0 )
			Do While ( oBrowse > ARG1 )
				Skip -1
				if ( BOF() )
					Exit
				endif
				oBrowse--
			EndDo
		endif
	endif
	return oBrowse

METHOD ForceStable( browse )
****************************
   WHILE !::stabilize()
   EndDo
	return( Self )

METHOD InsToggle()
******************
   if READINSERT()
       READINSERT(.F.)
       SETCURSOR(SC_NORMAL)

   else
       READINSERT(.T.)
       SETCURSOR(SC_INSERT)

   endif
   return( Self )

METHOD HotKey( cTecla, xFuncao )
*********************************
   if ::KeyHotKey = NIL
      ::KeyHotKey := {}
   endif
   Aadd( ::KeyHotKey, { cTecla, xFuncao } )
	return( Self )

Function TMsBrowseNew( nLint, nColt, nLinB, nColb )
***************************************************
	return( MsBrowse():New( nLint, nColt, nLinb, nColb ))
