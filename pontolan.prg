/*
  ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
 İ³																								 ?
 İ³	Modulo.......: PONTOLAN.PRG														 ?
 İ³	Sistema......: CONTROLE DE PONTO								          	    ?
 İ³	Aplicacao....: SCI - SISTEMA COMERCIAL INTEGRADO                      ?
 İ³	Versao.......: 8.5.00							                            ?
 İ³	Programador..: Vilmar Catafesta				                            ?
 İ³   Empresa......: Macrosoft Informatica Ltda                             ?
 İ³	Inicio.......: 12.11.1991 						                            ?
 İ³   Ult.Atual....: 12.04.2018                                             ?
 İ³   Compilador...: Harbour 3.2/3.4                                        ?
 İ³   Linker.......: BCC/GCC/MSCV                                           ?
 İ³	Bibliotecas..:  									                            ?
 İÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
 ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

#include <sci.ch>

*:==================================================================================================================================

Proc PontoLan()
***************
LOCAL Op        := 1
LOCAL lOk		 := OK
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
*:==================================================================================================================================
oMenu:Limpa()
*:==================================================================================================================================
SetaClasse()
WHILE lOk
	BEGIN Sequence
		SetKey( F5, NIL )
		Op 		  := oMenu:Show()
		Do Case
		Case Op = 0.0 .OR. Op = 1.01
			ErrorBeep()
			if Conf("Pergunta: Encerrar este modulo ?")
				lOk := FALSO
				Break
			endif
		Case op = 2.01 ; Servidor()
		Case op = 2.02 ; MoviPonto()
		Case op = 2.03 ; PontoAuto()
		Case op = 3.01 ; AlteraServidor()
		Case op = 3.02 ; MoviDbedit()
		Case op = 3.03 ; AjustaCarga()
		Case op = 4.01 ; AlteraServidor()
		Case op = 4.02 ; MoviDbedit()
		Case op = 5.01 ; AlteraServidor()
		Case op = 5.02 ; MoviDbedit()
		Case op = 6.01 ; ListaServidor()
		Case op = 6.02 ; ListaPonto()
		EndCase
	End Sequence
EndDo
Mensagem("Aguarde, Fechando Arquivos.")
FechaTudo()
return

*:==================================================================================================================================

STATIC Proc SetaClasse()
************************
LOCAL oP 		 := 1
oMenu:Menu		 := oMenuPontolan()
oMenu:Disp		 := aDispPontoLan()
oMenu:Ativo 	 := IF( Int( Op ) <= 0, 1, Int( Op ))
oMenu:StatusSup := SISTEM_NA8 + " " + SISTEM_VERSAO
oMenu:StatusInf := "F1-HELP³F8-SPOOL³F10-CALC³"
Return

*:==================================================================================================================================

Proc AlteraServidor()
*********************
LOCAL Arq_Ant	:= Alias()
LOCAL Ind_Ant	:= IndexOrd()
LOCAL cScreen	:= SaveScreen()
LOCAL oBrowse	:= MsBrowse():New()

oMenu:Limpa()
Area("Servidor")
Servidor->( Order( SERVIDOR_NOME ))
Servidor->(DbGoTop())
oBrowse:Add( "CODIGO",       "Codi",    "9999")
oBrowse:Add( "NOME",         "Nome",    "@!")
oBrowse:Add( "CARGO",        "Cargo",   "@!")
oBrowse:Add( "CARGA HORARIA","Carga",   "999999.99")
oBrowse:Titulo := "CONSULTA/ALTERACAO DE SERVIDORES"
oBrowse:PreDoGet := {|| PreServidor( oBrowse ) }
oBrowse:PosDoGet := {|| PosServidor( oBrowse ) }
oBrowse:PreDoDel := NIL
oBrowse:PosDoDel := NIL
oBrowse:Show()
oBrowse:Processa()
AreaAnt( Arq_Ant, Ind_Ant )
ResTela( cScreen )

Function PreServidor( oBrowse )
*******************************
LOCAL oCol	  := oBrowse:getColumn( oBrowse:colPos )
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()

if !PodeAlterar()
	return( FALSO)
endif
return( OK )

Function PosServidor( oBrowse )
*******************************
LOCAL oCol		 := oBrowse:getColumn( oBrowse:colPos )
LOCAL Arq_Ant	 := Alias()
LOCAL Ind_Ant	 := IndexOrd()
LOCAL Retorno	 := NIL

Do Case
Case oCol:Heading = "SENHA"
	Retorno := AlterarSenha( Servidor->Codi )
	if Retorno != NIL
		if Servidor->(TravaReg())
			Servidor->Senha := Retorno
			Servidor->Atualizado := Date()
		endif
	endif
EndCase
AreaAnt( Arq_Ant, Ind_Ant )
return( OK )

*:==================================================================================================================================

Proc Servidor()
***************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen( )
LOCAL nOpcao
LOCAL cCodi
LOCAL cNome
LOCAL cCargo
LOCAL nCarga
LOCAL cSenha
FIELD Codi

WHILE OK
	oMenu:Limpa()
	Area("Servidor")
	Servidor->(Order( SERVIDOR_CODI ))
	DbGoBottom()
	cCodi  := StrZero(Val( Codi ) + 1, 4 )
	cNome  := Space(40)
	cCargo := Space(30)
	nCarga := 0
	MaBox( 05, 02, 11, 78, "INCLUSAO DE SERVIDORES" )
	@ 06, 03 Say "Codigo......:" Get cCodi  Pict "9999" Valid SerCerto( @cCodi )
	@ 07, 03 Say "Servidor....:" Get cNome  Pict "@!"
	@ 08, 03 Say "Cargo.......:" Get cCargo Pict "@!"
	@ 09, 03 Say "Carga Mensal:" Get nCarga Pict "999999.99"
	@ 10, 03 Say "Senha.......:"
	Read
	if LastKey() = ESC
		ResTela( cScreen )
		Exit
	endif
	cSenha := Senha( 10, 17, 14 )
	ErrorBeep()
	nOpcao := Alerta( "Pergunta: Voce Deseja ?", {" Incluir ", " Alterar ", " Sair "})
	if nOpcao = 1 // Incluir
		if SerCerto( @cCodi )
			if Servidor->(Incluiu())
				 Servidor->Codi  := cCodi
				 Servidor->Nome  := cNome
				 Servidor->Cargo := cCargo
				 Servidor->Carga := nCarga
				 Servidor->Senha := MsEncrypt( cSenha )
				 Servidor->(Libera())
			endif
		endif
	elseif nOpcao = 2  // Alterar
		Loop
	elseif nOpcao = 3  // Sair
		Exit
	endif
EndDo
ResTela( cScreen )
return

*:==================================================================================================================================

Function SenhaServidor( cCodi )
*******************************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen()
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
LOCAL cSenha
LOCAL Passe

Servidor->(Order( SERVIDOR_CODI ))
DbSeek( Servidor->( cCodi ))
WHILE OK
	oMenu:Limpa()
	cSenha := MsDecrypt( Servidor->Senha )
	MaBox( 10, 11, 12, 47 )
	Write( 11, 12, "Senha de acesso..: " )
	Passe  := Senha( 11, 32, 14 )
	if LastKey() = ESC
		AreaAnt( Arq_Ant, Ind_Ant )
		ResTela( cScreen )
		return( FALSO )
	endif
	if !Empty( Passe) .AND. ( AllTrim( cSenha ) == AllTrim( Passe ))
		AreaAnt( Arq_Ant, Ind_Ant )
		ResTela( cScreen )
		return( OK )
	else
		ErrorBeep()
		if Conf("Pergunta: Senha Nao Confere. Novamente ?")
			Loop
		endif
		AreaAnt( Arq_Ant, Ind_Ant )
		ResTela( cScreen )
		return( FALSO )
  endif
EndDo

*:==================================================================================================================================

Function AlterarSenha( cCodi )
******************************
LOCAL GetList	  := {}
LOCAL cScreen	  := SaveScreen()
LOCAL cSenha1
LOCAL cSenha2

oMenu:Limpa()
Servidor->(Order( SERVIDOR_CODI ))
if cCodi = NIL
	MaBox( 00, 10, 04, 50 )
	@ 01, 11 Say "Servidor....: " Get cCodi Pict "@!" Valid UsuarioErrado( @cCodi )
	Read
	if LastKey() = ESC
		ResTela( cScreen )
		return NIL
	endif
endif
if SenhaServidor( cCodi )
	WHILE OK
		MaBox( 00, 10, 04, 50 )
		@	 01, 11 Say "Servidor.............: " + cCodi
		Write( 02, 11, "Nova Senha...........: " )
		Write( 03, 11, "Verificacao de Senha.: " )
		cSenha1 := Senha( 02, 34, 14 )
		cSenha2 := Senha( 03, 34, 14 )
		if LastKey() = ESC
			ResTela( cScreen )
			return NIL
		endif
		if Empty( cSenha1 )
			Loop
		endif
		if cSenha1 == cSenha2
			ResTela( cScreen )
			return( MsEncrypt( cSenha1 ))
		endif
		ErrorBeep()
		if Conf("Erro: Senha nao Confere. Novamente ?")
			Loop
		endif
		ResTela( cScreen )
		return NIL
	EndDo
endif
ResTela( cScreen )
return NIL

*:==================================================================================================================================

Function SerCerto( cCodi )
**************************
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()

if Empty( cCodi )
	ErrorBeep()
	Alerta( "Erro: Codigo Servidor Invalido...")
	return( FALSO )
endif
Area("Servidor")
Servidor->(Order( SERVIDOR_CODI ))
if Servidor->(DbSeek( cCodi ))
	ErrorBeep()
	Alerta( "Erro: Codigo Servidor Registrado.")
	cCodi := StrZero( Val( cCodi ) + 1, 4 )
	AreaAnt( Arq_Ant, Ind_Ant )
	return( FALSO )
endif
AreaAnt( Arq_Ant, Ind_Ant )
return( OK )

*:==================================================================================================================================

Function ServErrado( cCodi, nRow, nCol )
****************************************
LOCAL aRotina := {{|| Servidor() }}
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()

Area("Servidor")
Servidor->(Order( SERVIDOR_CODI ))
if Servidor->(!DbSeek( cCodi ))
	Servidor->( Order( SERVIDOR_NOME ))
	Servidor->(Escolhe( 00, 00, 24, "Codi + ' ' + Nome", "CODI NOME DO SERVIDOR", aRotina ))
endif
cCodi := Servidor->Codi
if nRow != Nil
	Write( nRow, nCol, Servidor->Nome )
endif
AreaAnt( Arq_Ant, Ind_Ant )
return( OK )

*:==================================================================================================================================

Proc ListaServidor()
********************
LOCAL GetList	  := {}
LOCAL cScreen	  := SaveScreen( )
LOCAL aParcial   := { " Geral   ", " Parcial   " }
LOCAL nChoice	  := 0
LOCAL nParcial   := 0
LOCAL cCodiIni   := Space(04)
LOCAL cCodifim   := Space(04)
LOCAL oBloco

WHILE OK
	oMenu:Limpa()
	M_Title("ESC Retorna")
	nParcial := FazMenu( 04, 10, aParcial, Cor())
	Do Case
	Case nParcial = 0
		ResTela( cScreen )
		return

	Case nParcial = 1
		Area("Servidor")
		Servidor->(Order( SERVIDOR_NOME ))
		Servidor->(DbGoTop())
		oBloco := { || Servidor->(!Eof()) }
		PrintServidor( oBloco )

	Case nParcial = 2
		cCodiIni   := Space(4)
		cCodifim   := Space(4)
		MaBox( 10, 10, 13, 79 )
		@ 11, 11 Say 'Codigo Inicial.:' Get cCodiIni Pict '9999' Valid ServErrado( @cCodiIni, Row(), Col()+1 )
		@ 12, 11 Say 'Codigo Final...:' Get cCodifim Pict '9999' Valid ServErrado( @cCodifim, Row(), Col()+1 )
		Read
		if LastKey() = ESC
			Loop
		endif
		Area("Servidor")
		Servidor->(Order( SERVIDOR_CODI ))
		oBloco := { || Servidor->Codi >= cCodiIni .AND. Servidor->Codi <= cCodifim }
		Servidor->(DbSeek( cCodiIni ))
		PrintServidor( oBloco )
	EndCase
EndDo

*:==================================================================================================================================

Proc PrintServidor( oBloco )
****************************
LOCAL cScreen := SaveScreen()
LOCAL Col	  := 9
LOCAL Tam	  := CPI1280
LOCAL cTitulo := "LISTAGEM DE SERVIDORES"
LOCAL Pagina  := 0
FIELD Codi
FIELD Nome
FIELD Cargo
FIELD Carga

if !Instru80()
	ResTela( cScreen )
	return
endif
Mensagem("Aguarde, Imprimindo.")
PrintOn()
FPrint( _CPI12 )
SetPrc( 0, 0 )
Col := 58
WHILE Eval( oBloco ) .AND. Rel_Ok()
	if Col >=  58
		Write( 00, 00, Linha1( Tam, @Pagina))
		Write( 01, 00, Linha2())
		Write( 02, 00, Linha3(Tam))
		Write( 03, 00, Linha4(Tam, SISTEM_NA8 ))
		Write( 04, 00, Padc( cTitulo, Tam ) )
		Write( 05, 00, Linha5(Tam))
		Write( 06, 00, "CODI NOME DO SERVIDOR                         CARGO                         CARGA HORARIA")
		Write( 07, 00, Linha5(Tam))
		Col := 8
	endif
	Qout( Codi, Nome, Cargo, Carga )
	Col++
	DbSkip()
	if Col >= 58 .OR. Eof()
		Write( Col, 0, Repl( SEP, Tam ))
		__Eject()
	endif
EndDo
PrintOff()
ResTela( cScreen )
return

*:==================================================================================================================================

Proc PontoAuto()
****************
LOCAL GetList := {}
LOCAL aMenu   := { "Entrada Manha", "Saida Manha", "Entrada Tarde", "Saida Tarde"}
LOCAL cScreen := SaveScreen( )
LOCAL cString := ""
LOCAL cMovi   := ""
LOCAL nOpcao  := 0
LOCAL nChoice := 0
LOCAL cCodi   := Space(04)
LOCAL dData   := Date()

WHILE OK
	oMenu:Limpa()
	M_Title("ESCOLHA O PERIODO")
	nChoice := FazMenu( 05, 05, aMenu )
	if nChoice = 0
		ResTela( cScreen )
		return
	endif
	cString := "INCLUSAO DE PONTO: " + Upper( aMenu[nChoice] )
	WHILE OK
		cCodi := Space(04)
		MaBox( 13, 05, 15, 78, cString )
		@ 14, 06 Say "Codigo......:" Get cCodi   Pict "9999"     Valid CodiErrado( @cCodi,, Row(), Col()+1 )
		Read
		if LastKey() = ESC
			Exit
		endif
		if !SenhaServidor( cCodi )
			Loop
		endif
		ErrorBeep()
		nOpcao := Alerta( "Pergunta: Voce Deseja ?", {" Incluir ", " Alterar ", " Sair "})
		if nOpcao = 1 // Incluir
			cMovi := cCodi + DateToStr( dData )
			Area("Ponto")
			Ponto->(Order( PONTO_CODI_DATA ))
			if Ponto->(!DbSeek( cMovi ))
				Ponto->(Incluiu())
				Ponto->Codi := cCodi
				Ponto->Data := dData
			else
				Ponto->(TravaReg())
			endif
			if nChoice = 1
				Ponto->Manha1	 := Time()
			elseif nChoice = 2
				Ponto->Manha2	 := Time()
			elseif nChoice = 3
				Ponto->Tarde1	 := Time()
			elseif nChoice = 4
				Ponto->Tarde2	 := Time()
			endif
			CalculaPonto(Ponto->( RecNo() ))
			Ponto->(Libera())
		elseif nOpcao = 2  // Alterar
			Loop
		elseif nOpcao = 3  // Sair
			Exit
		endif
	EndDo
EndDo
ResTela( cScreen )
return

*:==================================================================================================================================

Proc MoviPonto()
****************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen( )
LOCAL nSoma1  := 0
LOCAL nSoma2  := 0
LOCAL nSobra  := 0
LOCAL nCarga  := 0
LOCAL cCodi   := Space(04)
LOCAL cManha1 := Space(05)
LOCAL cManha2 := Space(05)
LOCAL cTarde1 := Space(05)
LOCAL cTarde2 := Space(05)
LOCAL dData   := Date()
LOCAL nOpcao

oMenu:Limpa()
Area("Ponto")
Ponto->(Order( PONTO_CODI ))
WHILE OK
	MaBox( 05, 02, 10, 78, "INCLUSAO DE PONTO" )
	@ 06, 03 Say "Codigo......:" Get cCodi   Pict "9999"     Valid CodiErrado( @cCodi,,06, 22 )
	@ 07, 03 Say "Data........:" Get dData   Pict "##/##/##" Valid LastKey() = UP .OR. AchaMov( cCodi, dData )
	@ 08, 03 Say "Manha.......:" Get cManha1 Pict "99:99" Valid VerHora( cManha1 )
	@ 08, 24 						  Get cManha2 Pict "99:99" Valid VerHora( cManha2 )
	@ 09, 03 Say "Tarde.......:" Get cTarde1 Pict "99:99" Valid VerHora( cTarde1 )
	@ 09, 24 						  Get cTarde2 Pict "99:99" Valid VerHora( cTarde2 )
	Read
	if LastKey() = ESC
		ResTela( cScreen )
		Exit
	endif
	ErrorBeep()
	nOpcao := Alerta( "Pergunta: Voce Deseja ?", {" Incluir ", " Alterar ", " Sair "})
	if nOpcao = 1 // Incluir
		if AchaMov( cCodi, dData )
			if Ponto->(Incluiu())
				Ponto->Codi 	 := cCodi
				Ponto->Data 	 := dData
				Ponto->Manha1	 := cManha1
				Ponto->Manha2	 := cManha2
				Ponto->Tarde1	 := cTarde1
				Ponto->Tarde2	 := cTarde2
				CalculaPonto(Ponto->( RecNo() ))
				Ponto->(Libera())
			endif
		endif
	elseif nOpcao = 2  // Alterar
		Loop
	elseif nOpcao = 3  // Sair
		Exit
	endif
EndDo
ResTela( cScreen )
return

*:==================================================================================================================================

Function VerHora( cHora )
*************************
LOCAL nHora   := Val( Left( cHora, 2 ))
LOCAL nMinuto := Val( Right( cHora, 2 ))
LOCAL nTam	  := Len( AllTrim( cHora ))

if nTam < 5  // 00:00
	ErrorBeep()
	Alerta("Erro: Hora Invalida.")
	return( FALSO )
endif
if nHora > 24
	ErrorBeep()
	Alerta("Erro: Hora Invalida.")
	return( FALSO )
endif
if nMinuto > 59
	ErrorBeep()
	Alerta("Erro: Hora Invalida.")
	return( FALSO )
endif
if nHora = 24 .AND. nMinuto > 0
	ErrorBeep()
	Alerta("Erro: Hora Invalida.")
	return( FALSO )
endif
return( OK )

*:==================================================================================================================================

STATIC Function CodiErrado( cCodi, cNome, nRow, nCol)
*****************************************************
LOCAL aRotina := {{|| Servidor() }}
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()

Area("Servidor")
Servidor->(Order( if( cCodi = Space(40), SERVIDOR_NOME, SERVIDOR_CODI )))
if Servidor->(!DbSeek( cCodi ))
	Servidor->(Order( SERVIDOR_NOME ))
	Servidor->(DbGoTop())
	Escolhe( 00, 00, 24, "Codi + ' ' + Nome", 'CODIGO     NOME DO SERVIDOR', aRotina )
endif
cCodi := Servidor->Codi
cNome := Servidor->Nome
if nRow != Nil
	Write( nRow  , nCol, cNome )
endif
AreaAnt( Arq_Ant, Ind_Ant )
return(OK)

*:==================================================================================================================================

Function AchaMov( cCodi, dData )
********************************
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
LOCAL cString := cCodi + Dtoc( dData )

Area("Ponto")
Ponto->(Order( PONTO_CODI_DATA ))
if Ponto->(!DbSeek( cString ))
	AreaAnt( Arq_Ant, Ind_Ant )
	return( OK )
endif
AreaAnt( Arq_Ant, Ind_Ant )
ErrorBeep()
Alerta("Erro: Use Pesquisa/Altera Ponto.")
return(FALSO)

*:==================================================================================================================================

Proc MoviDbedit()
*****************
LOCAL Arq_Ant	:= Alias()
LOCAL Ind_Ant	:= IndexOrd()
LOCAL cScreen	:= SaveScreen()
LOCAL oBrowse	:= MsBrowse():New()

oMenu:Limpa()
Servidor->(Order( SERVIDOR_CODI ))
Area("Ponto")
Set Rela To Ponto->Codi Into Servidor
Ponto->( Order( PONTO_CODI_DATA ))
Ponto->(DbGoTop())
oBrowse:Add( "CODIGO",       "Codi",           "9999")
oBrowse:Add( "DATA",         "Data",           "##/##/##")
oBrowse:Add( "ENT MANHA",    "Manha1",         "99:99")
oBrowse:Add( "SAI MANHA",    "Manha2",         "99:99")
oBrowse:Add( "ENT TARDE",    "Tarde1",         "99:99")
oBrowse:Add( "SAI TARDE",    "Tarde2",         "99:99")
oBrowse:Add( "CARGA HORARIA","Quant",          "999999.99")
oBrowse:Titulo := "CONSULTA/ALTERACAO DE MOVIMENTO"
oBrowse:PreDoGet := {|| PreMovi( oBrowse ) } // Rotina do Usuario Antes de Atualizar
oBrowse:PosDoGet := {|| PosMovi( oBrowse ) } // Rotina do Usuario apos Atualizar
oBrowse:PreDoDel := NIL
oBrowse:PosDoDel := NIL
oBrowse:Show()
oBrowse:Processa()
AreaAnt( Arq_Ant, Ind_Ant )
ResTela( cScreen )

*:==================================================================================================================================

Function PreMovi( oBrowse )
***************************
LOCAL oCol	  := oBrowse:getColumn( oBrowse:colPos )
LOCAL nMarVar := 0

Do Case
Case oCol:Heading = "NOME"
	ErrorBeep()
	Alerta("Erro: Alteracao nao permitida.")
	return( FALSO )
Case oCol:Heading = "CARGA HORARIA"
	ErrorBeep()
	Alerta("Erro: Alteracao nao permitida.")
	return( FALSO )
EndCase
if oBrowse:ColPos >= 3 .AND. oBrowse:ColPos <= 6
	if Ponto->(TravaReg())
		CalculaPonto()
		Ponto->(Libera())
		return( OK )
	endif
endif
return( OK )

*:==================================================================================================================================

Function PosMovi( oBrowse )
***************************
LOCAL oCol		 := oBrowse:getColumn( oBrowse:colPos )
LOCAL nMarVar	 := 0
LOCAL cCodi 	 := Space(04)
LOCAL Arq_Ant	 := Alias()
LOCAL Ind_Ant	 := IndexOrd()
LOCAL cManha1	 := Ponto->Manha1

Do Case
Case oCol:Heading = "CODI"
	cCodi := Ponto->Codi
	CodiErrado( @cCodi )
	Ponto->Codi := cCodi
	AreaAnt( Arq_Ant, Ind_Ant )
Case oCol:Heading = "ENT MANHA"
	VerHora( Ponto->Manha1 )
Case oCol:Heading = "SAI MANHA"
	VerHora( Ponto->Manha2 )
Case oCol:Heading = "ENT TARDE"
	VerHora( Ponto->Tarde1 )
Case oCol:Heading = "SAI TARDE"
	VerHora( Ponto->Tarde2 )
EndCase
return( OK )

STATIC Proc AbreArea()
**********************
LOCAL cScreen := SaveScreen()
ErrorBeep()
Mensagem("Aguarde, Abrindo base de dados.", WARNING, _LIN_MSG )
FechaTudo()

if !UsaArquivo("PONTO")
	MensFecha()
	return
endif

if !UsaArquivo("SERVIDOR")
	MensFecha()
	return
endif

if !UsaArquivo("VENDEDOR")
	MensFecha()
	return
endif
return



*:==================================================================================================================================

Function oMenuPontoLan()
***********************
LOCAL AtPrompt := {}
LOCAL cStr_Get
LOCAL cStr_Sombra

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
AADD( AtPrompt, {"Sair",               {"Encerrar Sessao"}})
AADD( AtPrompt, {"Inclusao",           {"Servidores", "Ponto Manual", "Ponto Automatico"}})
AADD( AtPrompt, {"Alteracao",          {"Servidores", "Ponto", "Ajustar Carga Horaria"}})
AADD( AtPrompt, {"Consulta",           {"Servidores", "Ponto"}})
AADD( AtPrompt, {"Exclusao",           {"Servidores", "Ponto"}})
AADD( AtPrompt, {"Relatorios",         {"Servidores", "Folha Ponto"}})
AADD( AtPrompt, {"Help",               {"Help"}})
return( AtPrompt )

*:==================================================================================================================================

Function aDispPontoLan()
************************
LOCAL oPontolan := TIniNew( oAmbiente:xUsuario + ".INI")
LOCAL AtPrompt := oMenuPontoLan()
LOCAL nMenuH   := Len(AtPrompt)
LOCAL aDisp 	:= Array( nMenuH, 22 )
LOCAL aMenuV   := {}

Mensagem("Aguarde, Verificando Diretivas do CONTROLE DE PONTO.")
return( aDisp := ReadIni("pontolan", nMenuH, aMenuV, AtPrompt, aDisp, oPontoLan))

*:==================================================================================================================================

Proc ListaPonto()
*****************
LOCAL GetList	  := {}
LOCAL cScreen	  := SaveScreen( )
LOCAL aParcial   := { " Individual ", " Geral " }
LOCAL dIni		  := Date()-30
LOCAL dFim		  := Date()
LOCAL cCodi 	  := Space(04)
LOCAL nParcial   := 0
LOCAL oBloco1
LOCAL oBloco2

WHILE OK
	oMenu:Limpa()
	M_Title("LISTAGEM DE PONTO")
	nParcial := FazMenu( 04, 10, aParcial, Cor())
	Do Case
	Case nParcial = 0
		ResTela( cScreen )
		return

	Case nParcial = 1
		cCodi := Space(04)
		dIni	:= Date()-30
		dFim	:= Date()
		MaBox( 10, 10, 14, 79 )
		@ 11, 11 Say 'Codigo.......:' Get cCodi Pict '9999' Valid ServErrado( @cCodi, Row(), Col()+1 )
		@ 12, 11 Say 'Data Inicial.:' Get dIni  Pict '##/##/##'
		@ 13, 11 Say 'Data Final...:' Get dFim  Pict '##/##/##'
		Read
		if LastKey() = ESC
			Loop
		endif
		Servidor->(Order( SERVIDOR_CODI ))
		Servidor->(DbSeek( cCodi ))
		Ponto->(Order( PONTO_CODI_DATA ))
		oBloco1 := {|| Servidor->Codi = cCodi }
		oBloco2 := {|| Ponto->Data >= dIni .AND. Ponto->Data <= dFim }
		FolhaPonto( oBloco1, oBloco2, dIni, dFim )

	Case nParcial = 2
		dIni	:= Date()-30
		dFim	:= Date()
		MaBox( 10, 10, 13, 40 )
		@ 11, 11 Say 'Data Inicial.:' Get dIni Pict '##/##/##'
		@ 12, 11 Say 'Data Final...:' Get dFim Pict '##/##/##' Valid dFim >= dIni
		Read
		if LastKey() = ESC
			Loop
		endif
		Servidor->(Order( SERVIDOR_CODI ))
		Servidor->(DbGoTop())
		Ponto->(Order( PONTO_CODI_DATA ))
		oBloco1 := {|| Servidor->(!Eof()) }
		oBloco2 := {|| Ponto->Data >= dIni .AND. Ponto->Data <= dFim }
		FolhaPonto( oBloco1, oBloco2, dIni, dFim )
	EndCase
EndDo


Proc AjustaCarga()
******************
LOCAL cScreen := SaveScreen()

Area("Ponto")
if Ponto->(TravaArq())
	Ponto->(DbGoTop())
	Mensagem("Aguarde, Ajustando Carga Horaria.")
	WHILE Ponto->(!Eof())
		CalculaPonto()
		Ponto->( dbSkip(1) )
	EndDo
	Ponto->(Libera())
endif
Restela( cScreen )
return

Proc FolhaPonto( oBloco1, oBloco2, dIni, dFim )
***********************************************
LOCAL cScreen	  := SaveScreen( )
LOCAL Col		  := 58
LOCAL Tam		  := 132
LOCAL nLargura   := 120
LOCAL cTitulo    := 'RELATORIO DO CARTAO DE PONTO DO SERVIDOR : '
LOCAL cCodi 	  := Space(04)
LOCAL cPeriodo   := ''
LOCAL cNome 	  := ''
LOCAL nCarga	  := 0
LOCAL nGeral	  := 0
LOCAL Pagina	  := 0
LOCAL nSobra1	  := 0
LOCAL nSobra	  := 0
LOCAL nQuant	  := 0
LOCAL nSoma1	  := 0
LOCAL nSoma2	  := 0
LOCAL nNormal	  := 0
LOCAL nSabado	  := 0
LOCAL nDomingo   := 0
LOCAL nExtra	  := 0
LOCAL nExtraSab  := 0
LOCAL nExtraNor  := 0

if !Instru80()
	ResTela( cScreen )
	return
endif
Mensagem( "Aguarde, Imprimindo.")
PrintOn()
FPrint( PQ )
WHILE Eval( oBloco1 ) .AND. Rel_Ok()
	SetPrc( 0, 0 )
	Pagina	:= 0
	Col		:= 58
	nCarga	:= 0
	nGeral	:= 0
	nSabado	:= 0
	nNormal	:= 0
	nDomingo := 0
	nExtra	:= 0
	nSobra1	:= 0
	nSobra	:= 0
	cCodi 	:= Servidor->Codi
	cNome 	:= Alltrim( Servidor->Nome )
	cPeriodo := ' REF O PERIODO DE ' + Dtoc( dIni ) + ' A ' + Dtoc( dFim )
	if Ponto->(DbSeek( cCodi ))
		WHILE Ponto->Codi = cCodi .AND. REL_OK()
			if Eval( oBloco2 )
				if Col >=  58
					Write( 00, 00, Linha1( Tam, @Pagina))
					Write( 01, 00, Linha2())
					Write( 02, 00, Linha3(Tam))
					Write( 03, 00, Linha4(Tam, SISTEM_NA8 ))
					Write( 04, 00, Padc( cTitulo + cNome + cPeriodo, Tam ) )
					Write( 05, 00, Linha5(Tam))
					Write( 06, 00, 'DATA        DIA SEMANA     ENT MANHA   SAI MANHA   ENT TARDE   SAI TARDE   HORAS TRAB  HRS EXTRA  HRS EX SAB')
					Write( 07, 00, Linha5(Tam))
					Col := 8
				endif
				cDia		:= Upper(cDowPort( Ponto->Data))
				nTamanho := Len( cDia )
				nExtraSab := Ponto->Quant - 4
				nExtraNor := Ponto->Quant - 8
				if nExtraSab < 0
					nExtraSab := 0
				endif
				if nExtraNor < 0
					nExtraNor := 0
				endif
				Qout( Ponto->Data,	'  |  ', ;
						cDia + Space(8-nTamanho), '  |  ',;
						Ponto->Manha1, '  |  ',;
						Ponto->Manha2, '  |  ',;
						Ponto->Tarde1, '  |  ',;
						Ponto->Tarde2, '  |  ',;
						Tran( Ponto->Quant, '99.99'), '  |  ' )
						if cDia = 'SABADO'
							QQout( Space(05), '  |  ' )
							QQout( Tran( nExtraSab, '99.99'), '  |  ')
						else
							QQout( Tran( nExtraNor, '99.99'), '  |  ')
						endif
				nCarga  += Ponto->Quant
				nGeral  += Ponto->Quant
				nSobra1 := nGeral - Int( nGeral )
				nSobra  := nCarga - Int( nCarga )
				if cDia = 'SABADO'
					nSabado	+= nExtraSab
				elseif cDia = 'DOMINGO'
					nDomingo += ( Ponto->Quant )
				else
					nNormal += nExtraNor
				endif
				if ( nSobra > 0.59 )
					nCarga -= nSobra
					nSobra -= 0.6
					nCarga ++
					nCarga += nSobra
				endif
				if ( nSobra1 > 0.59 )
					nGeral  -= nSobra1
					nSobra1 -= 0.6
					nGeral  ++
					nGeral  += nSobra1
				endif
				nRestNormal := nNormal - Int( nNormal )
				if ( nRestNormal > 0.59 )
					nNormal		-= nRestNormal
					nRestNormal -= 0.6
					nNormal		++
					nNormal		+= nRestNormal
				endif
				nRestSabado := nSabado - Int( nSabado )
				if ( nRestSabado > 0.59 )
					nSabado		-= nRestSabado
					nRestSabado -= 0.6
					nSabado		++
					nSabado		+= nRestSabado
				endif
				nRestDomingo := nDomingo - Int( nDomingo )
				if ( nRestDomingo > 0.59 )
					nDomingo 	 -= nRestDomingo
					nRestDomingo -= 0.6
					nDomingo 	 ++
					nDomingo 	 += nRestDomingo
				endif
				Col++
				if Col >= 57
					nQuant := 0
					Write( ++Col, 0, "** Sub-Total **" + Space(64) + Tran( nCarga, "999999.99"))
					__Eject()
				endif
			endif
			Ponto->(DbSkip(1))
		EndDo
		nExtra	:= (( nNormal + nSabado ) + nDomingo )
		cExtenso := Extenso( nGeral, 3, 2, nLargura )
		Write(	Col, 00, Linha5(Tam))
		Write( ++Col, 01, 'TOTAL DE HORAS TRABALHADAS NO PERIODO..: ' + Tran( nGeral, '999999.99'))
		Write( ++Col, 06, Left( cExtenso, nLargura ))
		Write( ++Col, 06, Right( cExtenso, nLargura ))
		Write( ++Col, 00, Linha5(Tam))
		Write( ++Col, 00, 'HRS EXTRAS SEGUNDA/SEXTA  |   HRS EXTRAS SABADOS  |  HRS EXTRAS DOMINGOS  |   TOTAL HRS EXTRAS   |')
		Write( ++Col, 08, Tran( nNormal,  "999999.99"))
		Write(	Col, 26, '|')
		Write(	Col, 35, Tran( nSabado,  "999999.99"))
		Write(	Col, 50, '|')
		Write(	Col, 58, Tran( nDomingo, "999999.99"))
		Write(	Col, 74, '|')
		Write(	Col, 82, Tran( nExtra,	 "999999.99"))
		Write(	Col, 97, '|')
		Write( ++Col, 00, Linha5(Tam))
		Write( ++Col, 01, 'TOTAL DE HORAS EXTRAS NO PERIODO.......: ' + Tran( nExtra, '999999.99'))
		Col++
		Col++
		Col++
		Col++
      Write( ++Col, 01, 'DECLARO CONCORDAR PLENAMENTE COM O PRESENTE DEMOSTRATIVO DE HORAS, QUE TEVE COMO BASE O MEU CARTAO PONTO, COM HORARIOS AUTENTICADOS')
      Write( ++Col, 01, 'MECANICA/ELETRONICAMENTE, NOS DIAS QUE TRABALHEI DURANTE ESTE PERIODO, QUE FICARA ARQUIVADO EM PODER DA EMPRESA,  DO QUAL DOU MINHA')
      Write( ++Col, 01, 'PLENA,GERAL E IRREVOGAVEL QUITACAO.')
		Col++
		Col++
		Col++
		Write( ++Col, 01, Space(44) + Repl('-',40))
		Write( ++Col, 01, '____/____/____' + Space(30) + cNome )
		__Eject()
		if !Rel_Ok()
			Exit
		endif
	endif
	Servidor->(DbSkip(1))
EndDo
PrintOff()
ResTela( cScreen )
return

Proc CalculaPonto()
*******************
FIELD Manha1
FIELD Manha2
FIELD Tarde1
FIELD Tarde2
LOCAL nSoma1 := TimeDiff( Manha1, Manha2)
LOCAL nSoma2 := TimeDiff( Tarde1, Tarde2)
LOCAL nSobra := 0
LOCAL nCarga := 0

if ( Ponto->Manha1 = "00:00" .AND. Ponto->Manha2 = "24:00" .AND. Ponto->Tarde1 = "00:00" .AND. Ponto->Tarde2 = "00:00" )
	 Nsoma1 := "24:00:00"
endif
if ( Ponto->Manha1 = "00:00" .AND. Ponto->Tarde2 = "24:00" .AND. Ponto->Manha2 = "00:00" .AND. Ponto->Tarde1 = "00:00" )
	 Nsoma1 := "24:00:00"
endif
nSoma1  := Val(Stuff(Left(Nsoma1, 5), 3, 1, "."))
nSoma2  := Val(Stuff(Left(Nsoma2, 5), 3, 1, "."))
***************************************************
nSobra1 := nSoma1 - Int( nSoma1 )
nSobra2 := nSoma2 - Int( nSoma2 )
nCarga  := Int( nSoma1) + Int( nSoma2 )
nDiff   := ( nSobra1 + nSobra2 )
if nDiff > 0.59
	 nDiff -= 0.6
	 nCarga ++
endif
Ponto->Quant := ( nCarga + nDiff )
return
