/*
  ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 İ³																								 ³
 İ³	Modulo.......: VENLAN.PRG   														 ³ 						 
 İ³	Sistema......: CONTROLE DE VENDEDORES						            	 ³ 
 İ³	Aplicacao....: SCI - SISTEMA COMERCIAL INTEGRADO                      ³
 İ³	Versao.......: 8.5.00							                            ³
 İ³	Programador..: Vilmar Catafesta				                            ³
 İ³   Empresa......: Macrosoft Informatica Ltda                             ³
 İ³	Inicio.......: 12.11.1991 						                            ³
 İ³   Ult.Atual....: 12.04.2018                                             ³
 İ³   Compilador...: Harbour 3.2/3.4                                        ³
 İ³   Linker.......: BCC/GCC/MSCV                                           ³
 İ³	Bibliotecas..:  									                            ³
 İÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
 ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

#include <sci.ch>

*:==================================================================================================================================

Proc VenLan()
*************
LOCAL lOk		  := OK
LOCAL Op 		  := 1
PUBLI cVendedor   := Space(40)
PUBLI cCaixa		:= Space(04)

*:==================================================================================================================================
AbreArea()
oMenu:Limpa()
if !VerSenha( @cCaixa, @cVendedor )
	Mensagem("Aguarde, Fechando Arquivos." )
	DbCloseAll()
	Set KEY F2 TO
	Set KEY F3 TO
	return
endif
/******************************************************************************/
oMenu:Limpa()
RefreshClasse()
WHILE lOk
	BEGIN Sequence
		Op 		  := oMenu:Show()
		Do Case
		Case Op = 0.0 .OR. op = 1.01
			ErrorBeep()
			if Conf("Pergunta: Encerrar este modulo ?")
				GravaDisco()
				lOk := FALSO
				Break
			endif
		Case Op = 2.01 ; FuncInclusao()
		Case Op = 2.02 ; CadastraSenha()
		Case Op = 2.03 ; Func_Adian()
		Case Op = 2.04 ; Cred_Inclu()
		Case Op = 3.01 ; VendedorDbedit()
		Case Op = 3.02 ; CadastraSenha()
		Case Op = 3.03 ; VarreParcial()
		Case Op = 3.04 ; VarreGeral()
		Case Op = 3.05 ; AjustaComissao()
		Case Op = 3.06 ; VarreComissao()
		Case Op = 3.07 ; AlteraDebCre()
		Case Op = 3.08 ; AlteraDebCre()
		Case Op = 4.01 ; VendedorDbedit()
		Case Op = 4.02 ; CadastraSenha()
		Case Op = 5.01 ; VendedorDbedit()
		Case Op = 5.02 ; SaldoDbEdit()
		Case Op = 5.03 ; Func_Consu()
		Case Op = 5.04 ; Cred_Consu()
		Case Op = 6.01 ; FunrePagar()
		Case Op = 6.02 ; DemosPagar()
		Case Op = 6.03 ; FunReVen()
		Case Op = 6.04 ; FunAdian()
		Case Op = 6.05 ; funCreditos()
		Case Op = 6.06 ; FunRelac()
		Case Op = 6.07 ; RelSaldos()
		EndCase
	End Sequence
EndDo
Mensagem("Aguarde... Fechando Arquivos.", WARNING, _LIN_MSG )
FechaTudo()
return

STATIC Proc RefreshClasse()
***************************
oMenu:StatusSup		:= oMenu:StSupArray[6]
oMenu:StatusInf		:= oMenu:StInfArray[6]
oMenu:Menu				:= oMenu:MenuArray[6]
oMenu:Disp				:= oMenu:DispArray[6]
return

*:==================================================================================================================================

Proc Cred_Inclu()
*****************
LOCAL cScreen	  := SaveScreen()
LOCAL GetList	  := {}
LOCAL dData 	  := Date()
LOCAL cDocnr	  := Space(07)
LOCAL cDescricao := Space(40)
LOCAL nVlr		  := 0
LOCAL cCodi 	  := Space( 04 )
LOCAL cSaldo	  := ""
LOCAL nDisp 	  := 0
LOCAL nComi 	  := 0

Area("Vendedor")
Vendemov->(Order( VENDEDOR_CODIVEN ))
oMenu:Limpa()
WHILE OK
	MaBox( 08, 10, 14, 68, "LANCAMENTOS A CREDITOS" )
	@ 09, 11 Say "Codigo....:" Get cCodi Pict "9999" Valid FunErrado( @cCodi,, Row(), Col()+1 )
	@ 10, 11 Say "Data......:" Get dData      Pict "##/##/##"
	@ 11, 11 Say "Docto N§..:" Get cDocnr     Pict "@!"
	@ 12, 11 Say "Valor.....:" Get nVlr       Pict "99999999.99" Valid if( nVlr <= 0,           ( ErrorBeep(), Alerta("Erro: Valor Invalido"), FALSO ), OK )
	@ 13, 11 Say "Descricao.:" Get cDescricao Pict "@!" Valid if( Empty( cDescricao ), ( ErrorBeep(), Alerta("Erro: Campo nao Pode ser Vazio"), FALSO ), OK )
	Read
	if LastKey() = ESC .OR. LastKey() = K_ALT_F4
		ResTela( cScreen )
		Exit
	endif
	ErrorBeep()
	if Conf( "Confirma Inclusao do Debito ?" )
		if Vendedor->(TravaReg())
			if Vendemov->(!Incluiu())
				Vendedor->(Libera())
				Loop
			endif
			Vendemov->CodiVen   := cCodi
			Vendemov->Data 	  := dData
			Vendemov->Docnr	  := cDocnr
			Vendemov->Vlr		  := nVlr
			Vendemov->Dc		  := "C"
			Vendemov->Descricao := cDescricao
			Vendemov->Comdisp   := Vendemov->ComDisp	+ nVlr
			Vendemov->Comissao  := Vendemov->Comissao + nVlr
			Vendemov->(Libera())

			nDisp := Vendedor->ComDisp
			nComi := Vendedor->Comissao
			Vendedor->Comdisp   := ( nDisp + nVlr )
			Vendedor->Comissao  := ( nComi + nVlr )
			Vendedor->(Libera())
		endif
	endif
EndDo
return

*:==================================================================================================================================

Proc Func_Consu()
*****************
LOCAL GetList	  := {}
LOCAL Func_Consu := SaveScreen( )
LOCAL aMenuArray := { " Por Docto ", " Individual ", " Por Data ", " Geral " }
LOCAL cArquivo   := TempNew()
LOCAL cDocnr
LOCAL cCodi
LOCAL aTela
LOCAL Op1
LOCAL cTela
LOCAL dData
LOCAL oBloco
LOCAL nField
FIELD Codiven

WHILE OK
	 aTela := SaveScreen()
	 M_Title( "CONSULTAS DE DEBITOS")
	 Op1 := FazMenu( 08, 20, aMenuArray, Cor() )
	 Do Case
	 Case op1 = 0
		 ResTela( func_consu )
		 Exit

	 Case op1 = 1
		 Vendedor->( Order( VENDEDOR_CODIVEN ))
		 Area("Vendemov")
		 Vendemov->( Order( VENDEMOV_DOCNR ))
		 Vendemov->(DbGoTop())
		 MaBox( 18,20,20,41 )
		 cDocnr = Space( Len( Vendemov->Docnr )-2 )
		 @ 19, 21 Say "Docto N§...¯" Get cDocnr Pict "@!" Valid DocFuerr( cDocnr )
		 Read
		 if LastKey( ) = ESC
			 ResTela( aTela )
			 Loop
		 endif
		 Copy Stru To ( cArquivo )
		 Use (cArquivo) Exclusive New
		 oBloco := {|| Vendemov->Docnr = cDocnr }
		 oMenu:Limpa()
		 cTela := Mensagem("Aguarde. Verificando movimento.", Cor())
		 WHILE Eval( oBloco ) .AND. Rep_Ok()
			 if Vendemov->Descricao = Space(40)
				 Vendemov->(DbSkip(1))
				 Loop
			 endif
			 if Vendemov->Dc = "C"
				 Vendemov->(DbSkip(1))
				 Loop
			 endif
			 DbAppend()
			 For nField := 1 To FCount()
				 FieldPut( nField, Vendemov->(FieldGet( nField )))
			 Next
			 Vendemov->(DbSkip(1))
		 EndDo
		 Restela( cTela )
		 Set Rela To CodiVen Into Vendedor
		 DbGoTop()
		 Func_Mostra()
		 DbClearRel()
		 DbCloseArea()
		 Ferase( cArquivo )

	Case op1 = 2
		Vendedor->( Order( VENDEDOR_CODIVEN ))
		Area("Vendemov")
		Vendemov->(Order( VENDEMOV_CODIVEN ))
		Vendemov->(DbGoTop())
		MaBox( 18, 20, 20, 36 )
		cCodi := Space(04)
		@ 19,21 Say "Codigo..¯" Get cCodi Pict "9999" Valid FunErrado( @cCodi )
		Read
		if LastKey( ) = ESC
			ResTela( aTela )
			Loop
		endif
		if Vendemov->(DbSeek( cCodi ))
			Copy Stru To ( cArquivo )
			Use (cArquivo) Exclusive New
			oBloco := {|| Vendemov->CodiVen = cCodi }
			oMenu:Limpa()
			cTela := Mensagem("Aguarde. Verificando movimento.", Cor())
			WHILE Eval( oBloco ) .AND. Rep_Ok()
				if Vendemov->Descricao = Space(40)
					Vendemov->(DbSkip(1))
					Loop
				endif
				if Vendemov->Dc = "C"
					Vendemov->(DbSkip(1))
					Loop
				endif
				DbAppend()
				For nField := 1 To FCount()
					FieldPut( nField, Vendemov->(FieldGet( nField )))
				Next
				Vendemov->(DbSkip(1))
			EndDo
			Restela( cTela )
			Set Rela To CodiVen Into Vendedor
			DbGoTop()
			Func_Mostra()
			DbClearRel()
			DbCloseArea()
			Ferase( cArquivo )
		else
			Nada()
			Restela( aTela )
		endif

	Case op1 = 3
		Vendedor->( Order( VENDEDOR_CODIVEN ))
		Area("Vendemov")
		Vendemov->(Order( VENDEMOV_DATA ))
		Vendemov->(DbGoTop())
		MaBox( 18,20,20,39 )
		dData = Date()
		@ 19,21 Say "Data....¯" Get dData Pict "##/##/##"
		Read
		if LastKey( ) = ESC
			ResTela( aTela )
			Loop
		endif
		if Vendemov->(DbSeek( dData ))
			Copy Stru To ( cArquivo )
			Use (cArquivo) Exclusive New
			oBloco := {|| Vendemov->Data = dData }
			oMenu:Limpa()
			cTela := Mensagem("Aguarde. Verificando movimento.", Cor())
			WHILE Eval( oBloco ) .AND. Rep_Ok()
				if Vendemov->Descricao = Space(40)
					Vendemov->(DbSkip(1))
					Loop
				endif
				if Vendemov->Dc = "C"
					Vendemov->(DbSkip(1))
					Loop
				endif
				DbAppend()
				For nField := 1 To FCount()
					FieldPut( nField, Vendemov->(FieldGet( nField )))
				Next
				Vendemov->(DbSkip(1))
			EndDo
			Restela( cTela )
			Set Rela To CodiVen Into Vendedor
			DbGoTop()
			Func_Mostra()
			DbClearRel()
			DbCloseArea()
			Ferase( cArquivo )
		else
			Nada()
			Restela( aTela )
		endif

	 Case op1 = 4
		 Vendedor->( Order( VENDEDOR_CODIVEN ))
		 Area("Vendemov")
		 Vendemov->(Order( VENDEMOV_CODIVEN ))
		 Vendemov->(DbGoTop())
		 Copy Stru To ( cArquivo )
		 Use (cArquivo) Exclusive New
		 oBloco := {|| Vendemov->(!Eof()) }
		 oMenu:Limpa()
		 cTela := Mensagem("Aguarde. Verificando movimento.", Cor())
		 WHILE Eval( oBloco ) .AND. Rep_Ok()
			 if Vendemov->Descricao = Space(40)
				 Vendemov->(DbSkip(1))
				 Loop
			 endif
			 if Vendemov->Dc = "C"
				 Vendemov->(DbSkip(1))
				 Loop
			 endif
			 DbAppend()
			 For nField := 1 To FCount()
				 FieldPut( nField, Vendemov->(FieldGet( nField )))
			 Next
			 Vendemov->(DbSkip(1))
		 EndDo
		 Restela( cTela )
		 Set Rela To CodiVen Into Vendedor
		 DbGoTop()
		 Func_Mostra()
		 DbClearRel()
		 DbCloseArea()
		 Ferase( cArquivo )
	 EndCase
