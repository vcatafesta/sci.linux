Proc ExtratoVideo()
*******************
LOCAL cArquivo  := FTempname()
LOCAL xNtx1     := FTempname()
LOCAL xNtx2     := FTempname()
LOCAL xNtx3     := FTempname()
LOCAL xNtx4     := FTempname()
LOCAL xNtx5     := FTempname()
LOCAL xNtx6     := FTempname()
LOCAL Arq_Ant	 := Alias()
LOCAL Ind_Ant	 := IndexOrd()
LOCAL cScreen	 := SaveScreen()
LOCAL nDebitos  := 0
LOCAL nCreditos := 0
LOCAL nChoice	 := 0
LOCAL oBrowse
LOCAL dData_Ini
LOCAL dData_Fim
LOCAL cCodi
LOCAL cTela
LOCAL aStru

Chemov->(DbGoTop())
if Chemov->(Eof())
	Nada()
	ResTela( cScreen )
	return
endif
WHILE OK
	Chemov->(Order( CHEMOV_CODI_DATA ))
	Chemov->(DbGoTop())
	Area("Cheque")
	Cheque->(Order( CHEQUE_CODI ))
	cCodi 	 := Space(4)
	nDebitos  := 0
	nCreditos := 0
	dData_Ini := Chemov->Data
	dData_Fim := Date()
   MaBox( 05, 05, 09, 53 )
   @ 06, 06 Say  "Codigo..........:" Get cCodi     Pict "9999"     Valid CheErrado( @cCodi )
   @ 07, 06 Say  "Data Inicial....:" Get dData_Ini Pict "##/##/##"
   @ 08, 06 Say  "Data Final......:" Get dData_Fim Pict "##/##/##" Valid dData_Fim >= dData_Ini
   Read
	if LastKey() = ESC
      Ferase( cArquivo )
      Ferase( xNtx1 )
      Ferase( xNtx2 )
      Ferase( xNtx3 )
      Ferase( xNtx4 )
      Ferase( xNtx5 )
      Ferase( xNtx6 )
		ResTela( cScreen )
		Exit
	endif
	Reg_Ant := Recno()
	nChoice := 1
	M_Title("ESCOLHA O TIPO DE LANCAMENTO")
   nChoice := FazMenu( 12, 05, {" Geral ", " Creditos "," Debitos "})
	if nChoice = 0
		ResTela( cScreen )
		Loop
	endif
	oMenu:Limpa()
   MaBox( 21, 00, 24, 79 )
	Cheque->(DbGoTo( Reg_Ant ))
	Write( 22, 01, "Debitos.: " + Tran( nDebitos, "@E 99,999,999,999.99"))
	Write( 22, 29, "Creditos.: " + Tran( nCreditos, "@E 99,999,999,999.99"))
	Write( 23, 01, "Saldo...: " + Cheque->(Tran( Saldo, "@ECX 99,999,999,999.99")))
	Area("Chemov")
	Order( CHEMOV_CODI_DATA )
	if !LoopData( cCodi, dData_Ini, dData_Fim )
		Loop
   endif
   aStru := Chemov->(DbStruct())
   Aadd( aStru, {"REGISTRO",  "N", 7, 0})
   DbCreate( cArquivo, aStru )
	Use (cArquivo) Exclusive Alias xAlias New
	oBloco := {|| Chemov->Codi = cCodi }
	cTela  := Mensagem("Please, Aguarde... Anexando Registro n§ 00000. ESC Cancela.", Cor())
	nConta := 0
	WHILE Eval( oBloco ) .AND. Rep_Ok()
		if Chemov->Data > dData_Fim
			Exit
		endif
		if nChoice = 1
			if Chemov->Codi = cCodi .AND. Chemov->Data >= dData_Ini .AND. Chemov->Data <= dData_Fim
			  nRecno := Chemov->(Recno())
			else
				Chemov->(DbSkip(1))
				Loop
			endif
		elseif nChoice = 2
			if Chemov->Codi = cCodi .AND. Chemov->Data >= dData_Ini .AND. Chemov->Data <= dData_Fim .AND. Chemov->Cre > 0
			  nRecno := Chemov->(Recno())
			else
				Chemov->(DbSkip(1))
				Loop
			endif
		else
			if Chemov->Codi = cCodi .AND. Chemov->Data >= dData_Ini .AND. Chemov->Data <= dData_Fim .AND. Chemov->Deb > 0
			  nRecno := Chemov->(Recno())
			else
				Chemov->(DbSkip(1))
				Loop
			endif
		endif
		nDebitos  += Chemov->Deb
		nCreditos += Chemov->Cre
		nConta++
		Write( 12, 51, StrZero( nConta, 5))
		Write( 22, 01, "Debitos.: " + Tran( nDebitos, "@E 99,999,999,999.99"))
		Write( 22, 29, "Creditos.: " + Tran( nCreditos, "@E 99,999,999,999.99"))
		xAlias->(DbAppend())
		For nField := 1 To FCount()
			xAlias->(FieldPut( nField, Chemov->(FieldGet( nField ))))
         xAlias->Registro := Chemov->(Recno())
		Next
		Chemov->(DbSkip(1))
	EnDdo
   Area("xALias")
   Mensagem("Aguarde, Organizando Tabela.")
   Inde on Codi  To (xNtx1)
   Inde on Docnr To (xNtx2)
   Inde on Codi + DateToStr( Data ) To (xNtx4)
   Inde on Fatura To (xNtx5)
   Inde on Hist To (xNtx6)
   Inde on Data  To (xNtx3)
   xAlias->(DbCloseArea())
	Use (cArquivo) Exclusive Alias xAlias New
   xAlias->(DbSetIndex( xNtx3 ))
   xAlias->(DbSetIndex( xNtx2 ))
   xAlias->(DbSetIndex( xNtx1 ))
   xAlias->(DbSetIndex( xNtx4 ))
   xAlias->(DbSetIndex( xNtx5 ))
   xAlias->(DbSetIndex( xNtx6 ))
	xAlias->(DbGoTop())
   oBrowse := TMsBrowseNew( 01, 01, 15, MaxCol()-1)
   oBrowse:Add( "DATA LCTO", "Data",   "##/##/##")
   oBrowse:Add( "HISTORICO", "Hist",   "@!")
   oBrowse:Add( "DOCTO N§",  "Docnr",  "@!")
   oBrowse:Add( "DEBITO",    "Deb",    "@E 99,999,999,999.99")
   oBrowse:Add( "CREDITO",   "Cre",    "@E 99,999,999,999.99")
   oBrowse:Add( "SALDO",     "Saldo",  "@ECX 99,999,999,999.99")
   oBrowse:Titulo := "EXTRATO VIDEO - CONTA :" + Cheque->Codi + ' - ' +  AllTrim( Cheque->Titular )
   oBrowse:PreDoGet := {|| PreExtrato( oBrowse ) } // Rotina do Usuario Antes de Atualizar
   oBrowse:PosDoGet := {|| PosExtrato( oBrowse ) } // Rotina do Usuario apos Atualizar
   oBrowse:PreDoDel := {|| PreDelExtrato( oBrowse ) }
   oBrowse:PosDoDel := {|| PosDelExtrato( oBrowse ) }
   oBrowse:Show()
   oBrowse:Processa()
   xAlias->(DbCloseArea())
	Ferase( cArquivo )
   Ferase( xNtx1 )
   Ferase( xNtx2 )
   Ferase( xNtx3 )
   Ferase( xNtx4 )
   Ferase( xNtx5 )
   Ferase( xNtx6 )
	AreaAnt( Arq_Ant, Ind_Ant )
	ResTela( cScreen )
   if oBrowse:Alterado <> NIL
      ErrorBeep()
      if Conf("Pergunta: Atualizar Saldos Agora ?")
         IndexarData( cCodi )
      endif
   endif
Enddo
