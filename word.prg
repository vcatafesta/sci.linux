
#xcommand TRY       => 	bError := errorBlock( {|oErr| break( oErr ) } ) ;;
								BEGIN SEQUENCE
#xcommand CATCH [<!oErr!>] => errorBlock( bError ) ;;
								RECOVER [USING <oErr>] <-oErr-> ;;
								errorBlock( bError )

function main()
	Abre_word("teste.doc", 1)

*****************************
def Abre_word(cARQ,IMP)
*****************************
	LOCAL oWord, oText, oDoc

	if IMP=Nil
	 IMP="N"
	endif
	MsgRun("Aguarde Gerando Documento de Word...")

	GERAFILE() // gera um nome para arq. temporario

	vARQ:={}
	aadd( vARQ, {"LINHA","C",200,0} )
	DBcreate(cFILE, vARQ,"DBFCDX")

	SELE 999
	USE (cFILE) alias gera_ole EXCL new VIA "DBFCDX"// ALIAS tela shared NEW
	append from (cARQ) sdf && nome completo do arquivo sdf

	TRY
	 oWord := GetActiveObject( "Word.Application" )
	CATCH
	 TRY
		oWord := CreateObject( "Word.Application" )
	 CATCH
		MsgStop("Não foi Possivel Achar o Word Instalado","Aviso do Sistema")
		return
	 END
	END
	if !FILE(cARQ)
	 MsgStop("Não Foi possivel Abrir o Documento de Word")
	 return
	endif

	oWord:Documents:Add()
	oText := oWord:Selection()

	Sele gera_ole
	dbgotop()
	Do while !eof()
	 cLinha := Linha     // Busca linha de impressao
	 oText:Font:Name := "Lucida Console"
	 oText:Font:Size := 8
	 oText:Font:Bold := .F.
	 oText:Text+= cLinha + CRLF
	 dbskip()
	enddo

	if IMP="N"
	 oWord:Visible := .T. //PARA VISUALIZAR OU NÃO ANTES
	 oWord:WindowState := 1 // Maximize
	endif
	if IMP="S"
	 oWord:Visible := .F. //PARA VISUALIZAR OU NÃO ANTES
	 oWord:PrintOut() //PARA IMPRIMIR DIRETO
	endif
	return