EndDo

*:==================================================================================================================================

Proc Func_Mostra()
******************
LOCAL cScreen := SaveScreen()
LOCAL Mostra2 := {"Codiven", "Vendedor->Nome", "Tran( Vlr, '@E 99,999,999,999.99' )","data", "docnr", "descricao" }
LOCAL Mostra1 := {"CODI", "NOME DO VENDEDOR", "DEBITO" ,"DATA" ,"DOCTO N§" ,"DESCRICAO"}

oMenu:Limpa()
MaBox( 01, 00, MaxRow()-1, MaxCol(), "CONSULTA DE LANCAMENTOS" )
Seta1(23)
DbEdit( 02, 01, MaxRow()-2, MaxCol()-1, Mostra2, OK, OK, Mostra1 )
ResTela( cScreen )
return

*:==================================================================================================================================

Proc Cred_Consu()
*****************
LOCAL GetList	  := {}
LOCAL Func_Consu := SaveScreen( )
LOCAL aMenuArray := { " Por Docto ", " Individual ", " Por Data ", " Geral " }
LOCAL cArquivo   := FTempName("T*.TMP")
LOCAL cDocnr
LOCAL cCodi
LOCAL aTela
LOCAL Op1
LOCAL cTela
LOCAL dData
LOCAL oBloco
LOCAL nField
FIELD CodiVen

WHILE OK
	 aTela := SaveScreen()
	 M_Title( "CONSULTAS DE CREDITOS")
	 Op1 := FazMenu( 08, 20, aMenuArray, Cor() )
	 Do Case
	 Case op1 = 0
		 ResTela( func_consu )
		 Exit

	 Case op1 = 1
		 Vendedor->( Order( VENDEDOR_CODIVEN ))
		 Area("Vendemov")
		 Vendemov->(Order( VENDEMOV_DOCNR ))
		 Vendemov->(DbGoTop())
		 MaBox( 18,20,20,41 )
		 cDocnr = Space( Len( Vendemov->Docnr )-2 )
		 @ 19, 21 Say "Docto N§...¯" Get cDocnr Pict "@!" Valid DocFuerr( cDocnr )
		 Read
		 if LastKey( ) = ESC
			 ResTela( aTela )
			 Loop
		 endif
		 Copy Stru To ( cArquivo )
		 Use (cArquivo) Exclusive New
		 oBloco := {|| Vendemov->Docnr = cDocnr }
		 oMenu:Limpa()
		 cTela := Mensagem("Aguarde. Verificando movimento.", Cor())
		 WHILE Eval( oBloco ) .AND. Rep_Ok()
			 if Vendemov->Descricao = Space(40)
				 Vendemov->(DbSkip(1))
				 Loop
			 endif
			 if Vendemov->Dc = "D"
				 Vendemov->(DbSkip(1))
				 Loop
			 endif
			 DbAppend()
			 For nField := 1 To FCount()
				 FieldPut( nField, Vendemov->(FieldGet( nField )))
			 Next
			 Vendemov->(DbSkip(1))
		 EndDo
		 Restela( cTela )
		 Set Rela To CodiVen Into Vendedor
		 DbGoTop()
		 Func_Mostra()
		 DbClearRel()
		 DbCloseArea()
		 Ferase( cArquivo )

	Case op1 = 2
		Vendedor->( Order( VENDEDOR_CODIVEN ))
		Area("Vendemov")
		Vendemov->(Order( VENDEMOV_CODIVEN ))
		Vendemov->(DbGoTop())
		MaBox( 18, 20, 20, 36 )
		cCodi := Space(04)
		@ 19,21 Say "Codigo..¯" Get cCodi Pict "9999" Valid FunErrado( @cCodi )
		Read
		if LastKey( ) = ESC
			ResTela( aTela )
			Loop
		endif
		if Vendemov->(DbSeek( cCodi ))
			Copy Stru To ( cArquivo )
			Use (cArquivo) Exclusive New
			oBloco := {|| Vendemov->CodiVen = cCodi }
			oMenu:Limpa()
			cTela := Mensagem("Aguarde. Verificando movimento.", Cor())
			WHILE Eval( oBloco ) .AND. Rep_Ok()
				if Vendemov->Descricao = Space(40)
					Vendemov->(DbSkip(1))
					Loop
				endif
				if Vendemov->Dc = "D"
					Vendemov->(DbSkip(1))
					Loop
				endif
				DbAppend()
				For nField := 1 To FCount()
					FieldPut( nField, Vendemov->(FieldGet( nField )))
				Next
				Vendemov->(DbSkip(1))
			EndDo
			Restela( cTela )
			Set Rela To CodiVen Into Vendedor
			DbGoTop()
			Func_Mostra()
			DbClearRel()
			DbCloseArea()
			Ferase( cArquivo )
		else
			Nada()
			Restela( aTela )
		endif

	Case op1 = 3
		Vendedor->( Order( VENDEDOR_CODIVEN ))
		Area("Vendemov")
		Vendemov->(Order( VENDEMOV_DATA ))
		Vendemov->(DbGoTop())
		MaBox( 18,20,20,39 )
		dData = Date()
		@ 19,21 Say "Data....¯" Get dData Pict "##/##/##"
		Read
		if LastKey( ) = ESC
			ResTela( aTela )
			Loop
		endif
		if Vendemov->(DbSeek( dData ))
			Copy Stru To ( cArquivo )
			Use (cArquivo) Exclusive New
			oBloco := {|| Vendemov->Data = dData }
			oMenu:Limpa()
			cTela := Mensagem("Aguarde. Verificando movimento.", Cor())
			WHILE Eval( oBloco ) .AND. Rep_Ok()
				if Vendemov->Descricao = Space(40)
					Vendemov->(DbSkip(1))
					Loop
				endif
				if Vendemov->Dc = "D"
					Vendemov->(DbSkip(1))
					Loop
				endif
				DbAppend()
				For nField := 1 To FCount()
					FieldPut( nField, Vendemov->(FieldGet( nField )))
				Next
				Vendemov->(DbSkip(1))
			EndDo
			Restela( cTela )
			Set Rela To CodiVen Into Vendedor
			DbGoTop()
			Func_Mostra()
			DbClearRel()
			DbCloseArea()
			Ferase( cArquivo )
		else
			Nada()
			Restela( aTela )
		endif

	 Case op1 = 4
		 Vendedor->( Order( VENDEDOR_CODIVEN ))
		 Area("Vendemov")
		 Vendemov->(Order( VENDEMOV_CODIVEN ))
		 Vendemov->(DbGoTop())
		 Copy Stru To ( cArquivo )
		 Use (cArquivo) Exclusive New
		 oBloco := {|| Vendemov->(!Eof()) }
		 oMenu:Limpa()
		 cTela := Mensagem("Aguarde. Verificando movimento.", Cor())
		 WHILE Eval( oBloco ) .AND. Rep_Ok()
			 if Vendemov->Descricao = Space(40)
				 Vendemov->(DbSkip(1))
				 Loop
			 endif
			 if Vendemov->Dc = "D"
				 Vendemov->(DbSkip(1))
				 Loop
			 endif
			 DbAppend()
			 For nField := 1 To FCount()
				 FieldPut( nField, Vendemov->(FieldGet( nField )))
			 Next
			 Vendemov->(DbSkip(1))
		 EndDo
		 Restela( cTela )
		 Set Rela To CodiVen Into Vendedor
		 DbGoTop()
		 Func_Mostra()
		 DbClearRel()
		 DbCloseArea()
		 Ferase( cArquivo )
	 EndCase
EndDo

*:==================================================================================================================================

Proc Func_Adian()
*****************
LOCAL cScreen	  := SaveScreen()
LOCAL GetList	  := {}
LOCAL cCodi 	  := Space(04)
LOCAL dData 	  := Date()
LOCAL cDocnr	  := Space(07)
LOCAL cDescricao := Space(40)
LOCAL nVlr		  := 0
LOCAL cSaldo	  := ""
LOCAL nDisp
LOCAL nComi

Area("Vendedor")
Order( VENDEDOR_CODIVEN )
oMenu:Limpa()
MaBox( 08, 10, 14, 68, "LANCAMENTOS A DEBITOS" )
WHILE OK
	@ 09, 11 Say "Codigo....:" Get cCodi      Pict "9999" Valid FunErrado( @cCodi,, Row(), Col()+1 )
	@ 10, 11 Say "Data......:" Get dData      Pict "##/##/##"
	@ 11, 11 Say "Docto N§..:" Get cDocnr     Pict "@!"
	@ 12, 11 Say "Valor.....:" Get nVlr       Pict "99999999.99" Valid if( nVlr <= 0,           ( ErrorBeep(), Alerta("Erro: Valor Invalido"), FALSO ), OK )
	@ 13, 11 Say "Descricao.:" Get cDescricao Pict "@!"          Valid if( Empty( cDescricao ), ( ErrorBeep(), Alerta("Erro: Campo nao Pode ser Vazio"), FALSO ), OK )
	Read
	if LastKey() = ESC .OR. LastKey() = K_ALT_F4
		ResTela( cScreen )
		Exit
	endif
	ErrorBeep()
	if Conf( "Confirma Inclusao do Debito ?" )
		if Vendedor->(TravaReg())
			if Vendemov->(!Incluiu())
				Vendedor->(Libera())
				Loop
			endif
			Vendemov->CodiVen   := cCodi
			Vendemov->Data 	  := dData
			Vendemov->Docnr	  := cDocnr
			Vendemov->Vlr		  := nVlr
			Vendemov->Dc		  := "D"
			Vendemov->Descricao := cDescricao
			Vendemov->ComDisp   := Vendemov->ComDisp - nVlr
			Vendemov->Comissao  := Vendemov->Comissao - nVlr
			Vendemov->(Libera())

			nDisp := Vendedor->ComDisp
			nComi := Vendedor->Comissao
			Vendedor->Comdisp   := ( nDisp - nVlr )
			Vendedor->Comissao  := ( nComi - nVlr )
			Vendedor->(Libera())
		endif
	endif
EndDo
return

*:==================================================================================================================================

Proc FunAdian()
***************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen( )
LOCAL aMenu   := {"Individual", "Geral" }
LOCAL Choice
LOCAL dIni
LOCAL dFim
LOCAL oBloco
LOCAL oBloco1
LOCAL oBloco2
LOCAL oBloco3
LOCAL cCodi
FIELD Codi
FIELD CodiVen

WHILE OK
	oMenu:Limpa()
	M_Title( "ROL DEBITOS")
	Choice := FazMenu( 10, 10, aMenu )
	Do Case
	Case Choice = 0
		ResTela( cScreen )
		Exit

	Case Choice = 1
		dIni	:= Date() - 30
		dFim	:= Date()
		cCodi := Space( 04 )
		MaBox( 16, 10, 20, 76 )
		@ 17, 11 Say "Vendedor.....:" Get cCodi Pict "@!" Valid FunErrado( @cCodi, NIL, Row(), Col()+1 )
		@ 18, 11 Say "Data Inicial.:" Get dIni  Pict "##/##/##"
		@ 19, 11 Say "Data Final...:" Get dFim  Pict "##/##/##"
		Read
		if LastKey( ) = ESC
			Loop
		endif
		Vendedor->( Order( VENDEDOR_CODIVEN ))
		Receber->( Order( RECEBER_CODI ))
		Area( "VendeMov")
		Set Rela To Codi Into Receber, Codiven Into Vendedor
		Vendemov->(Order( VENDEMOV_CODIVEN ))
		if Vendemov->(!DbSeek( cCodi ))
			Nada()
		else
			oBloco  := {|| Vendemov->Codiven = cCodi }
			oBloco1 := {|| Vendemov->Data >= dIni .AND. Vendemov->Data <= dFim }
			oBloco2 := {|| Vendemov->Descricao != Space(40) }
			oBloco3 := {|| Vendemov->Dc = "D" }
		endif
		FunImp( oBloco, oBloco1, oBloco2, oBloco3, dIni, dFim, "D" )

	Case Choice = 2
		dIni	:= Date() - 30
		dFim	:= Date()
		MaBox( 16, 10, 19, 76 )
		@ 17, 11 Say "Data Inicial.:" Get dIni  Pict "##/##/##"
		@ 18, 11 Say "Data Final...:" Get dFim  Pict "##/##/##"
		Read
		if LastKey( ) = ESC
			Loop
		endif
		Vendedor->( Order( VENDEDOR_CODIVEN ))
		Receber->( Order( RECEBER_CODI ))
		Area( "VendeMov")
		Set Rela To Codi Into Receber, Codiven Into Vendedor
		Vendemov->(Order( VENDEMOV_CODIVEN ))
		Vendemov->(DbGoTop())
		if Vendemov->(LastRec() = 0 )
			Nada()
		else
			oBloco  := {|| Vendemov->(!Eof()) }
			oBloco1 := {|| Vendemov->Data >= dIni .AND. Vendemov->Data <= dFim }
			oBloco2 := {|| Vendemov->Descricao != Space(40) }
			oBloco3 := {|| Vendemov->Dc = "D" }
		endif
		FunImp( oBloco, oBloco1, oBloco2, oBloco3, dIni, dFim, "D" )
	EndCase
	Vendemov->( DbClearRel())
	Vendemov->( DbGoTop())
