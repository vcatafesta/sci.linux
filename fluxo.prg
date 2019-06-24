Function Main()
***************
LOCAL cCodi
LOCAL cCpf
LOCAL cNome
LOCAL cCodiAnt
LOCAL nField
LOCAL nConta
LOCAL nNewCodi := 45000

Cls
Tone(100,5)
if !File('recemov.dbf')
   Alert('Erro: Falta arquivo recemov.dbf')
   Quit
endif
if !File('receber.dbf')
   Alert('Erro: Falta arquivo receber.dbf')
   Quit
endif
if !File('rec3.dbf')
   Alert('Erro: Falta arquivo rec3.dbf')
   Quit
endif
if !File('mov3.dbf')
   Alert('Erro: Falta arquivo mov3.dbf')
   Quit
endif

Set Date Brit
Qout('1.01 Aguarde, Abrindo Rec3')
Use Rec3 New
Qout('1.02 Aguarde, Indexando Rec3')
Inde On Codi To Rec3

Qout('1.03 Aguarde, Abrindo Mov3')
Use Mov3 New
Qout('1.04 Aguarde, Indexando Mov3')
Inde On Codi To Mov3

Area('Mov3')
Rec3->(Order( 1 ))
Rec3->(DbGotop())
Qout('1.05 Aguarde, Vericando Clientes.')
While Rec3->(!Eof())
	cCodi := Rec3->Codi
	if Mov3->(!DbSeek( cCodi ))
		Rec3->(DbDelete())
	endif
	Rec3->(DbSkip(1))
EndDo

Qout('1.07 Aguarde, Compactando Mov3.')
Area('Mov3')
Pack
Qout('1.07 Aguarde, Compactando Rec3.')
Area('Rec3')
Pack
Qout('1.07 Aguarde, Abrindo Recemov.')
Use Recemov New
Qout('1.08 Aguarde, Abrindo Receber.')
Use Receber New
Qout('1.09 Aguarde, Indexando Receber1')
Inde On Receber->Codi To Receber1
Qout('1.10 Aguarde, Indexando Receber2')
Inde On Receber->Cpf To Receber2

DbCloseAll()
Use Rec3 Index Rec3 New
Use Mov3 Index Mov3 New
Use Recemov New
Use Receber Index Receber1, Receber2 New

Qout('1.11 Aguarde, Alterando N§ Titulos Mov3')
Area('Mov3')
Mov3->(DbGotop())
While Mov3->(!Eof())
   Mov3->Docnr  := 'J' + Right( Mov3->Docnr, 8 )
   Mov3->Fatura := 'J' + Right( Mov3->Fatura, 8 )
	Mov3->(DbSkip(1))
EndDO

Area('Receber')
Receber->(Order( 2 ))
Area('Rec3')
Rec3->(DbGoTop())
Qout('1.12 Aguarde, Processando Rec3')
While Rec3->(!Eof())
	cCpf		:= Rec3->Cpf
	cNome 	:= Rec3->Nome
	cCodiAnt := Rec3->Codi
	Receber->(Order( 2 ))
   if Receber->(!DbSeek( cCpf ))
		Receber->(Order( 1 ))
		Receber->(DbGoBottom())
		cCodi := StrZero( Val( Receber->Codi )+1, 5 )
		Receber->(DbAppend())
		nConta := Receber->(FCount())
		For nField := 1 To nConta
			Receber->(FieldPut( nField, Rec3->(FieldGet( nField ))))
		Next
      nNewCodi++
      cCodi := StrZero( nNewCodi, 5 )
      Qout('1.12 Aguarde, Anexando Cliente ' + cCodi)
      Receber->Codi := cCodi
	else
		cCodi := Receber->Codi
	endif
	Mov3->(DbSeek( cCodiAnt ))
	While Mov3->Codi = cCodiAnt
		nConta := Recemov->(FCount())
		Recemov->(DbAppend())
		For nField := 1 To nConta
			Recemov->(FieldPut( nField, Mov3->(FieldGet( nField ))))
		Next
		Recemov->Codi := cCodi
      Recemov->Tipo := 'J' + Left( Recemov->Tipo, 5 )
		Mov3->(DbSkip(1))
	EndDo
	Rec3->(DbSkip(1))
EndDo

Function Order( Ordem )
***********************
Iif( Ordem = Nil , Ordem := 0,  Ordem )
DbSetOrder( Ordem )
DbGoTo( Recno())			 // Fixar Bug
return( IndexOrd())

Function Area( cArea)
*********************
DbSelectArea( cArea )
return NIl