EndDo

Proc FunImp( oBloco, oBloco1, oBloco2, oBloco3, dIni, dFim, cDC )
*****************************************************************
LOCAL cScreen		  := SaveScreen()
LOCAL Tam			  := 80
LOCAL Col			  := 58
LOCAL Pagina		  := 0
LOCAL NovoCodiVen   := OK
LOCAL nTotalVend	  := 0
LOCAL nSubTotal	  := 0
LOCAL nTotalGeral   := 0
LOCAL cRelato		  := "RELATORIO DE " + if( cDC = "D", "DEBITOS ", "CREDITOS ") + " REF " + Dtoc( dIni ) + " A " + DToc( dFim )
LOCAL UltCodiVen
fIELD CodiVen
fIELD Data
FIELD Docnr
FIELD Descricao
FIELD Vlr

if !Instru80()
	ResTela( cScreen )
	return
endif
UltCodiVen := CodiVen
Mensagem("Aguarde, Imprimindo.")
PrintOn()
SetPrc( 0, 0 )
While Eval( oBloco ) .AND. REL_OK()
	if Col >=  58
		Write( 00, 00, Linha1( Tam, @Pagina))
		Write( 01, 00, Linha2())
		Write( 02, 00, Linha3(Tam))
		Write( 03, 00, Linha4(Tam, SISTEM_NA6 ))
		Write( 04, 00, Padc( cRelato, Tam ))
		Write( 05, 00, Linha5(Tam))
		Write( 06, 00,"DATA     DOCTO N§  DESCRICAO                                               VALOR")
		Write( 07, 00, Linha5(Tam))
		Col := 8
	endif
	if Col = 8
		Write( Col, 00, NG + "VENDEDOR : " + Vendemov->CodiVen + " " + Vendedor->Nome + NR )
		Col += 2
	endif
	if NovoCodiVen
		NovoCodiVen := FALSO
		nSubTotal	:= 0
		nTotalVend	:= 0
	endif
	if Eval( OBloco1 )
		if Eval( OBloco2 )
			if Eval( OBloco3 )
				Write( Col, 0, Dtoc( Data ) + " " + Docnr + " " + Descricao +  "       " + Tran( Vlr, "@E 999,999,999.99" ) )
				Col++
				nTotalVend	+= Vlr
				nSubTotal	+= Vlr
				nTotalGeral += Vlr
			endif
		endif
	endif
	UltCodiVen := Vendemov->CodiVen
	Vendemov->(DbSkip(1))
	if Col = 55 .OR. UltCodiVen != CodiVen
		Write( (Col + 1), 00, "*** SubTotal Vendedor *** ")
		Write( (Col + 1), ( MaxCol() - 13), Tran( nSubTotal, "@E 999,999,999.99" ) )
		nSubTotal := 0
		if UltCodiVen != CodiVen
			NovoCodiVen := OK
			Write( (Col + 2), 00, "*** Total Vendedor *** ")
			Write( (Col + 2), ( MaxCol() - 13), Tran( nTotalVend, "@E 999,999,999.99" ) )
		endif
		if !Eval( oBloco )
			Write( (Col + 3), 00, "*** Total Geral *** ")
			Write( (Col + 3), ( MaxCol() - 13), Tran( nTotalGeral, "@E 999,999,999.99" ) )
		endif
		if Col >= 55
			Col := 55
			__Eject()
		endif
	endif
EndDo
PrintOff()
ResTela( cScreen )
return

Proc FunCreditos()
*****************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen( )
LOCAL aMenu   := {"Individual", "Geral" }
LOCAL Choice
LOCAL dIni
LOCAL dFim
LOCAL oBloco
LOCAL oBloco1
LOCAL oBloco2
LOCAL oBloco3
LOCAL cCodi
FIELD Codi
FIELD CodiVen

WHILE OK
	oMenu:Limpa()
	M_Title( "ROL CREDITOS")
	Choice := FazMenu( 10, 10, aMenu )
	Do Case
	Case Choice = 0
		ResTela( cScreen )
		Exit

	Case Choice = 1
		dIni	:= Date() - 30
		dFim	:= Date()
		cCodi := Space( 04 )
		MaBox( 16, 10, 20, 76 )
		@ 17, 11 Say "Vendedor.....:" Get cCodi Pict "@!" Valid FunErrado( @cCodi, NIL, Row(), Col()+1 )
		@ 18, 11 Say "Data Inicial.:" Get dIni  Pict "##/##/##"
		@ 19, 11 Say "Data Final...:" Get dFim  Pict "##/##/##"
		Read
		if LastKey( ) = ESC
			Loop
		endif
		Vendedor->( Order( VENDEDOR_CODIVEN ))
		Receber->( Order( RECEBER_CODI ))
		Area( "VendeMov")
		Set Rela To Codi Into Receber, Codiven Into Vendedor
		Vendemov->(Order( VENDEMOV_CODIVEN ))
		if Vendemov->(!DbSeek( cCodi ))
			Nada()
		else
			oBloco  := {|| Vendemov->Codiven = cCodi }
			oBloco1 := {|| Vendemov->Data >= dIni .AND. Vendemov->Data <= dFim }
			oBloco2 := {|| Vendemov->Descricao != Space(40) }
			oBloco3 := {|| Vendemov->Dc = "C" }
		endif
		FunImp( oBloco, oBloco1, oBloco2, oBloco3, dIni, dFim, "C" )

	Case Choice = 2
		dIni	:= Date() - 30
		dFim	:= Date()
		MaBox( 16, 10, 19, 76 )
		@ 17, 11 Say "Data Inicial.:" Get dIni  Pict "##/##/##"
		@ 18, 11 Say "Data Final...:" Get dFim  Pict "##/##/##"
		Read
		if LastKey( ) = ESC
			Loop
		endif
		Vendedor->( Order( VENDEDOR_CODIVEN ))
		Receber->( Order( RECEBER_CODI ))
		Area( "VendeMov")
		Set Rela To Codi Into Receber, Codiven Into Vendedor
		Vendemov->(Order( VENDEMOV_CODIVEN ))
		Vendemov->(DbGoTop())
		if Vendemov->(LastRec() = 0 )
			Nada()
		else
			oBloco  := {|| Vendemov->(!Eof()) }
			oBloco1 := {|| Vendemov->Data >= dIni .AND. Vendemov->Data <= dFim }
			oBloco2 := {|| Vendemov->Descricao != Space(40) }
			oBloco3 := {|| Vendemov->Dc = "C" }
		endif
		FunImp( oBloco, oBloco1, oBloco2, oBloco3, dIni, dFim, "C" )
	EndCase
	Vendemov->( DbClearRel())
	Vendemov->( DbGoTop())
EndDo

*:==================================================================================================================================

Proc FunReVen()
***************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen( )
LOCAL aMenu   := {"Individual", "Por Regiao", "Por Forma Pagto", "Geral"}
LOCAL Choice
LOCAL dIni
LOCAL dFim
LOCAL cCodi
LOCAL cRegiao
LOCAL oBloco
LOCAL cforma

WHILE OK
	oMenu:Limpa()
	M_Title("RELATORIO DE VENDAS")
	Choice := FazMenu( 02, 10, aMenu, Cor() )
	Do Case
	Case Choice = 0
		ResTela( cScreen )
		Exit

	Case Choice = 1
		cCodi := Space(4)
		dIni	:= Date() - 30
		dFim	:= Date()
		MaBox( 10, 10, 14, 75 )
		@ 11, 11 Say "Vendedor.....:" Get cCodi Pict "9999" Valid FunErrado( @cCodi,, Row(), Col()+1 )
		@ 12, 11 Say "Data Inicial.:" Get dIni  Pict "##/##/##"
		@ 13, 11 Say "Data Final...:" Get dFim  Pict "##/##/##"
		Read
		if LastKey() = ESC
			Loop
		endif
		Vendedor->( Order( VENDEDOR_CODIVEN ))
		Receber->(Order( RECEBER_CODI ))
		Area( "VendeMov" )
		Vendemov->(Order( VENDEMOV_CODIVEN ))
		Set Rela To Vendemov->Codi Into Receber, Vendemov->Codiven Into Vendedor
		oBloco := {|| Vendemov->CodiVen = cCodi }
		if Vendemov->(!DbSeek( cCodi ))
			Nada()
		else
			FunReVenImp( oBloco, dIni, dFim )
		endif

	Case Choice = 2
		cRegiao := Space( 2 )
		dIni	  := Date() - 30
		dFim	  := Date()
		MaBox( 10, 10, 14, 75 )
		@ 11, 11 Say "Regiao.......:" Get cRegiao Pict "99" Valid RegiaoErrada( @cRegiao, Row(), Col()+1 )
		@ 12, 11 Say "Data Inicial.:" Get dIni    Pict "##/##/##"
		@ 13, 11 Say "Data Final...:" Get dFim    Pict "##/##/##"
		Read
		if LastKey( ) = ESC
			Loop
		endif
		Vendedor->( Order( VENDEDOR_CODIVEN ))
		Receber->(Order( RECEBER_CODI ))
		Area( "VendeMov" )
		Vendemov->(Order( VENDEMOV_REGIAO ))
		Set Rela To Vendemov->Codi Into Receber, Vendemov->Codiven Into Vendedor
		OBloco := {|| Vendemov->(!Eof()) }
		if Vendemov->(!DbSeek( cRegiao ))
			Nada()
		else
			Vendemov->(Order( VENDEMOV_CODIVEN ))
			Vendemov->(DbGoTop())
			FunReVenImp( oBloco, dIni, dFim, cRegiao )
		endif

	Case Choice = 3
		cForma  := Space( 2 )
		dIni	  := Date() - 30
		dFim	  := Date()
		MaBox( 10, 10, 14, 75 )
		@ 11, 11 Say "Forma........:" Get cForma  Pict "99" Valid FormaErrada( @cForma, NIL, Row(), Col()+1 )
		@ 12, 11 Say "Data Inicial.:" Get dIni    Pict "##/##/##"
		@ 13, 11 Say "Data Final...:" Get dFim    Pict "##/##/##"
		Read
		if LastKey( ) = ESC
			ResTela( cScreen )
			Loop
		endif
		Vendedor->( Order( VENDEDOR_CODIVEN ))
		Receber->(Order( RECEBER_CODI ))
		Area( "VendeMov" )
		Vendemov->(Order( VENDEMOV_FORMA ))
		Set Rela To Vendemov->Codi Into Receber, Vendemov->Codiven Into Vendedor
		oBloco := {|| Vendemov->Forma = cForma }
		if Vendemov->(!DbSeek( cForma ))
			Nada()
		else
			FunReVenImp( oBloco, dIni, dFim )
		endif
	Case Choice = 4
		Area("VendeMov")
		Vendemov->(Order( VENDEMOV_CODIVEN ))
		dIni := Date() - 30
		dFim := Date()
		MaBox( 10, 10, 13, 75 )
		@ 11, 11 Say "Data Inicial.:" Get dIni Pict "##/##/##"
		@ 12, 11 Say "Data Final...:" Get dFim Pict "##/##/##"
		Read
		if LastKey( ) = ESC
			ResTela( cScreen )
			Loop
		endif
		Vendedor->( Order( VENDEDOR_CODIVEN ))
		Receber->(Order( RECEBER_CODI ))
		Area( "VendeMov" )
		Vendemov->(Order( VENDEMOV_CODIVEN ))
		Set Rela To Vendemov->Codi Into Receber, Vendemov->Codiven Into Vendedor
		OBloco := {|| Vendemov->(!Eof()) }
		Vendemov->(DbGoTop())
		if Vendemov->(LastRec() = 0 )
			Nada()
		else
			FunReVenImp( oBloco, dIni, dFim )
		endif
	EndCase
	Vendemov->(DbClearRel())
	Vendemov->(DbGoTop())
EndDo

*:==================================================================================================================================

Proc FunReVenImp( oBloco, dIni, dFim, cRegiao )
***********************************************
LOCAL cScreen	 := SaveScreen()
LOCAL Relato	 := "RELATORIO DE VENDAS DE " + Dtoc( dIni ) + " A " + Dtoc( dFim )
LOCAL lNovo 	 := OK
LOCAL lUltimo	 := OK
LOCAL Tam		 := 80
LOCAL Col		 := 58
LOCAL Pagina	 := 0
LOCAL nTotal	 := 0
LOCAL nSubTotal := 0
LOCAL nGeral	 := 0
LOCAL oBloco1	 := {|| Empty( Vendemov->Descricao )}
LOCAL oBloco2	 := {|| Vendemov->Data >= dIni .AND. Vendemov->Data <= dFim }
LOCAL oBloco3	 := NIL

if !Instru80()
	ResTela( cScreen )
	return
endif
Mensagem("Aguarde, Imprimindo.")
if cRegiao != NIL
	oBloco3	 := {|| Vendemov->Regiao = cRegiao }
	Relato += " - REGIAO : " + cRegiao
else
	oBloco3	 := {|| Vendemov->(!Eof()) }
endif
PrintOn()
SetPrc( 0, 0 )
While Eval( oBloco ) .AND. REL_OK()
	if Col >=  58
		Write( 00, 00, Linha1( Tam, @Pagina))
		Write( 01, 00, Linha2())
		Write( 02, 00, Linha3(Tam))
		Write( 03, 00, Linha4(Tam, SISTEM_NA6 ))
		Write( 04, 00, Padc( Relato, Tam ))
		Write( 05, 00, Linha5(Tam))
		Write( 06, 00, "FATURA    CLIENTE                                  RG FP  PORC      VALOR FATURA")
		Write( 07, 00, Linha5(Tam))
		Col := 8
	endif
	if Eval( oBloco1 )
		if Eval( oBloco2 )
			if Eval( oBloco3 )
				if Col = 8
					Write( 08, 00, NG + "VENDEDOR : " + Vendemov->CodiVen + " " + Vendedor->Nome + NR )
					Qout()
					Col := 10
				endif
				if lNovo
					lNovo 	 := FALSO
					nSubTotal := 0
					nTotal	 := 0
				endif
				Qout( Vendemov->Fatura, Receber->Nome, Receber->Regiao, Vendemov->Forma, Vendemov->Porc, Tran( Vendemov->Vlr, "@E 99,999,999,999.99" ))
				Col++
				nTotal	 += Vendemov->Vlr
				nGeral	 += Vendemov->Vlr
				nSubTotal += Vendemov->Vlr
			endif
		endif
	endif
	lUltimo := Vendemov->CodiVen
	Vendemov->(DbSkip(1))
	if Col = 55 .OR. lUltimo != Vendemov->CodiVen
		if nSubTotal != 0
			Col++
			Write( Col, 00, "*** SubTotal Vendedor *** ")
			Write( Col, (MaxCol()-15), Tran( nSubTotal, "@E 9,999,999,999.99" ) )
			Col++
			nSubTotal := 0
		endif
		if lUltimo != Vendemov->CodiVen
			lNovo := OK
			if nTotal != 0
				Write( Col, 00, "*** Total Vendedor *** ")
				Write( Col, ( MaxCol() - 15), Tran( nTotal, "@E 9,999,999,999.99" ) )
				Col++
				nTotal := 0
				if !Eval( oBloco )
					 Write( Col, 00, "*** Total Geral *** ")
					 Write( Col, ( MaxCol() - 15), Tran( nGeral, "@E 9,999,999,999.99" ) )
					 Col := 58
				endif
				Col := 58
			endif
		endif
		if Col >= 55
			Col := 58
		  __Eject()
		endif
	endif
EndDo
PrintOff()
ResTela( cScreen )
return

*:==================================================================================================================================

Proc SaldoDbEdit()
******************
LOCAL Arq_Ant	:= Alias()
LOCAL Ind_Ant	:= IndexOrd()
LOCAL cScreen	:= SaveScreen()
LOCAL oBrowse	:= MsBrowse():New()

oMenu:Limpa()
Area("Vendedor")
Vendedor->(Order( VENDEDOR_NOME ))
Vendedor->(DbGoTop())
oBrowse:Add( "CODIGO",     "CodiVen")
oBrowse:Add( "NOME",       "Nome")
oBrowse:Add( "DISPONIVEL", "ComDisp")
oBrowse:Add( "BLOQUEADA",  "ComBloq")
oBrowse:Add( "TOTAL",      "Comissao")
oBrowse:Titulo   := "CONSULTA DE COMISSOES"
oBrowse:PreDoGet := {|| ( ErrorBeep(), Alerta("Erro: Alteracao nao permitida"), FALSO ) } // Rotina do Usuario Antes de Atualizar
oBrowse:PreDoDel := {|| ( ErrorBeep(), Alerta("Erro: Exclusao nao permitida"), FALSO ) } // Rotina do Usuario Antes de Atualizar
oBrowse:PosDoGet := NIL
oBrowse:PosDoDel := NIL
oBrowse:Show()
oBrowse:Processa()
AreaAnt( Arq_Ant, Ind_Ant )
ResTela( cScreen )

Proc VendedorDbedit()
*********************
LOCAL Arq_Ant	:= Alias()
LOCAL Ind_Ant	:= IndexOrd()
LOCAL cScreen	:= SaveScreen()
LOCAL oBrowse	:= MsBrowse():New()
LOCAL nChoice	:= 0

oMenu:Limpa()
Area("Vendedor")
Vendedor->(Order( VENDEDOR_NOME ))
Vendedor->(DbGoTop())
oBrowse:Add( "DESATIVADO", "Rol")
oBrowse:Add( "CODIGO",     "CodiVen")
oBrowse:Add( "NOME",       "Nome")
oBrowse:Titulo   := "CONSULTA/ALTERACAO DE VENDEDORES"
oBrowse:PreDoGet := NIL
oBrowse:PosDoGet := {|| PosVenDbEdit( oBrowse, nChoice ) } // Rotina do Usuario apos Atualizar
oBrowse:PreDoDel := NIL
oBrowse:PosDoDel := NIL
oBrowse:Show()
oBrowse:Processa()
AreaAnt( Arq_Ant, Ind_Ant )
ResTela( cScreen )

Function PosVenDbedit( oBrowse, nChoice )
*****************************************
LOCAL oCol		 := oBrowse:getColumn( oBrowse:colPos )
LOCAL lRol		 := FALSO
LOCAL Arq_Ant	 := Alias()
LOCAL Ind_Ant	 := IndexOrd()

Do Case
Case oCol:Heading = "DESATIVADO"
	lRol := Vendedor->Rol
	lPickSimNao( @lRol )
	Vendedor->Rol := lRol
	AreaAnt( Arq_Ant, Ind_Ant )
OtherWise
EndCase
return( OK )

Proc FunReLac()
***************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen()
LOCAL nChoice := 1
LOCAL aMenu   := {" Individual ", " Todos " }
LOCAL aOrdem  := {" Ordem Nome ", " Ordem Codigo " }
LOCAL oBloco
LOCAL cCodi

WHILE OK
	oMenu:Limpa()
	M_Title( "RELACAO VENDEDORES")
	nChoice := FazMenu( 07, 16, aMenu )
	Do Case
	Case nChoice = 0
		ResTela( cScreen )
		Exit

	Case nChoice = 1
		Area("Vendedor")
		Vendedor->(Order( VENDEDOR_CODIVEN ))
		cCodi := Space(4)
		MaBox( 14, 16, 16, 38 )
		@ 15, 17 Say "Codigo..:" Get cCodi Valid FuncErr( @cCodi )
		Read
		if LastKey() = ESC
			ResTela( cScreen )
			Loop
		endif
		oBloco := {|| Vendedor->Codiven = cCodi }
		RelProdu1( oBloco )

	Case nChoice = 2
		M_Title( "RELACAO VENDEDORES")
		nChoice := FazMenu( 09, 18, aOrdem )
		if nChoice = 0
			ResTela( cScreen )
			Loop
		endif
		Area("Vendedor")
		Vendedor->(Order( if( nChoice = 1, VENDEDOR_CODIVEN, VENDEDOR_NOME )))
		Vendedor->(DbGoTop())
		oBloco := {|| Vendedor->(!Eof()) }
		RelProdu1( oBloco )
	EndCase
EndDo

Proc RelProdu1( oBloco )
************************
LOCAL cScreen := SaveScreen()
LOCAL Tam	  := 80
LOCAL Col	  := 58
LOCAL Pagina  := 0

if !Instru80()
	ResTela( cScreen )
	return
endif
PrintOn()
SetPrc( 0, 0 )
WHILE Eval( oBloco ) .AND. REL_OK( )
	if Col >= 58
		 Write( 00, 00, Linha1( Tam, @Pagina))
		 Write( 01, 00, Linha2())
		 Write( 02, 00, Linha3(Tam))
		 Write( 03, 00, Linha4(Tam, SISTEM_NA6 ))
		 Write( 04, 00, Padc( "LISTAGEM DE VENDEDORES",Tam ) )
		 Write( 05, 00, Linha5(Tam))
		 Write( 06, 00, "CODI         NOME VENDEDOR")
		 Write( 07, 00, Linha5(Tam))
		 Col := 8
	endif
	Write(	Col, 0, NG + Vendedor->CodiVen + " " + Vendedor->Nome + NR )
	Write( ++Col, 5, Vendedor->Cpf  + Space(10) + Vendedor->Rg)
	Write( ++Col, 5, Vendedor->Ende	+ " " + Vendedor->Bair )
	Write( ++Col, 5, Vendedor->Cep  + "/" + AlLTrim( Vendedor->Cida ) + "-" + Vendedor->Esta )
	Col += 2
	if Col = 58
		Write( Col, 0,  Repl( SEP, Tam ) )
		__Eject()
	endif
	Vendedor->(DbSkip(1))
EndDo
PrintOff()
Restela( cScreen )
return

Function VerMovimento( cCodiVen )
*********************************
Vendemov->(Order( VENDEMOV_CODIVEN ))
if Vendemov->(!DbSeek( cCodiVen ))
	Nada()
	return( FALSO )
endif
return( OK )

Function DocFuerr( cDocnr )
***************************
if Empty( cDocnr )
	ErrorBeep()
	Alerta( "ERRO: Codigo Documento Inv lido." )
	return( FALSO )
endif
if !DbSeek( cDocnr )
	 ErrorBeep()
	 Alerta( "ERRO: Documento nao Localizado." )
	 return( FALSO )
endif
return( OK )

Function FuncErr( cCodifun, cCodi, nRow, nCol )
***********************************************
LOCAL aRotinaInc := {{|| FuncInclusao() }}
LOCAL aRotinaAlt := {{|| FuncInclusao(OK) }}
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()

if (Lastrec() = 0 )
	Nada()
	return( FALSO )
endif
Area( "Vendedor")
Vendedor->(Order( if( Len( cCodifun) < 40, VENDEDOR_CODIVEN, VENDEDOR_NOME )))
if Vendedor->(!DbSeek( cCodifun ))
	Vendedor->(Order( VENDEDOR_NOME ))
	Vendedor->(Escolhe( 03, 01, MaxRow()-2, "CodiVen + 'İ' + Nome + 'İ' + Fone", "CODI NOME DO VENDEDOR" + Space(25)+ "TELEFONE", aRotinaInc, NIL, aRotinaAlt ))
	cCodifun := if( Len( cCodifun ) < 40, Vendedor->CodiVen, Vendedor->Nome )
	cCodi 	:= Vendedor->CodiVen
endif
if nRow != NIL
	Write( nRow, nCol, Vendedor->Nome )
endif
AreaAnt( Arq_Ant, Ind_Ant )
return( OK )

STATIC Proc AbreArea()
**********************
LOCAL cScreen := SaveScreen()
ErrorBeep()
Mensagem("Aguarde, Abrindo base de dados.", WARNING, _LIN_MSG )
FechaTudo()

if !UsaArquivo("VENDEDOR")
	MensFecha()
	return
endif
if !UsaArquivo("VENDEMOV")
	MensFecha()
	return
endif
if !UsaArquivo("RECEMOV")
	MensFecha()
	return
endif
if !UsaArquivo("RECEBER")
	MensFecha()
	return
endif
if !UsaArquivo("FORMA")
	MensFecha()
	return
endif
if !UsaArquivo("REGIAO")
	MensFecha()
	return
endif
if !UsaArquivo("SAIDAS")
	MensFecha()
	return
endif
if !UsaArquivo("NOTA")
	MensFecha()
	return
endif
return

Proc RelSaldos()
****************
LOCAL cScreen := SaveScreen()
LOCAL Tam	  := 80
LOCAL Col	  := 59
LOCAL Pagina  := 0
LOCAL nTotal  := 0
LOCAL lDesativados
FIELD CodiVen
FIELD Nome
FIELD ComBloq
FIELD ComDisp
FIELD Comissao

ErrorBeep()
lDesativados := Conf("Pergunta: Imprimir Desativados ?")
if !Instru80()
	ResTela( cScreen )
	return
endif
Area( "Vendedor")
Vendedor->( Order( VENDEDOR_CODIVEN ))
DbGoTop()
Mensagem( "Aguarde, Imprimindo.")
PrintOn()
SetPrc( 0, 0 )
While !Eof() .AND. REL_OK()
	if Col >=  58
		Write( 00, 00, Padr( "Pagina N§ " + StrZero( ++Pagina,3 ), ( Tam/2 ) ) + Padl( Time(), ( Tam/2 ) ) )
		Write( 01, 00, Date() )
		Write( 02, 00, Padc( XNOMEFIR, Tam ) )
		Write( 03, 00, Padc( SISTEM_NA6, Tam ) )
		Write( 04, 00, Padc( "SALDO VENDEDORES", Tam ) )
		Write( 05, 00, Repl( SEP, Tam ) )
		Write( 06, 00,"CODI VENDEDOR                                  BLOQUEADA DISPONIVEL      TOTAL")
		Write( 07, 00, Repl( SEP, Tam ) )
		Col := 8
	endif
	if lDesativados = FALSO
		if Rol = OK
			DbSkip(1)
			Loop
		endif
	endif
	Qout( Codiven, Nome, Tran( ComBloq, "@E 999,999.99" ), Tran( ComDisp, "@E 999,999.99" ), Tran( Comissao, "@E 999,999.99" ))
	Col++
	nTotal += Comissao
	DbSkip(1)
	if Eof()
		Qout("")
		Qout( "*** Total Geral *** ")
		QQout( Space(44) + Tran( nTotal, "@E 999,999,999.99" ))
	endif
	if Col >= 58
		Col := 8
		__Eject()
	endif
EndDo
__Eject()
PrintOff()
ResTela( cScreen )
return

*:---------------------------------------------------------------------------------------------------------------------------------
Proc SaldoConsulta()
********************
LOCAL Arq_Ant	 := Alias()
LOCAL Ind_Ant	 := IndexOrd()
LOCAL cScreen	 := SaveScreen()
LOCAL oBrowse	 := MsBrowse():New()
LOCAL xTemp 	 := FTempName()
LOCAL cCaixa	 := ""
LOCAL cVendedor := ""
LOCAL aStruct

oMenu:Limpa()
Area("Vendedor")
if !VerSenha( @cCaixa, @cVendedor )
	ResTela( cScreen )
	AreaAnt( Arq_Ant, Ind_Ant )
	return
endif
aStruct := Vendedor->(DbStruct())
DbCreate( xTemp, aSTruct )
Use ( xTemp ) Alias xVendedor Exclusive New
xVendedor->(DbAppend())
For nField := 1 To FCount()
	xVendedor->(FieldPut( nField, Vendedor->(FieldGet( nField ))))
Next
oBrowse:Add( "CODIGO",     "CodiVen")
oBrowse:Add( "NOME",       "Nome")
oBrowse:Add( "DISPONIVEL", "ComDisp")
oBrowse:Add( "BLOQUEADA",  "ComBloq")
oBrowse:Add( "TOTAL",      "Comissao")
oBrowse:Titulo   := "CONSULTA DE COMISSOES"
oBrowse:PreDoGet := {|| ( ErrorBeep(), Alerta("Erro: Alteracao nao permitida"), FALSO ) } // Rotina do Usuario Antes de Atualizar
oBrowse:PreDoDel := {|| ( ErrorBeep(), Alerta("Erro: Exclusao nao permitida"), FALSO ) } // Rotina do Usuario Antes de Atualizar
oBrowse:PosDoGet := NIL
oBrowse:PosDoDel := NIL
oBrowse:Show()
oBrowse:Processa()
xVendedor->(DbCloseArea())
Ferase( xTemp )
AreaAnt( Arq_Ant, Ind_Ant )
ResTela( cScreen )

*:---------------------------------------------------------------------------------------------------------------------------------

Proc AlteraDebCre()
*******************
LOCAL Arq_Ant	 := Alias()
LOCAL Ind_Ant	 := IndexOrd()
LOCAL cScreen	 := SaveScreen()
LOCAL oBrowse	 := MsBrowse():New()

oMenu:Limpa()
Area("Vendemov")
oBrowse:Add( "CODIGO",     "CodiVen")
oBrowse:Add( "DOCTO N§",   "Docnr")
oBrowse:Add( "DATA",       "Data")
oBrowse:Add( "D/C",        "Dc")
oBrowse:Add( "VALOR",      "Vlr")
oBrowse:Add( "DESCRICAO",  "Descricao")
oBrowse:Titulo   := "CONSULTA/ALTERACAO DE DEBITO/CREDITO"
oBrowse:PreDoGet := NIL
oBrowse:PreDoDel := NIL
oBrowse:PosDoGet := NIL
oBrowse:PosDoDel := NIL
oBrowse:Show()
oBrowse:Processa()
ResTela( cScreen )

*:==================================================================================================================================

Proc DemosPagar()
*****************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen( )
LOCAL aMenu   := {" Individual ", " Parcial ", " Por Forma Pagto", " Geral " }
LOCAL nChoice
LOCAL dIni
LOCAL dFim
LOCAL cCodi
LOCAL oBloco
LOCAL oSkipper

WHILE OK
	oMenu:Limpa()
	M_Title("DEMOSTRATIVO COMISSOES A PAGAR")
	nChoice := FazMenu( 07, 20, aMenu, Cor())
	Do Case
	Case nChoice = 0
		ResTela( cScreen )
		Exit

	Case nChoice = 1
		cCodi := Space( 4 )
		dFim	:= Date()
		dIni	:= Date() - Day( Date() ) + 1
		MaBox( 15, 20, 19, 46 )
		@ 16, 21 Say "Vendedor......:" Get cCodi Pict "9999" Valid FunErrado( @cCodi )
		@ 17, 21 Say "Data Inicial..:" Get dIni Pict "##/##/##"
		@ 18, 21 Say "Data Final....:" Get dFim Pict "##/##/##"
		Read
		if LastKey( ) = ESC
			ResTela( cScreen )
			Loop
		endif
		Area( "VendeMov" )
		Vendemov->(Order( VENDEMOV_CODIVEN ))
		if Vendemov->(!DbSeek( cCodi ))
			ErrorBeep()
			Nada()
			Loop
		endif
		Receber->( Order( RECEBER_CODI ))
		Vendedor->( Order( VENDEDOR_CODIVEN ))
		Set Rela To Vendemov->Codiven Into Vendedor, Vendemov->Codi Into Receber
		oBloco	:= {|| Vendemov->CodiVen = cCodi }
		oSkipper := {|| Vendemov->Data >= dIni .AND. Vendemov->Data <= dFim }
		DemosImp( dIni, dFim, oBloco, oSkipper )

	Case nChoice = 2
		cCodi 	:= Space(04)
		cCodifim := Space(04)
		dFim		:= Date()
		dIni		:= Date() - Day( Date() ) + 1
		MaBox( 15, 20, 20, 48 )
		@ 16, 21 Say "Vendedor Inicial.:" Get cCodi    Pict "9999" Valid FunErrado( @cCodi )
		@ 17, 21 Say "Vendedor Final...:" Get cCodifim Pict "9999" Valid FunErrado( @cCodifim )
		@ 18, 21 Say "Data Inicial.....:" Get dIni     Pict "##/##/##"
		@ 19, 21 Say "Data Final.......:" Get dFim     Pict "##/##/##"
		Read
		if LastKey( ) = ESC
			ResTela( cScreen )
			Loop
		endif
		lEncontrou := FALSO
		Vendedor->(Order( VENDEDOR_CODIVEN ))
		Vendedor->(DbSeek( cCodi ))
		Area( "VendeMov" )
		Vendemov->(Order( VENDEMOV_CODIVEN ))
		While Vendedor->CodiVen >= cCodi .AND. Vendedor->CodiVen <= cCodifim
			cCodi := Vendedor->CodiVen
			if Vendemov->(DbSeek( cCodi ))
				lEncontrou := OK
				Exit
			endif
			Vendedor->(DbSkip(1))
		EndDo
		if !lEncontrou
			ResTela( cScreen )
			Nada()
			Loop
		endif
		Receber->( Order( RECEBER_CODI ))
		Vendedor->( Order( VENDEDOR_CODIVEN ))
		Set Rela To Vendemov->Codiven Into Vendedor, Vendemov->Codi Into Receber
		oBloco	:= {|| Vendemov->CodiVen >= cCodi .AND. Vendemov->CodiVen <= cCodifim }
		oSkipper := {|| Vendemov->Data >= dIni .AND. Vendemov->Data <= dFim }
		DemosImp( dIni, dFim, oBloco, oSkipper )

	Case nChoice = 3
		cCodi 	:= Space(04)
		cForma	:= Space(02)
		dFim		:= Date()
		dIni		:= Date() - Day( Date() ) + 1
		MaBox( 15, 20, 20, 48 )
		@ 16, 21 Say "Vendedor.........:" Get cCodi    Pict "9999" Valid FunErrado( @cCodi ) .AND. VerMovimento( @cCodi )
		@ 17, 21 Say "Forma............:" Get cForma   Pict "99" Valid FormaErrada( @cForma )
		@ 18, 21 Say "Data Inicial.....:" Get dIni     Pict "##/##/##"
		@ 19, 21 Say "Data Final.......:" Get dFim     Pict "##/##/##"
		Read
		if LastKey( ) = ESC
			ResTela( cScreen )
			Loop
		endif
		Area( "VendeMov" )
		Vendemov->(Order( VENDEMOV_CODIVEN ))
		if Vendemov->(!DbSeek( cCodi ))
			ResTela( cScreen )
			Nada()
			Loop
		endif
		Receber->( Order( RECEBER_CODI ))
		Vendedor->( Order( VENDEDOR_CODIVEN ))
		Set Rela To Vendemov->Codiven Into Vendedor, Vendemov->Codi Into Receber
		oBloco	:= {|| Vendemov->CodiVen = cCodi }
		oSkipper := {|| Vendemov->Data >= dIni .AND. Vendemov->Data <= dFim .AND. Vendemov->Forma = cForma }
		DemosImp( dIni, dFim, oBloco, oSkipper )

	Case nChoice = 4
		dFim := Date()
		dIni := Date() - Day( Date() ) + 1
		MaBox( 15, 20, 18, 46 )
		@ 16, 21 Say "Data Inicial..:" Get dIni Pict "##/##/##"
		@ 17, 21 Say "Data Final....:" Get dFim Pict "##/##/##"
		Read
		if LastKey( ) = ESC
			ResTela( cScreen )
			Loop
		endif
		Area( "VendeMov" )
		Vendemov->(Order( VENDEMOV_CODIVEN ))
		Vendemov->(DbGoTop())
		if Vendemov->(Eof())
			ErrorBeep()
			Nada()
			Loop
		endif
		Receber->( Order( RECEBER_CODI ))
		Vendedor->( Order( VENDEDOR_CODIVEN ))
		Set Rela To Vendemov->Codiven Into Vendedor, Vendemov->Codi Into Receber
		oBloco	:= {|| Vendemov->(!Eof()) }
		oSkipper := {|| Vendemov->Data >= dIni .AND. Vendemov->Data <= dFim }
		DemosImp( dIni, dFim, oBloco, oSkipper )
	EndCase
	VendeMov->( DbClearRel())
	VendeMov->( DbClearFilter())
	VendeMov->( DbGoTop())
EndDo

*:==================================================================================================================================

Proc FunRePagar()
*****************
LOCAL cScreen	 := SaveScreen()
LOCAL xAlias	  := TempNew()
LOCAL xNtx		  := TempNew()
LOCAL nConta	  := 0
LOCAL aMenuArray := {"Individual", "Parcial", "Por Forma Pgto", "Geral"}
LOCAL Opcao

WHILE OK
	M_Title("ROL COMISSOES A PAGAR")
	Opcao := FazMenu( 07, 20, aMenuArray, Cor())
	Do Case
	Case Opcao = 0
		ResTela( cScreen )
		Exit

	Case Opcao = 1
		MaBox( 15, 20, 19, 44 )
		cCodiIni := Space( 4 )
		dIni		:= Date() - Day( Date()) + 1
		dFim		:= Date()
		@ 16, 21 Say "Vendedor.....:" Get cCodiIni Pict "9999" Valid FunErrado( @cCodiIni ) .AND. VerMovimento( @cCodiIni )
		@ 17, 21 Say "Data Inicial.:" Get dIni Pict "##/##/##"
		@ 18, 21 Say "Data Final...:" Get dFim Pict "##/##/##"
		Read
		if LastKey( ) = ESC
			ResTela( cScreen )
			Loop
		endif
		Area("Vendemov")
		Vendemov->(Order( VENDEMOV_CODIVEN ))
		if Vendemov->(!DbSeek( cCodiIni ))
			Nada()
			ResTela( cScreen )
			Loop
		endif
		nConta := 0
		Copy Stru To ( xAlias )
		Use ( xAlias ) Exclusive Alias xTemp New
		Mensagem("Aguarde, Processando.", Cor())
		WHILE Vendemov->Codiven = cCodiIni
			 if Vendemov->Data >= dIni .AND. Vendemov->Data <= dFim .AND. Vendemov->Descricao = ""
				xTemp->(DbAppend())
				For nField := 1 To FCount()
					FieldPut( nField, Vendemov->(FieldGet( nField )))
				Next
				nConta++
			 endif
			 Vendemov->(DbSkip(1))
		EndDo
		Receber->(Order( RECEBER_CODI ))
		Forma->(Order( FORMA_FORMA ))
		Vendedor->(Order( VENDEDOR_CODIVEN ))
		Sele xTemp
		Set Rela To xTemp->Codiven Into Vendedor,;
						xTemp->Forma Into Forma,;
						xTemp->Codi Into Receber
		xTemp->(DbGoTop())
		if nConta = 0
			Nada()
		else
			PagarImp( dIni, dFim )
		endif
		xTemp->(DbClearRel())
		xTemp->(DbGoTop())
		xTemp->(DbCloseArea())
		Ferase( xAlias )
		Ferase( xNtx )
		ResTela( cScreen )

	Case Opcao = 2
		MaBox( 15, 20, 20, 48 )
		cCodiIni := Space( 04 )
		cCodifim := Space( 04 )
		dIni		:= Date() - Day( Date()) + 1
		dFim		:= Date()
		@ 16, 21 Say "Vendedor Inicial.:" Get cCodiIni Pict "9999" Valid FunErrado( @cCodiIni ) .AND. VerMovimento( @cCodiIni )
		@ 17, 21 Say "Vendedor Final...:" Get cCodifim Pict "9999" Valid FunErrado( @cCodifim ) .AND. VerMovimento( @cCodifim )
		@ 18, 21 Say "Data Inicial.....:" Get dIni     Pict "##/##/##"
		@ 19, 21 Say "Data Final.......:" Get dFim     Pict "##/##/##"
		Read
		if LastKey( ) = ESC
			ResTela( cScreen )
			Loop
		endif
		Area("Vendemov")
		Vendemov->(Order( VENDEMOV_CODIVEN ))
		if Vendemov->(!DbSeek( cCodiIni ))
			ResTela( cScreen )
			Nada()
			Loop
		endif
		nConta := 0
		Copy Stru To ( xAlias )
		Use ( xAlias ) Exclusive Alias xTemp New
		Mensagem("Aguarde, Processando.", Cor())
		WHILE Vendemov->Codiven >= cCodiIni .AND. Vendemov->Codiven <= cCodifim
			 if Vendemov->Data >= dIni .AND. Vendemov->Data <= dFim .AND. Vendemov->Descricao = ""
				xTemp->(DbAppend())
				For nField := 1 To FCount()
					FieldPut( nField, Vendemov->(FieldGet( nField )))
				Next
				nConta++
			 endif
			 Vendemov->(DbSkip(1))
		EndDo
		Receber->(Order( RECEBER_CODI ))
		Forma->(Order( FORMA_FORMA ))
		Vendedor->(Order( VENDEDOR_CODIVEN ))
		Sele xTemp
		Set Rela To xTemp->Codiven Into Vendedor,;
						xTemp->Forma Into Forma,;
						xTemp->Codi Into Receber
		xTemp->(DbGoTop())
		if nConta = 0
			Nada()
		else
			PagarImp( dIni, dFim )
		endif
		xTemp->(DbClearRel())
		xTemp->(DbGoTop())
		xTemp->(DbCloseArea())
		Ferase( xAlias )
		Ferase( xNtx )
		ResTela( cScreen )

	Case Opcao = 3
		MaBox( 15, 20, 20, 48 )
		cCodiIni := Space( 04 )
		cForma	:= Space(02)
		dIni		:= Date() - Day( Date()) + 1
		dFim		:= Date()
		@ 16, 21 Say "Vendedor.........:" Get cCodiIni Pict "9999" Valid FunErrado( @cCodiIni ) .AND. VerMovimento( @cCodiIni )
		@ 17, 21 Say "Forma............:" Get cForma   Pict "9999" Valid FormaErrada( @cForma )
		@ 18, 21 Say "Data Inicial.....:" Get dIni     Pict "##/##/##"
		@ 19, 21 Say "Data Final.......:" Get dFim     Pict "##/##/##"
		Read
		if LastKey( ) = ESC
			ResTela( cScreen )
			Loop
		endif
		Area("Vendemov")
		Vendemov->(Order( VENDEMOV_CODIVEN ))
		if Vendemov->(!DbSeek( cCodiIni ))
			ResTela( cScreen )
			Nada()
			Loop
		endif
		nConta := 0
		Copy Stru To ( xAlias )
		Use ( xAlias ) Exclusive Alias xTemp New
		Mensagem("Aguarde, Processando.", Cor())
		WHILE Vendemov->Codiven = cCodiIni
			 if Vendemov->Data >= dIni .AND. Vendemov->Data <= dFim .AND. Vendemov->Forma = cForma .AND. Vendemov->Descricao = ""
				xTemp->(DbAppend())
				For nField := 1 To FCount()
					FieldPut( nField, Vendemov->(FieldGet( nField )))
				Next
				nConta++
			 endif
			 Vendemov->(DbSkip(1))
		EndDo
		Receber->(Order( RECEBER_CODI ))
		Forma->(Order( FORMA_FORMA ))
		Vendedor->(Order( VENDEDOR_CODIVEN ))
		Sele xTemp
		Set Rela To xTemp->Codiven Into Vendedor,;
						xTemp->Forma Into Forma,;
						xTemp->Codi Into Receber
		xTemp->(DbGoTop())
		if nConta = 0
			Nada()
		else
			PagarImp( dIni, dFim )
		endif
		xTemp->(DbClearRel())
		xTemp->(DbGoTop())
		xTemp->(DbCloseArea())
		Ferase( xAlias )
		Ferase( xNtx )
		ResTela( cScreen )

	Case Opcao = 4
		MaBox( 15, 20, 18, 48 )
		dIni		:= Date() - Day( Date()) + 1
		dFim		:= Date()
		@ 16, 21 Say "Data Inicial.....:" Get dIni     Pict "##/##/##"
		@ 17, 21 Say "Data Final.......:" Get dFim     Pict "##/##/##"
		Read
		if LastKey( ) = ESC
			ResTela( cScreen )
			Loop
		endif
		Area("Vendemov")
		Vendemov->(Order( VENDEMOV_CODIVEN ))
		Vendemov->(DbGoTop())
		nConta := 0
		Copy Stru To ( xAlias )
		Use ( xAlias ) Exclusive Alias xTemp New
		Mensagem("Aguarde, Processando.", Cor())
		WHILE Vendemov->(!Eof())
			 if Vendemov->Data >= dIni .AND. Vendemov->Data <= dFim .AND. Vendemov->Descricao = ""
				xTemp->(DbAppend())
				For nField := 1 To FCount()
					FieldPut( nField, Vendemov->(FieldGet( nField )))
				Next
				nConta++
			 endif
			 Vendemov->(DbSkip(1))
		EndDo
		Receber->(Order( RECEBER_CODI ))
		Forma->(Order( FORMA_FORMA ))
		Vendedor->(Order( VENDEDOR_CODIVEN ))
		Sele xTemp
		Set Rela To xTemp->Codiven Into Vendedor,;
						xTemp->Forma Into Forma,;
						xTemp->Codi Into Receber
		xTemp->(DbGoTop())
		if nConta = 0
			Nada()
		else
			PagarImp( dIni, dFim )
		endif
		xTemp->(DbClearRel())
		xTemp->(DbGoTop())
		xTemp->(DbCloseArea())
		Ferase( xAlias )
		Ferase( xNtx )
		ResTela( cScreen )

  EndCase
EndDo

*:==================================================================================================================================

Function oMenuVenlan()
**********************
LOCAL AtPrompt := {}
LOCAL cStr_Get
LOCAL cStr_Sombra

if !aPermissao[SCI_VENDEDORES]
	return( AtPrompt )
endif

if oAmbiente:Get_Ativo
	cStr_Get := "Desativar Get Tela Cheia"
else
	cStr_Get := "Ativar Get Tela Cheia"
endif
if oMenu:Sombra
	cStr_Sombra := "DesLigar Sombra"
else
	cStr_Sombra := "Ligar Sombra"
endif
AADD( AtPrompt, {"Sair",        {"Encerrar Sessao"}})
AADD( AtPrompt, {"Inclusao",    {"Vendedores", "Senha", "Debitos","Creditos"}})
AADD( AtPrompt, {"Alteracao",   {"Vendedores", "Senha", "Re-Lancamento Parcial de Comissoes", "Re-Lancamento Geral de Comissoes", "Ajustar Saldo de Comissoes", "Limpar Comissao", "Debitos", "Creditos"}})
AADD( AtPrompt, {"Exclusao",    {"Vendedores", "Senha"}})
AADD( AtPrompt, {"Consulta",    {"Vendedores", "Saldos", "Debitos","Creditos"}})
AADD( AtPrompt, {"Relatorios",  {"Comissoes a Pagar","Demostrativo de Comissoes","Relatorios Vendas","Relatorios de Debitos","Relatorios de Creditos","Relatorio de Vendedores","Saldos Vendedores"}})
AADD( AtPrompt, {"Help",        {"Help"}})
return( AtPrompt )

*==================================================================================================================================

Function aDispVenlan()
**********************
LOCAL oVenlan	:= TIniNew( oAmbiente:xUsuario + ".INI")
LOCAL AtPrompt := oMenuVenlan()
LOCAL nMenuH   := Len(AtPrompt)
LOCAL aDisp 	:= Array( nMenuH, 22 )
LOCAL aMenuV   := {}

if !aPermissao[SCI_VENDEDORES]
	return( aDisp )
endif

Mensagem("Aguarde, Verificando Diretivas do CONTROLE DE VENDEDORES.")
return( aDisp := ReadIni("venlan", nMenuH, aMenuV, AtPrompt, aDisp, oVenLan))

*==================================================================================================================================

Proc PagarImp( dIni, dFim )
***************************
LOCAL cScreen := SaveScreen()
LOCAL lResumo := FALSO
LOCAL nAtraso := 0

oMenu:Limpa()
lResumo := Conf("Pergunta: Imprimir somente Resumo ?")
if !Instru80() .OR. !LptOk()
	ResTela( cScreen )
	return
endif
Mensagem("Aguarde, Imprimindo.", Cor())
Tam			  := 132
Col			  := 59
Pagina		  := 00
NovoCodiVen   := OK
UltCodiVen	  := CodiVen
nTotalComis   := 0
nTotalValor   := 0
nSubTComis	  := 0
nSubVlr		  := 0
nGeralComis   := 0
nGeralValor   := 0
nParcial 	  := 0
nGeral		  := 0
nTotal		  := 0

lSair 		  := FALSO
cIni			  := Dtoc( dIni )
cFim			  := Dtoc( dFim )

AbreSpooler()
PrintOn()
FPrint( PQ )
WHILE !Eof() .AND. REL_OK()
	if Col >=  57
		Write( 00, 00, Padr( "Pagina N§ " + StrZero( ++Pagina,3 ), ( Tam/2 ) ) + Padl( Time(), ( Tam/2 ) ) )
		Write( 01, 00, Date() )
		Write( 02, 00, Padc( XNOMEFIR, Tam ) )
		Write( 03, 00, Padc( SISTEM_NA6, Tam ) )
		Write( 04, 00, Padc( "RELATORIO DE COMISSOES A PAGAR REF. &cIni. A &cFim.", Tam ) )
		Write( 05, 00, Repl( SEP, Tam ) )
		Write( 06, 00, "NOME DO CLIENTE                           EMISSAO  VENCTO ATRAS  N§ DOCTO  FATURA   CP    VLR FATURA  PERC   COM. TOTAL COM.LIBERADA")
		Write( 07, 00, Repl( SEP, Tam ) )
		Col := 08
	endif
	if NovoCodiVen .OR. Col = 08
		if NovoCodiVen
			NovoCodiVen := FALSO
		endif
		if !lResumo
			if Col != 08
				Qout()
				Col++
			endif
			Qout( "VENDEDOR : " + CodiVen + " " + Vendedor->Nome )
			Qout()
			Col += 2
		endif
	endif
	nComis		:= xTemp->Comdisp
	nComisTotal := Round(( xTemp->Porc * xTemp->Vlr ) / 100, 2)
	if Empty( Vcto )
		nAtraso := 0
	else
		nAtraso := ( Vcto - Data )
	endif
	if !lResumo
		Qout( Receber->Nome, Data, Vcto, Tran( nAtraso, '9999'), Docnr, Fatura, Forma->Forma, Tran( Vlr, "@E 99,999,999.99"), ;
				Porc, Tran( nComisTotal, "@E 9,999,999.99" ),;
				Tran( nComis, "@E 9,999,999.99" ))
		Col++
	endif
	nTotalComis += nComis
	nGeralComis += nComis
	nTotalValor += Vlr
	nGeralValor += Vlr
	nGeral		+= nComisTotal
	nTotal		+= nComisTotal
	UltCodiVen	:= CodiVen
	cNome 		:= Vendedor->Nome
	DbSkip(1)
	if UltCodiVen != CodiVen
		NovoCodiVen := OK
		if !lResumo
			Qout()
			Qout("*** Total Vendedor *** ")
			QQout( Space(64))
			QQout( Tran( nTotalValor, "@E 99,999,999.99" ) )
			QQout( Space(07))
			QQout( Tran( nTotal, 	  "@E 9,999,999.99" ) )
			QQout( Space(01))
			QQout( Tran( nTotalComis, "@E 9,999,999.99" ) )
		else
			Qout( cNome )
			QQout( Space(47))
			QQout( Tran( nTotalValor, "@E 99,999,999.99" ) )
			QQout( Space(07))
			QQout( Tran( nTotal, 	  "@E 9,999,999.99" ) )
			QQout( Space(01))
			QQout( Tran( nTotalComis, "@E 9,999,999.99" ) )
		endif
		nTotalValor := 0
		nTotal		:= 0
		nTotalComis := 0
		Col++
	endif
	if Col >= 57
		__Eject()
	endif
EndDo
if nGeralValor != 0
	Qout("***  Total Geral   *** ")
	QQout( Space(64))
	Qqout( Tran( nGeralValor, "@E 99,999,999.99" ) )
	QQout( Space(07))
	Qqout( Tran( nGeral, 	  "@E 9,999,999.99" ) )
	QQout( Space(01))
	Qqout( Tran( nGeralComis, "@E 9,999,999.99" ) )
  __Eject()
endif
PrintOff()
ResTela( cScreen )
return

Proc DemosImp( dIni, dFim, oBloco, oSkipper )
*********************************************
LOCAL cScreen			:= SaveScreen()
LOCAL nCop				:= 1
LOCAL nTotalDebitos	:= 0
LOCAL nTotalCreditos := 0
LOCAL Tam				:= 132
LOCAL Col				:= 59
LOCAL Pagina			:= 0
LOCAL NovoCodiVen 	:= OK
LOCAL UltCodiVen		:= CodiVen
LOCAL nTotalComis 	:= 0
LOCAL nTotalValor 	:= 0
LOCAL nPrVlr			:= 0
LOCAL i					:= 1
LOCAL nDebitos 		:= 0
LOCAL nCreditos		:= 0
LOCAL nValor			:= 0
LOCAL cStr0 			:= ""
LOCAL cStr1 			:= ""
LOCAL cStr2 			:= ""
LOCAL nLiquido 		:= 0
LOCAL nComDisp 		:= 0
LOCAL nComBloq 		:= 0
LOCAL nComissao		:= 0
LOCAL nGdVlr			:= 0
LOCAL nGdComissao 	:= 0
LOCAL NPrComissao 	:= 0
LOCAL nGdComBloq		:= 0
LOCAL nPrComBloq		:= 0
LOCAL nGdComDisp		:= 0
LOCAL nPrComDisp		:= 0
LOCAL nGdDebitos		:= 0
LOCAL nPrDebitos		:= 0
LOCAL nGdCreditos 	:= 0
LOCAL nPrCreditos 	:= 0
LOCAL nAtraso			:= 0
FIELD Vlr
FIELD Descricao
FIELD Porc
FIELD Dc
FIELD Data
FIELD CodiVen
FIELD ComDisp
FIELD ComBloq
FIELD Comissao
FIELD Forma
FIELD Regiao

if !Instru80()
	ResTela( cScreen )
	return
endif
Mensagem("Aguarde, Imprimindo")
PrintOn()
FPrint( PQ )
While Eval( oBloco ) .AND. Rel_Ok()
	if Col >=  58
		Write( 00, 00, Linha1( Tam, @Pagina))
		Write( 01, 00, Linha2())
		Write( 02, 00, Linha3(Tam))
		Write( 03, 00, Linha4(Tam, SISTEM_NA6 ))
		Write( 04, 00, Padc( "DEMOSTRATIVO DAS COMISSOES REF. " + DToc( dIni ) + " A " + DToc( dFim ), Tam ) )
		Write( 05, 00, Linha5(Tam))
		Write( 06, 00,"CLIENTE/HISTORICO        DATA     VCTO ATR  FATURA    N§ DOCTO FP RG  PERC  VLR FATU  COMISSAO  COM.BLOQ  COM.DISP CREDITOS   ADIANT")
		Write( 07, 00, Repl( SEP, Tam ) )
		Col := 8
	endif
	if Eval( oSkipper )
		if Col = 8
			Write( 08, 00, NG + "VENDEDOR : " + CodiVen + " " + Vendedor->Nome + NR )
			Qout()
			Col := 10
		endif
		if NovoCodiVen
			NovoCodiVen 	:= FALSO
			nGdVlr			:= 0
			nPrVlr			:= 0
			nGdComissao 	:= 0
			NPrComissao 	:= 0
			nGdComBloq		:= 0
			nPrComBloq		:= 0
			nGdComDisp		:= 0
			nPrComDisp		:= 0
			nGdDebitos		:= 0
			nPrDebitos		:= 0
			nGdCreditos 	:= 0
			nPrCreditos 	:= 0
		endif
		nComissao := 0
		nComDisp  := 0
		nComBloq  := 0
		nDebitos  := 0
		nCreditos := 0
		if Empty( Descricao )
			cStr0 	 := Left( Receber->Nome, 20 )
			cStr1 	 := Vendemov->Fatura
			cStr2 	 := Vendemov->Docnr
			nComissao := Vendemov->Comissao
			nComDisp  := Vendemov->ComDisp
			nComBloq  := Vendemov->ComBloq
		else
			cStr0 	 := Left( Vendemov->Descricao, 20 )
			cStr1 	 := Vendemov->Fatura
			cStr2 	 := Vendemov->Docnr
			if Dc = "D"
				nDebitos  := Vlr
			else
				nCreditos := Vlr
			endif
		endif
		if Empty( Vendemov->Vcto )
			nAtraso := 0
		else
			nAtraso := ( Vendemov->Vcto - Vendemov->Data )
		endif
		Qout( cStr0, Data, Vcto, Tran( nAtraso,'999'), cStr1, cStr2, Forma, Regiao, Porc,;
				Tran( Vlr,			 "@E 99,999.99"),;
				Tran( nComissao,	 "@E 99,999.99"),;
				Tran( nComBloq,	 "@E 99,999.99"),;
				Tran( nComDisp,	 "@E 99,999.99"),;
				Tran( nCreditos,	 "@E 9,999.99"),;
				Tran( nDebitos,	 "@E 9,999.99") )
		nGdVlr		+= Vlr
		nPrVlr		+= Vlr
		nGdComissao += nComissao
		nPrComissao += nComissao
		nGdComBloq	+= nComBloq
		nPrComBloq	+= nComBloq
		nGdComDisp	+= nComDisp
		nPrComDisp	+= nComDisp
		nGdDebitos	+= nDebitos
		nPrDebitos	+= nDebitos
		nGdCreditos += nCreditos
		nPrCreditos += nCreditos
		Col++
	endif
	UltCodiVen := CodiVen
	DbSkip(1)
	if Col = 55 .OR. UltCodiVen != CodiVen
		if nPrVlr != 0
			Qout( Repl( SEP, Tam ))
			Qout( "** SubTotal **", Space(58),;
			Tran( nPrVlr,		 "@E 999,999.99"),;
			Tran( nPrComissao, "@E 99,999.99"),;
			Tran( nPrComBloq,  "@E 99,999.99"),;
			Tran( nPrComDisp,  "@E 99,999.99"),;
			Tran( nPrCreditos, "@E 9,999.99"),;
			Tran( nPrDebitos,  "@E 9,999.99"))
			nPrVlr			:= 0
			nPrComissao 	:= 0
			nPrComBloq		:= 0
			nPrComDisp		:= 0
			nPrDebitos		:= 0
			nPrCreditos 	:= 0
			nLiquido 		:= ( nGdComissao + nGdCreditos ) - nGdDebitos
			Col ++
			Col ++
		endif
		if UltCodiVen != CodiVen
			NovoCodiVen := OK
			if nGdVlr != 0
				Qout( "** Total **", Space(61), ;
				Tran( nGdVlr,		 "@E 999,999.99"),;
				Tran( nGdComissao, "@E 99,999.99"),;
				Tran( nGdComBloq,  "@E 99,999.99"),;
				Tran( nGdComDisp,  "@E 99,999.99"),;
				Tran( nGdCreditos, "@E 9,999.99"),;
				Tran( nGdDebitos,  "@E 9,999.99"))
				Qout( "** Liquido **", Space(107),;
				Tran( nLiquido,		"@E 999,999.99"))
				Col ++
				Col ++
				Col := 58
			endif
		endif
		if Col >= 55
			Col := 58
		  __Eject()
		endif
	endif
EndDo
PrintOff()
ResTela( cScreen )
return

Proc VarreParcial()
*******************
LOCAL cScreen		:= SaveScreen()
LOCAL GetList		:= {}
LOCAL nComissao	:= 0
LOCAL nDebito		:= 0
LOCAL nCredito 	:= 0
LOCAL nComis_Bloq := 0
LOCAL nComis_Disp := 0
LOCAL nChoice		:= 0
LOCAL cCodiVen 	:= Space(4)
LOCAL cFatura		:= ''
LOCAL nConta
LOCAL nRecno
LOCAL dIni
LOCAL dFim
LOCAL oBloco
LOCAL oDados

oMenu:Limpa()
dIni := Date() - 30
dFim := Date()
MaBox( 10, 10, 13, 40 )
@ 11, 11 Say "Data Inicial.:" Get dIni Pict "##/##/##"
@ 12, 11 Say "Data Final...:" Get dFim Pict "##/##/##"
Read
if LastKey( ) = ESC
	ResTela( cScreen )
	return
endif
ErrorBeep()
if !Conf("Pergunta: Confirma o ajuste das comissoes?")
	ResTela( cScreen )
	return
endif
nComissao	:= 0
nDebito		:= 0
nCredito 	:= 0
nComis_Bloq := 0
nComis_Disp := 0
oBloco		:= {|| Nota->Data >= dIni .AND. Nota->Data <= dFim .AND. Rel_Ok() }
oDados		:= {|| Saidas->Data != Vendemov->Data .AND. Saidas->Codiven != Vendemov->CodiVen .OR. Saidas->VlrFatura != Vendemov->Vlr }
oMenu:Limpa()
Saidas->(Order( SAIDAS_FATURA ))
Vendemov->(Order( VENDEMOV_FATURA ))
Area("Nota")
Nota->(Order( NOTA_DATA ))
if Nota->(DbSeek( dIni, OK ))
	While Nota->(Eval( oBloco ))
		Mensagem("Aguarde, Ajustando comissoes. Passo #1")
		cFatura := Nota->Numero
		if Vendemov->(DbSeek( cFatura ))
			Mensagem("Aguarde, Ajustando comissoes. Passo #2")
			nConta := 0
			While Vendemov->Fatura = cFatura
				if nConta > 1 // Fatura dupla?
					if Vendemov->(Travareg())
						Vendemov->(DbDelete())
						Vendemov->(Libera())
						Vendemov->(DbSkip(1))
						Loop
					endif
				endif
				if Saidas->(DbSeek( cFatura ))
					if Empty( Saidas->Codiven )
						if Vendemov->(Travareg())
							Vendemov->(DbDelete())
							Vendemov->(Libera())
							Vendemov->(DbSkip(1))
							Loop
						endif
					endif
					if Eval( oDados )
						Mensagem("Aguarde, Ajustando comissoes. Passo #3")
						if Vendemov->(Travareg())
							Vendemov->CodiVen  := Saidas->Codiven
							Vendemov->Codi 	 := Saidas->Codi
							Vendemov->Vlr		 := Saidas->VlrFatura
							Vendemov->Fatura	 := Saidas->Fatura
							Vendemov->Docnr	 := Saidas->Fatura
							Vendemov->Data 	 := Saidas->Data
							Vendemov->Porc 	 := Saidas->Porc
							Vendemov->Comissao := Round(( Saidas->Vlrfatura * Saidas->Porc ) / 100,2)
							Vendemov->Pedido	 := Saidas->Fatura
							Vendemov->Dataped  := Saidas->Data
							Vendemov->Forma	 := Saidas->Forma
							Vendemov->Regiao	 := Saidas->Regiao
							Vendemov->ComBloq  := 0
							Vendemov->ComDisp  := 0
							Vendemov->(Libera())
						endif
					endif
				endif
				nConta ++
				Vendemov->(DbSkip(1))
			EndDo
		else
			if Saidas->(DbSeek( cFatura ))
				if !Empty( Saidas->Codiven )
					Mensagem("Aguarde, Ajustando comissoes. Passo #4")
					if Vendemov->(Incluiu())
						Vendemov->CodiVen  := Saidas->Codiven
						Vendemov->Codi 	 := Saidas->Codi
						Vendemov->Vlr		 := Saidas->VlrFatura
						Vendemov->Fatura	 := Saidas->Fatura
						Vendemov->Docnr	 := Saidas->Fatura
						Vendemov->Data 	 := Saidas->Data
						Vendemov->Porc 	 := Saidas->Porc
						Vendemov->Comissao := Round(( Saidas->Vlrfatura * Saidas->Porc ) / 100,2)
						Vendemov->Pedido	 := Saidas->Fatura
						Vendemov->Dataped  := Saidas->Data
						Vendemov->Forma	 := Saidas->Forma
						Vendemov->Regiao	 := Saidas->Regiao
						Vendemov->ComBloq  := 0
						Vendemov->ComDisp  := 0
						Vendemov->(Libera())
					endif
				endif
			endif
		endif
		Nota->(DbSkip(1))
	EndDo
endif

Proc VarreGeral( lSim)
**********************
LOCAL cScreen		:= SaveScreen()
LOCAL GetList		:= {}
LOCAL cFatura		:= ''
LOCAL nConta
LOCAL nRecno

if lSim = NIL
   oMenu:Limpa()
   ErrorBeep()
   if !Conf("Pergunta: A tarefa pode ser extremamente demorada. Continuar ?")
      ResTela( cScreen )
      return
   endif
endif
oMenu:Limpa()
Area("Vendemov")
if Vendemov->(!TravaArq())
	ErrorBeep()
	Alerta("Erro: Nao consigo travar o arquivo de comissoes.")
	Restela( cScreen )
	return
endif
oMenu:Limpa()
ErrorBeep()
Mensagem("Aguarde, Preparando Arquivo. Passo #1 de 3")
//Vendemov->(DbEval( {|| _Field->Vendemov->Dc := "C"}, {|| Right( Vendemov->Docnr, 2) <> Space(02)},,,, .F. ))
ErrorBeep()
Mensagem("Aguarde, Preparando Arquivo. Passo #2 de 3")
Vendemov->(DbEval( {|| dbDelete()}, {|| Empty( Vendemov->Dc )},,,, .F. ))
Vendemov->(Libera())
Vendemov->(Order( VENDEMOV_FATURA ))
Saidas->(Order( SAIDAS_FATURA ))
Area("Nota")
Nota->(Order( NOTA_NUMERO ))
Nota->(DbGoTop())
oMenu:Limpa()
ErrorBeep()
Mensagem("Aguarde, Re-Lancando comissoes. Passo #3 de 3")
While Nota->(!Eof())
	cFatura := Nota->Numero
	if Saidas->(DbSeek( cFatura ))
		if !Empty( Saidas->Codiven )
			if Vendemov->(Incluiu())
				Vendemov->CodiVen  := Saidas->Codiven
				Vendemov->Codi 	 := Saidas->Codi
				Vendemov->Vlr		 := Saidas->VlrFatura
				Vendemov->Fatura	 := Saidas->Fatura
				Vendemov->Docnr	 := Saidas->Fatura
				Vendemov->Data 	 := Saidas->Data
				Vendemov->Porc 	 := Saidas->Porc
				Vendemov->Comissao := Round(( Saidas->Vlrfatura * Saidas->Porc ) / 100,2)
				Vendemov->Pedido	 := Saidas->Fatura
				Vendemov->Dataped  := Saidas->Data
				Vendemov->Forma	 := Saidas->Forma
				Vendemov->Regiao	 := Saidas->Regiao
				Vendemov->ComBloq  := 0
				Vendemov->ComDisp  := 0
				Vendemov->(Libera())
			endif
		endif
	endif
	Nota->(DbSkip(1))
EndDo
oMenu:Limpa()
Alerta('Tarefa efetuada. Se ainda houver problemas,;reconstrua o arquivo NOTA e fa‡a novamente.')

Proc VarreComissao()
********************
LOCAL cScreen := SaveScreen()
LOCAL GetList := {}
LOCAL dIni	  := Date()
LOCAL cCodi   := Space(04)
LOCAL aMenu   := {"Individual", "Geral" }
LOCAL oBloco  := NIL

WHILE OK
	oMenu:Limpa()
	M_Title( "EXCLUSAO DE COMISSOES")
	Choice := FazMenu( 10, 10, aMenu )
	Do Case
	Case Choice = 0
		ResTela( cScreen )
      return

	Case Choice = 1
		MaBox( 16, 10, 19, 76 )
		@ 17, 11 Say "Vendedor.........:" Get cCodi Pict "@!" Valid FunErrado( @cCodi, NIL, Row(), Col()+1 )
		@ 18, 11 Say "Limpar at‚ o dia.:" Get dIni  Pict "##/##/##"
		Read
		if LastKey() = ESC
			ResTela( cScreen )
			return
		endif
		oBloco := {|| Saidas->Codiven = cCodi .AND. Saidas->Emis <= dIni}
      Exit
	Case Choice = 2
		MaBox( 16, 10, 18, 76 )
		@ 17, 11 Say "Limpar at‚ o dia.:" Get dIni  Pict "##/##/##"
		Read
		if LastKey() = ESC
			ResTela( cScreen )
			return
		endif
      oBloco := {|| Saidas->Emis <= dIni }
      Exit
	EndCase
EndDo
ErrorBeep()
if !Conf("Pergunta: A tarefa pode ser extremamente demorada. Continuar ?")
	ResTela( cScreen )
	return
endif
oMenu:Limpa()
Area("Saidas")
if Saidas->(!TravaArq())
	ErrorBeep()
	Alerta("Erro: Nao consigo travar o arquivo SAIDAS")
	Restela( cScreen )
	return
endif
ErrorBeep()
Mensagem("Aguarde, Preparando Arquivo. Passo #1 de 1")
DBEval( {|| _FIELD->saidas->codiven := Space(04), _FIELD->Saidas->Porc := 0}, oBloco,,,, .F. )
VarreGeral( OK )

Proc AjustaComissao()
*********************
LOCAL cScreen		:= SaveScreen()
LOCAL GetList		:= {}
LOCAL aArrayMenu	:= { "Individual", "Geral" }
LOCAL nComissao	:= 0
LOCAL nDebito		:= 0
LOCAL nCredito 	:= 0
LOCAL nComis_Bloq := 0
LOCAL nComis_Disp := 0
LOCAL nChoice		:= 0
LOCAL cCodiVen 	:= Space(4)
LOCAL cFatura		:= ''
LOCAL nRecno
LOCAL oBloco
LOCAL oSkipper

M_Title("AJUSTAR COMISSAO")
nChoice := FazMenu( 10, 10, aArrayMenu, Cor())
if nChoice = 0
	ResTela( cScreen )
	return
elseif nChoice  = 1
	Area("Vendemov")
	Vendemov->(Order( VENDEMOV_CODIVEN_DATA ))
	cCodiVen := Space(4)
	MaBox( 16, 10, 18, 79 )
	@ 17, 11 Say "Codigo.......:" Get cCodiVen Pict "9999" Valid FunErrado( @cCodiven, NIL, Row(), Col()+1 )
	Read
	if LastKey( ) = ESC
		ResTela( cScreen )
		return
	endif
	oMenu:Limpa()
	ErrorBeep()
	if !Conf("Pergunta: Confirma o ajuste da comissao deste vendedor?")
		ResTela( cScreen )
		return
	endif
	nComissao	:= 0
	nDebito		:= 0
	nCredito 	:= 0
	nComis_Bloq := 0
	nComis_Disp := 0
	Mensagem("Aguarde o termino do ajuste individual de comissao.")
	Area("Vendemov")
	Vendemov->(Order( VENDEMOV_CODIVEN ))
	if Vendemov->(DbSeek( cCodiVen ))
		oBloco	 := {|| Vendemov->CodiVen = cCodiven .AND. Vendemov->(!Eof()) .AND. Rel_Ok() }
		nComissao := EvalComissao( cCodiven, oBloco, @nCredito, @nDebito )
	endif
	Recemov->(Order( RECEMOV_CODIVEN ))
	if Recemov->(DbSeek( cCodiVen ))
		While Recemov->CodiVen = cCodiven
			if Recemov->Comissao // Liberar Comissao ?
				nComis_Bloq += Round(( Recemov->Vlr * Recemov->Porc ) / 100,2 )
			endif
			Recemov->(DbSkip(1))
		EndDo
	endif
	Vendedor->(Order( VENDEDOR_CODIVEN ))
	if Vendedor->(DbSeek( cCodiVen ))
		nComissao	:= ((nComissao + nCredito ) - nDebito )
		nComis_Disp := ( nComissao - nComis_Bloq )
		if Vendedor->(TravaReg())
			Vendedor->Comissao := nComissao
			Vendedor->ComBloq  := nComis_Bloq
			Vendedor->ComDisp  := nComis_Disp
			Vendedor->(Libera())
		endif
	endif
	oMenu:Limpa()
	ErrorBeep()
	Alerta('Ajuste individual de Comissao. Tarefa efetuada.')

elseif nChoice = 2
	oMenu:Limpa()
	ErrorBeep()
	if !Conf("Pergunta: Confirma o ajuste geral das comissoes?")
		ResTela( cScreen )
		return
	endif
	Mensagem("Aguarde o termino do ajuste geral das comissoes.")
	Vendedor->(Order( VENDEDOR_CODIVEN ))
	Vendedor->(DbGoTop())
	While Vendedor->(!Eof())
		nComissao	:= 0
		nDebito		:= 0
		nCredito 	:= 0
		nComis_Bloq := 0
		nComis_Disp := 0
		cCodiVen 	:= Vendedor->Codiven
		Vendemov->(Order( VENDEMOV_CODIVEN ))
		if Vendemov->(DbSeek( cCodiVen ))
			oBloco	 := {|| Vendemov->CodiVen = cCodiven .AND. Vendemov->(!Eof()) .AND. Rel_Ok() }
			nComissao := EvalComissao( cCodiven, oBloco, @nDebito, @nCredito )
		endif
		Recemov->(Order( RECEMOV_CODIVEN ))
		if Recemov->(DbSeek( cCodiVen ))
			While Recemov->CodiVen = cCodiven
				if Recemov->Comissao // Liberar Comissao ?
					nComis_Bloq += Round(( Recemov->Vlr * Recemov->Porc ) / 100,2 )
				endif
				Recemov->(DbSkip(1))
			EndDo
		endif
		nComissao	:= ((nComissao + nCredito ) - nDebito )
		nComis_Disp := ( nComissao - nComis_Bloq )
		if Vendedor->(TravaReg())
			Vendedor->Comissao := nComissao
			Vendedor->ComBloq  := nComis_Bloq
			Vendedor->ComDisp  := nComis_Disp
			Vendedor->(Libera())
		endif
		Vendedor->(DbSkip(1))
	EndDo
	oMenu:Limpa()
	ErrorBeep()
	Alerta('Ajuste geral de Comissoes. Tarefa efetuada.')
endif
ResTela( cScreen )
return

Function EvalComissao( cCodiven, oBloco, nCredito, nDebito )
************************************************************
LOCAL nRecno	 := 0
LOCAL nComissao := 0

While Vendemov->Codiven = cCodiven .AND. Eval( oBloco )
	if !Empty( Vendemov->Descricao )
		if Vendemov->Dc = "C"
			nCredito += Vendemov->Vlr
		else
			nDebito	+= Vendemov->Vlr
		endif
	endif
	nComissao += Round(( Vendemov->Vlr * Vendemov->Porc ) / 100,2)
	Vendemov->(DbSkip(1))
EndDo
return( nComissao )
