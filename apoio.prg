/*
  ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 Ý³																								 ³
 Ý³	Programa.....: APOIO.PRG															 ³
 Ý³	Aplicacaoo...: MODULO DE APOIO AO SCI											 ³
 Ý³	Versao.......: 19.50 																 ³
 Ý³	Programador..: Vilmar Catafesta													 ³
 Ý³	Empresa......: Microbras Com de Prod de Informatica Ltda 				 ³
 Ý³	Inicio.......: 12 de Novembro de 1991. 										 ³
 Ý³	Ult.Atual....: 15 de Maio de 2017.     										 ³
 Ý³	Compilacao...: Harbour 3.2/3.4   												 ³
 Ý³	Linker.......: GCC/BCC/MSVC                  								 ³
 Ý³	Bibliotecas..: Clipper/Funcoes/Mouse/Funcky15/Funcky50/Classe/Classic ³
 ÝÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
 ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
#include "sci.ch"
#include "hbgtinfo.ch"			

def VerDebitosEmAtraso()
	LOCAL nNivel := SCI_VERIFICAR_DEBITOS_EM_ATRASO
	if !Empty( aPermissao )
		if aPermissao[ nNivel ]
			return( true )
		endif
	endif
	return( FALSO )
endef

*==================================================================================================*

def PodeExcederDescMax()
	LOCAL nNivel := SCI_PODE_EXCEDER_DESCONTO_MAXIMO
	if !Empty( aPermissao )
		if aPermissao[ nNivel ]
			return( true )
		endif
		return( PedePermissao( nNivel))
	endif
	return( false )
endef

*==================================================================================================*
	
def PodeMudarData( dEmis )
	LOCAL nNivel := SCI_ALTERAR_DATA_FATURA
	
	if dEmis == Date()
		return( true )
	endif
	
	if !Empty( aPermissao )
		if aPermissao[ nNivel ]
			return( true )
		endif
		if !PedePermissao( nNivel )
			return( false )
		endif
		return( true )
	endif	
	return( false )
endef

*==================================================================================================*
	
def PodeRecDataDif( dEmis )
	LOCAL nNivel := SCI_ALTERAR_DATA_BAIXA

	if dEmis == Date()
		return( true )
	endif
	if !Empty( aPermissao )
		if aPermissao[ nNivel ]
			return( true )
		endif
		if !PedePermissao( nNivel )
			return( false )
		endif
		return( true )
	endif
	return( false )
endef

*==================================================================================================*
	
def PodeReceber()
	if !Empty( aPermissao )
		if aPermissao[ SCI_RECEBIMENTOS ]
			return( true )
		endif
		nNivel := SCI_RECEBIMENTOS
		if !PedePermissao( nNivel )
			return( false )
		endif
		return( true )
	endif
	return( false )
endef
	
*==================================================================================================*	
	
def PodePagar()
	if !Empty( aPermissao )
		if aPermissao[ SCI_PAGAMENTOS ]
			return( true )
		endif
		nNivel := SCI_PAGAMENTOS
		if !PedePermissao( nNivel )
			return( false )
		endif
		return( true )
	endif
	return( false )
endef

*==================================================================================================*
	
def PodeVenderComLimiteEstourado()
	if !Empty( aPermissao )
		if aPermissao[SCI_VENDER_COM_LIMITE_ESTOURADO]
			return( true )
		endif
	endif
	return( false )
endef
	
*==================================================================================================*	
	
def VerificarLimiteCredito()
	if !Empty( aPermissao )
		if aPermissao[SCI_VERIFICAR_LIMITE_DE_CREDITO]
			return( true )
		endif
	endif
	return( false )
endef
	
*==================================================================================================*	
	
def TipoCadastro()
	if !Empty( aPermissao )
		if aPermissao[SCI_TIPO_DE_CADASTRO_DE_CLIENTE]
			return( true )
		endif
	endif
	return( false )
endef
	
*==================================================================================================*	
	
def PodeBaixarTituloAVista()
	if !Empty( aPermissao )
		if aPermissao[SCI_BAIXAR_TITULO_QDO_VENDA_A_VISTA]
			return( true )
		endif
	endif
	return( false )
endef

*==================================================================================================*
	
def PodeFaturarComEstoqueNegativo()
	if !Empty( aPermissao )
		if aPermissao[SCI_FATURAR_COM_ESTOQUE_NEGATIVO]
			return( true )
		endif
	endif
	return( false )
endef

*==================================================================================================*
	
def PodeFazerBackup()
	if !Empty( aPermissao )
		if aPermissao[SCI_COPIA_DE_SEGURANCA]
			return( true )
		endif
	endif
	return( false )
endef
	
*==================================================================================================*	
	
def PodeFazerRestauracao()
	if !Empty( aPermissao )
		if aPermissao[SCI_RESTAURAR_COPIA_SEGURANCA]
			return( true )
		endif
	endif
	return( false )	
endef	

*==================================================================================================*

def PodeAlterar()
	if !Empty( aPermissao )
		if aPermissao[SCI_ALTERACAO_DE_REGISTROS]
			return( true )
		endif
	endif
	return( false )
endef

*==================================================================================================*
	
def PodeTrocarEmpresa()
	if !Empty( aPermissao )
		if aPermissao[SCI_TROCAR_DE_EMPRESA]
			return( true )
		endif
	endif
	return( false )
endef

*==================================================================================================*
	
def PodeIncluir()
	if !Empty( aPermissao )
		if aPermissao[SCI_INCLUSAO_DE_REGISTROS]
			return( true )
		endif
	endif
	return( false )
endef

*==================================================================================================*
	
def PodeExcluir()
	if !Empty( aPermissao )
		if aPermissao[SCI_EXCLUSAO_DE_REGISTROS]
			return( .t. )
		endif
	endif
	return( false )
endef

*==================================================================================================*

def MS_DbUser( Modo, Ponteiro , Var)
*-----------------------------------*
LOCAL GetList		:= {}
LOCAL cScreen		:= SaveScreen()
LOCAL Key			:= LastKey()
LOCAL Arq_Ant		:= Alias()
LOCAL Ind_Ant		:= IndexOrd()
LOCAL cN_Original := Space(15)
STATI nPosicao 	:= 1
LOCAL nLastrec 	:= Lastrec()
LOCAL Registro
LOCAL Salva_tela
LOCAL lInativos	:= oIni:ReadBool('sistema', 'MostrarClientesInativos', false )

ScrollBarUpdate( aScroll, Recno(), Lastrec(), true )
Do Case
	Case Key = F2
		if Alias() = "LISTA"
			oMenu:Limpa()
			MaBox( 10, 10, 12, 48 )
			@ 11, 11 Say "Codigo Fabricante..." Get cN_Original Pict "@!" Valid CodiOriginal( @cN_Original )
			Read
			if LastKey() = ESC
				ResTela( cScreen )
				return(1)
			endif
			ResTela( cScreen )
		else
			if Alias() = "RECEBER"
				oMenu:Limpa()
				ClientesFiltro()
				ResTela( cScreen )
			endif
		endif
		AreaAnt( Arq_Ant, Ind_Ant )
		return(1)

	Case Key = K_INS
		if aRotina != Nil
			if PodeIncluir()
				Eval( aRotina[1])
			else
				if lExcecao != Nil
					Eval( aRotina[1])
				endif
			endif
		endif
		AreaAnt( Arq_Ant, Ind_Ant )
		return(1)

#define ALT_ENTER 284
	Case Key = K_CTRL_RET .or. Key = ALT_ENTER
		if !(aRotinaAlteracao == NIL )
			if PodeAlterar() .OR. !(lExcecao == NIL)
			   Eval( aRotinaAlteracao[1])
			endif
		endif
		AreaAnt( Arq_Ant, Ind_Ant )
		return(1)

	Case Key = K_DEL
		if aRotina != Nil
			if PodeExcluir()
				if aRotinaExclusao != NIL
					if !Eval( aRotinaExclusao[1] )
						return(1)
					endif
				endif
				ErrorBeep()
				if Conf("Pergunta: Excluir Registro sob o Cursor ?")
					if TravaReg()
						DbDelete()
						Libera()
					  Keyb Chr( K_CTRL_PGUP )
					endif
				endif
			endif
		endif
		return(1)

	Case Modo < 4
		return(1)

	Case LastKey() = 27
		nPosicao := 1
		return(0)

	Case LastKey() = 13
		return(0)

	Case LastKey() >= 48 .AND. LastKey() <= 122	&&  1 a Z
		if   ValType( cCampo ) = "C"
			xVar := Upper(Chr(Key))
			xVar := xVar + Space( nTam - Len( xVar))
			Keyb(Chr(K_RIGHT))
			@ nCol-1, nLin+2 Get xVar Pict "@!"
			Read

		elseif ValType( cCampo ) = "N"
			if nKey < Chr(48) .OR. nKey > Chr(57) // 0 a 9
				return(1)
			endif
			xVar := Chr(nKey)
			Keyb(Chr(K_RIGHT))
			@ nCol-1, nLin+2 Get xVar
			Read

		elseif ValType( cCampo ) = "D"
			xVar := Date()
			@ nCol-1, nLin+2 Get xVar Pict "##/##/##"
			Read
		endif
		if LasTKey() = ESC
			ResTela( cScreen )
			return(1)
		endif
		xVar := Iif( ValType( cCampo ) = "C", AllTrim( xVar ), xVar)
		ResTela( cScreen )
		DbSeek( xVar )
		return(1)

	OTHERWISE
		if Alias() = "RECEBER"
			if lInativos
				if Receber->Cancelada
					Receber->(DbSkip(1))
				endif
			endif
		endif
		return(1)

ENDCASE
return(1)

def Impressora()
****************
   LOCAL cScreen  := SaveScreen()
   LOCAL nChoice  := 0
   LOCAL aMenu    := {}
   LOCAL aPrinter := {}

   oMenu:Limpa()
   while true
      aPrinter := CupsArrayPrinter()
      aMenu    := aPrinter[CUPS_MENU]
      M_Title(" TECLE ENTER PARA ESCOLHER, ESC CANCELAR")
      nChoice := FazMenu( 09, 14, aMenu, Cor())
      if  nChoice = 0
         ResTela( cScreen )
         return
      else         
         MudaImpressora(nChoice)
      endif
   enddo
endef

def RetPrinterStatus()
   LOCAL i := 0
   LOCAL aStatus := {}
   
   for i := 1 to 3
      nStatus := PrnStatus(i)
      if nStatus = 0 
         nStatus := Iif(IsPrinter(i), 1, 2 )
      else
        if nStatus = -1
           nStatus = 4
        else
           nStatus++
         endif
      endif	
      Aadd( aStatus, nStatus )
   next
   return aStatus
endef      
   
def MudaImpressora( nCorrente, aMenu )
**************************************
   LOCAL cCodi    := Space(02)
   LOCAL aPrinter := CupsArrayPrinter()
   LOCAL aModelo 	:= aPrinter[CUPS_MODELO]
	LOCAL aAction	:= aPrinter[CUPS_ACTION]
   LOCAL aStatus  := aPrinter[CUPS_STATUS]   
   
   if IsNil( aMenu)
      aMenu := aPrinter[CUPS_MENU]
   endif
   
	if UsaArquivo("PRINTER")
		PrinterErrada( @cCodi )
      aArrayPrn := {;
                     Printer->Codi,;
                     Printer->Nome, ;
                     Printer->_Cpi10,; 
                     Printer->_Cpi12,; 
                     Printer->Gd,; 
                     Printer->Pq,; 
                     Printer->Ng,; 
                     Printer->Nr,; 
                     Printer->Ca,; 
                     Printer->c18,; 
                     Printer->LigSub,; 
                     Printer->DesSub,; 
                     Printer->_SaltoOff,; 
                     Printer->_Spaco1_6,; 
                     Printer->_Spaco1_8,;
                     Printer->Reseta;
                  }
      switch nCorrente
      case 1
      case 2
      case 3
         nIndex := nCorrente
         &("oAmbiente:aLpt" + trimstr(nIndex)) := {}
         Aadd( &("oAmbiente:aLpt" + trimstr(nIndex)), aArrayPrn)
         cStr := &("oAmbiente:aLpt" + trimstr(nIndex))                           
         aMenu[nIndex] := " LPT" + trimstr(nIndex) + " þ " + aAction[aStatus[nIndex]] + " þ " + cStr[1,2]
         exit                                                                     
		case 13
		case 14
		case 15
		case 16
		case 17
		case 18
		case 19
		case 20
		case 21
         nIndex := ( nCorrente - 12 )
         &("oAmbiente:aLpd" + trimstr(nIndex)) := {}
			Aadd( &("oAmbiente:aLpd" + trimstr(nIndex)), aArrayPrn)
         cStr := &("oAmbiente:aLpd" + trimstr(nIndex))                           
         aMenu[nCorrente] := " LPD" + TrimStr(nIndex) + "  þ REDE CUPS      þ " + Left(cStr[1,2],17) + " em " + aModelo[nIndex]                                                                 
         exit            			
      endswitch
		
		Printer->(DbCloseArea())
		if UsaArquivo("USUARIO")
			if Usuario->(DbSeek( oAmbiente:xUsuario ))
				if Usuario->(TravaReg())
					Usuario->Lpt1 := Iif( oAmbiente:aLpt1[1,1] = NIL, "", oAmbiente:aLpt1[1,1])
					Usuario->Lpt2 := Iif( oAmbiente:aLpt2[1,1] = NIL, "", oAmbiente:aLpt2[1,1])
					Usuario->Lpt3 := Iif( oAmbiente:aLpt3[1,1] = NIL, "", oAmbiente:aLpt3[1,1])
					Usuario->Lpd1 := Iif( oAmbiente:aLpd1[1,1] = NIL, "", oAmbiente:aLpd1[1,1])
					Usuario->Lpd2 := Iif( oAmbiente:aLpd2[1,1] = NIL, "", oAmbiente:aLpd2[1,1])
					Usuario->Lpd3 := Iif( oAmbiente:aLpd3[1,1] = NIL, "", oAmbiente:aLpd3[1,1])
					Usuario->Lpd4 := Iif( oAmbiente:aLpd4[1,1] = NIL, "", oAmbiente:aLpd4[1,1])
					Usuario->Lpd5 := Iif( oAmbiente:aLpd5[1,1] = NIL, "", oAmbiente:aLpd5[1,1])
					Usuario->Lpd6 := Iif( oAmbiente:aLpd6[1,1] = NIL, "", oAmbiente:aLpd6[1,1])
					Usuario->Lpd7 := Iif( oAmbiente:aLpd7[1,1] = NIL, "", oAmbiente:aLpd7[1,1])
					Usuario->Lpd8 := Iif( oAmbiente:aLpd8[1,1] = NIL, "", oAmbiente:aLpd8[1,1])
					Usuario->Lpd9 := Iif( oAmbiente:aLpd9[1,1] = NIL, "", oAmbiente:aLpd9[1,1])               
					Usuario->(Libera())
				endif
			endif
			Usuario->(DbCloseArea())
		endif
	endif
endef

def CriaNtx( Col_1, Lin_1, Nome_Field, Nome_Ntx, cTag )
************************************************************
	Ferase( (Nome_Ntx) + ".NTX")
	Ferase( (Nome_Ntx) + ".CDX")
	SetColor("W*+/N")
	Write( Col_1, Lin_1, Chr(10))
	MacroNtx( Nome_Field, Nome_Ntx, cTag )
	SetColor("W+/R")
	Write( Col_1, Lin_1, Chr(251)) // û
	return Nil

def MacroNtx( Nome_Field, Nome_Ntx, cTag )
***********************************************
	LOCAL cScreen := SaveScreen()

	if RddSetDefa() = "DBFNTX"
	  MaBox( 07, 10, 11, 61 )
	  Index On &Nome_Field. To &Nome_Ntx. Eval NtxProgress() Every LastRec()/1000
	else
	  Index On &Nome_Field. Tag &Nome_Ntx. TO ( cTag ) EVAL Odometer() Every 10
	endif
	ResTela( cScreen )
	return Nil
   
def Spooler()
*************
   LOCAL GetList     := {}
   LOCAL cScreen     := SaveScreen()
   LOCAL Arq_Ant     := Alias()
   LOCAL Ind_Ant     := IndexOrd()
   LOCAL cFile       := ""
   LOCAL Files       := '*.txt'   
   LOCAL aMenuChoice := { " Limpar Spooler                 ",;
                          " Enviar Arquivo para Impressora ",;
                          " Visualizar Arquivo             ",;
                          " Escolher Impressora            "}
   while true
      oMenu:Limpa()
      M_Title("SPOOLER DE IMPRESSAO")
      nChoice := FazMenu( 05, 10, aMenuChoice )
      
      do case
      case nChoice = 0
         if !Empty( Arq_Ant)
            Select( Arq_Ant )
            Order( Ind_Ant )
         endif
         return(ResTela( cScreen ))

      case nChoice = 1
         oAmbiente:cArquivo := ""
         oAmbiente:Spooler  := false
         Alerta("Limpeza efetuada com sucesso")         
         Loop

      case nChoice = 2         
         cFile := iif( Empty( oAmbiente:cArquivo), Space(len(FTempPorExt("txt", oAmbiente:xBaseTxt) + Space(10))), oAmbiente:cArquivo )
         MaBox( 15, 10, 17 , MaxCol()-1 )
         @ 16, 11 Say "Arquivo para Impressao : " Get cFile Pict "@!" valid PickTemp( @cFile)
         Read
         if LastKey() = 27
            oAmbiente:cArquivo := ""            
            Loop
         endif         
         oAmbiente:cArquivo := TrimStr(cFile)         
         Instru80(, oAmbiente:cArquivo )   
         loop

      case nChoice = 3
         cFile := iif( Empty( oAmbiente:cArquivo), Space(len(FTempPorExt("txt", oAmbiente:xBaseTxt) + Space(10))), oAmbiente:cArquivo )         
         MaBox( 15, 10, 17 , MaxCol()-1 )
         @ 16, 11 Say "Arquivo para Visualizar : " Get cFile Pict "@!" valid PickTemp( @cFile)
         Read
         if LastKey() = 27            
            loop
         endif		
         oAmbiente:cArquivo := TrimStr(cFile)         
         oAmbiente:Externo  := FALSO
         oAmbiente:Spooler  := OK		
         #if defined( __PLATFORM__UNIX )
            M_View( 00, 00, MaxRow(), MaxCol(), oAmbiente:cArquivo, Cor())
         #else
            ShellRun("NOTEPAD " + oAmbiente:cArquivo )
         #endif   
         CloseSpooler()
         oAmbiente:Spooler := FALSO                  
         loop

      case nChoice = 4
         Impressora()
      endcase
   enddo
   return
endef      

def _Instru80( Mode, nCorrente, nRowPos )
******************************************
	LOCAL cCodi     := Space(02)
	LOCAL cPath     := FChdir()
   LOCAL aArryaPrn := {}
   LOCAL nIndex    := 0
   
   #define default    otherwise  
   #define CTRL_PGDN  30

	do case
	case LastKey() = K_CTRL_PGDN .or. lastkey() = CTRL_PGDN
	  lCancelou := true
	  return( 0 )

	case Mode = 0
		return(2)

	case Mode = 1 .OR. Mode = 2
		ErrorBeep()
		return(2)

	case LastKey() = K_ESC
		return(0)

	case LastKey() = K_ENTER
		return(1)

   #define K_SH_ENTER 284   
	case LastKey() = K_CTRL_RET .or. Lastkey() = K_SH_ENTER
      MudaImpressora(nCorrente, @aMenu)
		return(2)

	default
		return(2)

	EndCase
endef
	
*==================================================================================================*			
 
def CupsArrayPrinter()   
   LOCAL aPrinter := cupsGetDests()
   LOCAL aModelo  := {}
   LOCAL aMenu    := {} 
   LOCAL aAction	:= { "PRONTA         ","FORA DE LINHA  ","DESLIGADA      ","SEM PAPEL      ", "NAO CONECTADA  "}
   LOCAL aComPort := { "DISPONIVEL     ","INDISPONIVEL   " }
   LOCAL aStatus  := RetPrinterStatus()
   LOCAL nIndex   := 0
   LOCAL nPr      
   MEMVAR cStr
   
   aMenu := {  " LPT1 þ " + aAction[ aStatus[1]] + " þ " + oAmbiente:aLpt1[1,2],;
					" LPT2 þ " + aAction[ aStatus[2]] + " þ " + oAmbiente:aLpt2[1,2],;
					" LPT3 þ " + aAction[ aStatus[3]] + " þ " + oAmbiente:aLpt3[1,2],;
					" COM1 þ " + Iif( FIsPrinter("COM1"), aComPort[1], aComPort[2]) + " þ " + "PORTA SERIAL 1",;
					" COM2 þ " + Iif( FIsPrinter("COM2"), aComPort[1], aComPort[2]) + " þ " + "PORTA SERIAL 2",;
					" COM3 þ " + Iif( FIsPrinter("COM3"), aComPort[1], aComPort[2]) + " þ " + "PORTA SERIAL 3",;
					" USB  þ " + aAction[ aStatus[1]] + " þ IMPRESSORA USB",;
					" VISUALIZAR   þ ",;
					" ENVIAR EMAIL þ ",;
					" WEB BROWSER  þ ",;
					" SPOOLER      þ ",;
					" CANCELAR     þ ";
            }   
      
   FOR EACH nPr IN aPrinter               
      //? nPr:__enumIndex(), i
      //nWidth := Max( nWidth, Len( nPr ) )         
      nIndex++          
      cStr := &( "oAmbiente:aLpd" + trimstr(nIndex))
      Aadd( aMenu, " LPD" + TrimStr(nPr:__enumIndex()) + "  þ REDE CUPS      þ " + Left(cStr[1,2],17) + " em " + nPr)                    
      Aadd( aModelo, nPr)        
   NEXT                       
   return {aMenu, aModelo, aAction, aStatus, aPrinter}
endef   

*==================================================================================================*			   

def SetarVariavel( aNewLpt )
****************************
	LOCAL nPos       := 2   
	PUBLIC _CPI10	  := MsDecToChr( aNewLpt[1,++nPos] )
	PUBLIC _CPI12	  := MsDecToChr( aNewLpt[1,++nPos] )
	PUBLIC GD		  := MsDecToChr( aNewLpt[1,++nPos] )
	PUBLIC PQ		  := MsDecToChr( aNewLpt[1,++nPos] )
	PUBLIC NG		  := MsDecToChr( aNewLpt[1,++nPos] )
	PUBLIC NR		  := MsDecToChr( aNewLpt[1,++nPos] )
	PUBLIC CA		  := MsDecToChr( aNewLpt[1,++nPos] )
	PUBLIC C18		  := MsDecToChr( aNewLpt[1,++nPos] )
	PUBLIC LIGSUB	  := MsDecToChr( aNewLpt[1,++nPos] )
	PUBLIC DESSUB	  := MsDecToChr( aNewLpt[1,++nPos] )
	PUBLIC _SALTOOFF := MsDecToChr( aNewLpt[1,++nPos] )
	PUBLIC _SPACO1_8 := MsDecToChr( aNewLpt[1,++nPos] )
	PUBLIC _SPACO1_6 := MsDecToChr( aNewLpt[1,++nPos] )
	PUBLIC RESETA	  := MsDecToChr( aNewLpt[1,++nPos] )
	return   
endef   



def Instruim()
*******************
   return( Instru80() )
endef
   
def InstruEt()
**************
   LOCAL cScreen := SaveScreen()
   LOCAL nChoice
   oMenu:Limpa()
   ErrorBeep()
   nChoice := Alert(" INSTRU€ŽO PARA EMISSŽO DE ETIQUETAS      " + ;
                     ";; û Coloque Formulario Etiqueta.        " + ;
                     "; û Acerte a Altura do Picote           " + ;
                     "; û Resete ou Ligue a Impressora        ", { "Imprimir", "Visualizar", "Cancelar"})
   ResTela( cScreen )
   if nChoice = 1
      oAmbiente:cArquivo := ""
      oAmbiente:Spooler  := FALSO
      return( true )
   elseif nChoice = 2
      SaidaParaArquivo()
      return( true )
   else
      return( false )
   endif
endef
   
Proc CadastroImpressoras()
**************************
LOCAL GetList	  := {}
LOCAL cScreen	  := SaveScreen()
LOCAL cCodi 	  := Space(02)
LOCAL cNome 	  := Space(30)
LOCAL c_Cpi10	  := Space(30)
LOCAL c_Cpi12	  := Space(30)
LOCAL cGd		  := Space(30)
LOCAL cPq		  := Space(30)
LOCAL cNg		  := Space(30)
LOCAL cNr		  := Space(30)
LOCAL cCa		  := Space(30)
LOCAL cC18		  := Space(30)
LOCAL cLigSub	  := Space(30)
LOCAL cDesSub	  := Space(30)
LOCAL c_SaltoOff := Space(30)
LOCAL c_Spaco1_6 := Space(30)
LOCAL c_Spaco1_8 := Space(30)
LOCAL cReseta	  := Space(30)
LOCAL nOpcao
LOCAL nTam
LOCAL nCol
LOCAL nRow

FIELD Codi
FIELD Nome
FIELD Gd
FIELD Pq
FIELD Ng
FIELD Nr
FIELD Ca
FIELD C18
FIELD LigSub
FIELD DesSub
FIELD _SaltoOff
FIELD _Spaco1_6
FIELD _Spaco1_8
FIELD Reseta

if !UsaArquivo("PRINTER")
	return
endif
Area("Printer")
Printer->(DbGoBottom())
nTam	:= Printer->(Len( Codi ))
cCodi := Printer->(StrZero( Val( Codi ) +1, nTam ))
oMenu:Limpa()
MaBox( 05, 10, 22, 60, "INCLUSAO DE IMPRESSORAS" )
nCol := 11
nRow := 06
WHILE OK
	@ nRow,	  nCol Say "Codigo...........:" Get cCodi Pict "99" Valid PrinterCerto( @cCodi )
	@ Row()+1, nCol Say "Modelo...........:" Get cNome Pict "@!"
	@ Row()+1, nCol Say "Ligar 05 CPI.....:" Get cGd        Pict "@!"
	@ Row()+1, nCol Say "Desl  05 CPI.....:" Get cCA        Pict "@!"
	@ Row()+1, nCol Say "Ligar 10 CPI.....:" Get c_Cpi10    Pict "@!"
	@ Row()+1, nCol Say "Ligar 12 CPI.....:" Get c_Cpi12    Pict "@!"
	@ Row()+1, nCol Say "Ligar 15 CPI.....:" Get cPQ        Pict "@!"
	@ Row()+1, nCol Say "Desl  15 CPI.....:" Get cC18       Pict "@!"
	@ Row()+1, nCol Say "Ligar NEGRITO....:" Get cNG        Pict "@!"
	@ Row()+1, nCol Say "Desl  NEGRITO....:" Get cNR        Pict "@!"
	@ Row()+1, nCol Say "Ligar SUBLINHADO.:" Get cLigSub    Pict "@!"
	@ Row()+1, nCol Say "Desl  SUBLINHADO.:" Get cDesSub    Pict "@!"
	@ Row()+1, nCol Say "Desl SALTO PAG...:" Get c_SaltoOff Pict "@!"
	@ Row()+1, nCol Say "Espacamento 1/8..:" Get c_Spaco1_8 Pict "@!"
	@ Row()+1, nCol Say "Espacamento 1/6..:" Get c_Spaco1_6 Pict "@!"
	@ Row()+1, nCol Say "RESETAR..........:" Get cReseta    Pict "@!"
	Read
	if LastKey() = ESC
		ResTela( cScreen )
		Exit
	endif
	ErrorBeep()
	nOpcao := Alerta(" Pergunta: Voce Deseja ? ", {" Incluir ", " Alterar ", " Sair " })
	if nOpcao = 1 // Incluir
		if PrinterCerto( @cCodi )
			if Printer->(Incluiu())
				Printer->Codi		 := cCodi
				Printer->Nome		 := cNome
				Printer->_Cpi10	 := c_Cpi10
				Printer->_Cpi12	 := c_Cpi12
				Printer->Gd 		 := cGd
				Printer->Pq 		 := cPq
				Printer->Ng 		 := cNg
				Printer->Nr 		 := cNr
				Printer->Ca 		 := cCa
				Printer->C18		 := cC18
				Printer->LigSub	 := cLigSub
				Printer->DesSub	 := cDesSub
				Printer->_SaltoOff := c_SaltoOff
				Printer->_Spaco1_6 := c_Spaco1_6
				Printer->_Spaco1_8 := c_Spaco1_8
				Printer->Reseta	 := cReseta
				cCodi 				 := Printer->(StrZero( Val( Codi ) +1, nTam ))
				Printer->(Libera())
			endif
		endif
	elseif nOpcao = 2 // Alterar
		Loop
	elseif nOpcao = 3 // Sair
		ResTela( cScreen )
		Exit
	endif
END

def PrinterCerto( cCodi )
******************************
LOCAL nTam	  := Printer->(Len( Codi ))
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
LOCAL lRetVal := OK

Area("Printer")
Printer->(Order( PRINTER_CODI ))
if Printer->(DbSeek( cCodi ))
	ErrorBeep()
	Alerta("Erro: Codigo ja Registrado.")
	cCodi := StrZero( Val( cCodi ) + 1, nTam )
	lRetVal := FALSO
endif
AreaAnt( Arq_Ant, Ind_Ant )
return( lRetVal )

*==================================================================================================*		
	
def Instru80( nQualPorta, cArquivo )
   MEMVAR cStr
	LOCAL cScreen				:= SaveScreen()
	LOCAL Arq_Ant				:= Alias()
	LOCAL Ind_Ant				:= IndexOrd()   
   LOCAL aPrinter          := {}
	LOCAL nChoice
	LOCAL aNewLpt
   LOCAL nTamJan           := 0                  
	LOCAL i						:= 0
	LOCAL nStatus				:= 0
	STATI nPortaDeImpressao := 1
	PUBLI lCancelou			:= FALSO
	PRIVA aStatus				:= {}
	PRIVA aAction				:= {}
	PRIVA aComPort 			:= {}
   PRIVA aModelo           := {}
   PRIVA nPr               := 0 
   PRIVA nIndex            := 0    
	PRIVA aMenu
   PRIVA aModelo
   
	if len(oAmbiente:aLpt1) == 0 .or. len(oAmbiente:aLpd1) == 0
		oPrinter:EscolheImpressoraUsuario()
	endif
	
	if nQualPorta != NIL
		nQualPorta := nPortaDeImpressao
		return( true )
	endif
   
	ErrorBeep()
	while(true)
		oMenu:Limpa()
      aPrinter := CupsArrayPrinter()
		aMenu  	:= aPrinter[CUPS_MENU]
      aModelo 	:= aPrinter[CUPS_MODELO]
		aAction	:= aPrinter[CUPS_ACTION]
      aStatus  := aPrinter[CUPS_STATUS]
		aComPort := { "DISPONIVEL     ","INDISPONIVEL   " }
		alDisp   := { OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, true }
      nTamJan  := AmaxStrLen(aMenu) + 3
      nIndex   := Len(aMenu)

		MaBox( 05, 10, 05 + nIndex + 1, nTamJan + 1, nil , "ENTER=IMPRIMIR³CTRL/ALT+ENTER=ESCOLHER³CTRL+PGDN=ONLINE")
		nChoice := aChoice( 06, 11, 04 + nIndex + 1, nTamJan, aMenu, alDisp, "_Instru80" )
		if nChoice = 0 .OR. nChoice = 12
         if Conf("Pergunta: Cancelar Impressao ?")
            lCancelou := OK
            return false
         endif   
			Loop
		endif	
		
      aNewLpt := oAmbiente:aLpt1
      switch nChoice
      case 1
      case 7
      case 8
      case 9 
      case 11
         aNewLpt := oAmbiente:aLpt1
         exit
      case 2
         aNewLpt := oAmbiente:aLpt2
         exit         
      case 3
         aNewLpt := oAmbiente:aLpt3 
         exit
      case 13
      case 14
      case 15
      case 16
      case 17
      case 18
      case 19
      case 20
      case 21         
         aNewLpt := &("oAmbiente:aLpd" + trimstr(nChoice-12))
         exit
      endswitch
      
		AreaAnt( Arq_Ant, Ind_Ant )
		SetarVariavel( aNewLpt )
      oAmbiente:IsPrinter := nChoice
      do Case
		case nChoice = 0 .OR. nChoice = 12
			if lCancelou
				lCancelou := FALSO
				Loop
			endif
			if Conf("Pergunta: Cancelar Impressao ?")
				return( false )
			endif
		case nChoice = 7
			nPortaDeImpressao := 1
         return(SaidaParaUsb())
		case nChoice = 8 // Visualizar
			nPortaDeImpressao     := 1
         oAmbiente:lVisSpooler := true
			return( SaidaParaArquivo())
		case nChoice = 9
			nPortaDeImpressao := 1
			return(SaidaParaEmail())
		case nChoice = 10
			nPortaDeImpressao := 1
			return(SaidaParaHtml())
		case nChoice = 11
			nPortaDeImpressao     := 1
         oAmbiente:lVisSpooler := true
			return(SaidaParaSpooler())
      case nChoice >= 13 .and. nChoice <= 21
         oAmbiente:CupsPrinter := aModelo[nChoice-12]
         nPortaDeImpressao     := nChoice
         oAmbiente:lVisSpooler := false         
         if !(Isnil(cArquivo))
            oAmbiente:cArquivo := cArquivo
            cupsPrintFile( oAmbiente:CupsPrinter, cArquivo, "Macrosoft SCI for Linux")
            loop
         endif   			
			return(SaidaParaRedeCups(cArquivo))
		otherwise
			nPortaDeImpressao     := Iif( nChoice = 0, 1, nChoice )
			oAmbiente:cArquivo    := ""
			oAmbiente:Spooler     := FALSO
         oAmbiente:lVisSpooler := false
			oAmbiente:IsPrinter   := nChoice
			nQualPorta			    := nChoice
			if LptOk()
				ResTela( cScreen )
				return( true )
			endif
		endcase
	enddo
	ResTela( cScreen )
endef	

*==================================================================================================*			

def PrintOn( lFechaSpooler )
	LOCAL nQualPorta := 1
	LOCAL cSaida	  := ""
   LOCAL cLpr       := "|lpr -h -l -P"

	if lFechaSpooler = NIL
		AbreSpooler()
	endif
	Instru80( @nQualPorta )
   
	switch nQualPorta 
   case 1	
		cSaida := "LPT1"
      exit
	case 2
		cSaida := "LPT2"
      exit
	case 3
		cSaida := "LPT3"
      exit
	case 4
		cSaida := "COM1"
      exit
	case 5
		cSaida := "COM2"
      exit
	case 6
		cSaida := "COM3"   
      exit
	endswitch
   
   cSaida := cLpr += cSaida
	if lFechaSpooler == nil
		oMenu:StatInf()
		oAmbiente:nRegistrosImpressos := 0
	endif	
	Set Cons Off
	Set Devi To Print
	if !oAmbiente:Spooler
		if nQualPorta != 1
			Set Print To ( cSaida )
		endif
	endif
	Set Print On
	FPrint( RESETA )
	SetPrc(0,0)
	return Nil
endef

*==================================================================================================*		
	
def PrintOff()
	PrintOn( true )
	FPrint( RESETA )
	Set Devi To Screen
	Set Prin Off
	Set Cons On
	Set Print to
	CloseSpooler()
	return Nil
endef

*==================================================================================================*		

Proc InclusaoProdutos( lAlteracao )
***********************************
LOCAL cScreen	  := SaveScreen()
LOCAL GetList	  := {}
LOCAL lModificar := FALSO
LOCAL Arq_Ant	  := Alias()
LOCAL Ind_Ant	  := IndexOrd()
LOCAL cCodi 	  := Space(04)
LOCAL cCodi1	  := Space(04)
LOCAL cCodi2	  := Space(04)
LOCAL cCodi3	  := Space(04)
LOCAL cCodi4	  := Space(04)
LOCAL cRepres	  := Space(04)
LOCAL cCodigo	  := "000000"
LOCAL cGrupo	  := "000"
LOCAL cSub		  := "000.00"
LOCAL cDesc 	  := Space( 40 )
LOCAL cFab		  := Space(15)
LOCAL cCodeBar   := Space(13)
LOCAL cLocal	  := Space(10)
LOCAL cUn		  := "PC"
LOCAL nOpcao	  := 0
LOCAL nEmb		  := 0
LOCAL nQmin 	  := 0
LOCAL nQmax 	  := 0
LOCAL nPorc 	  := 0
LOCAL nTx_Icms   := 0
LOCAL nReducao   := 0
LOCAL nAtacado   := 0
LOCAL nVarejo	  := 0
LOCAL nPCompra   := 0
LOCAL nMarVar	  := 0
LOCAL nMarCus	  := 0
LOCAL nMarAta	  := 0
LOCAL nPcusto	  := 0
LOCAL nAm		  := 0
LOCAL nAc		  := 0
LOCAL nRo		  := 0
LOCAL nRr		  := 0
LOCAL nMt		  := 0
LOCAL cSituacao  := Space(01)
LOCAL cClasse	  := Space(02)
LOCAL cTam		  := Space(06)
LOCAL cSigla	  := Space(10)
LOCAL nDescMax   := 0
LOCAL cServico   := 'N'
LOCAL cSwap
LOCAL cSwapBar
LOCAL cString

if lAlteracao != NIL .AND. lAlteracao
	lModificar := OK
	if !PodeAlterar()
		ResTela( cScreen )
		Return
	endif
endif
if !lModificar
	if !PodeIncluir()
		 Restela( cScreen )
		Return
	endif
endif
oMenu:Limpa()
Area("Lista")
Lista->(Order( LISTA_CODIGO ))
#IFDEF DEMO
	if !lModificar
		if Lista->(LastRec()) >= 10
			ErrorBeep()
			Alerta("Erro: Limite de Inclusao de Produtos Excedido.;Por favor, registre sua copia.")
			ResTela( cScreen )
			Return
		endif
	endif
#endif
WHILE OK
	oMenu:Limpa()
	cClasse	 := IF( lModificar, Lista->Classe,			Lista->( Space( Len( Classe	  ))))
	cGrupo	 := IF( lModificar, Lista->CodGrupo,		Lista->( Space( Len( CodGrupo   ))))
	cSub		 := IF( lModificar, Lista->CodSGrupo,		Lista->( Space( Len( CodsGrupo  ))))
	cDesc 	 := IF( lModificar, Lista->Descricao,		Lista->( Space( Len( Descricao  ))))
	cFab		 := IF( lModificar, Lista->N_Original, 	Lista->( Space( Len( N_Original ))))
	cLocal	 := IF( lModificar, Lista->Local,			Lista->( Space( Len( Local 	  ))))
	cUn		 := IF( lModificar, Lista->Un,				Lista->( Space( Len( Un 		  ))))
	cUn		 := IF( lModificar, Lista->Un,				Lista->( Space( Len( Un 		  ))))
	cTam		 := IF( lModificar, Lista->Tam,				Lista->( Space( Len( Tam		  ))))
	cSituacao := IF( lModificar, Lista->Situacao,		Lista->( Space( Len( Situacao   ))))
	cCodi 	 := IF( lModificar, Lista->Codi, 			Lista->( Space( Len( Codi		  ))))
	cCodi1	 := IF( lModificar, Lista->Codi1,			Lista->( Space( Len( Codi1 	  ))))
	cCodi2	 := IF( lModificar, Lista->Codi2,			Lista->( Space( Len( Codi2 	  ))))
	cCodi3	 := IF( lModificar, Lista->Codi3,			Lista->( Space( Len( Codi3 	  ))))
	cRepres	 := IF( lModificar, Lista->Repres,			Lista->( Space( Len( Repres	  ))))
	cCodeBar  := IF( lModificar, Lista->CodeBar, 		Lista->( Space( Len( Codebar	  ))))
	nAm		 := IF( lModificar, Lista->Am,				0 )
	nAc		 := IF( lModificar, Lista->Ac,				0 )
	nMt		 := IF( lModificar, Lista->Mt,				0 )
	nRo		 := IF( lModificar, Lista->Ro,				0 )
	nRr		 := IF( lModificar, Lista->Rr,				0 )
	nEmb		 := IF( lModificar, Lista->Emb,				0 )
	nQmin 	 := IF( lModificar, Lista->Qmin, 			0 )
	nQmax 	 := IF( lModificar, Lista->Qmax, 			0 )
	nPorc 	 := IF( lModificar, Lista->Porc, 			0 )
	nDescMax  := IF( lModificar, Lista->Desconto,		0 )
	nMarVar	 := IF( lModificar, Lista->MarVar,			0 )
	nMarCus	 := IF( lModificar, Lista->MarCus,			0 )
	nMarAta	 := IF( lModificar, Lista->Marata,			0 )
	nPcusto	 := IF( lModificar, Lista->Pcusto,			0 )
	nVarejo	 := IF( lModificar, Lista->Varejo,			0 )
	nPCompra  := IF( lModificar, Lista->PCompra, 		0 )
	nAtacado  := IF( lModificar, Lista->Atacado, 		0 )
	nTx_Icms  := IF( lModificar, Lista->Tx_Icms, 		0 )
	nReducao  := IF( lModificar, Lista->Reducao, 		0 )
	cServico  := IF( lModificar, IF( Lista->Servico, 'S', 'N'), 'N')

	IF( !lModificar, Lista->(DbGoBottom()),)
	lSair 	:= FALSO
	cCodigo	:= IF( lModificar, Lista->Codigo, ProxCodigo( Lista->Codigo ))
	cString	:= IF( lModificar, "ALTERACAO DE PRODUTOS", "INCLUSAO DE NOVOS PRODUTOS")
	cSwap 	:= cCodigo
	cSwapBar := AllTrim(cCodeBar)

	WHILE OK
		MaBox( 01, 01, 23, 77, cString )
		@		 02, 02 Say "Codigo..............:" Get cCodigo   Pict "999999"  Valid CodiCerto( @cCodigo, lModificar, cSwap )
      @ Row()+1, 02 Say "Grupo...............:" Get cGrupo    Pict "999"     Valid GrupoCerto( @cGrupo, Row(), Col()+1 )
      @ Row()+1, 02 Say "SubGrupo............:" Get cSub      Pict "999.99"  Valid SubCerto( @cSub, Row(), Col()+1, cGrupo )
		@ Row()+1, 02 Say "Descricao...........:" Get cDesc     Pict "@!"
		@ Row()+1, 02 Say "Codigo Fabricante...:" Get cFab      Pict "@!"
		@ Row(),   40 Say "Localizacao.........:" Get cLocal    Pict "@!"
		@ Row()+1, 02 Say "Unidade.............:" Get cUn       Pict "@!"
		@ Row(),   40 Say "Embalagem...........:" Get nEmb      Pict "999"
		@ Row()+1, 02 Say "Estoque Minimo......:" Get nQmin     Pict "999999.99"
		@ Row(),   40 Say "Estoque Maximo......:" Get nQmax     Pict "999999.99"
		@ Row()+1, 02 Say "Porc.Vendedor.......:" Get nPorc     Pict "99.99"
		@ Row()	, 40 Say "Tamanho.............:" Get cTam      Pict "@!"
		@ Row()+1, 02 Say "Produto ‚ servi‡o...:" Get cServico  Pict "!" Valid PickSimNao( @cServico )
		@ Row(),   40 Say "Desconto Maximo.....:" Get nDescMax  Pict "99.99"
		@ Row()+1, 02 Say "Pre‡o de Compra.....:" Get nPCompra  Pict "99999999.99"

		@ Row()+1, 02 Say "Margem Custo........:" Get nMarCus   Pict "999.99" Valid CalculaVenda( nPCompra, nMarCus, @nPcusto )
		@ Row(),   40 Say "Pre‡o de Custo......:" Get nPcusto   Pict "99999999.99"
		@ Row()+1, 02 Say "Margem Varejo.......:" Get nMarVar   Pict "999.99" Valid CalculaVenda( nPcusto, nMarVar, @nVarejo )
		@ Row(),   40 Say "Pre‡o Varejo........:" Get nVarejo   Pict "99999999.99"
		@ Row()+1, 02 Say "Margem Atacado......:" Get nMarAta   Pict "999.99" Valid CalculaVenda( nPcusto, nMarAta, @nAtacado )
		@ Row(),   40 Say "Pre‡o Atacado.......:" Get nAtacado  Pict "99999999.99"
      @ Row()+1, 02 Say "Situa‡ao Tributaria.:" Get cSituacao Pict "9"  Valid PickSituacao( @cSituacao )
		@ Row(),   40 Say "Classificao Fiscal..:" Get cClasse   Pict "99" Valid PickClasse( @cClasse ) .AND. CadReducao( cClasse, @nAm, @nRo, @nMt, @nAc, @nRr, cDesc)
		@ Row()+1, 02 Say "Icms Substituicao...:" Get nTx_Icms  Pict "999"
		@ Row(),   40 Say "Reducao Base Calculo:" Get nReducao  Pict "999"
		@ Row()+1, 02 Say "Fabricante..........:" Get cCodi     Pict "9999" Valid Pagarrado( @cCodi,  Row(), Col()+5, @cSigla ) .AND. BarNewCode( @cCodebar, cCodi, cCodigo )
		@ Row()+1, 02 Say "Fornecedor 1........:" Get cCodi1    Pict "9999" Valid Pagarrado( @cCodi1, Row(), Col()+5 )
		@ Row()+1, 02 Say "Fornecedor 2........:" Get cCodi2    Pict "9999" Valid Pagarrado( @cCodi2, Row(), Col()+5 )
		@ Row()+1, 02 Say "Fornecedor 3........:" Get cCodi3    Pict "9999" Valid Pagarrado( @cCodi3, Row(), Col()+5 )
		@ Row()+1, 02 Say "Representante.......:" Get cRepres   Pict "9999" Valid Represrrado( @cRepres, Row(), Col()+5 )
		@ Row()+1, 02 Say "Codigo de Barra.....:" Get cCodeBar  Pict "9999999999999" Valid BarErrado( @cCodeBar, lModificar, cSwapBar )
		Read
		if LastKey() = ESC
			Set Key -4 To TabPreco	// F5
			Set Key -8 To
			Set Key F2 To
			Set Key F3 To
			AreaAnt( Arq_Ant, Ind_Ant )
			lSair := OK
			Exit
		endif
		ErrorBeep()
		if lModificar
			nOpcao := Alerta(" Pergunta: Voce Deseja ? ", {" Alterar", " Cancelar ", "Sair "})
		Else
			nOpcao := Alerta(" Pergunta: Voce Deseja ? ", {" Incluir", " Alterar ", "Sair "})
		endif
		if nOpcao = 1 // Incluir
			if lModificar
			  if !Lista->(TravaReg()) ; Loop ; endif
			Else
			  if !CodiCerto( @cCodigo, lModificar ) ; Loop ; endif
			  if !Lista->(Incluiu())					 ; Loop ; endif
			endif
			Lista->Codigo		:= cCodigo
			Lista->CodGrupo	:= cGrupo
			Lista->CodsGrupo	:= cSub
			Lista->Descricao	:= cDesc
			Lista->N_Original := cFab
			Lista->Un			:= cUn
			Lista->Emb			:= nEmb
			Lista->Qmin 		:= nQmin
			Lista->Qmax 		:= nQmax
			Lista->Porc 		:= nPorc
			Lista->Sigla		:= cSigla
			Lista->Data 		:= Date()
			Lista->Pcusto		:= nPcusto
			Lista->PCompra 	:= nPCompra
			Lista->Varejo		:= nVarejo
			Lista->Atacado 	:= nAtacado
			Lista->MarVar		:= CalcMargem( nPcusto,  nVarejo,  nMarVar )
			Lista->MarAta		:= CalcMargem( nPcusto,  nAtacado, nMarAta )
			Lista->MarCus		:= CalcMargem( nPCompra, nPcusto,  nMarCus )
			Lista->Classe		:= cClasse
			Lista->Situacao	:= cSituacao
			Lista->Tx_Icms 	:= nTx_Icms
			Lista->Reducao 	:= nReducao
			Lista->Local		:= cLocal
			Lista->Repres		:= cRepres
			Lista->Tam			:= cTam
			Lista->CodeBar 	:= cCodeBar
			Lista->Desconto	:= nDescMax
			Lista->Servico 	:= IF( cServico = 'S', OK, FALSO )
			Lista->Atualizado := Date()
			Lista->Am			:= nAm
			Lista->Ac			:= nAc
			Lista->Mt			:= nMt
			Lista->Ro			:= nRo
			Lista->Rr			:= nRr
			Lista->Codi 		:= cCodi
			Lista->Codi1		:= cCodi1
			Lista->Codi2		:= cCodi2
			Lista->Codi3		:= cCodi3
			Lista->(Libera())
			if lModificar
				lSair := OK
				Exit
			endif
			cCodigo := ProxCodigo( cCodigo)
		Elseif nOpcao = 2 // Alterar
			Loop
		Elseif nOpcao = 3 // Sair
			Set Key -4 To TabPreco	// F5
			Set Key -8 To
			Set Key F2 To
			Set Key F3 To
			AreaAnt( Arq_Ant, Ind_Ant )
			lSair := OK
			Exit
		endif
	EndDo
	if lSair
		if !lModificar
			ResTela( cScreen )
		endif
		Exit
	endif
EndDo
ResTela( cScreen )
Set Key F5 To TabPreco
Set Key F9 To InclusaoProdutos()
Return

Function CalcMargem( nCusto, nVenda, nMargem )
**********************************************
LOCAL nPorc := nMargem
if nVenda != 0
	nPorc := (( nVenda / nCusto ) * 100 ) - 100
	if nPorc > 999.99
		nPorc := 999.99
	Elseif nMargem < 0
		nPorc := 0
	endif
endif
if nPorc > 999.99
	nPorc := 999.99
endif
if nPorc < -99.99
	nPorc := -99.99
endif
Return( nPorc )

Function CadReducao( cClasse, nAm, nRo, nMt, nAc, nRr, cDescricao)
******************************************************************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen()

if cClasse != "20" .OR. LastKey() = UP
	Return( OK )
endif

oMenu:Limpa()
MaBox( 10, 10, 17, 70, "INCLUSAO DE REDUCAO BASE CALCULO")
@ 11, 11 Say "Produto.....: " + cDescricao
@ 12, 11 Say "Acre........:" Get nAc Pict "999.99"
@ 13, 11 Say "Amazonas....:" Get nAm Pict "999.99"
@ 14, 11 Say "Mato Grosso.:" Get nMt Pict "999.99"
@ 15, 11 Say "Rondonia....:" Get nRo Pict "999.99"
@ 16, 11 Say "Roraima.....:" Get nRr Pict "999.99"
Read
if LastKey() = ESC
	ResTela( cScreen )
	Return( FALSO )
endif
ErrorBeep()
if Conf("Pergunta: Confirma Inclusao ?")
	ResTela( cScreen )
	Return( OK )
endif
ResTela( cScreen )
Return( FALSO )

def NovoArquivo()
*****************
   LOCAL cTela
   LOCAL xAlias := "t" + StrTran( Time(),":") + ".tmp"

   Mensagem("Aguarde... Criando Arquivo de Trabalho.")
   WHILE File((xAlias))
      xAlias := "t" + StrTran( Time(),":") + ".tmp"
   EndDo
   return( (xAlias) )
endef   

Function RecErrado( Var, cCodi, nRow, nCol, cNome )
***************************************************
LOCAL aRotina			  := {{||CliInclusao()}}
LOCAL aRotinaAlteracao := {{||CliInclusao( OK )}}
LOCAL Arq_Ant			  := Alias()
LOCAL Ind_Ant			  := IndexOrd()
LOCAL nMaxCol          := MaxCol()

Area("Receber")
Receber->(Order( IF( Len( Var ) < 40, RECEBER_CODI, RECEBER_NOME )))
if Receber->(!DbSeek( Var ))
	Receber->(Order( RECEBER_NOME ))
	Receber->(DbGoTop())
	if nMaxCol > 80
		Receber->(Escolhe( 03, 00, MaxRow()-2,"Codi + 'Ý' + Nome + 'Ý' + Fone + 'Ý' + Fax + 'Ý' + Left( Fanta, 15 ) + 'Ý' + Ende", "CODI NOME DO CLIENTE                           TELEFONE #1    TELEFONE #2    POP             ENDERECO", aRotina, nil, aRotinaAlteracao ))
	else
		Receber->(Escolhe( 03, 00, MaxRow()-2,"Codi + 'Ý' + Nome + 'Ý' + Fone + 'Ý' + Left( Fanta, 15 )", "CODI NOME DO CLIENTE                          TELEFONE       POP     ", aRotina, nil, aRotinaAlteracao ))
	endif
endif
if nRow != Nil
	Write( nRow, nCol, Receber->Nome )
endif
Var   := IF( Len(Var) > 5, Receber->Nome, Receber->Codi )
cNome := Receber->Nome
cCodi := Receber->Codi
AreaAnt( Arq_Ant, Ind_Ant )
Return( OK )

Function FuncInclusao(lAlteracao)
*********************************
LOCAL GetList    := {}
LOCAL cScreen    := SaveScreen()
LOCAL lModificar := FALSO
LOCAL cCida      
LOCAL cEnde      
LOCAL cNome      
LOCAL cBair      
LOCAL cCon	     
LOCAL dData      
LOCAL cCpf	     
LOCAL cRg1	     
LOCAL cEsta      
LOCAL cCep	     
LOCAL cFone      
LOCAL cObs	     
LOCAL cCt	     
LOCAL nPorc      
LOCAL cString

if lAlteracao != NIL .AND. lAlteracao
	lModificar := OK
	if !PodeAlterar()
	   ResTela( cScreen )
		Return
	endif
endif

if !lModificar
	if !PodeIncluir()
		Restela( cScreen )
		Return
	endif
endif

Area("Vendedor")
Vendedor->(Order( VENDEDOR_CODIVEN ))
WHILE OK
   oMenu:Limpa()
	cNome 	  := IF( lModificar, Vendedor->Nome,		  Vendedor->( Space( Len( Nome 	))))
	cCida 	  := IF( lModificar, Vendedor->Cida,		  Vendedor->( Space( Len( Cida 	))))
	cEnde 	  := IF( lModificar, Vendedor->Ende,		  Vendedor->( Space( Len( Ende 	))))
	cBair 	  := IF( lModificar, Vendedor->Bair,		  Vendedor->( Space( Len( Bair 	))))	
   cCon   	  := IF( lModificar, Vendedor->Con,	   	  Vendedor->( Space( Len( Con 	))))
   dData   	  := IF( lModificar, Vendedor->Data,   	  Date())				
   cCpf   	  := IF( lModificar, Vendedor->Cpf,	   	  Vendedor->( Space( Len( Cpf 	))))
   cRg   	  := IF( lModificar, Vendedor->Rg,	   	  Vendedor->( Space( Len( Rg  	))))				
   cEsta  	  := IF( lModificar, Vendedor->Esta,   	  Vendedor->( Space( Len( Esta 	))))
   cCep   	  := IF( lModificar, Vendedor->Cep,	   	  Vendedor->( Space( Len( Cep 	))))
	cFone   	  := IF( lModificar, Vendedor->Fone,   	  Vendedor->( Space( Len( Fone 	))))
   cObs   	  := IF( lModificar, Vendedor->Obs,	   	  Vendedor->( Space( Len( Obs 	))))
   cCt   	  := IF( lModificar, Vendedor->Ct,	   	  Vendedor->( Space( Len( Ct  	))))		
	nPorc   	  := IF( lModificar, Vendedor->PorcCob,  	  0 )
				
	IF( !lModificar, Vendedor->(DbGoBottom()),)
	lSair 	:= FALSO
	
	IF( lModificar )
	   cCodi := Vendedor->CodiVen
	Else
		Vendedor->(Order(NATURAL))
		Vendedor->(DbGobottom())
		cCodi := StrZero(Val( Vendedor->Codiven ) + 1, 4 )
	endif
	cString	:= IF( lModificar, "ALTERACAO DE FUNCIONARIO", "INCLUSAO DE FUNCIONARIO")
	WHILE OK
		MaBox( 06, 02, 22, 78, cString )
		@ 07, 24 Say Vendedor->CodiVen + " " + Vendedor->Nome
		@ 07, 03 Say "Codigo........:" Get cCodi Pict "9999" Valid FunCerto( @cCodi, lModificar )
		@ 08, 03 Say "Data Cadastro.:" Get dData Pict "##/##/##"
		@ 09, 03 Say "Nome..........:" Get cNome Pict "@!"
		@ 10, 03 Say "CPF...........:" Get cCpf  Pict "999.999.999-99" Valid TestaCpf( cCpf )
		@ 11, 03 Say "Rg............:" Get cRg   Pict "@!"
		@ 12, 03 Say "Cart.Trabalho.:" Get cCt   Pict "@!"
		@ 13, 03 Say "Cep...........:" Get cCep  Pict "99999-999" Valid CepErrado( @cCep, @cCida, @cEsta, @cBair )
		@ 14, 03 Say "Endereco......:" Get cEnde Pict "@!"
		@ 15, 03 Say "Bairro........:" Get cBair Pict "@!"
		@ 16, 03 Say "Cidade........:" Get cCida Pict "@!"
		@ 17, 03 Say "Estado........:" Get cEsta Pict "@!"
		@ 18, 03 Say "Telefone......:" Get cFone Pict PIC_FONE
		@ 19, 03 Say "Contato.......:" Get cCon  Pict "@!"
		@ 20, 03 Say "Observacoes...:" Get cObs  Pict "@!"
		@ 21, 03 Say "Porc Cobranca.:" Get nPorc Pict "99.99"
		Read
		
		if LastKey() = ESC
			lSair := OK
			Exit
		endif
		ErrorBeep()
		if lModificar
			nOpcao := Alerta(" Pergunta: Voce Deseja ? ", {" Alterar", " Cancelar ", "Sair "})
		Else
			nOpcao := Alerta(" Pergunta: Voce Deseja ? ", {" Incluir", " Alterar ", "Sair "})
		endif	
		
		if nOpcao = 1 // Incluir
			if lModificar
				if !Vendedor->(TravaReg()) ; Loop ; endif
			Else
				if !FunCerto( @cCodi, lModificar ) ; Loop ; endif
				if !Vendedor->(Incluiu())			  ; Loop ; endif
			endif
		
			Vendedor->CodiVen := cCodi
			Vendedor->Data 	:= dData
			Vendedor->Nome 	:= cNome
			Vendedor->Rg		:= cRg
			Vendedor->Ende 	:= cEnde
			Vendedor->Bair 	:= cBair
			Vendedor->Cida 	:= cCida
			Vendedor->Con		:= cCon
			Vendedor->Obs		:= cObs
			Vendedor->Cpf		:= cCpf
			Vendedor->Esta 	:= cEsta
			Vendedor->Cep		:= cCep
			Vendedor->Fone 	:= cFone
			Vendedor->Ct		:= cCt
			Vendedor->PorcCob := nPorc
			Vendedor->(Libera())
			
			if lModificar
			   if !Empty(vendedor->senha)
					cStr := "Deseja TROCAR a SENHA deste vendedor/cobrador ?"
				else	
					cStr := "Deseja ALTERAR a SENHA deste vendedor/cobrador ?"
				endif
			else	
				cStr := "Deseja CADASTRAR a SENHA deste vendedor/cobrador ?"
			endif
			
			if Conf( cStr )
				CadastraSenha( cCodi )
			endif
			
			if lModificar
				lSair := OK
			endif
			Exit
			
		Elseif nOpcao = 2 // Alterar
			Loop
		Elseif nOpcao = 3 // Sair
			lSair := OK
			Exit
		endif
	EndDO
	if lSair
		ResTela( cScreen )
		Exit
	endif
EndDo

Function FunCerto( cCodi, lModificar)
*************************************
LOCAL Arq_Ant	  := Alias()
LOCAL Ind_Ant	  := IndexOrd()

if Empty( cCodi )
	ErrorBeep()
   Alerta( "ERRO: Codigo de vendedor invalido.")
	Return( FALSO )
endif

if lModificar != nil
   if lModificar
	   return( OK )
   endif
endif	
Vendedor->(Order( VENDEDOR_CODIVEN ))
if Vendedor->(!DbSeek(cCodi))
	AreaAnt( Arq_Ant, Ind_Ant )
	Return(OK)
endif
ErrorBeep()
Alerta( "ERRO: Codigo de vendedor ja registrado.")
cCodi := StrZero( Val( cCodi ) + 1,4)
AreaAnt( Arq_Ant, Ind_Ant )
Return( FALSO )

Function CadastraSenha( cCodi )
*******************************
LOCAL GetList	  := {}
LOCAL cScreen	  := SaveScreen()
LOCAL Arq_Ant	  := Alias()
LOCAL Ind_Ant	  := IndexOrd()
LOCAL lParametro := FALSO
LOCAL cPasse     := Space(10)

oMenu:Limpa()
WHILE OK
	Area("Vendedor")
	Vendedor->(Order( VENDEDOR_CODIVEN ))
	MaBox( 15, 11, 18, 67 )
	if cCodi = NIL
		cCodi := Space(04)
	endif
	@ 16, 12 Say "Codigo..:" Get cCodi  Pict "9999" Valid FunErrado( @cCodi,, Row(), Col()+1 )
	@ 17, 12 Say "Senha...:" Get cPasse Pict "@S"   Valid FunSenha( cCodi, cPasse )	
	Read
	
	if LastKey() = ESC
		AreaAnt( Arq_Ant, Ind_Ant )
		ResTela( cScreen )
		return FALSO
	endif
	ResTela( cScreen )
	AreaAnt( Arq_Ant, Ind_Ant )
	return OK
EndDo

Function FunSenha( cCodi, cPasse)
*********************************
LOCAL Arq_Ant    := Alias()
LOCAL Ind_Ant    := IndexOrd()
LOCAL cPassOld   := space(10)
LOCAL cScreen	  := SaveScreen()

if !Empty( Vendedor->Senha )
	ErrorBeep()
	if !Conf("Pergunta: Senha do Vendedor Ja Registrada, Trocar ?")
		return FALSO
	endif
	cPasse := Space(10)
	MaBox( 19, 11, 22, 40 )
	@ 20, 12 Say "Anterior...:" Get cPassOld Pict "@S" valid SenhaCerta( cCodi, cPassOld )
	@ 21, 12 Say "Nova Senha.:" Get cPasse   Pict "@S" 
	read
	if LastKey() = ESC
	   ResTela( cScreen )
		return FALSO
	endif	
endif   
if Conf( "Pergunta: Confirma Registro da Senha ?")
   if Vendedor->(TravaReg())
  	   Vendedor->Senha := MsEncrypt(Upper(cPasse))
	   Vendedor->(Libera())
   endif
endif
AreaAnt( Arq_Ant, Ind_Ant )
ResTela( cScreen )
return OK


Function FunErrado( Var, cCodi, nCol, nRow, cNome )
***************************************************
LOCAL aRotinaInc := {{||FuncInclusao()}}
LOCAL aRotinaAlt := {{||FuncInclusao(OK)}}
LOCAL Arq_Ant    := Alias()
LOCAL Ind_Ant    := IndexOrd()

Area( "VendeDor")
Vendedor->(Order( IF( Len( Var ) < 40, VENDEDOR_CODIVEN, VENDEDOR_NOME )))
if Vendedor->(!DbSeek( Var ))
	Vendedor->(Order( VENDEDOR_NOME ))
	Vendedor->(Escolhe( 03, 01, MaxRow()-2, "CodiVen + 'Ý' + Nome + 'Ý' + Fone", "CODI NOME DO VENDEDOR" + Space(25)+ "TELEFONE", aRotinaInc, NIL, aRotinaAlt ))
	Var := IF( Len( Var ) > 4, Vendedor->Nome, Vendedor->CodiVen )
endif
cCodi := Vendedor->CodiVen
if cNome != NIL
	cNome := Vendedor->Nome
endif
if nCol != NIL
	Write( nCol, nRow, Vendedor->Nome )
endif
AreaAnt( Arq_Ant, Ind_Ant )
return( OK )

Function FunAcha( cCpf )
***********************
LOCAL aRotinaInc := {{||FuncInclusao()}}
LOCAL aRotinaAlt := {{||FuncInclusao(OK)}}

if Vendedor->(!DbSeek( cCpf ))
   Vendedor->(Escolhe( 03, 01, MaxRow()-2, "CodiVen + 'Ý' + Nome + 'Ý' + Fone", "CODI NOME DO VENDEDOR" + Space(25)+ "TELEFONE", aRotinaInc, NIL, aRotinaAlt ))
	IF( Len( cCpf ) > 14, cCpf := Vendedor->Nome, cCpf := Vendedor->Cpf )
endif
Return( OK )

Function FazBrowse( nLinT, nColT, nLinB, nColb, cCabecalho )
************************************************************
LOCAL oBrowse		:= TBrowseDb( nLint, nColt, nLinb, nColb )
LOCAL cFrame2		:= SubStr( oAmbiente:Frame, 2, 1 )
LOCAL cFrame3		:= SubStr( oAmbiente:Frame, 3, 1 )
LOCAL cFrame4		:= SubStr( oAmbiente:Frame, 4, 1 )
LOCAL cFrame6		:= SubStr( oAmbiente:Frame, 6, 1 )
LOCAL oColuna1
LOCAL oColuna2
LOCAL oColuna3
LOCAL oColuna4
LOCAL oColuna5
LOCAL oColuna6
LOCAL oColuna7
LOCAL oColuna8
LOCAL oColuna9
LOCAL oColuna10

FIELD Quant
FIELD Codigo
FIELD Descricao
FIELD Unitario
FIELD Local

oBrowse:HeadSep	:= cFrame2 + cFrame3 + cFrame2
oBrowse:ColSep 	:= Chr(032) + cFrame4 + Chr(032)
oBrowse:FootSep	:= cFrame2	+ cFrame2 + cFrame2
oBrowse:colorSpec := "N/W, W+/G, B/W, B/BG, B/W, B/BG, R/W, W+/R"
oColuna1 			:= TBColumnNew( "QUANT"             ,  {|| Quant } )
oColuna2 			:= TBColumnNew( "CODI",                {|| Codigo } )
oColuna3 			:= TBColumnNew( "DESCRICAO DO PRODUTO",{|| Descricao } )
oColuna4 			:= TBColumnNew( "UNITARIO",            {|| Tran(Unitario,"@E 99,999,999.99")})
oColuna5 			:= TBColumnNew( "TOTAL ITEM",          {|| Tran(Unitario * Quant ,"@E 9,999,999,999.99")})
oColuna6 			:= TBColumnNew( "CUSTO",               {|| Tran(Pcusto, "@E 999,999.99")})
oColuna7 			:= TBColumnNew( "TOTAL CUSTO",         {|| Tran(Pcusto * Quant, "@E 999,999.99")})
oColuna8 			:= TBColumnNew( "MARGEM",              {|| Tran(((Unitario/Pcusto)*100)-100, "@E 999.99%")})
oColuna9 			:= TBColumnNew( "CMV",                 {|| Tran(((Pcusto/Unitario)*100), "@E 999.99%")})
oColuna10			:= TBColumnNew( "LOCAL",               {|| Local })
oBrowse:AddColumn( oColuna1 )
oBrowse:AddColumn( oColuna2 )
oBrowse:AddColumn( oColuna3 )
oBrowse:AddColumn( oColuna4 )
oBrowse:AddColumn( oColuna5 )
oBrowse:AddColumn( oColuna6 )
oBrowse:AddColumn( oColuna7 )
oBrowse:AddColumn( oColuna8 )
oBrowse:AddColumn( oColuna9 )
oBrowse:AddColumn( oColuna10)
oColuna1:DefColor := {7,8 }
oColuna4:DefColor := {7,8 }
oColuna5:DefColor := {7,8 }
oColuna6:DefColor := {7,8 }
oColuna7:DefColor := {7,8 }
oColuna8:DefColor := {7,8 }
oColuna9:DefColor := {7,8 }
oColuna2:Width 	:= 6
oColuna3:Width 	:= 20
Return( oBrowse )

Function BrowseEntradas( nLinT, nColT, nLinB, nColb, cCabecalho )
****************************************************************
LOCAL oBrowse		:= TBrowseDb( nLint, nColt, nLinb, nColb )
LOCAL cFrame2		:= SubStr( oAmbiente:Frame, 2, 1 )
LOCAL cFrame3		:= SubStr( oAmbiente:Frame, 3, 1 )
LOCAL cFrame4		:= SubStr( oAmbiente:Frame, 4, 1 )
LOCAL cFrame6		:= SubStr( oAmbiente:Frame, 6, 1 )
LOCAL oColuna1
LOCAL oColuna2
LOCAL oColuna3
LOCAL oColuna4
LOCAL oColuna5
FIELD Quant
FIELD Codigo
FIELD Descricao
FIELD Unitario

oBrowse:HeadSep	:= cFrame2 + cFrame3 + cFrame2
oBrowse:ColSep 	:= Chr(032) + cFrame4 + Chr(032)
oBrowse:FootSep	:= cFrame2	+ cFrame2 + cFrame2
oBrowse:colorSpec := "N/W, W+/G, B/W, B/BG, B/W, B/BG, R/W, W+/R"
oColuna1 			:= TBColumnNew( "QUANT"             ,  {|| Quant } )
oColuna2 			:= TBColumnNew( "CODI",                {|| Codigo } )
oColuna3 			:= TBColumnNew( "DESCRICAO DO PRODUTO",{|| Descricao } )
oColuna4 			:= TBColumnNew( "CUSTO NFF",           {|| Tran(Unitario,"@E 99,999,999.99")})
oColuna5 			:= TBColumnNew( "TOTAL ITEM",          {|| Tran(Unitario * Quant ,"@E 9,999,999,999.99")})
oColuna6 			:= TBColumnNew( "FRETE",               {|| Tran(Frete,    "999.99")})
oColuna7 			:= TBColumnNew( "IMPOSTO",             {|| Tran(Imposto,  "999.99")})
oColuna8 			:= TBColumnNew( "CUSTO FINAL",         {|| Tran(CustoFinal, "@E 999,999.99")})
oBrowse:AddColumn( oColuna1 )
oBrowse:AddColumn( oColuna2 )
oBrowse:AddColumn( oColuna3 )
oBrowse:AddColumn( oColuna4 )
oBrowse:AddColumn( oColuna5 )
oBrowse:AddColumn( oColuna6 )
oBrowse:AddColumn( oColuna7 )
oBrowse:AddColumn( oColuna8 )
oColuna1:DefColor := {7,8 }
oColuna4:DefColor := {7,8 }
oColuna5:DefColor := {7,8 }
oColuna6:DefColor := {7,8 }
oColuna7:DefColor := {7,8 }
oColuna2:Width 	:= 6
oColuna3:Width 	:= 20
Return( oBrowse )

Function BaixaDocnr( cDocnr, nRegistro )
****************************************
LOCAL cScreen	 := SaveScreen()
LOCAL GetList	 := {}
LOCAL Arq_Ant	 := Alias()
LOCAL Ind_Ant	 := IndexOrd()
LOCAL nTam		 := 0
LOCAL aDocnr	 := {}
LOCAL aRegistro := {}
LOCAL aTodos	 := {}
LOCAL xTodos	 := {}
LOCAL cCodi 	 := Space(05)
LOCAL nChoice	 := 0
LOCAL xLen		 := 0
LOCAL nT 		 := 0

oMenu:Limpa()
MaBox( 15, 01, 17, 78 )
@ 16, 02 Say "Codigo Cliente..: " Get cCodi Pict PIC_RECEBER_CODI Valid RecErrado( @cCodi,, 16, 35 )
Read
if LastKey() = ESC
	AreaAnt( Arq_Ant, Ind_Ant )
	ResTela( cScreen )
	Return( FALSO )
endif
Area("Recemov")
Recemov->(Order( RECEMOV_CODI ))
if Recemov->(!DbSeek( cCodi ))
	ErrorBeep()
	Alerta( "Erro: Nenhum Debito em Aberto Deste Cliente." )
	AreaAnt( Arq_Ant, Ind_Ant )
	ResTela( cScreen )
	Return( FALSO )
endif
WHILE Recemov->Codi = cCodi
	Recemov->(Aadd( xTodos, {Docnr, Emis, Vcto, Vlr, Recno(), Obs}))
	Recemov->(DbSkip(1))
EndDo
if (nTam := Len( xTodos )) = 0
	ErrorBeep()
	Alerta( "Erro: Nenhum Debito em Aberto Cliente." )
	AreaAnt( Arq_Ant, Ind_Ant )
	ResTela( cScreen )
	Return( FALSO )
endif
Asort( xTodos,,, {|x,y|y[3]>x[3]}) // ordenar por vcto
xLen := Len(xTodos)
For nT := 1 To xLen
	Aadd( aDocnr,	  xTodos[nT,1])
	Aadd( aRegistro, xTodos[nT,5])
	Aadd( aTodos,	  xTodos[nT,1] + " " + Dtoc(xTodos[nT,2]) + " " + Dtoc(xTodos[nT,3]) + " " + Tran(xTodos[nT,4],"@E 999,999,999.99") + " " + xTodos[nT,6])
Next
MaBox( 01, 01, 14, 78, "DOCTO  N§  EMISSAO   VENCTO          VALOR OBSERVACAO" + Space(23))
nChoice := aChoice( 02, 02, 13, 77, aTodos )
ResTela( cScreen )
if nChoice = 0
	AreaAnt( Arq_Ant, Ind_Ant )
	Alerta( "Erro: Procura Cancelada..." )
	ResTela( cScreen )
	Return( FALSO )
endif
cDocnr	 := aDocnr[ nChoice ]
nRegistro := aRegistro[ nChoice ]
AreaAnt( Arq_Ant, Ind_Ant )
ResTela( cScreen )
Return( OK )

Proc Autenticar( nRecno, nSobra )
*********************************
LOCAL cScreen := SaveScreen()
LOCAL cValor  := Space(0)
LOCAL nValor  := Space(0)
LOCAL cHist   := Space(60)
LOCAL nVlr	  := 0
LOCAL Larg	  := 76
LOCAL nOpcao  := 1
LOCAL cDocnr

Receber->(Order( RECEBER_CODI ))
Area("Recebido")
Set Rela To Codi Into Receber
Recebido->(Order( RECEBIDO_DOCNR ))
Recebido->(DbGoTo( nRecno ))
cDocnr := Recebido->Docnr
nVlr	 := Recebido->VlrPag
cValor := AllTrim( Tran( nVlr,'@E 999,999.99'))
ErrorBeep()
For i := 1 To 3
	if !Instru80()
		Recebido->(DbClearRel())
		Restela( cScreen )
		Return
	endif
	Mensagem("Aguarde, Autenticando.")
	PrintOn()
	FPrInt( PQ )
	SetPrc(0,0)
	Qout("*MP*" + cDocnr + "*" + Dtoc( Date()) + "*" + cValor + "*" + Left( Receber->Nome,4 ) + "*")
	Qout("*MP*" + cDocnr + "*" + Dtoc( Date()) + "*" + cValor + "*" + Left( Receber->Nome,4 ) + "*")
	PrintOff()
Next
ResTela( cScreen )
Return

Function DocErrado( Var, nValor, nVlrTotal, dVcto, cHist, nRow, nCol, lLancarJurosNaoPago )
******************************************************************************************
LOCAL Arq_Ant		 := Alias()
LOCAL Ind_Ant		 := IndexOrd()
LOCAL nRegistro	 := 0
LOCAL cComplemento := Space(0)
LOCAL cString		 := Space(0)
LOCAL nTam
DEFAU lLancarJurosNaoPago TO FALSO

#IFDEF MICROBRAS
	cComplemento := "PAG PARCIAL "
	cString		 := "PARCELA CONTRATO SERVICOS DE INTERNET."
	cHist 		 := cString + Space(60-Len(cString))
#endif

Receber->(Order( RECEBER_CODI ))
Area("Recemov")
if ( Recemov->(DbGoTop()), Recemov->(Eof()))
	AreaAnt( Arq_Ant, Ind_Ant )
	Nada()
	Return( FALSO )
endif
IfNil( nVlrTotal, 0)
if ( Recemov->(Order( RECEMOV_DOCNR )), Recemov->(!DbSeek( Var )))
   if !lLancarJurosNaoPago
	   ErrorBeep()
		if Conf("Erro: Documento nao Encontrado. Localizar por Nome?")
			if BaixaDocnr( @Var, @nRegistro )
				Recemov->( DbGoTo( nRegistro ))
				nValor    := Round(IF( nVlrTotal <= 0, Recemov->Vlr, nVlrTotal),2)
				nVlrTotal := Round(IF( nVlrTotal <= 0, CalcJuros(), nVlrTotal),2)
				dVcto 	 := Recemov->Vcto
				nTam		 := Len(AllTrim(Recemov->Obs))
				cHist 	 := IF( Empty(Recemov->Obs), cComplemento + cHist, cComplemento + Left(Recemov->Obs,nTam) + Space((60-12-nTam)))
				if nRow != NIL
					Write( nRow, nCol, Receber->Nome )
				endif
				AreaAnt( Arq_Ant, Ind_Ant )
				Return( OK )
			endif
		endif
		Receber->(Order( RECEBER_CODI ))
		Area("Recemov")
		Recemov->(Order( RECEMOV_DOCNR ))
		Set Rela To Recemov->Codi Into Receber
		Recemov->(DbGoTop())
		Recemov->(Escolhe( 03, 01, MaxRow()-2, "Docnr + 'Ý' + Receber->Nome", "DOCTO N§  NOME DO CLIENTE" ))
	else
		AreaAnt( Arq_Ant, Ind_Ant )
		Return( FALSO )
	endif	
endif
Var		 := Recemov->Docnr
nValor    := Round(IF( nVlrTotal <= 0, Recemov->Vlr, nVlrTotal),2)
nVlrTotal := Round(IF( nVlrTotal <= 0, CalcJuros(), nVlrTotal),2)
dVcto 	 := Recemov->Vcto
nTam		 := Len(AllTrim(Recemov->Obs))
cHist 	 := IF( Empty(Recemov->Obs), cComplemento + cHist, cComplemento + Left(Recemov->Obs,nTam) + Space((60-12-nTam)))
if nRow != NIL
	Write( nRow, nCol, Receber->Nome )
endif
AreaAnt( Arq_Ant, Ind_Ant )
Return(OK)

Function CheErrado( cCodi, cCodi1, nLinha, nCol, lOpcional )
************************************************************
LOCAL aRotina := {{|| Cheq11() }}
LOCAL cScreen := SaveScreen()
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
FIELD Codi
FIELD Titular
//MEMVAR cField_Name
//MEMVAR cName_Cabec

if LastKey() = UP
	Return( OK )
endif
if lOpcional != Nil
	if Empty( cCodi )
		if nLinha != Nil
			Write( nLinha, nCol, "MOVIMENTO CONTRA PARTIDA NAO LANCADO")
		endif
		Keyb Chr( ENTER )
		AreaAnt( Arq_Ant, Ind_Ant )
		Return( OK )
	endif
endif
Area("Cheque")
Order( IF( Len( cCodi ) < 40, CHEQUE_CODI, CHEQUE_TITULAR ))
if !( DbSeek( cCodi ) )
	Order( CHEQUE_TITULAR )
	DbGoTop()
	Escolhe( 03, 01, MaxRow()-2, "Codi + 'Ý' + Titular","CODI TITULAR DA CONTA", aRotina  )
	cCodi  := IF( Len( cCodi ) = 4, Codi,	  Titular )
	if cCodi1 != Nil
		cCodi1 := IF( Len( cCodi1 ) = 4, Codi, 	Titular )
	endif
endif
if nLinha != Nil
	Write( nLinha, nCol, Titular )
endif
AreaAnt( Arq_Ant, Ind_Ant )
Return(OK)

Proc Paga22( cCaixa )
*********************
LOCAL cScreen := SaveScreen( )
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
LOCAL GetList := {}
LOCAL nLancar := 0
LOCAL cDocnr
LOCAL dData
LOCAL nVlr
LOCAL cFone
LOCAL cPort
LOCAL nDebito
LOCAL nJuro
LOCAL cCida
LOCAL cEsta
LOCAL cCep
LOCAL cEnde
LOCAL nRecno
LOCAL cCodi
LOCAL cNome
LOCAL dEmis
LOCAL dVcto
LOCAL ctipo
LOCAL cDc
LOCAL nAtraso
LOCAL nTotJuros
LOCAL nVlrTotal
LOCAL nVlrPago
LOCAL cCodiCx
LOCAL lOk_Baixo
LOCAL nRecno1
LOCAL cFatura
LOCAL cCodiCx1
LOCAL cCodiCx2
LOCAL cCodiCx3
LOCAL cDc1
LOCAL cDc2
LOCAL cDc3
LOCAL cObs1
LOCAL cObs2
LOCAL cHist
LOCAL nCol
LOCAL nRow
LOCAL nJuroDia
LOCAL lEmitir
LOCAL nChSaldo
LOCAL cHist2
LOCAL nDiferenca

FIELD Nome
FIELD CodiVen
FIELD Vlr
FIELD Fone
FIELD Port
FIELD Tipo
FIELD Cida
FIELD Ende
FIELD Codi
FIELD Emis
FIELD Vcto
FIELD Esta
FIELD Cep
FIELD Juro
FIELD Docnr

if !PodePagar()
	ResTela( cScreen )
	Return
endif

WHILE OK
	oMenu:Limpa()
	MaBox( 15, 10, 17, 31 )
	cDocnr := Space( 09 )
	@ 16, 11 Say "Doc.No.." Get cDocnr Pict  "@!" Valid PgDocErrad( @cDocnr )
	Read
	if LastKey() = ESC
		ResTela( cScreen )
		Exit
	endif
	if Pagamov->(!TravaReg())
		Loop
	endif
	Pagar->(Order( PAGAR_CODI ))
	Area( "PagaMov" )
	Set Rela To Codi Into Pagar
	dData 	 := Date()
	nVlr		 := Pagamov->Vlr
	cPort 	 := Pagamov->Port
	cTipo 	 := Pagamov->Tipo
	nJuro 	 := Pagamov->Juro
	cDocnr	 := Pagamov->Docnr
	cFatura	 := Pagamov->Fatura
	cCodiCx	 := "0000"
	cCodiCx1  := Space(04)
	cCodiCx2  := Space(04)
	cCodiCx3  := Space(04)
	cDc		 := "D"
	cDc1		 := "D"
	cDc2		 := "C"
	cDc3		 := "C"
	cCodi 	 := Pagamov->Codi
	dEmis 	 := Pagamov->Emis
	dVcto 	 := Pagamov->Vcto
	nVlr		 := Pagamov->Vlr
	cObs1 	 := Pagamov->Obs1
	cObs2 	 := Pagamov->Obs2
	cNome 	 := Pagar->Nome
	cHist 	 := "PAG " + cNome
	WHILE OK
		nCol := 06
		nRow := 02
		MaBox( 02, 05 , nRow+18 , 79, "PAGAMENTOS" )
		@ nRow+01, nCol	 SAY "Fornecedor..: " + Pagar->Codi + " " + Pagar->Nome
		@ nRow+02, nCol	 SAY "Tipo........: " + cTipo
		@ nRow+02, nCol+35 SAY "Docto N§....: " + cDocnr
		@ nRow+03, nCol	 SAY "Emissao.....: " + Dtoc( Emis )
		@ nRow+03, nCol+35 SAY "Vencto......: " + Dtoc( Vcto )
		@ nRow+04, nCol	 SAY "Juros Mes...: " + Tran( nJuro , "@E 9,999,999,999.99" )
		@ nRow+04, nCol+35 SAY "Dias Atraso.: "
		@ nRow+05, nCol	 SAY "Valor.......: " + Tran( Vlr ,      "@E 9,999,999,999.99" )
		@ nRow+05, nCol+35 SAY "Desconto....: " + Tran( Desconto , "@E 999.99" )
		@ nRow+06, nCol	 SAY "Jrs Devidos.: "
		@ nRow+07, nCol	 SAY "Vlr c/Juros.: "
		@ nRow+07, nCol+35 SAY "Vlr c/ Desc.: "
		@ nRow+08, nCol	 SAY "Data Pgto...: " Get dData Pict "##/##/##"
		Read
		if LastKey() = ESC
			Exit
		endif
		nAtraso	:= Atraso( dData, Vcto )
		nJuroDia := JuroDia( Vlr, nJuro )
		if nAtraso <= 0
			nTotJuros := 0
			nVlrTotal := Vlr
			nVlrTotal -= Desconto
		Else
			nTotJuros := ( nAtraso * nJuroDia )
			nVlrTotal := ( nTotJuros + Vlr )
		endif
		nVlrPago := nVlrTotal

		Write( nRow+04, nCol+35, "Dias Atraso.: " + Tran( nAtraso,   "99999") + " Dias" )
		Write( nRow+06, nCol,	 "Jrs Devidos.: " + Tran( nTotJuros, "@E 9,999,999,999.99"))
		Write( nRow+07, nCol,	 "Vlr c/juros.: " + Tran( nVlrTotal, "@E 9,999,999,999.99"))
		Write( nRow+07, nCol+35, "Vlr c/ Desc.: " + Tran( nVlrPago,  "@E 9,999,999,999.99"))

		@ nRow+09, nCol	 Say "Valor Pago..: " GET nVlrPago Pict "@E 9,999,999,999.99"
		@ nRow+10, nCol	 Say "Portador....: " GET cPort    Pict "@!"
		@ nRow+11, nCol	 Say "Conta Caixa.: " GET cCodiCx  Pict "9999" Valid LastKey() = UP .OR. CheErrado( @cCodiCx,,  Row(), 35 )
		@ nRow+11, nCol+20 Say "D/C.:"          GET cDc      Pict "!"    Valid PickTam({'Credito em conta','Debito em conta'}, {'C','D'}, @cDc )
		@ nRow+12, nCol	 Say "C. Partida..: " GET cCodiCx1 Pict "9999" Valid LastKey() = UP .OR. CheErrado( @cCodiCx1,, Row(), 35, OK )
		@ nRow+12, nCol+20 Say "D/C.:"          GET cDc1     Pict "!"    Valid PickTam({'Credito em conta','Debito em conta'}, {'C','D'}, @cDc1 )
		@ nRow+13, nCol	 Say "C. Partida..: " GET cCodiCx2 Pict "9999" Valid LastKey() = UP .OR. CheErrado( @cCodiCx2,, Row(), 35, OK )
		@ nRow+13, nCol+20 Say "D/C.:"          GET cDc2     Pict "!"    Valid PickTam({'Credito em conta','Debito em conta'}, {'C','D'}, @cDc2 )
		@ nRow+14, nCol	 Say "C. Partida..: " GET cCodiCx3 Pict "9999" Valid LastKey() = UP .OR. CheErrado( @cCodiCx3,, Row(), 35, OK )
		@ nRow+14, nCol+20 Say "D/C.:"          GET cDc3     Pict "!"    Valid PickTam({'Credito em conta','Debito em conta'}, {'C','D'}, @cDc3 )
		@ nRow+15, nCol	 Say "Historico...: " GET cHist    Pict "@!"   Valid LastKey() = UP .OR. !Empty( cHist )
		@ nRow+16, nCol	 Say "Observacoes.: " GET cObs1    Pict "@!"
		@ nRow+17, nCol	 Say "Observacoes.: " GET cObs2    Pict "@!"
		Read
		if LastKey() = ESC
			Exit
		endif
		lOk_Baixo := Conf(" Pergunta: Baixar Registro ? ", {" Sim ", " Alterar ", " Sair " })
		if 	 lOk_Baixo = 2 // Alterar
			Loop
		Elseif lOk_Baixo = 1 // Baixar
			lEmitir := 1
			if nVlrPago <> nVlrTotal
				ErrorBeep()
				lEmitir := Conf("Valor pago diferente que o devido.;;Pergunta: Fazer Baixa como:",;
									  {"Quitar", "Parcial", "Diferenca C/C", "Cancelar"})
				if lEmitir = 4
					Loop
				endif
				if lEmitir = 3
					cCodiCx2 := Space(04)
					cDc2		:= " "
					cHist2	:= cHist
					MaBox( nRow+15, 05 , nRow+18 , 74, "LANCAMENTOS DIFERENCA C/C")
					@ nRow+16, nCol	 Say "Conta Caixa.: " GET cCodiCx2  Pict "9999" Valid CheErrado( @cCodiCx2,, Row(), nCol+28 )
					@ nRow+16, nCol+20 Say "D/C.:"          GET cDc2      Pict "!" Valid cDc2 $ "DC"
					@ nRow+17, nCol	 Say "Historico...: " GET cHist2    Pict "@!" Valid !Empty( cHist2 )
					Read
					if LastKey() = ESC
						Loop
					endif
					ErrorBeep()
					if !Conf("Pergunta: Confirma Lancamento ?")
						Loop
					endif
				endif
			endif
			//:**************************************************
			if Pago->(!Incluiu())	  ; DbUnLockAll() ; Loop ; endif
			if Chemov->(!Incluiu())   ; DbUnLockAll() ; Loop ; endif
			Cheque->(Order( CHEQUE_CODI ))
			if Cheque->(!DbSeek( cCodiCx )) ; DbUnLockAll() ; Loop ; endif
			if Cheque->(!TravaReg())		  ; DbUnLockAll() ; Loop ; endif
			//:**************************************************
			if lEmitir = 2 // Parcial
				if nVlrPago < nVlrTotal
					if lEmitir = 2 // Parcial
						Pagamov->Emis := dData
						Pagamov->Vcto := dData
						Pagamov->Vlr  := ( nVlrTotal - nVlrPago )
					endif
				endif
			Else
				Pagamov->(DbDelete())
			endif
			Pagamov->(Libera())

			Pago->Codi	  := cCodi
			Pago->Docnr   := cDocnr
			Pago->Fatura  := cFatura
			Pago->Emis	  := dEmis
			Pago->Vcto	  := dVcto
			Pago->Vlr	  := nVlr
			Pago->DataPag := dData
			Pago->VlrPag  := nVlrPago
			Pago->Port	  := cPort
			Pago->Tipo	  := cTipo
			Pago->Juro	  := nJuro
			Pago->nDeb	  := "NAO"
			Pago->Obs1	  := cObs1
			Pago->Obs2	  := cObs2
			Pago->(Libera())

			//*********************************************************************//
			nChSaldo := Cheque->Saldo
			if cDc = "C"
				nChSaldo 	+= nVlrPago
				Chemov->Cre := nVlrPago
			Else
				nChSaldo 	 -= nVlrPago
				Chemov->Deb  := nVlrPago
			endif
			Chemov->Codi	  := cCodiCx
			Chemov->Docnr	  := cDocnr
			Chemov->Fatura   := cFatura
			Chemov->Emis	  := dData
			Chemov->Data	  := dData
			Chemov->Baixa	  := Date()
			Chemov->Hist	  := cHist
			Chemov->Saldo	  := nChSaldo
			Chemov->Tipo	  := "PG"
			Chemov->Caixa	  := IF( cCaixa = Nil, Space(4), cCaixa )
			Chemov->CPartida := FALSO
			Chemov->(Libera())
			Cheque->Saldo	:= nChSaldo
			//*********************************************************************//
			if Cheque->(DbSeek( cCodiCx1 ))
				if Cheque->(TravaReg())
					nChSaldo   := Cheque->Saldo
					if Chemov->(Incluiu())
						if cDc1 = "C"
							nChSaldo 	+= nVlrPago
							Chemov->Cre := nVlrPago
						Else
							nChSaldo 	 -= nVlrPago
							Chemov->Deb  := nVlrPago
						endif
						Chemov->Codi	:= cCodiCx1
						Chemov->Docnr	:= cDocnr
						Chemov->Fatura := cFatura
						Chemov->Emis	:= dData
						Chemov->Data	:= dData
						Chemov->Baixa	:= Date()
						Chemov->Hist	:= cHist
						Chemov->Saldo	:= nChSaldo
						Chemov->Tipo	:= "PG"
						Chemov->Caixa	:= IF( cCaixa = Nil, Space(4), cCaixa )
						Chemov->CPartida := OK
						Chemov->(Libera())
						Cheque->Saldo := nChSaldo
					endif
				endif
			endif
			//*********************************************************************//
			if Cheque->(DbSeek( cCodiCx2 ))
				if Cheque->(TravaReg())
					nChSaldo   := Cheque->Saldo
					if Chemov->(Incluiu())
						if cDc2 = "C"
							nChSaldo 	+= nVlrPago
							Chemov->Cre := nVlrPago
						Else
							nChSaldo 	 -= nVlrPago
							Chemov->Deb  := nVlrPago
						endif
						Chemov->Codi	:= cCodiCx2
						Chemov->Docnr	:= cDocnr
						Chemov->Fatura := cFatura
						Chemov->Emis	:= dData
						Chemov->Data	:= dData
						Chemov->Baixa	:= Date()
						Chemov->Hist	:= cHist
						Chemov->Saldo	:= nChSaldo
						Chemov->Tipo	:= "PG"
						Chemov->(Libera())
						Cheque->Saldo := nChSaldo
					endif
				endif
			endif
			//*********************************************************************//
			if Cheque->(DbSeek( cCodiCx3 ))
				if Cheque->(TravaReg())
					nChSaldo   := Cheque->Saldo
					if Chemov->(Incluiu())
						if cDc3 = "C"
							nChSaldo 	+= nVlrPago
							Chemov->Cre := nVlrPago
						Else
							nChSaldo 	 -= nVlrPago
							Chemov->Deb  := nVlrPago
						endif
						Chemov->Codi	:= cCodiCx3
						Chemov->Docnr	:= cDocnr
						Chemov->Fatura := cFatura
						Chemov->Emis	:= dData
						Chemov->Data	:= dData
						Chemov->Baixa	:= Date()
						Chemov->Hist	:= cHist
						Chemov->Saldo	:= nChSaldo
						Chemov->Tipo	:= "PG"
						Chemov->(Libera())
						Cheque->Saldo := nChSaldo
					endif
				endif
			endif
			//*********************************************************************//
			if lEmitir = 3
				if Cheque->(DbSeek( cCodiCx2 ))
					if Cheque->(TravaReg())
						nChSaldo := Cheque->Saldo
						if nVlrTotal < nVlrpago
							nDiferenca := nVlrPago - nVlrTotal
						Else
							nDiferenca := nVlrTotal - nVlrPago
						endif
						if Chemov->(Incluiu())
							if cDc2 = "C"
								nChSaldo 	+= nDiferenca
								Chemov->Cre := nDiferenca
							Else
								nChSaldo 	 -= nDiferenca
								Chemov->Deb  := nDiferenca
							endif
							Chemov->Codi	:= cCodiCx2
							Chemov->Docnr	:= cDocnr
							Chemov->Fatura := cFatura
							Chemov->Emis	:= dData
							Chemov->Data	:= dData
							Chemov->Baixa	:= Date()
							Chemov->Hist	:= cHist2
							Chemov->Saldo	:= nChSaldo
							Chemov->Tipo	:= "DF"  // Tipo Diferenca C/C
							//Chemov->Caixa  := IF( cCaixa = Nil, Space(4), cCaixa )
							Chemov->(Libera())
							Cheque->Saldo	:= nChSaldo
						endif
					endif
				endif
			endif
			Cheque->(Libera())
		endif
		Exit
	EndDo
	DbUnLockAll()
	Pagamov->(DbClearRel())
	AreaAnt( Arq_Ant, Ind_Ant )
	ResTela( cScreen )
EndDo

Function PgDocErrad( cDocnr )
****************************
LOCAL cScreen	 := SaveScreen()
LOCAL Ind_Ant	 := IndexOrd()
LOCAL Arq_Ant	 := Alias()
LOCAL nRegistro := 0
FIELD Docnr
FIELD Emis
FIELD Vcto
FIELD Vlr

Pagar->(Order( PAGAR_CODI ))
Area("Pagamov")
if ( Pagamov->(DbGoTop()), Pagamov->(Eof()))
	AreaAnt( Arq_Ant, Ind_Ant )
	Nada()
	Return( FALSO )
endif
if ( Pagamov->(Order( PAGAMOV_DOCNR )), Pagamov->(!DbSeek( cDocnr )))
	ErrorBeep()
	if Conf("Erro: Documento nao Encontrado. Localizar por Nome ?.")
		if BaixaPag( @cDocnr, @nRegistro )
			Pagamov->( DbGoTo( nRegistro ))
			AreaAnt( Arq_Ant, Ind_Ant )
			Return( OK )
		endif
		Pagar->(Order( PAGAR_CODI ))
		Area("Pagamov")
		Pagamov->(Order( PAGAMOV_DOCNR ))
		Set Rela To Pagamov->Codi Into Pagar
	endif
	Pagamov->(DbGoTop())
	Pagamov->(Escolhe( 03, 00, 22, "Docnr + 'Ý' + Dtoc( Emis ) + 'Ý' + Dtoc( Vcto ) + 'Ý' + Tran( Vlr, '@E 999,999.99') + 'Ý' + Left( Pagar->Nome, 37 )", "DOCTO N§  EMISSAO  VCTO         VALOR  NOME DO FORNECEDOR"))
	cDocnr := Pagamov->Docnr
endif
AreaAnt( Arq_Ant, Ind_Ant )
Return( OK )

Function BaixaPag( cDocnr, nRegistro )
**************************************
LOCAL cScreen	 := SaveScreen()
LOCAL GetList	 := {}
LOCAL Arq_Ant	 := Alias()
LOCAL Ind_Ant	 := IndexOrd()
LOCAL nTam		 := 0
LOCAL aDocnr	 := {}
LOCAL aRegistro := {}
LOCAL aTodos	 := {}
LOCAL cCodi 	 := Space(04)
LOCAL nChoice	 := 0

oMenu:Limpa()
MaBox( 15, 10, 17, 78 )
@ 16, 11 Say "Fornecedor......: " Get cCodi Pict '9999' Valid Pagarrado( @cCodi,, Row(), Col()+1 )
Read
if LastKey() = ESC
	AreaAnt( Arq_Ant, Ind_Ant )
	ResTela( cScreen )
	Return( FALSO )
endif
Area("Pagamov")
Pagamov->(Order( PAGAMOV_CODI ))
if Pagamov->(!DbSeek( cCodi ))
	ErrorBeep()
	Alerta( "Erro: Nenhum Debito em Aberto Deste fornecedor." )
	AreaAnt( Arq_Ant, Ind_Ant )
	ResTela( cScreen )
	Return( FALSO )
endif
WHILE Pagamov->Codi = cCodi
	Aadd( aDocnr,	  Pagamov->Docnr )
	Aadd( aRegistro, Pagamov->(Recno()))
	Aadd( aTodos,	  Pagamov->Docnr + " " + Dtoc( Pagamov->Emis ) + " " + Dtoc( Pagamov->Vcto ) + " " + Tran( Pagamov->Vlr, "@E 999,999,999.99"))
	Pagamov->(DbSkip(1))
EndDo
nTam := Len( aTodos )
if nTam = 0
	ErrorBeep()
	Alerta( "Erro: Nenhum Debito em Aberto deste Fornecedor." )
	AreaAnt( Arq_Ant, Ind_Ant )
	ResTela( cScreen )
	Return( FALSO )
endif
MaBox( 00, 10, 14, 53, "DOCTO  N§  EMISSAO   VENCTO          VALOR")
nChoice := aChoice( 01, 11, 13, 52, aTodos )
ResTela( cScreen )
if nChoice = 0
	AreaAnt( Arq_Ant, Ind_Ant )
	Alerta( "Erro: Procura Cancelada..." )
	ResTela( cScreen )
	Return( FALSO )
endif
cDocnr	 := aDocnr[ nChoice ]
nRegistro := aRegistro[ nChoice ]
AreaAnt( Arq_Ant, Ind_Ant )
ResTela( cScreen )
Return( OK )

Function TestaTecla( nKey, oBrowse )
************************************
if 	 nKey == K_UP
	oBrowse:up()				  // move o cursor para cima
Elseif nKey == K_DOWN
	oBrowse:down() 			  // move o cursor para baixo
Elseif nKey == K_LEFT
	oBrowse:Left() 			  // move o cursor para esquerda
Elseif nKey == K_RIGHT
	oBrowse:Right()			  // move o cursor para direita
Elseif nKey == K_HOME
	oBrowse:home() 			  // move o cursor para primeira coluna
Elseif nKey == K_END
	oBrowse:end()				  // move o cursor para ultima coluna
Elseif nKey == K_PGUP
	oBrowse:pageUp()			  // move fonte de dados uma tela acima
Elseif nKey == K_PGDN
	oBrowse:pageDown()		  // move fonte de dados uma tela abaixo
Elseif nKey == K_CTRL_PGUP
	oBrowse:gotop()			  // move o cursor para baixo
Elseif nKey == K_CTRL_PGDN
	oBrowse:goBottom()		  // move o cursor para esquerda
Elseif nKey == K_CTRL_HOME
	oBrowse:panHome() 		  // move o cursor para direita
Elseif nKey == K_CTRL_END
	oBrowse:panEnd()			  // move o cursor para primeira coluna
Elseif nKey == K_CTRL_LEFT
	oBrowse:panLeft() 		  // move o cursor para ultima coluna
Elseif nKey == K_CTRL_RIGHT
	oBrowse:panRight()		  // move fonte de dados uma tela acima
endif
Return VOID

Function Vlr_Icms( porc_icms, vlr_compra, vlr_icms )
****************************************************
Vlr_Icms := ( Vlr_Compra * Porc_Icms ) / 100
Write( 07, 48, Str( Vlr_Icms, 13, 2 ) )
Return( OK )

Function Desconto( nDesc, nTotal, nTot )
****************************************
if LastKey() = UP
	nTot := nTotal
Else
	nTot := ( nTotal - nDesc )
endif
Return(OK)

Function Mostra_Vlr( vlr_titu, vlr_mer )
****************************************
if Vlr_titu < vlr_mer
	ErrorBeep()
	Alerta( "Erro: Valor da Fatura Menor que a Soma das Mercadorias " )
	Return( FALSO )

endif
Return( OK )

Function SomaData( d_Vcto, d_Emis, n_Conta)
*******************************************
d_Vcto := ( d_Emis + n_Conta )
Return( OK )

Function DocFucer( cDocnr, lManutencao )
****************************************
if Empty( cDocnr )
	 ErrorBeep()
	 Alerta( "Erro: Codigo Documento Invalido...")
	 Return( FALSO )
endif
if lManutencao = NIL
	if DbSeek( cDocnr )
		ErrorBeep()
		Alerta( "Erro: Documento Ja Registrado ..." )
		Return( FALSO )
	endif
endif
Return( OK )

Function CheqDoc( var )
***********************
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
if ( Empty( Var ) )
	ErrorBeep()
	Nada("Erro: Numero Documento Invalido ...")
	Return( FALSO )
endif
Area("CheMov")
Order( CHEMOV_DOCNR )
if ( DbSeek( Var ) )
	ErrorBeep()
	Nada("Erro: Numero Documento Ja Registrado...")
	AreaAnt( Arq_Ant, Ind_Ant )
	Return( FALSO )
endif
AreaAnt( Arq_Ant, Ind_Ant )
Return( OK )


Function VisualEntraFatura( cDocnr, nVlrFatura, cCodi )
*******************************************************
LOCAL cScreen	 := SaveScreen()
LOCAL Arq_Ant	 := Alias()
LOCAL Ind_Ant	 := IndexOrd()
LOCAL nRegistro := 0

if LastKey() = UP
	Return( OK )
endif

if ( Entradas->(DbGoTop()), Entradas->(Eof()))
	Nada()
	AreaAnt( Arq_Ant, Ind_Ant )
	ResTela( cScreen )
	Return(FALSO)
endif
Pagar->(Order( PAGAR_CODI))
Area("Entradas")
Entradas->(Order( ENTRADAS_FATURA ))
if ( Entradas->(Order( ENTRADAS_FATURA )), Entradas->(!DbSeek( cDocnr )))
	ErrorBeep()
	if Conf("Erro: Documento nao Encontrado. Localizar por Fornecedor ?")
		if LocalizaEntrada( @cDocnr, @nRegistro )
			EntNota->( DbGoTo( nRegistro ))
			cDocnr := EntNota->Numero
		endif
	Else
		Pagar->(Order( PAGAR_CODI))
		Area("EntNota")
		Set Rela To EntNota->Codi Into Pagar
		EntNota->(Order( ENTNOTA_NUMERO ))
		Escolhe( 03, 01, 22, "Numero + 'Ý' + Pagar->Nome", "FATURA  NOME DO FORNECEDOR")
		EntNota->(DbClearRel())
		cDocnr := EntNota->Numero
	endif
	Area("Entradas")
	Entradas->(Order( ENTRADAS_FATURA ))
	if Entradas->(!( DbSeek( cDocnr ) ))
		ErrorBeep()
		Alerta( "Erro: Nenhum Produto Relacionado a este Documento.")
		AreaAnt( Arq_Ant, Ind_Ant )
		Return( FALSO )
	endif
endif
if cCodi != Nil
	if Entradas->Codi != cCodi
		ErrorBeep()
		Alerta( "Erro: Fatura nao e deste Fornecedor.")
		AreaAnt( Arq_Ant, Ind_Ant )
		Return( FALSO )
	endif
endif
if nVlrFatura != Nil
	nVlrFatura := Entradas->VlrFatura
endif
AreaAnt( Arq_Ant, Ind_Ant )
Return( OK )

Function VisualAchaFatura( cDocnr, nVlrFatura, cCodi )
******************************************************
LOCAL cScreen	 := SaveScreen()
LOCAL Arq_Ant	 := Alias()
LOCAL Ind_Ant	 := IndexOrd()
LOCAL nRegistro := 0

if LastKey() = UP
	Return( OK )
endif

if ( Saidas->(DbGoTop()), Saidas->(Eof()))
	Nada()
	AreaAnt( Arq_Ant, Ind_Ant )
	ResTela( cScreen )
	Return(FALSO)
endif
Receber->(Order( RECEBER_CODI))
Area("Saidas")
Saidas->(Order( SAIDAS_FATURA ))
if ( Saidas->(Order( SAIDAS_FATURA )), Saidas->(!DbSeek( cDocnr )))
	ErrorBeep()
	if Conf("Erro: Documento nao Encontrado. Localizar por Nome ?.")
		if LocalizaFatura( @cDocnr, @nRegistro )
			Nota->( DbGoTo( nRegistro ))
			cDocnr := Nota->Numero
		endif
	Else
		Receber->(Order( RECEBER_CODI))
		Area("Nota")
		Set Rela To Nota->Codi Into Receber
		Nota->(Order( NOTA_NUMERO ))
		Escolhe( 03, 01, 22, "Numero + 'Ý' + Receber->Nome+ 'Ý' + Situacao + 'Ý' + Caixa", "FATURA  NOME DO CLIENTE                         SITUACAO USER")
		Nota->(DbClearRel())
		cDocnr := Nota->Numero
	endif
	Area("Saidas")
	Saidas->(Order( SAIDAS_FATURA ))
	if Saidas->(!( DbSeek( cDocnr ) ))
		ErrorBeep()
		Alerta( "Erro: Nenhum Produto Relacionado a este Documento.")
		AreaAnt( Arq_Ant, Ind_Ant )
		Return( FALSO )
	endif
endif
if cCodi != Nil
	if Saidas->Codi != cCodi
		ErrorBeep()
		Alerta( "Erro: Fatura nao e deste cliente...")
		AreaAnt( Arq_Ant, Ind_Ant )
		Return( FALSO )
	endif
endif
if nVlrFatura != Nil
	nVlrFatura := Saidas->VlrFatura
endif
AreaAnt( Arq_Ant, Ind_Ant )
Return( OK )

Function LocalizaFatura( cDocnr, nRegistro )
********************************************
LOCAL cScreen	 := SaveScreen()
LOCAL GetList	 := {}
LOCAL Arq_Ant	 := Alias()
LOCAL Ind_Ant	 := IndexOrd()
LOCAL nTam		 := 0
LOCAL aDocnr	 := {}
LOCAL aRegistro := {}
LOCAL aTodos	 := {}
LOCAL cCodi 	 := Space(05)
LOCAL cNumero	 := ""
LOCAL cEmissao  := ""
LOCAL cDevol	 := ''
LOCAL cUser 	 := ''
LOCAL cVlr		 := ""
LOCAL cSituacao := Space(08)
LOCAL nChoice	 := 0
LOCAL nConta	 := 0
LOCAL cTela

oMenu:Limpa()
MaBox( 15, 10, 18, 78 )
Write( 17, 28, AllTrim(ValToStr(nConta)))
@ 16, 11 Say "Codigo Cliente: " Get cCodi Pict PIC_RECEBER_CODI Valid RecErrado( @cCodi,, Row(), Col()+1 )
@ 17, 11 Say "Registro Add #: "
Read
if LastKey() = ESC
	AreaAnt( Arq_Ant, Ind_Ant )
	ResTela( cScreen )
	Return( FALSO )
endif
Nota->(Order( NOTA_CODI ))
if Nota->(!DbSeek( cCodi ))
	ErrorBeep()
	Alerta( "Erro: Nenhuma Fatura Deste Cliente." )
	AreaAnt( Arq_Ant, Ind_Ant )
	ResTela( cScreen )
	Return( FALSO )
endif
Saidas->(Order( SAIDAS_FATURA ))
Nota->(Order( NOTA_CODI ))
WHILE Nota->Codi = cCodi .OR. LastKey() = ESC
	cNumero	 := Nota->Numero
	cDevol	 := Space(12)
	cUser 	 := Space(04)
	cSituacao := Space(08)
	cEmissao  := ""
	cVlr		 := ""
	nConta++
	Write( 17, 28, AllTrim(ValToStr(nConta)))
	if Saidas->(DbSeek( cNumero ))
		cEmissao  := Dtoc( Saidas->Data )
		cDevol	 := 'em ' + Dtoc( Saidas->Atualizado )
		cVlr		 := Tran( Saidas->VlrFatura, "@E 999,999,999.99")
		cSituacao := Saidas->Situacao
		cUser 	 := Saidas->Caixa
	endif
	Aadd( aDocnr, cNumero )
	Aadd( aRegistro, Nota->(Recno()))
	Aadd( aTodos, cNumero + "   " + cEmissao + " " + cVlr + " " + cSituacao + " " + cDevol + " " + cUser)
	Nota->(DbSkip(1))
	if nConta >= 65535 // Tamanho Max. Array
		ErrorBeep()
		Alerta('Erro: M ximo 65535 registros por cliente. Use individual.')
		Exit
	endif
EndDo
nTam := Len( aTodos )
if nTam = 0
	ErrorBeep()
	Alerta( "Erro: Nenhuma Fatura Deste Cliente." )
	AreaAnt( Arq_Ant, Ind_Ant )
	ResTela( cScreen )
	Return( FALSO )
endif
MaBox( 00, 10, 14, 70,"FATURA N§  EMISSAO          VALOR SITUACAO ALTER/EXCLU USER")
nChoice := aChoice( 01, 11, 13, 69, aTodos )
ResTela( cScreen )
if nChoice = 0
	AreaAnt( Arq_Ant, Ind_Ant )
	ResTela( cScreen )
	Return( FALSO )
endif
cDocnr	 := aDocnr[ nChoice ]
nRegistro := aRegistro[ nChoice ]
AreaAnt( Arq_Ant, Ind_Ant )
ResTela( cScreen )
Return( OK )

Function LocalizaEntrada( cDocnr, nRegistro )
**********************************************
LOCAL cScreen	 := SaveScreen()
LOCAL GetList	 := {}
LOCAL Arq_Ant	 := Alias()
LOCAL Ind_Ant	 := IndexOrd()
LOCAL nTam		 := 0
LOCAL aDocnr	 := {}
LOCAL aRegistro := {}
LOCAL aTodos	 := {}
LOCAL cCodi 	 := Space(04)
LOCAL cNumero	 := ""
LOCAL cEmissao  := ""
LOCAL cVlr		 := ""
LOCAL nChoice	 := 0

oMenu:Limpa()
MaBox( 15, 10, 17, 78 )
@ 16, 11 Say "Id Fornecedor...: " Get cCodi   Pict "9999" Valid Pagarrado( @cCodi, Row(), Col()+1 )
Read
if LastKey() = ESC
	AreaAnt( Arq_Ant, Ind_Ant )
	ResTela( cScreen )
	Return( FALSO )
endif
Area("EntNota")
EntNota->(Order( ENTNOTA_CODI ))
if EntNota->(!DbSeek( cCodi ))
	ErrorBeep()
	Alerta( "Erro: Nenhuma Fatura Deste Fornecedor." )
	AreaAnt( Arq_Ant, Ind_Ant )
	ResTela( cScreen )
	Return( FALSO )
endif
Entradas->(Order( ENTRADAS_FATURA ))
WHILE EntNota->Codi = cCodi
	cNumero		:= EntNota->Numero
	if Entradas->(DbSeek( cNumero ))
		cEmissao := Dtoc( Entradas->Data )
		cVlr		:= Tran( Entradas->VlrFatura, "@E 999,999,999.99")
	Else
		cEmissao := ""
		cVlr		:= ""
	endif
	Aadd( aDocnr, cNumero )
	Aadd( aRegistro, EntNota->(Recno()))
	Aadd( aTodos, cNumero + "   " + cEmissao + " " + cVlr )
	EntNota->(DbSkip(1))
EndDo
nTam := Len( aTodos )
if nTam = 0
	ErrorBeep()
	Alerta( "Erro: Nenhuma Fatura Deste Fornecedor." )
	AreaAnt( Arq_Ant, Ind_Ant )
	ResTela( cScreen )
	Return( FALSO )
endif
MaBox( 00, 10, 14, 44,"FATURA N§  EMISSAO          VALOR")
nChoice := aChoice( 01, 11, 13, 43, aTodos )
ResTela( cScreen )
if nChoice = 0
	AreaAnt( Arq_Ant, Ind_Ant )
	ResTela( cScreen )
	Return( FALSO )
endif
cDocnr	 := aDocnr[ nChoice ]
nRegistro := aRegistro[ nChoice ]
AreaAnt( Arq_Ant, Ind_Ant )
ResTela( cScreen )
Return( OK )

Function RecCerto( cCodi, lAlteracao, cSwap )
*********************************************
LOCAL Arq_Ant	  := Alias()
LOCAL Ind_Ant	  := IndexOrd()
LOCAL lModificar := IF( lAlteracao != NIL .AND. lAlteracao, OK, FALSO )
LOCAL nFieldLen  := Len( Receber->Codi )
LOCAL cFilial

if lModificar
	if cCodi == cSwap
		Return( OK )
	endif
endif

if LastKey() = UP
	Return( OK )
endif
if Empty( cCodi ) .OR. Len(AllTrim(cCodi)) < 5
	ErrorBeep()
	Alerta("Erro: Codigo Cliente Invalido.")
	Return( FALSO )
endif
Area("Receber")
Receber->(Order( RECEBER_CODI ))
if Receber->( DbSeek( cCodi ))
	ErrorBeep()
	Alerta("Erro: Codigo de Cliente Ja Registrado.")
	cCodi := ProxCli( @cCodi )
	AreaAnt( Arq_Ant, Ind_Ant )
	Return( FALSO )
endif
AreaAnt( Arq_Ant, Ind_Ant )
Return( OK )

Function ProxCli( cCodi )
*************************
LOCAL Arq_Ant	  := Alias()
LOCAL Ind_Ant	  := IndexOrd()
LOCAL nFieldLen  := Len( Receber->Codi )

Receber->(Order( RECEBER_CODI ))
While Receber->(DbSeek( cCodi ))
	cCodi := StrZero( Val( Right( cCodi, nFieldLen )) + 1, nFieldLen )
	Receber->(DbSkip(1))
EndDO
AreaAnt( Arq_Ant, Ind_Ant )
Return( cCodi )

Function Complet2( Mcep, Mcida, Mesta )
***************************************
if LastKey() = UP
	Return(OK)
endif
if Mcep	= XCCEP
	Mcida = XCCIDA
	Mesta = XCESTA
	Keyb Chr( 13 ) + Chr( 13 )
endif
Return( OK )


Function RegiaoErrada( cRegiao, nRow, nCol )
********************************************
LOCAL aRotina := {{|| RegiaoInclusao() }}
LOCAL Ind_Ant := IndexOrd()
LOCAL Arq_Ant := Alias()

Area("Regiao")
Regiao->(Order( REGIAO_REGIAO ))
if (Lastrec() = 0 )
	ErrorBeep()
	if Conf(" Pergunta: Nenhuma Regiao Disponivel... Registrar ?")
		RegiaoInclusao()
	endif
	AreaAnt( Arq_Ant, Ind_Ant )
	Return( FALSO )
endif
if !DbSeek( cRegiao)
	Regiao->(Order( REGIAO_NOME ))
	Escolhe( 03, 01, 22,"Regiao + 'Ý' + Nome", "COD NOME DA REGIAO", aRotina )
	cRegiao := Regiao->Regiao
endif
if nRow != NIL
	Write( nRow, nCol, Regiao->Nome )
endif
AreaAnt( Arq_Ant, Ind_Ant )
Return( OK )

Proc RegiaoInclusao()
*********************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen()
LOCAL cRegiao
LOCAL cNome
LOCAL lSair
LOCAL nOpcao
FIELD Regiao
FIELD Nome

Area("Regiao")
WHILE OK
	oMenu:Limpa()
	cRegiao := Space(02)
	cNome   := Space(40)
	Regiao->(Order( REGIAO_REGIAO ))
	Regiao->(DbGoBottom())
	cRegiao := Regiao->(StrZero( Val( Regiao)+1, 2))
	lSair   := FALSO
	WHILE OK
		MaBox( 06, 02 , 09 , 78, "INCLUSAO DE REGIOES" )
		@ 07		, 03 Say  "Codigo..:" Get cRegiao Pict "99" Valid RegiaoCerta( @cRegiao )
		@ Row()+1, 03 Say  "Nome....:" Get cNome   Pict "@!"
		Read
		if LastKey() = ESC
			lSair := OK
			Exit

		endif
		nOpcao := Alerta("Pergunta: Voce Deseja ? ", {" Incluir", " Alterar ", "Sair "})
		if nOpcao = 1	// Incluir
			if Regiao->(Incluiu())
				Regiao->Regiao := cRegiao
				Regiao->Nome	:= cNome
				Regiao->(Libera())
				Exit
			endif

		Elseif nOpcao = 2 // Alterar
			Loop

		Elseif nOpcao = 3 // Sair
			lSair := OK
			Exit

		endif

	EndDo
	if lSair
		ResTela( cScreen )
		Exit

	endif
EndDo

Proc CmInclusao( lAlteracao )
******************************
LOCAL GetList		:= {}
LOCAL cScreen		:= SaveScreen()
LOCAL lModificar	:= FALSO
LOCAL nOpcao		:= 0
LOCAL dInicio
LOCAL dFim
LOCAL nIndice
LOCAL cString
LOCAL cObs
LOCAL cSwap
LOCAL lSair

if lAlteracao != NIL .AND. lAlteracao
	lModificar := OK
endif

if !lModificar
	if !PodeIncluir()
		ResTela( cSCreen )
		Return
	endif
endif

Area("CM")
Cm->(Order( CM_INICIO ))
WHILE OK
	oMenu:Limpa()
	if lModificar
		dInicio	 := Cm->Inicio
		dFim		 := Cm->Fim
		nIndice	 := Cm->Indice
		cObs		 := Cm->Obs
		cString	 := "ALTERACAO DE CORRECAO MONETARIA"
	Else
		Cm->(Order( 0 ))
		Cm->(DbGoBottom())
		dInicio	 := Cm->Fim + 1
		dFim		 := dInicio + 29
		nIndice	 := 0
		cObs		 := Space(40)
		cString	 := "INCLUSAO DE CORRECAO MONETARIA"
	endif
	cSwap := dInicio
	lSair := FALSO
	WHILE OK
		MaBox( 06, 02, 11, 78, cString )
		@ 07		 , 03 Say  "Data Inicial.:" Get dInicio  Pict PIC_DATA Valid CmCerto( @dInicio, lModificar, cSwap )
		@ Row()+1 , 03 Say  "Data Final...:" Get dFim     Pict PIC_DATA
		@ Row()+1 , 03 Say  "Indice.......:" Get nIndice  Pict "9999.9999"
		@ Row()+1 , 03 Say  "Observacao...:" Get cObs     Pict "@!"
		Read
		if LastKey() = ESC
			lSair := OK
			Exit
		endif
		if lModificar
			nOpcao := Alerta("Pergunta: Voce Deseja ? ", {" Alterar", " Cancelar ", "Sair "})
		Else
			nOpcao := Alerta("Pergunta: Voce Deseja ? ", {" Incluir", " Alterar ", "Sair "})
		endif
		if nOpcao = 1
			if lModificar
				if Cm->(TravaReg())
					Cm->Inicio	 := dInicio
					Cm->Fim		 := dFim
					Cm->Indice	 := nIndice
					Cm->Obs		 := cObs
					Cm->(Libera())
					lSair := OK
					Exit
				endif
			Else
				if Cm->(Incluiu())
					Cm->Inicio	 := dInicio
					Cm->Fim		 := dFim
					Cm->Indice	 := nIndice
					Cm->Obs		 := cObs
					Cm->(Libera())
					Exit
				endif
			endif

		Elseif nOpcao = 2 // Alterar
			Loop

		Elseif nOpcao = 3 // Sair
			lSair := OK
			Exit

		endif
	EndDo
	if lSair
		ResTela( cScreen )
		Exit

	endif
EndDo

Function CmCerto( dInicio, lModificar, cSwap )
**********************************************
FIELD Inicio, Fim

if LastKey() = UP
	Return( OK )
endif

if lModificar != NIL .AND. lModificar
	if dInicio == cSwap
		Return( OK )
	endif
endif

if Empty( dInicio )
	ErrorBeep()
	Alerta("Erro: Entrada de Data Invalida.")
	Return( FALSO )
endif
Cm->(Order( CM_INICIO ))
if Cm->(DbSeek( dInicio ))
	ErrorBeep()
	Alerta("Erro: Indice de CM Ja Registrado. ")
	Return( FALSO )
endif
Return( OK )

Proc CepInclusao( lAlteracao )
******************************
LOCAL GetList		:= {}
LOCAL cScreen		:= SaveScreen()
LOCAL lModificar	:= FALSO
LOCAL nOpcao		:= 0
LOCAL cCep
LOCAL cCida
LOCAL cBair
LOCAL cEsta
LOCAL cString
LOCAL cSwap
LOCAL lSair

if lAlteracao != NIL .AND. lAlteracao
	lModificar := OK
endif

if !lModificar
	if !PodeIncluir()
		ResTela( cSCreen )
		Return
	endif
endif

Area("Cep")
Cep->(Order( CEP_CEP ))
WHILE OK
	oMenu:Limpa()
	if lModificar
		cCep		 := Cep->Cep
		cCida 	 := Cep->Cida
		cBair 	 := Cep->Bair
		cEsta 	 := Cep->Esta
		cString	 := "ALTERACAO DE CEP"
	Else
		cCep		 := Space(09)
		cCida 	 := Space(25)
		cBair 	 := Space(25 )
		cEsta 	 := Space(02)
		cString := "INCLUSAO DE NOVO CEP"
	endif
	cSwap := cCep
	lSair := FALSO
	WHILE OK
		MaBox( 06, 02, 11, 78, cString )
		@ 07		 , 03 Say  "Novo Cep....:" Get cCep      Pict "99999-999" Valid CepCerto( @cCep, lModificar, cSwap )
		@ Row()+1 , 03 Say  "Cidade......:" Get cCida     Pict "@!"
		@ Row()+1 , 03 Say  "Bairro......:" Get cBair     Pict "@!"
		@ Row()+1 , 03 Say  "Estado......:" Get cEsta     Pict "@!"
		Read
		if LastKey() = ESC
			lSair := OK
			Exit
		endif
		if lModificar
			nOpcao := Alerta("Pergunta: Voce Deseja ? ", {" Alterar", " Cancelar ", "Sair "})
		Else
			nOpcao := Alerta("Pergunta: Voce Deseja ? ", {" Incluir", " Alterar ", "Sair "})
		endif
		if nOpcao = 1
			if lModificar
				if Cep->(TravaReg())
					Cep->Cep 	  := cCep
					Cep->Cida	  := cCida
					Cep->Bair	  := cBair
					Cep->Esta	  := cEsta
					Cep->(Libera())
					lSair := OK
					Exit
				endif
			Else
				if Cep->(Incluiu())
					Cep->Cep 	  := cCep
					Cep->Cida	  := cCida
					Cep->Bair	  := cBair
					Cep->Esta	  := cEsta
					Cep->(Libera())
					Exit
				endif
			endif

		Elseif nOpcao = 2 // Alterar
			Loop

		Elseif nOpcao = 3 // Sair
			lSair := OK
			Exit

		endif
	EndDo
	if lSair
		ResTela( cScreen )
		Exit

	endif
EndDo

Function RegiaoCerta( cRegiao )
*******************************
FIELD Nome

if LastKey() = UP
	Return( OK )
endif
if Empty( cRegiao )
	ErrorBeep()
	Alerta("Erro: Codigo Regiao Invalida ....")
	Return( FALSO )

endif
Regiao->(Order( REGIAO_REGIAO ))
if Regiao->(DbSeek( cRegiao))
	ErrorBeep()
	Alerta("Erro: Regiao Ja Registrada... ;" + Regiao->(AllTrim(Nome)))
	cRegiao := StrZero( Val( cRegiao ) + 1, 2 )
	Return( FALSO )

endif
Return( OK )

Function SubErrado( cSubGrupo, nRow, nCol )
*******************************************
LOCAL aRotina := {{||Lista1_2() }}
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()

Area("SubGrupo")
SubGrupo->(Order( SUBGRUPO_CODSGRUPO ))
if SubGrupo->(!DbSeek( cSubGrupo ))
	SubGrupo->(Escolhe( 03, 01, 22, "CodsGrupo + 'Ý' + DessGrupo", "COD DESCRICAO DO SUBGRUPO", aRotina ))
	cSubGrupo := SubGrupo->CodsGrupo
endif
if nRow != NIL
	Write( nRow, nCol, SubGrupo->DesSGrupo )
endif
AreaAnt( Arq_Ant, Ind_Ant )
Return( OK )

Function GrupoErrado( cGrupo, nRow, nCol )
******************************************
LOCAL aRotina := {{||Lista1_1() }}
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()

Area("Grupo")
Grupo->(Order( GRUPO_CODGRUPO ))
if Grupo->( !DbSeek( cGrupo ))
	Grupo->(Order( GRUPO_DESGRUPO ))
	Grupo->(Escolhe( 03, 01, 22, "CodGrupo + 'Ý' + DesGrupo", "COD DESCRICAO DO GRUPO", aRotina ))
	cGrupo := Grupo->CodGrupo
endif
if nRow != NIL
	Write( nRow, nCol, Grupo->DesGrupo )
endif
AreaAnt( Arq_Ant, Ind_Ant )
Return( OK )

Proc Lista1_1()
***************
LOCAL cScreen	:= SaveScreen()
LOCAL GetList	:= {}
LOCAL Arq_Ant	:= Alias()
LOCAL Ind_Ant	:= IndexOrd()
LOCAL bSetKey	:= SetKey( F2 )
LOCAL cServico := Space(01)
LOCAL cDescricao
LOCAL cCodigo

SetKey(F2, NIL )
WHILE OK
	Area("Grupo")
	Grupo->(Order( GRUPO_CODGRUPO ))
	oMenu:Limpa()
	cDescricao := Space( Len( Grupo->Desgrupo ))
	cServico   := Space(01)
	Grupo->(DbGoBoTTom())
	cCodigo	  := StrZero( Val( Grupo->Codgrupo )+1,3)
	MaBox( 05, 01, 09, 55, "INCLUSAO DE GRUPOS")
	@ 06, 02 Say "Grupo.....: " Get cCodigo    Pict "999" Valid Grupo( @cCodigo )
	@ 07, 02 Say "Descricao.: " Get cDescricao Pict "@!"
	@ 08, 02 Say "Servicos..: " Get cServico   Pict "!" Valid PickServico( @cServico )
	Read
	if LastKey() = ESC
		Exit
	endif
	ErrorBeep()
	if Conf("Pergunta: Confirma Inclusao do Grupo ?")
		if Grupo( cCodigo )
			if Grupo->(Incluiu())
				Grupo->Codgrupo	:= cCodigo
				Grupo->Desgrupo	:= cDescricao
				Grupo->Atualizado := Date()
				Grupo->Servico 	:= IF( cServico = "S", OK, FALSO )
				Grupo->(Libera())
			endif
		endif
	endif
EndDo
SetKey( F2, bSetKey )
AreaAnt( Arq_Ant, Ind_Ant )
ResTela( cScreen )

Function PickServico( cServico )
********************************
LOCAL aList 	 := { "Grupo de Produtos", "Grupo de Servicos"}
LOCAL aSituacao := { "P", "S" }
LOCAL cScreen := SaveScreen()
LOCAL nChoice
if cServico $ aSituacao[1] .OR. cServico $ aSituacao[2]
	Return( OK )
Else
	MaBox( 11, 01, 14, 44, NIL, NIL, Roloc( Cor()) )
	if (nChoice := AChoice( 12, 02, 13, 43, aList )) != 0
		cServico := aSituacao[ nChoice ]
	endif
endif
ResTela( cScreen )
Return( OK )

Proc Lista1_2()
***************
LOCAL cScreen := SaveScreen()
LOCAL GetList := {}
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
LOCAL bSetKey := SetKey( F3 )
LOCAL cGrupo  := Space(03)
LOCAL cCodigo
LOCAL cDescricao

SetKey( F3, NIL )
WHILE OK
	Area("SubGrupo")
	SubGrupo->(Order( SUBGRUPO_CODSGRUPO ))
	oMenu:Limpa()
	MaBox( 05, 01, 08, 55, "INCLUSAO DE SUB-GRUPOS")
	SubGrupo->(DbGoBoTTom())
	cDescricao := Space( Len( SubGrupo->DessGrupo ) )
	cGrupo	  := Left( SubGrupo->CodsGrupo, 3 )
	cGrupo	  := IF( Empty( cGrupo ), "001", cGrupo )
	cCodigo	  := cGrupo + "." + StrZero( Val( Right( SubGrupo->CodSgrupo,2))+1, 2)
	@ 06, 02 Say "SubGrupo..¯ " Get cCodigo    Pict "999.99" Valid Sgrupo( cCodigo )
	@ 07, 02 Say "Descricao.¯ " Get cDescricao Pict "@!"
	Read
	if LastKey() = ESC
		Exit
	endif
	ErrorBeep()
	if Conf("Pergunta: Confirma Inclusao do SubGrupo ?")
		if Sgrupo( cCodigo )
			if SubGrupo->(Incluiu())
				SubGrupo->CodSgrupo	:= cCodigo
				SubGrupo->DesSgrupo	:= cDescricao
				SubGrupo->Atualizado := Date()
				SubGrupo->(Libera())
			endif
		endif
	endif
EndDo
SetKey( F3, bSetKey )
AreaAnt( Arq_Ant, Ind_Ant )
ResTela( cScreen )

Function Grupo( Var )
*********************
if Empty( Var ) .OR. Len(AllTrim(Var)) < 3
	ErrorBeep()
	Alerta("Erro: Codigo Grupo Invalido... ")
	Return(FALSO)
endif
Grupo->( Order( GRUPO_CODGRUPO ))
Grupo->( DbGoTop() )
if Grupo->( DbSeek( var ) )
	ErrorBeep()
	Alerta("Erro: Grupo Ja Registrado... ;" + Trim( Grupo->DesGrupo))
	Var := StrZero( Val( Var ) +1, 3 )
	Return( FALSO )
endif
Return( OK )

Function SGrupo( cGrupo )
*************************
LOCAL cScreen := SaveScreen()

if Empty( cGrupo )
	ErrorBeep()
	Alerta( "Erro: Codigo SubGrupo Invalido... ")
	Return( FALSO )
endif
Grupo->( Order( GRUPO_CODGRUPO ))
if !Grupo->( DbSeek( Left( cGrupo, 3 )))
	ErrorBeep()
	if Conf( "Pergunta: Grupo Nao Registrado... Registrar ? ")
		Lista1_1()
	endif
	ResTela( cScreen )
	SubGrupo->( DbGoTop() )
	Return( FALSO )
endif
if SubGrupo->(DbSeek( cGrupo ) )
	ErrorBeep()
	Alerta( "Erro: SubGrupo Ja Registrado...;" + Trim( SubGrupo->DesSgrupo))
	Return( FALSO )
endif
Return( OK )

Proc ForInclusao( lAlteracao )
******************************
LOCAL GetList	 := {}
LOCAL cScreen	 := SaveScreen( )
LOCAL nRegistro := 0
LOCAL cCodi
LOCAL cNome
LOCAL cFanta
LOCAL dData
LOCAL cCpf
LOCAL cFone
LOCAL cFax
LOCAL cRg1
LOCAL cEnde
LOCAL cBair
LOCAL cCgc
LOCAL cCon
LOCAL cCida
LOCAL cEsta
LOCAL cCep
LOCAL cIns
LOCAL cCaixa
LOCAL cObs
LOCAL cSigla
LOCAL lModificar := FALSO
LOCAL cString
LOCAL cSwap
LOCAL cRg
LOCAL cInsc
LOCAL lSair
LOCAL nOpcao

FIELD Codi
FIELD Nome
FIELD Fanta
FIELD Data
FIELD Cpf
FIELD Fone
FIELD Fax
FIELD Rg1
FIELD Ende
FIELD Bair
FIELD Cgc
FIELD Con
FIELD Cida
FIELD Esta
FIELD Cep
FIELD Ins
FIELD Caixa
FIELD Obs
FIELD Sigla

if lAlteracao != NIL
	if lAlteracao = OK
		lModificar := OK
	endif
endif

Area( "Pagar" )
Pagar->(Order( PAGAR_CODI ))
WHILE OK
	oMenu:Limpa()
	cNome  := IF( lModificar, Pagar->Nome, 	  Space(40))
	cFanta := IF( lModificar, Pagar->Fanta,	  Space(40))
	cSigla := IF( lModificar, Pagar->Sigla,	  Space(10))
	cCpf	 := IF( lModificar, Pagar->Cpf,		  Space(14))
	cFone  := IF( lModificar, Pagar->Fone, 	  Space(14))
	cFax	 := IF( lModificar, Pagar->Fax,		  Space(14))
	cRg	 := IF( lModificar, Pagar->Rg,		  Space(18))
	cCgc	 := IF( lModificar, Pagar->Cgc,		  Space(18))
	cEnde  := IF( lModificar, Pagar->Ende, 	  Space(30))
	cObs	 := IF( lModificar, Pagar->Obs,		  Space(30))
	cBair  := IF( lModificar, Pagar->Bair, 	  Space(20))
	cCon	 := IF( lModificar, Pagar->Con,		  Space(20))
	cCida  := IF( lModificar, Pagar->Cida, 	  Space(25))
	cEsta  := IF( lModificar, Pagar->Esta, 	  Space(02))
	cCep	 := IF( lModificar, Pagar->Cep,		  Space(09))
	cInsc  := IF( lModificar, Pagar->Insc, 	  Space(15))
	cCaixa := IF( lModificar, Pagar->Caixa,	  Space(03))
	dData  := IF( lModificar, Pagar->Data, 	  Date())
				 IF( lModificar,, Pagar->(DbGoBottom()))
	cCodi   := IF( lModificar, Pagar->Codi, Pagar->(StrZero(Val( Codi )+1, 4)))
	cString := IF( lModificar, "ALTERACAO DE FORNECEDORES", "INCLUSAO DE NOVOS FORNECEDORES")
	cSwap 	 := cCodi
	lSair 	 := FALSO
	nRegistro := Pagar->(Recno())
	WHILE OK
		MaBox( 06 , 02 , 21 , 78, cString )
		@ 07		, 03 Say "Codigo......:" Get cCodi  Pict "9999" Valid PagCerto( @cCodi, lModificar, cSwap )
		@ Row()+1, 03 Say "Data........:" Get dData  Pict  "##/##/##"
		@ Row()+1, 03 Say "R. Social...:" Get cNome  Pict  "@!" Valid !Empty(cNome) .OR. LastKey() = UP
		@ Row()+1, 03 Say "Sigla.......:" Get cSigla Pict  "@!" Valid !Empty(cSigla) .OR. LastKey() = UP
		@ Row()+1, 03 Say "Fantasia....:" Get cFanta Pict  "@!"
		@ Row()+1, 03 Say "CGC/MF......:" Get cCgc   Pict  "99.999.999/9999-99"
		@ Row()+1, 03 Say "Inscri‡ao...:" Get cInsc  Pict  "@!"
		@ Row()+1, 03 Say "CPF.........:" Get cCpf   Pict  "999.999.999-99" Valid TestaCpf( cCpf )
		@ Row()+1, 03 Say "Rg..........:" Get cRg    Pict  "@!"
		@ Row()+1, 03 Say "Endere‡o....:" Get cEnde  Pict  "@!"
		@ Row()+1, 03 Say "CEP.........:" Get cCep   Pict  "99999-999" Valid CepErrado( @cCep, @cCida, @cEsta, @cBair )
		@ Row()+1, 03 Say "Cidade......:" Get cCida  Pict  "@!"
		@ Row()+1, 03 Say "Bairro......:" Get cBair  Pict  "@!"
		@ Row()+1, 03 Say "Estado......:" Get cEsta  Pict  "@!"
		Read
		if LastKey() = ESC
			lSair := OK
			Exit
		endif
		Scroll( 07, 03, 20, 77, 14 )
		@ 07, 	  03 Say "Telefone....:" Get cFone  Pict  PIC_FONE
		@ Row()+1, 03 Say "Fax.........:" Get cFax   Pict  PIC_FONE
		@ Row()+1, 03 Say "Cx Postal...:" Get cCaixa Pict  "999"
		@ Row()+1, 03 Say "Contato.... :" Get cCon   Pict  "@!"
		@ Row()+1, 03 Say "Obs.........:" Get cObs   Pict  "@!"
		Read
		if LastKey() = ESC
			lSair := OK
			Exit
		endif
		ErrorBeep()
		if lModificar
			nOpcao := Alerta(" Pergunta: Voce Deseja ? ", {" Alterar", " Cancelar ", "Sair "})
		Else
			nOpcao := Alerta(" Pergunta: Voce Deseja ? ", {" Incluir", " Alterar ", "Sair "})
		endif
		if nOpcao = 1
			if lModificar
				Pagar->(DbGoTo( nRegistro ))
				if !Pagar->(TravaReg()) 			  ; Loop ; endif
			Else
				if !PagCerto( @cCodi, lModificar ) ; Loop ; endif
				if !Pagar->(Incluiu())				  ; Loop ; endif
			endif
			Pagar->Codi  := cCodi
			Pagar->Data  := dData
			Pagar->Nome  := cNome
			Pagar->Rg	 := cRg
			Pagar->Ende  := cEnde
			Pagar->Bair  := cBair
			Pagar->Cida  := cCida
			Pagar->Con	 := cCon
			Pagar->Obs	 := cObs
			Pagar->Cpf	 := cCpf
			Pagar->Esta  := cEsta
			Pagar->Cep	 := cCep
			Pagar->Fone  := cFone
			Pagar->Cgc	 := cCgc
			Pagar->Insc  := cInsc
			Pagar->Fanta := cFanta
			Pagar->Fax	 := cFax
			Pagar->Caixa := cCaixa
			Pagar->Sigla := cSigla
			Pagar->(Libera())
			if lModificar
				lSair := OK
			endif
			Exit

		Elseif nOpcao = 2 // Alterar
			Loop
		Elseif nOpcao = 3 // Sair
			lSair := OK
			Exit
		endif
	EndDo
	if lSair
		ResTela( cScreen )
		Exit
	endif
EndDo

Function CodiCerto( cCodigo, lAlteracao, cSwap )
************************************************
LOCAL cScreen	  := SaveScreen()
LOCAL Arq_Ant	  := Alias()
LOCAL Ind_Ant	  := IndexOrd()
LOCAL lModificar := IF( lAlteracao != NIL .AND. lAlteracao, OK, FALSO )

if lModificar
	if cCodigo == cSwap
		Return( OK )
	endif
endif
if LastKey() = UP
	Return( OK )
endif
if Len(AllTrim(cCodigo )) < 6 .OR. Empty( cCodigo )
	ErrorBeep()
	Alerta("Erro: Codigo Produto Invalido.")
	Return( FALSO )
endif
Lista->(Order( LISTA_CODIGO ))
if Lista->(DbSeek( cCodigo ))
	ErrorBeep()
	Alerta("Erro: Codigo de Produto Existente.")
	Lista->(DbGoBottom())
	cCodigo := ProxCodigo( Lista->Codigo )
	AreaAnt( Arq_Ant, Ind_Ant )
	Return( FALSO )
endif
AreaAnt( Arq_Ant, Ind_Ant )
Return( OK )

Function GrupoCerto( cGrupo, nCol, nLinha )
*******************************************
LOCAL oInclusao  := {{|| Lista1_1() }}
LOCAL oAlteracao := {{|| GrupoDbEdit() }}
LOCAL cScreen	  := SaveScreen()
LOCAL Arq_Ant	  := Alias()
LOCAL Ind_Ant	  := IndexOrd()

if LastKey() = UP
	Return( OK )
endif

Area("Grupo")
Grupo->(Order( GRUPO_CODGRUPO ))
if Grupo->(!DbSeek( cGrupo ))
	Grupo->(Order( GRUPO_DESGRUPO ))
	Grupo->(Escolhe( 03, 01, 22, "CodGrupo + 'Ý' + DesGrupo", "GRUPO DESCRICAO DO GRUPO", oInclusao, NIL, oAlteracao, NIL, NIL, NIL ))
	cGrupo := Grupo->CodGrupo
endif
Write( nCol, nLinha, Grupo->DesGrupo )
AreaAnt( Arq_Ant, Ind_Ant )
return( OK )

Function SubCerto( cSub, nCol, nLinha, cGrupo )
***********************************************
LOCAL oInclusao  := {{|| Lista1_2() 		}}
LOCAL oAlteracao := {{|| SubGrupoDbEdit() }}
LOCAL cScreen	  := SaveScreen()
LOCAL Arq_Ant	  := Alias()
LOCAL Ind_Ant	  := IndexOrd()

if LastKey() = UP
	Return( OK )
endif
Area("SubGrupo")
SubGrupo->(Order( SUBGRUPO_CODSGRUPO ))
if SubGrupo->(!DbSeek( cSub ))
	SubGrupo->(DbSeek( cGrupo ))
	SubGrupo->(Escolhe( 03, 01, 22, "CodsGrupo + 'Ý' + DessGrupo", "SUBGRUPO   DESCRICAO DO SUBGRUPO", oInclusao, NIL, oAlteracao, NIL, NIL, OK ))
	cSub := SubGrupo->CodsGrupo
endif
if Left( cSub, 3 ) != cGrupo
	ErrorBeep()
	Alerta('Erro: Subgrupo incompativel com o grupo.')
	AreaAnt( Arq_Ant, Ind_Ant )
	Return( FALSO )
endif
Write( nCol, nLinha, SubGrupo->DessGrupo )
AreaAnt( Arq_Ant, Ind_Ant )
Return( OK )

Proc RepresInclusao()
*********************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen( )
LOCAL Mcodi
LOCAL Nom
LOCAL Mfanta
LOCAL Dat
LOCAL Mcpf
LOCAL Fon
LOCAL Mfax
LOCAL Rg1
LOCAL End
LOCAL Bai
LOCAL Mcgc
LOCAL Mcon
LOCAL Mcida
LOCAL Mesta
LOCAL Mcep
LOCAL Mins
LOCAL Mcaixa
LOCAL Mobs
LOCAL cNome
LOCAL cFanta
LOCAL cSigla
LOCAL cCpf
LOCAL cFone
LOCAL cFax
LOCAL cRg
LOCAL cCgc
LOCAL cEnde
LOCAL cObs
LOCAL cBair
LOCAL cCon
LOCAL cCida
LOCAL cEsta
LOCAL cCep
LOCAL cCodi
LOCAL cInsc
LOCAL cCaixa
LOCAL dData
FIELD Codi
FIELD Nome
FIELD Repres

oMenu:Limpa()
Area( "Repres" )
Repres->(Order( REPRES_CODI ))
WHILE OK
	MaBox( 05, 02, 20, 78, "INCLUSAO DE REPRESENTANTES" )
	cNome  := Space(40)
	cFanta := Space(40)
	cSigla := Space(10)
	cCpf	 := Space(14)
	cFone  := Space(14)
	cFax	 := Space(14)
	cRg	 := Space(18)
	cCgc	 := Space(18)
	cEnde  := Space(30)
	cObs	 := Space(60)
	cBair  := Space(20)
	cCon	 := Space(20)
	cCida  := Space(25)
	cEsta  := Space(02)
	cCep	 := Space(09)
	cCodi  := Space(04)
	cInsc  := Space(15)
	cCaixa := Space(03)
	dData  := Date()

	Area( "Repres" )
	Repres->(Order( REPRES_CODI ))
	DbGoBottom()
	cCodi := StrZero( Val( Repres ) + 1 , 4)
	Write( 06, 23, "ANTERIOR " + Repres->Repres + " " + Repres->Nome )
	@ Row()	, 03 Say "Codigo......:" Get cCodi  Pict  "9999" Valid RepresCerto( @cCodi )
	@ Row()+1, 03 Say "R. Social...:" Get cNome  Pict  "@!" Valid !Empty(cNome) .OR. LastKey() = UP
	@ Row()+1, 03 Say "CGC/MF......:" Get cCgc   Pict  "99.999.999/9999-99" Valid TestaCgc( cCgc )
	@ Row()+1, 03 Say "Inscri‡ao...:" Get cInsc  Pict  "@!"
	@ Row()+1, 03 Say "Endere‡o....:" Get cEnde  Pict  "@!"
	@ Row()+1, 03 Say "CEP.........:" Get cCep   Pict  "99999-999" Valid CepErrado( @cCep, @cCida, @cEsta, @cBair )
	@ Row()+1, 03 Say "Cidade......:" Get cCida  Pict  "@!"
	@ Row()+1, 03 Say "Bairro......:" Get cBair  Pict  "@!"
	@ Row()+1, 03 Say "Estado......:" Get cEsta  Pict  "@!"
	@ Row()+1, 03 Say "Telefone....:" Get cFone  Pict  PIC_FONE
	@ Row()+1, 03 Say "Fax.........:" Get cFax   Pict  PIC_FONE
	@ Row()+1, 03 Say "Cx Postal...:" Get cCaixa Pict  "999"
	@ Row()+1, 03 Say "Contato.....:" Get cCon   Pict  "@!"
	@ Row()+1, 03 Say "Obs.........:" Get cObs   Pict  "@!"
	Read
	if LastKey() = ESC
		ResTela( cScreen )
		Exit
	endif
	if Conf(" Pergunta: Confirma Inclusao do Registro ?")
		if !RepresCerto( @cCodi)
			Loop
		endif
		if Repres->(Incluiu())
			Repres->Repres := cCodi
			Repres->Nome	:= cNome
			Repres->Ende	:= cEnde
			Repres->Bair	:= cBair
			Repres->Cida	:= cCida
			Repres->Con 	:= cCon
			Repres->Obs 	:= cObs
			Repres->Esta	:= cEsta
			Repres->Cep 	:= cCep
			Repres->Fone	:= cFone
			Repres->Cgc 	:= cCgc
			Repres->Insc	:= cInsc
			Repres->Fax 	:= cFax
			Repres->Caixa	:= cCaixa
			Repres->(Libera())
		endif
	endif
EndDo

Function Represrrado( Var, nRow, nCol, cSigla )
*********************************************
LOCAL aRotina := {{|| RepresInclusao() }}
LOCAL cScreen := SaveScreen()
LOCAL Ind_Ant := IndexOrd()
LOCAL Arq_Ant := Alias()
FIELD Codi, Nome

Area( "Repres" )
Repres->(Order( REPRES_CODI ))
if Repres->(!( DbSeek( Var )))
	Repres->( Order( REPRES_NOME ))
	Repres->( Escolhe( 03, 01, 22, "Repres + 'Ý' + Nome + 'Ý' + Fone", "CODI NOME REPRESENTANTE                       TELEFONE", aRotina ))
	Var := IF( Len( Var ) = 4, Repres->Repres, Repres->Nome )
endif
if nRow != Nil
	Write( nRow, nCol, Repres->Nome )
endif
AreaAnt( Arq_Ant, Ind_Ant )
Return(OK)

Function BarErrado( cCodeBar, lModificar, cSwapBar )
****************************************************
LOCAL Ind_Ant := IndexOrd()
LOCAL Arq_Ant := Alias()
LOCAL Reg_Ant := Recno()
LOCAL lRet	  := OK

if lModificar
	if AllTrim(cCodeBar) == cSwapBar
		Return( lRet )
	endif
endif
if LastKey() = UP
	Return( lRet )
endif
Lista->(Order( LISTA_CODEBAR ))
if Lista->(DbSeek( cCodeBar ))
	ErrorBeep()
	Alerta("Erro: Codigo de Barra Existente.")
	lRet := FALSO
endif
AreaAnt( Arq_Ant, Ind_Ant )
DbGoTo( Reg_Ant )
Return( lRet )

Function PagCerto( cCodi, lAlteracao, cSwap )
*********************************************
LOCAL lModificar := IF( lAlteracao != NIL .AND. lAlteracao, OK, FALSO )
LOCAL Ind_Ant	  := IndexOrd()
LOCAL Arq_Ant	  := Alias()

if LastKey() = UP
	Return( OK )
endif
if lModificar
	if cCodi == cSwap
		Return( OK )
	endif
endif
if Empty( cCodi ) .OR. Len(AllTrim( cCodi)) < 4
	ErrorBeep()
	Alerta( "Erro: Codigo de fornecedor Invalido." )
	Return( FALSO )
endif
Area( "Pagar" )
Pagar->(Order( PAGAR_CODI ))
if Pagar->(DbSeek( cCodi ))
	ErrorBeep()
	Alerta("Erro: Fornecedor Ja Registrado ou Incluido por outra Esta‡ao.." )
	Pagar->(DbGoBoTTom())
	cCodi := StrZero( Val( Pagar->Codi)+1, 4 )
	AreaAnt( Arq_Ant, Ind_Ant )
	Return(FALSO)
endif
AreaAnt( Arq_Ant, Ind_Ant )
Return(OK)

Function RepresCerto( cCodi )
*****************************
LOCAL Arq_Ant, Ind_Ant

if LastKey() = UP
	Return( OK )
endif
if Empty( cCodi )
	ErrorBeep()
	Alerta( "Erro: Codigo Representante Invalido." )
	Return(FALSO)
endif
Ind_Ant := IndexOrd()
Arq_Ant := Alias()
Area( "Repres" )
Repres->(Order( REPRES_CODI ))
if (DbSeek( cCodi ) )
	ErrorBeep()
	Alerta("Erro: Representante Ja Registrado." )
	Pagar->(DbGoBoTTom())
	cCodi := StrZero( Val( Repres->Repres ) + 1, 4 )
	AreaAnt( Arq_Ant, Ind_Ant )
	Return(FALSO)
endif
AreaAnt( Arq_Ant, Ind_Ant )
Return(OK)

Function Complet3( xCep , Mcida, Mesta)
***************************************
if xCep	 = XCCEP
	Mcida := XCCIDA
	Mesta := XCESTA
	Keyb Chr( 13 ) + Chr( 13 )

endif
Return( OK )

Function CodiErrado( cCodiIni, cCodiFim, lUltimo, nRow, nCol )
**************************************************************
LOCAL aRotina := {{|| InclusaoProdutos() }}
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()

cCodiIni := IF( ValType( cCodiIni ) = "N", StrZero( cCodiIni, 6), cCodiIni )
Area("Lista")
Lista->(Order( LISTA_CODIGO ))
if Lista->(!DbSeek( cCodiIni ))
	Lista->(Order( LISTA_DESCRICAO ))
	Lista->(Escolhe( 03, 00, 22,"Codigo + 'Ý' + Descricao + 'Ý' + Tran( Quant, '999999.99') + 'Ý' + Tran( Varejo, '@E 99,999,999.99') + 'Ý' + Sigla","CODIG DESCRICAO DO PRODUTO                       ESTOQUE         PRECO MARCA", aRotina ))
	cCodiIni := IF( Len( cCodiIni ) > 6, Lista->Descricao, Lista->Codigo )
endif
if nRow != NIL .AND. nCol != NIL
	Write( nRow, nCol, Lista->Descricao )
endif
AreaAnt( Arq_Ant, Ind_Ant )
Return( OK )

Function SimOuNao()
*******************
ErrorBeep()
Return( Alert("Esta opcao ira somar as entradas e saidas;" + ;
				  "de produtos e atualizar o estoque;; " + ;
				  "Deseja continuar ?", {" Sim ", " Nao "}) == 1 )

Proc InclusaoDolar( dData )
**************************
LOCAL cScreen	:= SaveScreen()
LOCAL GetList	:= {}
LOCAL nCotacao := 0

oMenu:Limpa()
if dData = Nil
	dData := Date() + 7
endif
dData 	:= Date()-1
nCotacao := 0
Area("Taxas")
Taxas->(Order( TAXAS_DFIM ))
WHILE OK
	dData++
	MaBox( 05, 11, 08, 51, "INCLUSAO DA COTA€AO DOLAR - ESC Retorna" )
	@ 06, 	  12 Say "Data                   ¯" Get dData    Pict "##/##/##" Valid DolarCerto( dData )
	@ Row()+1, 12 Say "Cota‡ao Dolar R$       ¯" Get nCotacao Pict "99999999.99" Valid nCotacao > 0
	Read
	if LastKey() = ESC
		ResTela( cScreen )
		Exit
	endif
	ErrorBeep()
	if Conf("Pergunta: Confirma Inclusao do Registro ?")
		if !DolarCerto( dData )
			Loop
		endif
		if Taxas->(!Incluiu())
			Loop
		endif
		Taxas->DIni 	 := dData
		Taxas->DFim 	 := dData
		Taxas->Cotacao  := nCotacao
		Taxas->(Libera())
	endif
EndDo

Proc InclusaoForma()
********************
LOCAL cScreen		 := SaveScreen()
LOCAL GetList		 := {}
LOCAL cForma		 := Space(02)
LOCAL cCondicoes	 := Space(40)
LOCAL cDescricao	 := Space(40)
LOCAL nComissao	 := 0
LOCAL cEspecificar := "S"
LOCAL nMeses		 := 0
LOCAL nIof			 := 0
LOCAL cDesdobrar	 := "N"
LOCAL cVista		 := "N"
LOCAL nParcelas	 := 1
LOCAL nDias 		 := 30

oMenu:Limpa()
MaBox( 05, 05, 13, 72, "INCLUSAO DE FORMA PGTO" )
Area("Forma")
Forma->(Order( FORMA_FORMA ))
WHILE OK
	Forma->(DbGoBoTTom())
	cForma := StrZero( Val( Forma->Forma ) + 1, 2 )
	cDesdobrar	 := "N"
	cVista		 := "N"
	nParcelas	 := 0
	nDias 		 := 0
   @ 06, 06 Say "Codigo..........:"    Get cForma       Pict "99"  Valid FormaCerta( cForma )
   @ 07, 06 Say "Condicoes.......:"    Get cCondicoes   Pict "@!"  Valid IF( Empty( cCondicoes ), ( ErrorBeep(), Alerta("Erro: Entrada Invalida."), FALSO ), OK )
	@ 08, 06 Say "Desdobramento...:"    Get cDesdobrar   Pict "!"   Valid PickSimNao( @cDesdobrar )
	@ 08, 35 Say "N§ Parcelas........:" Get nParcelas    Pict "99"  When cDesdobrar == "S"
	@ 09, 06 Say "1§ Parcela Vista:"    Get cVista       Pict "!"   Valid PickSimNao( @cVista ) When cDesdobrar = 'S'
   @ 09, 35 Say "Dias Entre Parcelas:" Get nDias        Pict "999" When cDesdobrar == "S"
	@ 10, 06 Say "Descricao.......:"    Get cDescricao   Pict "@!"
	@ 11, 06 Say "Comissao........:"    Get nComissao    Pict "99.99"
	@ 12, 06 Say "Taxa Financeiro.:"    Get nIof         Pict "999.9999"
	Read
	if LastKey() = ESC
		ResTela( cScreen )
		Exit
	endif
	ErrorBeep()
	if Conf("Pergunta: Confirma Inclusao do Registro ?")
		if !FormaCerta( cForma )
			Loop
		endif
		if Forma->(!Incluiu())
			Loop
		endif
		Forma->Forma		:= cForma
		Forma->Condicoes	:= cCondicoes
		Forma->Descricao	:= cDescricao
		Forma->Comissao	:= nComissao
		Forma->Iof			:= nIof
		Forma->Desdobrar	:= cDesdobrar == "S"
		Forma->Parcelas	:= nParcelas
		Forma->Dias 		:= nDias
		Forma->Vista		:= cVista == 'S'
		Forma->(Libera())
	endif
EndDo

Function DolarCerto( dData )
***************************
if Taxas->(DbSeek( dData ))
	ErrorBeep()
	if Taxas->Cotacao = 0
		Alerta("Erro: Cota‡ao registrada com valor 0...")
	Else
		Alerta("Erro: Cota‡ao desta Data ja registrada...")
	endif
	Return( FALSO )
endif
Return( OK )

Function FormaCerta( cForma )
*****************************
if Forma->(DbSeek( cForma ))
	ErrorBeep()
	Alerta("Erro: Codigo de Forma de Pgto ja registrada...")
	Return( FALSO )
endif
Return( OK )

Function Cotacao( dData, nCotacao, lExcecao )
*********************************************
LOCAL cScreen := SaveScreen()
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
LOCAL cString
if lExcecao = NIL
	#IFNDEF XDOLAR
		nCotacao := 1
		Return( OK )
	#endif
endif
Area("Taxas")
Taxas->(Order( TAXAS_DFIM ))
if Taxas->(!DbSeek( dData ))
	ErrorBeep()
	cString := "Cotacao de " + Dtoc( dData ) + " Nao Encontrada. Registrar ?"
	if Conf( cString )
		 InclusaoDolar( dData )
	endif
	AreaAnt( Arq_Ant, Ind_Ant )
	ResTela( cScreen )
	Return( FALSO )
endif
if Taxas->Cotacao = 0
	ErrorBeep()
	cString := "Cotacao ja Registrada com valor 0. Alterar ?"
	if Conf( cString )
		MudaDolar( OK )
	endif
	AreaAnt( Arq_Ant, Ind_Ant )
	ResTela( cScreen )
	Return( FALSO )
endif
nCotacao := Taxas->Cotacao
AreaAnt( Arq_Ant, Ind_Ant )
Return( OK )

PROC NaoTem()
*************
ErrorBeep()
Alerta("Erro: Nenhum Registro Neste Periodo... ")
Return

Proc CliAltera()
****************
LOCAL GetList	:= {}
LOCAL cScreen	:= SaveScreen()
LOCAL cCodi 	:= Space(05)

WHILE OK
	MaBox( 10, 10, 12, 75 )
	@ 11, 11 Say "Codigo Cliente..: " Get cCodi Pict PIC_RECEBER_CODI Valid RecErrado( @cCodi,, Row(), Col()+1 )
	Read
	if LastKey() = ESC
		Return
	endif
	CliInclusao( OK )
EndDo


Function SeekData( dMinor, dMajor, cCampo )
*******************************************
LOCAL xValor := Date()

if cCampo != NIL
	DbGoTop()
	xValor := FieldGet( FieldPos( cCampo ))
	if dMinor < xValor
		dMinor := xValor
	endif
endif
WHILE !DbSeek( dMinor++ )
	 if dMinor > dMajor
		 Return( FALSO )
	 endif
EndDo
Return( OK )

Function AchaTipo( cTipo )
**************************
Recemov->(Order( RECEMOV_TIPO_CODI ))
if Recemov->(!DbSeek( cTipo ))
	ErrorBeep()
	Alerta("Erro: Tipo nao localizado.")
	Return( FALSO )
endif
Return( OK )

Function Cliente( cCodi, cPraca, cCliRecno, cEsta )
***************************************************
LOCAL aRotinaInc := {{|| CliInclusao() }}
LOCAL aRotinaAlt := {{|| CliInclusao(OK) }}
LOCAL cScreen    := SaveScreen()
LOCAL Arq_Ant    := Alias()
LOCAL Ind_Ant    := IndexOrd()
LOCAL nRow       := MaxRow()
LOCAL nMaxCol    := MaxCol()

Area("Receber")
Receber->(Order( RECEBER_CODI ))
Receber->(DbGoTop())
if Receber->(Lastrec()) = 0
	ErrorBeep()
	if Conf( "Nenhum Cliente Registrado... Registrar ? " )
		CliInclusao()
	endif
	AreaAnt( Arq_Ant, Ind_Ant )
	ResTela( cScreen )
	Return( FALSO )
endif
if Receber->(!DbSeek( cCodi ))
	Receber->(Order( RECEBER_NOME ))
	Receber->(DbGoTop())
	if nMaxCol > 80
		Receber->(Escolhe( 03, 00, MaxRow()-2,"Codi + 'Ý' + Nome + 'Ý' + Fone + 'Ý' + Fax + 'Ý' + Left( Fanta, 15 ) + 'Ý' + Ende", "CODI NOME DO CLIENTE                           TELEFONE #1    TELEFONE #2    POP             ENDERECO", aRotinaInc, nil, aRotinaAlt ))
	else
		Receber->(Escolhe( 03, 00, MaxRow()-2,"Codi + 'Ý' + Nome + 'Ý' + Fone + 'Ý' + Left( Fanta, 15 )", "CODI NOME DO CLIENTE                          TELEFONE       POP     ", aRotinaInc, nil, aRotinaAlt ))
	endif
endif
cCliRecno := Receber->(Recno())
cCodi 	 := Receber->Codi
cPraca	 := Receber->Cep + "/" + Receber->Cida
cEsta 	 := Receber->Esta

Write( nRow-7, 15 , Receber->Nome )
Write( nRow-7, 66 , Receber->Codi )

Write( nRow-6, 15 , Receber->Ende )
Write( nRow-6, 59 , Receber->Bair )

Write( nRow-5, 15 , Receber->Cida )
Write( nRow-5, 66 , Receber->Esta )

Write( nRow-4, 15 , Receber->Cep + "/" + Receber->Cida )
Write( nRow-4, 66 , Receber->Esta )

Write( nRow-3, 15 , Receber->Cgc )
Write( nRow-3, 58 , Receber->Insc )

Write( nRow-2, 15 , Receber->Cpf )
Write( nRow-2, 58 , Receber->Rg )
AreaAnt( Arq_Ant, Ind_Ant )
Return( OK )

Proc Avisa()
************
ErrorBeep()
Alerta( "Erro: Nada Consta nos parametros informados.")
Return

Proc Cheq11()
*************
LOCAL GetList	 := {}
LOCAL cScreen	 := SaveScreen(  )
LOCAL cBanco	 := Space(10)
LOCAL dData 	 := Date()
LOCAL cCgc		 := Space(18)
LOCAL cConta	 := Space(08)
LOCAL cFone 	 := Space(13)
LOCAL cObs		 := Space(40)
LOCAL cTitular  := Space(40)
LOCAL cPoupanca := "N"
LOCAL cAg		 := XCCIDA + Space( 25 - Len( XCCIDA ) )
LOCAL cMens 	 := "N"
LOCAL cExterna  := "S"

WHILE OK
	oMenu:Limpa()
	cBanco	 := Space(10)
	dData 	 := Date()
	cCgc		 := Space(18)
	cConta	 := Space(08)
	cFone 	 := Space(13)
	cObs		 := Space(40)
	cTitular  := Space(40)
	cAg		 := XCCIDA + Space( 25 - Len( XCCIDA ) )
	cMens 	 := "N"
	cExterna  := "S"
	cPoupanca := "N"

	Area("Cheque")
	Cheque->(Order( CHEQUE_CODI ))
	DbGoBottom()
	cCodi := StrZero( Val( Codi ) + 1, 4 )
	MaBox( 06, 02, 18, 78, "INCLUSAO DE CONTAS" )
	WHILE OK
		@ 07,03 Say  "Codigo......:" GET cCodi     Pict "9999" Valid CheCerto( @cCodi )
		@ 08,03 Say  "Titular.....:" GET cTitular  Pict "@!" Valid !Empty( cTitular )
		@ 09,03 Say  "CGC/MF......:" GET cCgc      Pict "99.999.999/9999-99" Valid TestaCgc( cCgc )
		@ 10,03 Say  "Abertura....:" GET dData     Pict "##/##/##"
		@ 11,03 Say  "Banco.......:" GET cBanco    Pict "@!"
		@ 12,03 Say  "Telefone....:" GET cFone     Pict PIC_FONE
		@ 13,03 Say  "Agencia.....:" GET cAg       Pict "@K!"
		@ 14,03 Say  "Conta N§....:" GET cConta    Pict "@!"
		@ 15,03 Say  "Observ......:" GET cObs      Pict "@!"
		@ 16,03 Say  "Cob Externa.:" GET cExterna  Pict "!" Valid cExterna  $ "SN"
		@ 17,03 Say  "Poupanca....:" GET cPoupanca Pict "!" Valid cPoupanca $ "SN"
		Read
		if LastKey() = ESC
			ResTela( cScreen )
			Exit
		endif
		ErrorBeep()
		nOpcao := Alerta(" Pergunta: Voce Deseja ? ", {" Incluir ", " Alterar ", " Sair " })
		if nOpcao = 1
			if !Checerto( @cCodi )
				Loop
			endif
			Area("Cheque")
			if Cheque->(Incluiu())
				Cheque->Codi	  := cCodi
				Cheque->Titular  := cTitular
				Cheque->Data	  := dData
				Cheque->Banco	  := cBanco
				Cheque->Cgc 	  := cCgc
				Cheque->Ag		  := cAg
				Cheque->Conta	  := cConta
				Cheque->Fone	  := cFone
				Cheque->Obs 	  := cObs
				Cheque->Mens	  := IF( cMens 	 = "S", OK, FALSO )
				Cheque->Externa  := IF( cExterna  = "S", OK, FALSO )
				Cheque->Poupanca := IF( cPoupanca = "S", OK, FALSO )
				Cheque->(Libera())
				cCodi := StrZero( Val( cCodi )+1, 4 )
			endif
		Elseif nOpcao = 2
			Loop
		Else
			Exit
		endif
	EndDo
	ResTela( cScreen )
	Exit
EndDo

Function CheCerto( Var)
***********************
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
if ( Empty( Var ) )
	ErrorBeep()
	Alerta( "Erro: C¢digo Conta Invalida ..." )
	Return( FALSO )

endif
Area( "Cheque" )
Cheque->(Order( CHEQUE_CODI ))
DbGoTop()
if (DbSeek( Var ) )
	ErrorBeep()
	Alerta("Erro: Conta J  Registrada ou Incluida por outra Estacao..." )
	Var := StrZero( Val( Var )+1,4)
	AreaAnt( Arq_Ant, Ind_Ant )
	Return( FALSO )

endif
AreaAnt( Arq_Ant, Ind_Ant )
Return( OK )

Function Cancela( lCancelado)
*****************************
if Rep_OK()
	lCancelado := FALSO
	Return( OK )
Else
	lCancelado := OK
	Return( FALSO )
endif

Function BaixaGeral( cCodi, nApagar, nPago )
********************************************
LOCAL cScreen	 := SaveScreen()
LOCAL Arq_Ant	 := Alias()
LOCAL Ind_Ant	 := IndexOrd()
LOCAL nTotal	 := 0

Lista->(Order( LISTA_CODIGO ))
Area("Saidas")
Saidas->(Order( SAIDAS_CODI ))
Set Rela To Codigo Into Lista
if Saidas->(!DbSeek( cCodi ))
	ErrorBeep()
	Alerta( "Erro: Nenhum Produto Faturado Deste Cliente." )
	Saidas->(DbClearRel())
	AreaAnt( Arq_Ant, Ind_Ant )
	Return( FALSO )
endif
WHILE Saidas->Codi = cCodi
	if Saidas->C_C // Conta Corrente ?
		nQuant  := ( Saidas->Saida - Saidas->SaidaPaga )
		if nQuant > 0 // Deve ainda ?
			nTotal += nQuant * Lista->Varejo
		endif
	endif
	Saidas->(DbSkip(1))
EndDo
if nTotal = 0
	ErrorBeep()
	Alerta( "Erro: Cliente Sem Debito em Conta Corrente." )
	Saidas->(DbClearRel())
	AreaAnt( Arq_Ant, Ind_Ant )
	Return( FALSO )
endif
nApagar := nTotal
nPago   := nTotal
Saidas->(DbClearRel())
AreaAnt( Arq_Ant, Ind_Ant )
Return( OK )

Function SomaPagoInd( nApagar, cFatura, nQuant, cCodigo, nRegistro )
*******************************************************************
LOCAL oBloco
LOCAL nSoma 	  := 0
LOCAL cCombinado := ""
if LastKey() = UP
	Return( OK )
endif
nApagar	  := 0
nPago 	  := 0
cCombinado := cFatura + Space(2) + cCodigo
cTela 	  := Mensagem(" Aguarde...", Cor(), 20)

Lista->(Order( LISTA_CODIGO ))
Area("Saidas")
Saidas->(Order( SAIDAS_FATURA_CODIGO ))
Set Rela To Codigo Into Lista
Saidas->(DbGoto( nRegistro ))
if Saidas->Fatura = cFatura .AND. Saidas->Codigo = cCodigo
	nSoma := Saidas->SaidaPaga + nQuant
	if Saidas->Saida >= nSoma .AND. nQuant != 0
		nApagar := nQuant * Lista->Varejo
		Saidas->(DbClearRel())
		ResTela( cTela )
		Return( OK )
	Else
		ResTela( cTela )
		cSoma := StrZero((Saidas->Saida - Saidas->SaidaPaga), 7)
		ErrorBeep()
		Alerta(" Erro: Quantidade a baixar invalida..." + ;
				"; Disponivel : " + cSoma )
		Saidas->(DbClearRel())
		Return( FALSO)
	endif
endif
ResTela( cTela )
Alerta(" Erro: Registro nao encontrado...")
Saidas->(DbClearRel())
Return( FALSO )

Function SomaPago( nApagar, cFatura, nPago )
*******************************************
LOCAL oBloco
if LastKey() = UP
	Return( OK )
endif
nApagar := 0
nPago   := 0
Lista->(Order( LISTA_CODIGO ))
Area("Saidas")
Saidas->(Order( SAIDAS_FATURA ))
Set Rela To Codigo Into Lista
oBloco := {|| Saidas->Fatura = cFatura }
if Saidas->(Dbseek( cFatura ))
	WHILE Eval( oBloco )
		if Saidas->C_c
			nApagar += ( Saidas->Saida - Saidas->SaidaPaga ) * Lista->Varejo
			nPago   += Saidas->SaidaPaga * Lista->Varejo
		Else
			nPago   += ( Saidas->SaidaPaga * Lista->Varejo )
		endif
		Saidas->(DbSkip(1))
	EndDo
endif
Saidas->(DbClearRel())
if nApagar = 0
	ErrorBeep()
	Alerta(" Erro: Esta fatura ja esta paga !!")
	Return( FALSO )
endif
Return( OK )

Function CalcSobra( nApagar, nPerc, nSobra )
*******************************************
nSobra := nApagar - (( nApagar * nPerc ) / 100 )
Return( OK )

Function cDolar( cDolar )
*************************
LOCAL cScreen := SaveScreen()
LOCAL aMenu   := { " Real ", " Dolar " }
LOCAL aMoeda  := { "R", "U" }
LOCAL nChoice := 1

MaBox( 20, 33, 23, 43 )
nChoice := Achoice( 21, 34, 22, 42, aMenu )
cDolar  := aMoeda[ IF( nChoice = 0, 1, nChoice )]
Keyb Chr( ENTER )
ResTela( cScreen )
Return OK

Proc OrcaLista( lVarejo )
*************************
LOCAL cScreen := SaveScreen()
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
PRIVA aVetor1 := {"Codigo","Descricao", "Quant", IF( lVarejo = 2, "Varejo", "Atacado"), IF( lVarejo = 2, "Atacado", "Varejo"), "Vendida", "Local", "Sigla", "N_Original"}
PRIVA aVetor2 := {"CODIGO","DESCRICAO DO PRODUTO", "ESTOQUE", IF( lVarejo = 2, "VAREJO", "ATACADO"), IF( lVarejo = 2, "ATACADO", "VAREJO"), "VENDIDA","LOCALIZACACAO", "SIGLA","COD FABRICANTE"}

Area("Lista")
Lista->(Order( LISTA_DESCRICAO ))
Lista->(DbGoTop())
MaBox( 00, 00, 15, MaxCol()-1, "F2 PROCURA Ý  F6 TROCAR ORDEM Ý A-Z PROCURA")
Seta1(15)
DbEdit( 01, 01, 14, MaxCol()-2, aVetor1, "OrcaFunc", OK,  aVetor2 )
AreaAnt( Arq_Ant, Ind_Ant )
ResTela( cScreen )
Return

def NewFatura( cDeleteFile)
****************************
   LOCAL xAlias := "t" + StrTran( Time(),":") + ".tmp"

   Mensagem("Aguarde... Criando Arquivo de Trabalho.")
   
   while file((xAlias))
      xAlias := "t" + StrTran( Time(),":") + ".tmp"
   EndDo
   
   Dbf1 := {{ "CODIGO",   "C", 06, 0 }, ; // Codigo do Produto
            { "UN",       "C", 02, 0 }, ;
            { "CODI",     "C", 04, 0 }, ;
            { "QUANT",    "N", 08, 2 }, ;
            { "DESCONTO", "N", 05, 2 }, ;
            { "DESCRICAO","C", 40, 0 }, ;
            { "PCUSTO",   "N", 13, 2 }, ;
            { "VAREJO",   "N", 13, 2 }, ;
            { "ATACADO",  "N", 13, 2 }, ;
            { "UNITARIO", "N", 13, 2 }, ;
            { "TOTAL",    "N", 13, 2 }, ;
            { "MARVAR",   "N", 06, 2 }, ;
            { "MARATA",   "N", 06, 2 }, ;
            { "UFIR",     "N", 07, 2 }, ;
            { "IPI",      "N", 05, 2 }, ;
            { "II",       "N", 05, 2 }, ;
            { "PORC",     "N", 05, 2 }}
   DbCreate( xAlias, Dbf1 )
   Use (xAlias) Alias xAlias Exclusive New
   Return((xAlias))
endef   

Function Acha_Reg( cFatu, cCodigo, nQuant, nRegistro )
******************************************************
LOCAL cScreen	:= SaveScreen()
LOCAL Arq_Ant	:= Alias()
LOCAL Ind_Ant	:= IndexOrd()
LOCAL cProcura := cFatu + Space(2) + StrCodigo( cCodigo )
LOCAL aTodos	:= {}
LOCAL aRecno	:= {}
LOCAL aQuant	:= {}
LOCAL nChoice	:= 0

Area("Saidas")
Saidas->(Order( SAIDAS_FATURA_CODIGO ))
if !( DbSeek( cProcura ))
	Saidas->(Order( SAIDAS_FATURA ))
	Saidas->(DbSeek( cFatu ))
	WHILE Saidas->Fatura = cFatu
		 nQuant	:= ( Saidas->Saida - Saidas->SaidaPaga )
		 if nQuant > 0
			 Aadd( aTodos, Saidas->Codigo + " " + Lista->Descricao )
			 Aadd( aRecno, Saidas->(Recno()))
			 Aadd( aQuant, nQuant )
		 endif
		 Saidas->(DbSkip(1))
	EndDo
	MaBox( 03, 19, 17, 79,"CODIGO DESCRICAO DO PRODUTO                             ")
	nChoice := aChoice( 04, 20, 16, 78, aTodos )
	ResTela( cScreen )
	Saidas->(Order( SAIDAS_FATURA_CODIGO ))
	if nChoice = 0
		Alerta( "Erro: Procura Cancelada..." )
		AreaAnt( Arq_Ant, Ind_Ant )
		Return( FALSO )
	endif
	cTemp 	 := Left( aTodos[nChoice],5)
	nRegistro := aRecno[nChoice]
	cCodigo	 := cTemp
	if DbSeek( cFatu + Space(2) + cTemp )
		if nQuant != Nil
			nQuant  := ( Saidas->Saida - Saidas->SaidaPaga )
		endif
		AreaAnt( Arq_Ant, Ind_Ant )
		Return( OK )
	endif
	ErrorBeep()
	Alerta( "Erro: Produto Nao Encontrado na Fatura..." )
	AreaAnt( Arq_Ant, Ind_Ant )
	Return( FALSO )
endif
if nQuant != Nil
	nQuant  := ( Saidas->Saida - Saidas->SaidaPaga )
	cCodigo := Saidas->Codigo
endif
AreaAnt( Arq_Ant, Ind_Ant )
Return( OK )

Function BaixaProcura( cCodi, cFatu, cCodigo, nQuant, nApagar, nRegistro )
**************************************************************************
LOCAL cScreen	 := SaveScreen()
LOCAL Arq_Ant	 := Alias()
LOCAL Ind_Ant	 := IndexOrd()
LOCAL cProcura  := cFatu + Space(2) + StrCodigo( cCodigo )
LOCAL aTodos	 := {}
LOCAL aFatura	 := {}
LOCAL aApagar	 := {}
LOCAL aQuant	 := {}
LOCAL aRegistro := {}
LOCAL nChoice	 := 0
LOCAL nTam		 := 0
if LastKey() = UP
	Return( OK )
endif
Lista->(Order( LISTA_CODIGO ))
Area("Saidas")
Saidas->(Order( SAIDAS_CODI ))
Set Rela To Codigo Into Lista
if Saidas->(!DbSeek( cCodi ))
	ErrorBeep()
	Alerta( "Erro: Nenhum Produto Faturado Deste Cliente." )
	Saidas->(DbClearRel())
	AreaAnt( Arq_Ant, Ind_Ant )
	Return( FALSO )
endif
WHILE Saidas->Codi = cCodi
	if Saidas->C_C // Conta Corrente ?
		nQuant  := ( Saidas->Saida - Saidas->SaidaPaga )
		if nQuant > 0 // Deve ainda ?
			Aadd( aTodos,	  Saidas->Codigo + " " + Lista->Descricao + Str( nQuant, 9, 2 ))
			Aadd( aFatura,   Saidas->(Left( Fatura,7)))
			Aadd( aQuant,	  nQuant )
			Aadd( aApagar,   Saidas->VlrFatura )
			Aadd( aRegistro, Saidas->(Recno()))
		endif
	endif
	Saidas->(DbSkip(1))
EndDo
nTam := Len( aTodos )
if nTam = 0
	ErrorBeep()
	Alerta( "Erro: Nenhum Produto a Receber Deste Cliente." )
	Saidas->(DbClearRel())
	AreaAnt( Arq_Ant, Ind_Ant )
	Return( FALSO )
endif
MaBox( 00, 10, 14, 78,"CODIGO DESCRICAO DO PRODUTO                             ")
nChoice := aChoice( 01, 11, 13, 77, aTodos )
ResTela( cScreen )
if nChoice = 0
	Alerta( "Erro: Procura Cancelada..." )
	Saidas->(DbClearRel())
	AreaAnt( Arq_Ant, Ind_Ant )
	Return( FALSO )
endif
cCodigo	 := Left( aTodos[nChoice], 6)
cFatu 	 := aFatura[nChoice]
nApagar	 := aApagar[nChoice]
nQuant	 := aQuant[ nChoice ]
nRegistro := aRegistro[ nChoice ]
Saidas->(DbClearRel())
AreaAnt( Arq_Ant, Ind_Ant )
Keyb Chr( ENTER )
Return( OK )

Function BaixaLocaliza( cCodi, cFatu )
**************************************
LOCAL cScreen	 := SaveScreen()
LOCAL Arq_Ant	 := Alias()
LOCAL Ind_Ant	 := IndexOrd()
LOCAL aFatura	 := {}
LOCAL nQuant	 := 0
LOCAL nChoice	 := 0
LOCAL cFatura	 := ""

Area("Saidas")
Saidas->(Order( SAIDAS_CODI ))
if Saidas->(!DbSeek( cCodi ))
	ErrorBeep()
	Alerta( "Erro: Nenhum Produto Faturado Deste Cliente." )
	AreaAnt( Arq_Ant, Ind_Ant )
	Return( FALSO )
endif
WHILE Saidas->Codi = cCodi
	if Saidas->C_C // Conta Corrente ?
		nQuant  := ( Saidas->Saida - Saidas->SaidaPaga )
		if nQuant > 0 // Deve ainda ?
			cFatura := Saidas->(Left( Fatura, 7 ))
			if Ascan( aFatura, cFatura ) = 0
				Aadd( aFatura, cFatura )
			endif
		endif
	endif
	Saidas->(DbSkip(1))
EndDo
nTam := Len( aFatura )
if nTam = 0
	ErrorBeep()
	Alerta( "Erro: Nenhum Produto a Receber Deste Cliente." )
	AreaAnt( Arq_Ant, Ind_Ant )
	Return( FALSO )
endif
MaBox( 00, 10, 14, 20,"FATURA N§")
nChoice := aChoice( 01, 11, 13, 19, aFatura )
ResTela( cScreen )
if nChoice = 0
	Alerta( "Erro: Procura Cancelada..." )
	AreaAnt( Arq_Ant, Ind_Ant )
	Return( FALSO )
endif
cFatu 	 := aFatura[nChoice]
AreaAnt( Arq_Ant, Ind_Ant )
Keyb Chr( ENTER )
Return( OK )

/*--------------------------------*/
Function PickSituacao( cSituacao )

LOCAL aList 	 := { "0=Nacional", "1=Estrangeira - Importacao Direta", "2=Estrangeira - Adquirida no Mercado Interno" }
LOCAL aSituacao := { "0", "1", "2" }
LOCAL cScreen := SaveScreen()
LOCAL nChoice
if cSituacao $ aSituacao[1] .OR. cSituacao $ aSituacao[2] .OR. cSituacao $ aSituacao[3]
	Return( OK )
Else
	MaBox( 19, 34, 23, 79, NIL, NIL, Roloc( Cor()) )
	if (nChoice := AChoice( 20, 35, 22, 78, aList )) != 0
		cSituacao := aSituacao[ nChoice ]
	endif
endif
ResTela( cScreen )
Return( OK )

/*--------------------------------*/
Function PickClasse( cClasse )

LOCAL aList 	 := { "00=Tributada Integralmente", "10=Tributado e com cobranca do ICMS por Sub. Tributaria",;
							"20=Com reducao da Base de Calculo", "30=Isenta ou nao tributada e com Cobranca do ICMS por Sub. Tributaria", ;
							"40=Isenta", "41=Nao Tributada","50=Suspensao", ;
							"51=Diferimento", "60=Icms cobrado anteriormente por Sub. Tributaria",;
							"70=Com reducao de base de calculo e cobranca de ICMS por Substituicao Tributaria",;
							"90=Outros"}
LOCAL aClasse := { "00", "10", "20", "30", "40", "41", "50", "51", "60", "70", "90" }
LOCAL cScreen := SaveScreen()
LOCAL nTam	  := Len( aClasse )
LOCAL nChoice, nX
For nX := 1 To nTam
	if cClasse $ aClasse[nX]
		Return( OK )
	endif
Next
MaBox( 11, 34, 23, 79, NIL, NIL, Roloc( Cor()) )
if (nChoice := AChoice( 12, 35, 22, 78, aList )) != 0
	cClasse := aClasse[ nChoice ]
endif
ResTela( cScreen )
Return( OK )
/*--------------------------------*/

Function CalculaVenda( nPcusto, nMarVar, nVar )
************************************************
nVar := (( nPcusto * nMarVar ) / 100 ) + nPcusto
Return( OK )

Function DataExt( dData )
*************************
LOCAL Mes, MesExt

IF( dData = Nil, dData := Date(), dData )
Mes := Month( dData)

MesExt := { "Janeiro","Fevereiro","Marco","Abril","Maio","Junho",;
				"Julho","Agosto","Setembro","Outubro","Novembro","Dezembro" }

Cidade = XCCIDA + ",  "
Return( Cidade + StrZero( Day( dData), 2 ) +" de " + MesExt[ Mes] +" de " + Str(YEAR( dData ),4))

Proc ReciboRegiao()
*******************
LOCAL cScreen	 := SaveScreen()
LOCAL nVlr		 := 0
LOCAL cValor	 := Space(0)
LOCAL Larg		 := 80
LOCAL nValor	 := Space(0)
LOCAL nOpcao	 := 1
LOCAL cDocnr
LOCAL cHist 	 := Space(60)
LOCAL lCalcular := FALSO
LOCAL oBloco

oMenu:Limpa()
cRegiao := Space(02)
dIni	  := Date()-30
dFim	  := Date()
MaBox( 10, 10, 15, 79 )
@ 11, 11 Say "Regiao.... :" Get cRegiao Pict "99" Valid RegiaoErrada( @cRegiao ) .AND. VerRegiao( cRegiao )
@ 12, 11 Say "Data Ini.. :" Get dIni    Pict "##/##/##"
@ 13, 11 Say "Data Fim.. :" Get dFim    Pict "##/##/##"
@ 14, 11 Say "Referente..:" Get cHist   Pict "@!"
Read
if LastKey() = ESC
	ResTela( cScreen )
	Return
endif
Receber->(Order( RECEBER_CODI ))
Area("Recemov")
Set Rela To Recemov->Codi Into Receber
Recemov->(Order( RECEMOV_REGIAO ))
Recemov->(DbSeek( cRegiao ))
oBloco := {|| Recemov->Regiao = cRegiao }
lCalcular := Conf("Pergunta: Calcular Juros ?")
if !Instru80() .OR. !LptOk()
	Restela( cScreen )
	Return
endif
cTela := Mensagem("Aguarde, Imprimindo Recibo.", Cor())
PrintOn()
FPrInt( Chr(ESC) + "C" + Chr( 33 ))
While Eval( oBloco ) .AND. Recemov->(!Eof()) .AND. Rep_Ok()
	if Recemov->Vcto >= dIni .AND. Recemov->Vcto <= dFim
		cDocnr	 := Recemov->Docnr
		nMoeda	 := 1
		nVlr		 := Recemov->Vlr
		nVlrTotal := Recemov->Vlr
		if lCalcular
			nAtraso	 := Atraso( Date(), Vcto )
			nCarencia := Carencia( Date(), Vcto )
			if nAtraso <= 0
				nTotJuros := 0
				nVlrTotal := Recemov->Vlr
			Else
				nTotJuros := nCarencia * Recemov->Jurodia
				nVlrTotal := ( nTotJuros + Recemov->Vlr )
			endif
		endif
		cValor  := AllTrim(Tran( nVlrTotal,'@E 999,999,999,999.99'))
		nValor  := Extenso( nVlrTotal, nMoeda, 3, Larg )
		SetPrc(0,0)
		nRow := 2
		Write( nRow+00, 00, Repl("=",80))
		Write( nRow+01, 00, GD + Padc(AllTrim(oAmbiente:xFanta), 40) + CA )
		Write( nRow+02, 00, Padc( XENDEFIR + " - " + XCCIDA + " - " + XCESTA, 80 ))
		Write( nRow+03, 00, Repl("-",80))
		Write( nRow+04, 00, "N§ " + NG + cDocnr + NR )
		Write( nRow+04, 40, GD + "RECIBO" + CA )
		Write( nRow+04, 65, "R$ " + NG + cValor + NR)
		Write( nRow+06, 00, "Recebemos de    : " + NG + Receber->Nome + NR )
		Write( nRow+07, 00, "Estabelecido  a : " + NG + Receber->Ende + NR )
		Write( nRow+08, 00, "na Cidade de    : " + NG + Receber->Cida + NR )
		Write( nRow+10, 00, "A Importancia por extenso abaixo relacionada")
		Write( nRow+11, 00, NG + Left( nValor, Larg ) + NR  )
		Write( nRow+12, 00, NG + SubStr( nValor, Larg + 1, Larg ) + NR  )
		Write( nRow+13, 00, NG + Right( nValor, Larg ) + NR  )
		Write( nRow+15, 00, "Referente a")
		Write( nRow+16, 00, NG + cHist + NR )
		Write( nRow+18, 00, "Para maior clareza firmo(amos) o presente")
		Write( nRow+19, 35, NG + DataExt( Date()) + NR )
		Write( nRow+23, 00, "1§ VIA - CLIENTE" )
		Write( nRow+23, 40, Repl("-",40))
		Write( nRow+24, 00, Repl("=",80))
		__Eject()
	endif
	Recemov->(DbSkip(1))
Enddo
Recemov->(DbClearRel())
Recemov->(DbGoTop())
PrintOff()
ResTela( cTela )
Return

Function VerRegiao( cRegiao )
*****************************
Recemov->(Order( RECEMOV_REGIAO ))
if Recemov->(!DbSeek( cRegiao ))
	ErrorBeep()
	Alerta("Erro: Regiao Sem Movimento.")
	Return( FALSO )
endif
Return( OK )


/*
Function PutKey(oGet, cKey)
***************************
oGet:exitState := cKey
Return(OK)
*/

function LogAgenda( aAgenda )
*****************************
Mensagem("Aguarde, Registrando Recibo.")
if Agenda->(Incluiu())
	Agenda->Codi	 := aAgenda[1]
	Agenda->Data	 := aAgenda[2]
	Agenda->Hora	 := Time()
	Agenda->Hist	 := aAgenda[3]
	Agenda->Caixa	 := aAgenda[4]
	Agenda->Usuario := aAgenda[5]
	Agenda->Ultimo  := aAgenda[6]
	Agenda->(Libera())
	return OK
endif
return FALSO

def LogRecibo( aLog )
*---------------------*
	LOCAL Arq_Ant := Alias()
	LOCAL Ind_Ant := IndexOrd()
	LOCAL cScreen := SaveScreen()
	LOCAL xLog	  := 'recibo.log'
	LOCAL cString := Space(0)
	LOCAL nLen
	LOCAL nHandle
	LOCAL x

	Mensagem("Aguarde, Registrando Log Recibo.")
	if !ms_swap_file(xLog)
		nHandle := ms_swap_fcreate( xLog, FC_NORMAL )
		ms_swap_fclose( nHandle )
	endif
	
	nHandle := ms_swap_fopen( xLog, FO_READWRITE + FO_SHARED )
	nErro := FLocate( nHandle, aLog[ALOG_DATA]) // Data Sistema
	FBot( nHandle )
	
	if nErro < 0
		FWriteLine( nHandle, Repl("=", 186))
		FWriteLine( nHandle, "TIPO   CODI  NOME CLIENTE                             DOCTO N§  VENCTO   HORA     DATA_OS  USUARIO    CAIX       VALOR RECIBO HISTORICO")
		FWriteLine( nHandle, Repl("-", 186))
	endif
	
	nLen := Len(aLog)-3 //Ende, Cida

	for x := 1 To nLen
		cString += aLog[x] + ' '
	next

	FWriteLine( nHandle, cString )
	ms_swap_fclose(nHandle )
	
	if Recibo->(Incluiu())
		Recibo->Tipo	 := aLog[ALOG_TIPO]
		Recibo->Codi	 := aLog[ALOG_CODI]
		Recibo->Nome	 := aLog[ALOG_NOME]
		Recibo->Docnr	 := aLog[ALOG_DOCNR]
		Recibo->Vcto	 := Ctod(aLog[ALOG_VCTO])
		Recibo->Hora	 := aLog[ALOG_HORA]
		Recibo->Data	 := Ctod(aLog[ALOG_DATA])
		Recibo->Usuario := aLog[ALOG_USUARIO]
		Recibo->Caixa	 := aLog[ALOG_CAIXA]
		Recibo->Vlr 	 := StrToVal(aLog[ALOG_VLR])
		Recibo->Hist	 := aLog[ALOG_HIST]
		Recibo->Fatura  := aLog[ALOG_FATURA]
		Recibo->(Libera())
		return OK
	endif
	return false
endef

Function CalcJuros(dData, dVcto, nVlr)
***************************************
LOCAL nAtraso	  := 0
LOCAL nCarencia  := 0
LOCAL nTotJuros  := 0
LOCAL nVlrTotal  := 0
LOCAL nJuro      := oAmbiente:aSciArray[1,SCI_JUROMESCOMPOSTO]
LOCAL nDias      := 0
LOCAL nValorCm   := 0
LOCAL nCm        := 0
LOCAL aJuro      := 0
LOCAL nJuroDia   := 0
LOCAL nJuroTotal := 0
DEFAU dData     TO Date()
DEFAU dVcto     TO Recemov->Vcto
DEFAU nVlr      TO Recemov->Vlr

nAtraso	 := Atraso( dData, dVcto )
nCarencia := Carencia( dData, dVcto)
nVlrTotal := nVlr

if nCarencia > 0 // Atraso maior que a carencia
   
	/*
	nTotJuros := Recemov->Jurodia * nAtraso
	nVlrTotal += nTotJuros
	nMulta	 := VlrMulta( dData, dVcto, nVlrTotal )
	nVlrTotal += nMulta
	*/

   nDias       := (dData-dVcto)
   nValorCm    := CalculaCm(nVlr, dVcto, dData)
   nCm         := (nValorCm - nVlr)
   aJuro       := aAntComposto( nValorCm, nJuro, nDias, XJURODIARIO)
   nJuroDia    := aJuro[6]
   nJuroTotal  := aJuro[5]
   nJuroTotal  += nCm
   nJuroDia    := (nJuroTotal / nDias)
	
	nTotJuros   := nJuroTotal
	nVlrTotal   += nTotJuros
	nMulta	   := VlrMulta( dData, dVcto, nVlrTotal )
	nVlrTotal	+= nMulta
	
endif
Return( nVlrTotal )














Function ImprimirEtiqueta( aConfig, oBloco )
********************************************
LOCAL cScreen	  := SaveScreen()
LOCAL nCampos	  := 5
LOCAL nTamanho   := 35
LOCAL nMargem	  := 0
LOCAL nLinhas	  := 1
LOCAL nEspacos   := 1
LOCAL nCarreira  := 1
LOCAL nX 		  := 0
LOCAL aArray	  := {}
LOCAL aGets 	  := {}
LOCAL lComprimir := FALSO

if !InsTru80() .OR. !LptOk()
	ResTela( cScreen )
	Return
endif
nLen	  := Len( aConfig )
if nLen > 0
	nCampos	  := aConfig[1]
	nTamanho   := aConfig[2]
	nMargem	  := aConfig[3]
	nLinhas	  := aConfig[4]
	nEspacos   := aConfig[5]
	nCarreira  := aConfig[6]
	lComprimir := aConfig[7] == 1
	For nX := 8 To nLen
		Aadd( aGets, aConfig[nX] )
	Next
endif
aLinha := Array( aConfig[1] )
Afill( aLinha, "" )
PrintOn()
FPrint( _SALTOOFF )
if lComprimir
	FPrint( PQ )
endif
SetPrc( 0, 0 )
WHILE Eval( oBloco ).AND. !Rep_Ok()
	nCol := nMargem
	For nA := 1 To nCarreira
		For nB := 1 To nCampos
			cVar := aGets[nB]
			nTam := Len( &cVar. )
			aLinha[nB] += &cVar. + Space( ( nTamanho - nTam ) + nEspacos )
		Next
		DbSkip(1)
	Next
	For nC := 1 To nCampos
		Qout( aLinha[nC] )
		aLinha[nC] := ""
	Next
	For nD := 1 To nLinhas
		Qout()
	Next
EndDo
PrintOFF()
ResTela( cScreen )
Return

Proc ConfigurarEtiqueta()
*************************
LOCAL GetList	  := {}
LOCAL cScreen	  := SaveScreen()
LOCAL nCampos	  := 5
LOCAL nTamanho   := 35
LOCAL nMargem	  := 0
LOCAL nLinhas	  := 1
LOCAL nEspacos   := 1
LOCAL nCarreira  := 1
LOCAL nComprimir := 0
LOCAL nSpVert	  := 1
LOCAL nX 		  := 0
LOCAL aArray	  := {}
LOCAL aGets 	  := {}
LOCAL cArquivo   := 'ETIQUETA.ETI'
LOCAL oEtiqueta

Set Key F12 To
oMenu:Limpa()
MaBox( 05, 10, 07, 60 )
@ 06, 11 Say "Gravar no Arquivo.......:" Get cArquivo Pict "@!" Valid PickArquivo( @cArquivo, '*.ETI', OK)
Read
if LastKey() = ESC
	Set Key F12 To ConfigurarEtiqueta()
	ResTela( cScreen )
	Return
endif
oEtiqueta  := TIniNew( oAmbiente:xBaseDoc + '\' + cArquivo )
nCampos	  := oEtiqueta:ReadInteger('configuracao', 'Campos',    05 )
nTamanho   := oEtiqueta:ReadInteger('configuracao', 'Tamanho',   35 )
nMargem	  := oEtiqueta:ReadInteger('configuracao', 'Margem',    00 )
nLinhas	  := oEtiqueta:ReadInteger('configuracao', 'Linhas',    01 )
nEspacos   := oEtiqueta:ReadInteger('configuracao', 'Espacos',   01 )
nCarreira  := oEtiqueta:ReadInteger('configuracao', 'Carreira',  01 )
nComprimir := oEtiqueta:ReadInteger('configuracao', 'Comprimir', 00 )
nSpVert	  := oEtiqueta:ReadInteger('configuracao', 'Vertical',  01 )

MaBox( 08, 10, 17, 60 )
@ 09, 11 Say "Quantidade de Campos....:" Get nCampos    Pict "99"  Range 1, 16
@ 10, 11 Say "Tamanho da Etiqueta.....:" Get nTamanho   Pict "999" Range 1, 120
@ 11, 11 Say "Margem Esquerda.........:" Get nMargem    Pict "999" Range 0, 250
@ 12, 11 Say "Linhas Entre Etiquetas..:" Get nLinhas    Pict "99"  Range 0, 16
@ 13, 11 Say "Espaco Entre Etiquetas..:" Get nEspacos   Pict "999" Range 0, 120
@ 14, 11 Say "Quantidade de Carreiras.:" Get nCarreira  Pict "999" Range 1, 8
@ 15, 11 Say "Comprimir Impressao.....:" Get nComprimir Pict "9"   Valid PickTam({'Nao','Sim'}, {0,1}, @nComprimir )
@ 16, 11 Say "Espacamento Vertical....:" Get nSpVert    Pict "9"   Valid PickTam({'1/6"','1/8"'}, {0,1}, @nSpVert )
Read
if LastKey() = ESC
	Set Key F12 To ConfigurarEtiqueta()
	ResTela( cScreen )
	Return
endif
For nX := 1 To nCampos
	cCampo := oEtiqueta:ReadString('campos', 'campo' + StrZero( nX, 3), Space(60))
	cCampo += Space(60-Len(cCampo))
	Aadd( aGets, cCampo )
Next
oMenu:Limpa()
MaBox( 01, 01, 02+nCampos, 76, "DEFINICAO DOS CAMPOS DA ETIQUETA" )
For nX := 1 To nCampos
	cLinha := "Linha " + StrZero( nX, 2 ) + "...: "
	@ 01+nX, 02 Say cLinha Get aGets[nX] Pict "@!"
Next
Read
if LastKey() = ESC
	Set Key F12 To ConfigurarEtiqueta()
	ResTela( cScreen )
	Return
endif
oEtiqueta:Close()
oEtiqueta  := TIniNew( oAmbiente:xBaseDoc + '\' + cArquivo )
oEtiqueta:WriteString('configuracao', 'Campos',    StrZero( nCampos,    2))
oEtiqueta:WriteString('configuracao', 'Tamanho',   StrZero( nTamanho,   3))
oEtiqueta:WriteString('configuracao', 'Margem',    StrZero( nMargem,    3))
oEtiqueta:WriteString('configuracao', 'Linhas',    StrZero( nLinhas,    2))
oEtiqueta:WriteString('configuracao', 'Espacos',   StrZero( nEspacos,   3))
oEtiqueta:WriteString('configuracao', 'Carreira',  StrZero( nCarreira,  2))
oEtiqueta:WriteString('configuracao', 'Comprimir', StrZero( nComprimir, 1))
oEtiqueta:WriteString('configuracao', 'Vertical',  StrZero( nSpVert,    1))
For nX := 1 To nCampos
	oEtiqueta:WriteString('campos',    'campo' + StrZero( nX, 3), AllTrim( aGets[nX]))
Next
Set Key F12 To ConfigurarEtiqueta()
ResTela( cScreen )
Return

Proc Bordero()
**************
LOCAL Getlist := {}
LOCAL cScreen := SaveScreen()
LOCAL aArray  := {}
LOCAL cDocnr  := Space(09)
LOCAL nTam	  := 0
LOCAL nVlr	  := 0
LOCAL nTitulo := 0

oMenu:Limpa()
WHILE OK
	cDocnr := Space(09)
	MaBox( 10, 05, 16, 79 )
	@ 11, 06 Say "Documento N§.: " Get cDocnr Pict "@!" Valid DocErrado( @cDocnr )
	@ 12, 06 Say "Cliente......: "
	@ 13, 06 Say "Emissao......: "
	@ 14, 06 Say "Vcto.........: "
	@ 15, 06 Say "Valor........: "
	Read
	if LastKey() = ESC
		ResTela( cScreen )
		Exit
	endif
	Recemov->(Order( RECEMOV_DOCNR ))
	Receber->(Order( RECEBER_CODI ))
	if Recemov->(DbSeek( cDocnr ))
		cCodi := Recemov->Codi
		Receber->(DbSeek( cCodi ))
		Write( 12, 22, Receber->Nome )
		Write( 13, 22, Recemov->Emis )
		Write( 14, 22, Recemov->Vcto )
		Write( 15, 22, Recemov->(Tran( Vlr, "@E 999,999,999.99")))
		if Conf("Pergunta: Selecionar para impressao ?")
			Aadd( aArray, cDocnr )
			nVlr	 += Recemov->Vlr
			nTitulo++
		endif
	endif
	if nTitulo >= 14
		Exit
	endif
EndDo
nTam := Len( aArray )
if nTam > 0
	oMenu:Limpa()
	ErrorBeep()
	if !Conf("Pergunta: Deseja Imprimir os Registros ?")
		ResTela( cScreen )
		Return
	endif
	cPrefixo  := Space(07)
	cCodigo	 := Space(10)
	cCedente  := Space(15)
	cCarteira := Space(03)
	cVar		 := Space(04)
	cBordero  := Space(15)
	cPrefix	 := Space(05)
	cEspecie  := Space(03)
	cInstru	 := Space(05)
	dData 	 := Date()
	cResponsa := Space(10)
	cIof		 := Space(03)
	cConta	 := Space(15)
	cRazao	 := Space(20)
	MaBox( 05, 10, 20, 60, "INFORMACOES COMPLEMENTARES")
	@ 06, 11 Say "Prefixo Usuario...:" Get cPrefixo  Pict "@!"
	@ 07, 11 Say "Codigo Usuario....:" Get cCodigo   Pict "@!"
	@ 08, 11 Say "Codigo Cedente....:" Get cCedente  Pict "@!"
	@ 09, 11 Say "Carteira..........:" Get cCarteira Pict "@!"
	@ 10, 11 Say "Var...............:" Get cVar      Pict "@!"
	@ 11, 11 Say "N§ Bordero........:" Get cBordero  Pict "@!"
	@ 12, 11 Say "Prefixo...........:" Get cPrefix   Pict "@!"
	@ 13, 11 Say "Especie...........:" Get cEspecie  Pict "@!"
	@ 14, 11 Say "Instrucoes Codif..:" Get cInstru   Pict "@!"
	@ 15, 11 Say "Data Valorizacao..:" Get dData     Pict "##/##/##"
	@ 16, 11 Say "Codigo Responsab..:" Get cResponsa Pict "@!"
	@ 17, 11 Say "Iof...............:" Get cIof      Pict "@!"
	@ 18, 11 Say "Conta Emitente....:" Get cConta    Pict "@!"
	@ 19, 11 Say "Razao Deposito....:" Get cRazao    Pict "@!"
	Read
	if LastKey() = ESC
		ResTela( cScreen )
		Return
	endif
	if Instru80() .AND. LptOk()
		PrintOn()
		FPrint( PQ )
		Write( 05, 006, AllTrim(oAmbiente:xNomefir) )
		Write( 05, 110, XCGCFIR )
		Write( 07, 006, XENDEFIR )
		Write( 07, 090, XCCEP )
		Write( 07, 110, XCCIDA )

		Write( 09, 020, cPrefixo )
		Write( 09, 033, cCodigo )
		Write( 09, 049, cCedente )
		Write( 09, 074, cCarteira )
		Write( 09, 082, cVar )
		Write( 09, 091, cBordero )
		Write( 09, 118, cPrefix )
		Write( 09, 130, cEspecie )
		Write( 11, 010, Tran( nVlr, "@E 999,999,999.99"))
		Write( 11, 060, cInstru )
		Write( 11, 070, dData )
		Write( 11, 117, cResponsa )
		Write( 13, 004, cIof )
		Write( 13, 034, cConta )
		Write( 13, 060, cRazao )

		nCol	:= 19
		nSoma := 0
		cDia	:= StrZero( Day( Date()),2)
		cMes	:= Mes( Date())
		cAno	:= StrZero(Year( Date()),4)
		For nX := 1 To nTam
		  if Recemov->(DbSeek( aArray[ nX ]))
				nSoma++
				if nSoma = 1
					Write( nCol, 06, Recemov->Docnr )
					Write( nCol, 34, Recemov->Vlr )
					Write( nCol, 57, Recemov->Vcto )
				Else
					Write( nCol, 075, Recemov->Docnr )
					Write( nCol, 103, Recemov->Vlr )
					Write( nCol, 125, Recemov->Vcto )
					nSoma := 0
					nCol++
				endif
			endif
		Next
		Write( 27, 003, XCCIDA )
		Write( 27, 034, cDia )
		Write( 27, 042, cMes )
		Write( 27, 063, cAno )
		Write( 27, 102, Tran( nVlr, "@E 999,999,999.99"))
		Write( 27, 122, nTam )
		__Eject()
		PrintOff()
	endif
endif
ResTela( cScreen )
Return

Function CepCerto( cCep, lModificar, cSwap )
********************************************
FIELD Cep, Cida, Bair

if LastKey() = UP
	Return( OK )
endif

if lModificar != NIL .AND. lModificar
	if cCep == cSwap
		Return( OK )
	endif
endif

if Empty( cCep )
	ErrorBeep()
	Alerta("Erro: Entrada de Cep Invalido.")
	Return( FALSO )
endif
Cep->(Order( CEP_CEP ))
if Cep->(DbSeek( cCep ))
	ErrorBeep()
	Alerta("Erro: Cep Ja Registrado. " + Cep->( AllTrim( Cida)))
	Return( FALSO )
endif
Return( OK )

Function CepErrado( cCep, cCida, cEsta, cBair )
***********************************************
LOCAL aRotina			  := {{|| CepInclusao()}}
LOCAL aRotinaAlteracao := {{|| CepInclusao( OK )}}
LOCAL Ind_Ant			  := IndexOrd()
LOCAL Arq_Ant			  := Alias()

Area("Cep")
Cep->(Order( CEP_CEP ))
if (Lastrec() = 0 )
	ErrorBeep()
	if Conf(" Pergunta: Nenhum Cep Disponivel. Registrar ?")
		CepInclusao()
	endif
	AreaAnt( Arq_Ant, Ind_Ant )
	Return( FALSO )
endif
if Cep->(!DbSeek( cCep ))
	Cep->(Order( CEP_CIDA ))
	Cep->(Escolhe( 03, 01, 22, "Cep + 'Ý' + Cida + 'Ý' + Esta + 'Ý' + Bair ", "CEP        CIDADE                      UF BAIRRO", aRotina,, aRotinaAlteracao ))
endif
cCep	:= Cep->Cep
cCida := Cep->Cida
cEsta := Cep->Esta
if Empty( cBair )
	cBair := Cep->Bair
endif
AreaAnt( Arq_Ant, Ind_Ant )
Return( OK )

Proc CepPrint()
***************
LOCAL cScreen	  := SaveScreen()
LOCAL aMenuArray := { " Video ", " Impressora " }
LOCAL nChoice := 0

M_Title("CONSULTA/IMPRESSAO DE CEP")
nChoice := FazMenu( 10,10, aMenuArray, Cor())
Do Case
	Case nChoice = 0
		ResTela( cScreen )
		Return

	Case nChoice = 1
		CepVideo()

	Case nChoice = 2
		CepImpressora()

EndCase

Proc CepVideo()
***************
LOCAL cScreen := SaveScreen()
LOCAL aCep	  := {}
LOCAL cTela

Area("Cep")
Cep->(Order( CEP_CEP ))
Cep->(DbGoTop())
cTela := Mensagem("Aguarde ... ", Cor())

WHILE !Eof() .AND. Rep_Ok()
	 Aadd( aCep,  Cep->Cep + " " + Cep->Cida + " " + Cep->Esta + " " + Cep->Bair )
	 Cep->(DbSkip(1))
EndDo

if Len( aCep ) != ZERO
	ResTela( cTela )
	cString := " CEP       CIDADE                    UF BAIRRO"
	Print( 00, 00, cString + Space( 80 - Len(  cString )), Roloc(Cor()))
	M_Title( "ESC Retorna ")
	FazMenu( 01, 00, aCep, Cor())
endif

ResTela( cScreen )
Return

Proc CepImpressora()
********************
LOCAL cScreen := SaveScreen()
LOCAL Tam	  := 80
LOCAL Col	  := 58
LOCAL Pagina  := 0
LOCAL lSair   := FALSO

if !InsTru80() .OR. !LptOk()
	ResTela( cScreen )
	Return
endif

Area("Cep")
Cep->(Order( CEP_CEP ))
Cep->(DbGoTop())
Mensagem("Aguarde. Imprimindo.", Cor())
PrintOn()
SetPrc( 0, 0 )
WHILE Cep->(!Eof()) .AND. Rel_Ok()

  if Col >= 58
	  Write( 00, 00, Linha1( Tam, @Pagina))
	  Write( 01, 00, Linha2())
	  Write( 02, 00, Linha3(Tam))
	  Write( 03, 00, Linha4(Tam, SISTEM_NA2 ))
	  Write( 04, 00, Padc( "LISTAGEM DE CEPS",Tam ) )
	  Write( 05, 00, Linha5(Tam))
	  Write( 06, 00, "CEP       CIDADE                    UF BAIRRO")
	  Write( 07, 00, Linha5(Tam))
	  Col := 8
  endif

  Qout( Cep, Cida, Esta, Bair )
  Col := Col + 1
  
  if Col >= 58
	  Write( Col, 0,	Repl( SEP, Tam ))
	  __Eject()
  endif

  Cep->(DbSkip(1))
EndDo
__Eject()
PrintOff()
ResTela( cScreen )
Return

#IFDEF SWAP
	Proc Edicao( lEditarArquivoDeConfiguracao, cTipoDeArquivo )
	***********************************************************
	LOCAL cScreen	  := SaveScreen()
	LOCAL aMenuArray := {" Sci ", " Ed ", " Edit (DOS) ", " Notepad (Windows) "}
	LOCAL Files 	  := '*.DOC'
	LOCAL cFiles	  := IF( cTipoDeArquivo != NIL, cTipoDeArquivo, "" )
	LOCAL GetList	  := {}
	LOCAL nChoice	  := 1
	LOCAL cEditor
	PRIVA Arquivo

	FChdir( oAmbiente:xBaseDoc )
	Set Defa To ( oAmbiente:xBaseDoc )
	if lEditarArquivoDeConfiguracao = NIL
		M_Title("EDITOR DE TEXTO")
		nChoice := FazMenu( 03, 05, aMenuArray, Cor())
		if nChoice = 0
			FChdir( oAmbiente:xBaseDados )
			Set Defa To ( oAmbiente:xBaseDados )
			ResTela( cScreen )
			Return
		endif
		ResTela( cScreen )
		Arquivo := "CARTA.DOC" + Space(03)
		MaBox( 16, 10, 18, 61 )
		@ 17, 11 Say "Arquivo a Editar....:" Get Arquivo PICT "@!"
		Read
		if LastKey() = ESC
			FChdir( oAmbiente:xBaseDados )
			Set Defa To ( oAmbiente:xBaseDados )
			ResTela( cScreen )
			Return
		endif
		if Empty( Arquivo )
			M_Title( "Setas CIMA/BAIXO Move")
			Arquivo := Mx_PopFile( 03, 10, 15, 61, Files, Cor())
			if Empty( Arquivo )
				FChdir( oAmbiente:xBaseDados )
				Set Defa To ( oAmbiente:xBaseDados )
				ErrorBeep()
				ResTela( cScreen )
				Return
			endif
		Else
			if nChoice != 4
				if !File( Arquivo )
					ErrorBeep()
					ResTela( cScreen )
					if !Conf( Rtrim( Arquivo ) + " Nao Encontrado. Posso Cria-lo ? ")
						FChdir( oAmbiente:xBaseDados )
						Set Defa To ( oAmbiente:xBaseDados )
						ResTela( cScreen )
						Return
					endif
				endif
			endif
		endif
	Else
		oMenu:Limpa()
		M_Title("ESCOLHA O ARQUIVO DE CONFIGURACAO A ALTERAR" )
		Arquivo := Mx_PopFile( 05, 10, 20, 74, cFiles, Cor() )
	endif
	if nChoice = 1
		Set Key F10 To
		Set Key F2	To
		Set Key F1	To
		SetColor("GR+/N")
		@ 01, 00 TO 24-1, MaxCol()
		SetColor("W/W")
		StatusSup("³F1=HELP³CTRL+P=IMPRIMIR³ESC=SAIR³F2=GRAVA E SAI³F3=LIG ACENTO³F4=DES ACENTO", Cor(2))
		StatusInf( RTrim( Arquivo),"")
		SetColor("B/W")
		SetCursor(1)
		//Liga_Acento()
		MemoWrit( Arquivo, MemoEdit( MemoRead( Arquivo ), 02, 01, 24-2, (MaxCol()-2), .T., "Linha", 132))
		Set Key F10 To Calc()
		oAmbiente:Acento := FALSO
		ResTela( cScreen )
		Desliga_Acento()
		Set Key F1 To Help()
		FChdir( oAmbiente:xBaseDados )
		Set Defa To ( oAmbiente:xBaseDados )
		Return
	Elseif nChoice = 2
		cEditor := "Ed"
	Elseif nChoice = 3
		cEditor := "Edit"
	Elseif nChoice = 4
		cEditor := "Notepad"
	endif
	i = SWPUSEEMS(OK)
	i = SWPUSEXMS(OK)
	i = SWPUSEUMB(OK)
	i = SWPCURDIR(OK)
	i = SWPVIDMDE(OK)
	i = SWPRUNCMD( ( cEditor + " " + Arquivo ), 0, "", "")
	ResTela( cScreen )
	FChdir( oAmbiente:xBaseDados )
	Set Defa To ( oAmbiente:xBaseDados )
	Return

	Proc Comandos()
	***************
	LOCAL GetList	:= {}
	LOCAL cScreen	:= SaveScreen()
	LOCAL cComando := Space(256)
   
	while true
		oMenu:Limpa()
		cComando := Space(100)
		MaBox( 20, 10, 22, 122 )
		@ 21, 11 Say "Comando :" Get cComando Valid !Empty( cComando )
		Read
		if LastKey() = ESC
			ResTela( cScreen )
			Exit
		endif
		SetColor("")
		Cls
		//DosBlinker(cComando)
		DosShell(Alltrim(cComando))
	enddo
	ResTela( cScreen )
	VerDataDos()
	Return
	
	def DosBlinker(cComando)
		i = SWPUSEEMS(OK)
		i = SWPUSEXMS(OK)
		i = SWPUSEUMB(OK)
		i = SWPCURDIR(OK)
		i = SWPVIDMDE(OK)
		i = SWPDISMSG(OK)
		i = SWPRUNCMD( cComando, 0, "", "")
		Return NIL
	endef
   
	Function Linha( Mode, Line, Col )
	*********************************
	LOCAL nCopias	  := 1
	LOCAL cScreen	  := SaveScreen()
	LOCAL lCancel	  := FALSO
	LOCAL cOldColor  := SetColor()
	LOCAL Tela1

	DO Case
	Case Mode = 0
		StatusInf( Rtrim( Arquivo), StrZero( Line, 4) + ":" + StrZero( Col, 4 ))
		Return( 0 )

	Case LastKey() =	-1 	  // F2	GRAVA E SAI
		Return( 23 )

	Case LastKey() =	F3
		Liga_Acento()
		Return(1)

	Case LastKey() =	F4
		Desliga_Acento()
		Return(1)

	Case LastKey() =	27 	  // ESC ?
		if Conf(" Deseja Gravar o Texto ? " )
			Return( 23 )

		endif

	Case LastKey() =	F1
		MaBox( 10, 10, 17, 50, "COMANDOS DE EDICAO")
		Write( 11, 11, "CTRL+Y = Limpar Linha Corrente")
		Write( 12, 11, "CTRL+T = Eliminar Palavra a Direita")
		Write( 13, 11, "DELETE = Eliminar Caractere")
		Write( 14, 11, "INSERT = Liga/Desliga Insercao")
		Write( 15, 11, "HOME   = Vai para Inicio da Linha")
		Write( 16, 11, "END    = Vai para Final da Linha")
		Inkey(0)
		ResTela( cScreen )
		Return( 1 )

	Case LastKey() =	K_CTRL_P
		nCopias := 1
		MaBox( 13, 10, 15, 31 )
		@ 14,11 SAY "Qtde Copias...:" Get nCopias PICT "999" Valid nCopias > 0
		Read
		if LastKey() = ESC .OR. !Instru80()
			SetColor( cOldColor )
			ResTela( cScreen )
			Return
		endif
		Mensagem("Aguarde, Imprimindo.", Cor())
		PrintOn()
		SetPrc( 0, 0 )
		For X := 1 To nCopias
			 Campo	  := MemoRead( Arquivo )
			 Linhas	  := MlCount( Campo, 80 )
			 For Linha := 1 To Linhas
				 Imprime := MemoLine( Campo, 80, linha )
				 Write( 0 + Linha -1, 0, Imprime )
			 Next
			 __Eject()
		Next
		PrintOff()
		SetColor( cOldColor )
		ResTela( cScreen )
		Return

	OtherWise
		Return(0)

	EndCase

	Proc Dos()
	***********
	LOCAL cScreen	 := SaveScreen()
	LOCAL cOldColor := SetColor()
	LOCAL cOldDir	 := Curdir()
	LOCAL nChoice
   
	SetColor("")
	Cls
	nChoice := Alerta("Para retornar ao Microbras SCI digite EXIT")
	if nChoice = 0
		ResTela( cScreen )
		SetColor( cOldColor )
		Return
	endif
	?
	?
	?
	i = SWPUSEEMS(OK)
	i = SWPUSEXMS(OK)
	i = SWPUSEUMB(OK)
	i = SWPCURDIR(OK)
	FChDir( oAmbiente:xBase )
	i = SWPVIDMDE(OK)
	i = SWPRUNCMD( "", 0, "", "")
	FChDir( cOldDir )
	ResTela( cScreen )
	SetColor( cOldColor )
	VerDataDos()
	Return

	Proc MacroRestore()
	******************
	LOCAL GetList	:= {}
	LOCAL aDrive	:= { "A:","B:","C:","D:","E:","F:","G:","H:","I:","J:"}
	LOCAL aArray1	:= { "Todos os Arquivos","Especificar Arquivo" }
	LOCAL aZip		:= { "A:\SCI.ZIP", "B:\SCI.ZIP", "C:\SCIBACKU\","D:\SCIBACKU\","E:\SCIBACKU\","F:\SCIBACKU\"}
	LOCAL cScreen	:= SaveScreen()
	LOCAL cComando := Space(256)
	LOCAL cOldDir	:= Curdir()
	LOCAL nChoice	:= 0
	LOCAL nChoice1 := 0
	LOCAL cFiles	:= "*.ZIP"
	LOCAL cStr1 	:= ""
	LOCAL cStr2 	:= ""

	if !PodeFazerRestauracao()
		Return
	endif

	WHILE OK
		M_Title("COPIA DE SEGURANCA - RESTAURACAO")
		nChoice := FazMenu( 08, 10, aDrive, Cor())
		if nChoice = 0
			ResTela( cScreen )
			Exit
		endif
		oMenu:Limpa()
		i = SWPUSEEMS(OK)
		i = SWPUSEXMS(OK)
		i = SWPUSEUMB(OK)
		i = SWPCURDIR(OK)
		i = SWPVIDMDE(OK)
		i = SWPDISMSG(OK)
		ErrorBeep()
		cStr1 := "Atencao Insira o disco de dados no " + aDrive[nChoice]
		if nChoice = 1
			cStr2 := "Dcomprim -d -o " + aZip[nChoice]
		Elseif nChoice = 2
			cStr2 := "Dcomprim -d -o " + aZip[nChoice]
		Elseif nChoice >= 3
			cFiles := aDrive[nChoice] + "\SCIBACKU\*.ZIP"
			if !File( cFiles )
			  oMenu:Limpa()
			  ErrorBeep()
			  Alert("Erro: Arquivos de Backup nao disponiveis.")
			  ResTela( cScreen )
			  Exit
			endif
			oMenu:Limpa()
			M_Title("ESCOLHA O ARQUIVO PARA RESTAURACAO")
			xArquivo := Mx_PopFile( 05, 10, 20, 74, cFiles, Cor() )
			if Empty( xArquivo )
				ErrorBeep()
				ResTela( cScreen )
				Exit
			endif
			cStr2 := "Dcomprim -d -o " + xArquivo
		endif
		M_Title("COPIA DE SEGURANCA - OPCOES")
		nChoice1 := FazMenu( 12, 12, aArray1, Cor())
		if nChoice1 = 0
			ResTela( cScreen )
			Exit
		endif
		if nChoice1 = 1
			if Alert( cStr1, { " Cancelar ", " Continuar " }) = 2
				SetColor("")
				Cls
				FChDir( oAmbiente:xBase )
				i := SWPRUNCMD( cStr2, 0, "", "" )
				FChDir( cOldDir )
			endif
		Else
			cEspFile := Space( 40 )
			MaBox( 20, 12, 22, 75 )
			@ 21, 13 Say "Arquivos :" Get cEspFile Pict "@!" Valid !Empty( cEspFile )
			Read
			if LastKey() = ESC
				ResTela( cScreen )
				Return
			endif
			if Alert( cStr1, { " Cancelar ", " Continuar " }) = 2
				 SetColor("")
				 Cls
				 FChDir( oAmbiente:xBase )
				 i := SWPRUNCMD( cStr2 + ' ' + ( cEspFile ), 0, "", "" )
				 FChDir( cOldDir )
			 endif
		endif
		ResTela( cScreen )
	EndDo
	Return

	Proc MacroBackup()
	******************
	LOCAL GetList	:= {}
	LOCAL aArray	:= { "A:","B:","C:","D:","E:","F:","G:","H:","I:","J:"}
	LOCAL cScreen	:= SaveScreen()
	LOCAL cComando := Space(256)
	LOCAL cOldDir	:= Curdir()
	LOCAL cData 	:= ' -S' + StrTran(Dtoc(Date()),'/') + ' '
	LOCAL cPath
	LOCAL xDiretorio
	LOCAL xString
	LOCAL xDrive

	if !PodeFazerBackup()
		Return
	endif
	WHILE OK
		M_Title("COPIA DE SEGURANCA - BACKUP")
		nChoice := FazMenu( 05, 10, aArray, Cor())
		if nChoice = 0
			ResTela( cScreen )
			Exit
		endif
		oMenu:Limpa()
		i = SWPUSEXMS(OK)
		i = SWPUSEUMB(OK)
		i = SWPCURDIR(OK)
		i = SWPVIDMDE(OK)
		i = SWPDISMSG(OK)
		ErrorBeep()
		xDrive := aArray[nChoice]
		if nChoice = 1 .OR. nChoice = 2	// A: B:
			if Alert("Atencao Todos o dados do Drive " + xDrive + " serao apagados.", { " Cancelar ", " Continuar " }) = 2
				SetColor("")
				Cls
				FChDir( oAmbiente:xBase )
// 			xString := "COMPRIME -EX -RP -&F " + xDrive + cData + "\SCI *.DBF + *.CFG + *.DOC + *.TXT + *.PRO + *.LIS + *.BAT + *.ETI + *.NFF + *.COB + *.DUP *.LIS *.DIV *.LOG"
				xString := 'COMPRIME -EX -RP ' + cData + ' -&F ' + xDrive + "\SCI *.DBF + *.CFG + *.DOC + *.TXT + *.PRO + *.LIS + *.BAT + *.LOG + *.ETI + *.NFF + *.COB + *.DUP + *.DIV"
				i		  := SWPRUNCMD( xString, 0, "", "" )
				FChDir( cOldDir )
			endif
		Elseif nChoice > 2
			xDiretorio := xDrive + "\SCIBACKU"
			cDiaMes	  := Left( StrTran( Dtoc( Date()), "/"), 4 )
			cDia		  := xDiretorio + "\SCI" + cDiaMes
			MkDir( xDiretorio )
			if Conf("Proceder com a copia de Seguranca para " + xDrive + " ?")
				SetColor("")
				Cls
				FChDir( oAmbiente:xBase )
				xString := "COMPRIME -EX -RP" + cData + cDia + " *.DBF + *.CFG + *.DOC + *.TXT + *.PRO + *.LIS + *.BAT + *.LOG + *.ETI + *.NFF + *.COB + *.DUP + *.DIV"
				i		  := SWPRUNCMD( xString, 0, "", "" )
				FChDir( cOldDir )
			endif
		endif
		ResTela( cScreen )
	EndDo
	Return
#ELSE
	Proc Edicao
	Proc Dos
	Proc Comandos
	Proc MacroRestore
	Proc MacroBackup
#endif

Proc AtivaRegNew( lAtivaRegNew )
********************************
if lAtivaRegNew
	lAtivaRegNew := FALSO
	Alert("Busca Proximo Registro DESATIVADA.")
	Return
endif
lAtivaRegNew := OK
Alert("Busca Proximo Registro ATIVADA.")
Return

def Tbdemo( Dbf, Index )
************************
   LOCAL cScreen	:= SaveScreen()
   LOCAL Files 	:= '*.dbf'   
   LOCAL cArquivo
   LOCAL oBrowse

   while( true )
      FChdir( oAmbiente:xBaseDados )
      Set Defa To ( oAmbiente:xBaseDados )
      oMenu:Limpa()
      M_Title( "Setas CIMA/BAIXO Move")
      cArquivo := Mx_PopFile( 02, 10, MaxRow()-2, 57, files, Cor())
      if Empty( cArquivo )
         Beep(1)
         return(resTela( cScreen))
      endif
      xArquivo := cArquivo
      cArquivo := StrTran( cArquivo, '.dbf', '')
      cArquivo := StrTran( cArquivo, oAmbiente:xBaseDados + _SLASH_, '')
      
      if !UsaArquivo( cArquivo )
         MensFecha()
         Loop
      endif
      
      oBrowse	:= MsBrowse():New()
      nLen		:= FCount()
      
      for i := nLen To 1 Step -1
         oColuna := TBColumnNew( field( i ), FieldWBlock( field( i ), select() ) )
         oBrowse:InsColumn( oBrowse:ColPos, oColuna )
      next
      
      oBrowse:Titulo   := "CONSULTA/ALTERACAO/EXCLUSAO [" + xArquivo + "]"
      oBrowse:PreDoGet := NIL
      oBrowse:PosDoGet := NIL
      oBrowse:Show()
      oBrowse:Processa()
   EndDo
   ResTela( cScreen )
   Mensagem("Aguarde...", Cor())
   FechaTudo()
   return nil
endef   

Func VerDataDos()
*****************
LOCAL cLimite
LOCAL cDataDos

CenturyOn()
cLimite	:= oAmbiente:xDataCodigo
cDataDos := Dtoc( Date())
if Ctod( cDataDos ) > Ctod( cLimite )
	Hard( 1, ProcName(), ProcLine() )
	SetColor("")
	Cls
	Quit
endif
CenturyOff()
Return

function ProBranco( cCodi_Cli, aReg )
*************************************
LOCAL GetList		 := {}
LOCAL cScreen		 := SaveScreen()
LOCAL nMoeda		 := 1
LOCAL _QtDup		 := 0
LOCAL nLargura     := 132
LOCAL nAltura  	 := oIni:ReadInteger('relatorios','tampromissoria', 33 )
LOCAL cNomeEmpresa := oIni:ReadString('sistema','nomeempresa', AllTrim(oAmbiente:xNomefir) )
LOCAL cFantasia	 := oIni:ReadString('sistema','fantasia', XFANTA )
LOCAL cCgcEmpresa  := oIni:ReadString('sistema','cgcempresa', XCGCFIR )
LOCAL cNomeSocio	 := oIni:ReadString('sistema','nomesocio', XNOMESOCIO )
LOCAL cCpfSocio	 := oIni:ReadString('sistema','cpfsocio', XCPFSOCIO )
LOCAL cStr1
LOCAL cStr2
LOCAL nConta
LOCAL Col
LOCAL Var1
LOCAL var2
LOCAL i
LOCAL Larg
LOCAL nLinhas
LOCAL cDia
LOCAL cMes
LOCAL cAno
LOCAL Vlr_Dup

#IFDEF GRUPO_MICROBRAS
	cStr1 := cNomeSocio
	cStr2 := cCpfSocio
#ELSE
	cStr1 := cNomeEmpresa
	cStr2 := cCgcEmpresa
#endif

WHILE OK
	if PCount() = 0
		cCodi_Cli := Space(05)
		aReg		 := {}
		aReg		 := EscolheTitulo( cCodi_Cli )
	endif
	if ( _QtDup := Len( aReg )) = 0 
	   return(Restela( cScreen)) 
	endif	
	if !Instru80()
		Loop
	endif
	Mensagem("Aguarde, Imprimindo Promissorias. ESC Cancela.", WARNING )
	PrintOn()
	Fprint( RESETA )
	FPrInt( Chr(ESC) + "C" + Chr(nAltura))		
   FPrint( PQ )
   //FPrint( NG )
	SetPrc( 0, 0 )
	nConta := 0
	Col	 := 0
	Receber->(Order( RECEBER_CODI ))
	Recemov->(Order( RECEMOV_CODI ))
	Area("Recemov")
	Set Rela To Recemov->Codi Into Receber
	Recemov->(Order( RECEMOV_CODI ))
	FOR i :=  1 TO _qtdup
		DbGoto( aReg[i] )
		if Receber->Cgc = "  .   .   /    -  " .OR. Receber->Cgc = Space( 18 )
			Var1 := Receber->Cpf
			Var2 := Receber->Rg
		Else
			Var1 := Receber->Cgc
			Var2 := Receber->Insc
		endif
		Larg	  := 125-41
		nLinhas := 2
		cMes	  := Mes( Date())
		cDia	  := Left( Dtoc( Date()),2)
		cAno	  := Right( Dtoc( Date()),1)
		Vlr_Dup := Extenso( Recemov->Vlr, nMoeda, nLinhas, Larg )
		Write( Col,   000, PQ + Repl("=", nLargura))
		Write( Col+1, 000, PQ + "N§ " + Recemov->Docnr)
		Write( Col+1, 113, PQ + "VENCIMENTO: " + Dtoc(Recemov->Vcto) )
		Write( Col+2, 112, PQ + "VALOR R$  : " + AllTrim( Tran( Recemov->Vlr, "@E 9,999,999,999.99")))
		Write( Col+3, 000, "No " + PQ + DataExtenso( Recemov->Vcto ) + "." + C18 )
		Write( Col+4, 000, "pagarei por unica via de " + GD + "NOTA PROMISSORIA")
		Write( Col+6, 000, "a " + PQ + cStr1 + C18)
		Write( Col+6, 070, "CNPJ/CPF " + PQ + cStr2 + C18 )
		Write( Col+8, 000, "ou a sua ordem a quantia de " + PQ + Left( Vlr_Dup, Larg) + C18 )
		Write( Col+9, 000, PQ + Right( Vlr_Dup, Larg-4) + " em moeda corrente deste pais.")
		Write( Col+11, 000, "Pagavel em: " + PQ + XCCIDA + '/' + XCESTA + C18 )
		Write( Col+12, 000, "Emitente  : " + PQ + Receber->Nome + " " + Receber->Codi + Space(14) + XCCIDA + '/' + XCESTA + ", " + DataExt1( Date()) + C18 )
		Write( Col+13, 000, "Cnpj/Cpf  : " + PQ + Var1 + C18 )
		Write( Col+14, 000, "Endereco  : " + PQ + Receber->Ende + " - " + Receber->(AllTrim(Cida) + "/" + Esta ) + C18 )		
		
		Write( Col+17, 000, PQ + Repl("_",50) + Space(22) + Repl("_",60) + C18 )
		Write( Col+18, 000, PQ + "AVALISTA : " + Receber->Conhecida + Space(21) + Receber->Nome + C18 )
		Write( Col+19, 000, PQ + "CPF      : " + Receber->CpfAval + C18 )
		Write( Col+20, 000, PQ + Repl("=", nLargura))
		nConta++
		__Eject()
		nConta := 0
		Col	 := 0
	Next
	PrintOff()
	Recemov->(DbClearRel())
	Recemov->(DbGoTop())
	if PCount() != 0
		ResTela( cScreen )
		Return
	endif
EndDo
ResTela( cScreen )
Return

Proc DupPersonalizado( cCodi_Cli, aReg )
****************************************
LOCAL GetList			:= {}
LOCAL cScreen			:= SaveScreen()
LOCAL nMoeda			:= 1
LOCAL aMenu 			:= { "Imprimir, Usando um Arquivo Existente", "Criar Arquivo de Configuracao ", "Alterar Arquivos de Duplicata", "Configurar arquivos padrao"}
LOCAL aNt				:= {}
LOCAL nChoice			:= 0
LOCAL lRetornoBeleza := FALSO
LOCAL nLen				:= 0
LOCAL _QtDup			:= 0
LOCAL nX 				:= 0
LOCAL cVar1 			:= ""
LOCAL cVar2 			:= ""
LOCAL cCepPagto		:= ""
LOCAL cCidaPagto		:= ""
LOCAL cEstaPagto		:= ""
LOCAL nLargura 		:= 0
LOCAL cExtenso 		:= ""
LOCAL aDados			:= {}
LOCAL aMoeda			:= {"R$ ", "US$ ", "URV " }
LOCAL cMoeda			:= aMoeda[1]
LOCAL nPag				:= 0
LOCAL lImprimir		:= FALSO
LOCAL i					:= 0
LOCAL Larg				:= 0
LOCAL Vlr_Dup			:= 0
LOCAL nA 				:= 0
LOCAL cMora 			:= ""
LOCAL xDuplicata		:= oIni:ReadString('impressao', 'dup', NIL )
LOCAL aDuplicata


WHILE OK
	if PCount() = 0
		cCodi_Cli := Space(05)
		aReg		 := {}
		aReg		 := EscolheTitulo( cCodi_Cli )
	endif
	if ( _QtDup := Len( aReg )) = 0
		ResTela( cScreen )
		Return
	endif
	if xDuplicata = NIL
		ErrorBeep()
		WHILE OK
			lImprimir := FALSO
			oMenu:Limpa()
			M_Title("IMPRESSAO DE DUPLICATAS")
			nChoice := FazMenu( 10, 10, aMenu, Cor())
			Do Case
			Case nChoice = 0
				Exit
			Case nChoice = 1
				ErrorBeep()
				aDuplicata := LerDuplicata(, @lRetornoBeleza )
				if !lRetornoBeleza
					Loop
				endif
				lImprimir := OK
				Exit
			Case nChoice = 2
				GravaDuplicata()
				Loop
			Case nChoice = 3
				Edicao( OK, "*.DUP" )
				Loop
			Case nChoice = 4
				ConfImpressao()
			EndCase
			lImprimir := OK
			Exit
		EndDo
		if !lImprimir
			aReg := {}
			Loop
		endif
	Else
		aDuplicata := LerDuplicata( xDuplicata, @lRetornoBeleza )
		if !lRetornoBeleza
			xDuplicata := NIL
			Loop
		endif
		lImprimir := OK
	endif
	if !InsTru80() .OR. !Rep_Ok()
		ResTela( cScreen )
		Exit
	endif
	cMoeda := aMoeda[IF( nMoeda = 0, 1, nMoeda )]
	Mensagem("Aguarde Imprimindo Duplicatas. ESC Cancela.", WARNING )
	PrintOn()
	#IFDEF CENTRALCALCADOS
		PrintOn()
		Fprint( _CPI12 )
		Fprint( _SPACO1_6 )
		FPrint("C$")
		SetPrc( 0, 0 )
	#ELSE
		FPrint( RESETA )
		anT						:= aDuplicata
		XIMPRIMIRCONDENSADO	:= 01
		XIMPRIMIR12CPI 		:= 02
		XIMPRIMIRNEGRITO		:= 03
		XESPACAMENTOVERTICAL := 04
		nPag						:= 05 			 // Tamanho Pagina
		XTAMANHOEXTENSO		:= 31
		if aNt[XIMPRIMIRCONDENSADO,1]  > 0 ; FPrint( PQ )			; endif
		if aNt[XIMPRIMIR12CPI,1]		 > 0 ; FPrint( _CPI12 ) 	; endif
		if aNt[XIMPRIMIRNEGRITO,1] 	 > 0 ; FPrint( NG )			; endif
		if aNt[XESPACAMENTOVERTICAL,1] = 0 ; FPrint( _SPACO1_6 ) ; endif
		if aNt[XESPACAMENTOVERTICAL,1] = 1 ; FPrint( _SPACO1_8 ) ; endif
		FPrInt( Chr( 27 ) + "C" + Chr( anT[nPag,01]))
		SetPrc( 0,0 )
	#endif
	Cep->(Order( CEP_CEP ))
	FOR i :=  1 TO _qtdup
		Recemov->(DbGoto( aReg[i] ))
		if Receber->Cgc = "  .   .   /    -  " .OR. Receber->Cgc = Space( 18 )
			cVar1 := Receber->Cpf
			cVar2 := Receber->Rg
		Else
			cVar1 := Receber->Cgc
			cVar2 := Receber->Insc
		endif
		#IFDEF CENTRALCALCADOS
			SubDuplicata( cVar1, cVar2, nMoeda )
			__Eject()
		#ELSE
			cCepPagto  := Receber->Praca
			cCidaPagto := Receber->Cida
			cEstaPagto := Receber->Esta
			if Cep->(DbSeek( cCepPagto ))
				cCidaPagto := Cep->Cida
				cEstaPagto := Cep->Esta
			endif
			Larg	  := IF( anT[XTAMANHOEXTENSO,01] >= 0, anT[XTAMANHOEXTENSO,01], 56 ) 		 // Largura da Duplicata
			Vlr_Dup := Extenso( Recemov->Vlr, nMoeda, 2, Larg )	  // Valor Por Extenso
			cMora   := cMoeda + AllTrim( Tran( Recemov->Jurodia,"@E 999,999.99"))
			aDados  := {}
			Aadd( aDados, AllTrim(oAmbiente:xNomefir) )
			Aadd( aDados, XENDEFIR )
			Aadd( aDados, XCGCFIR )
			Aadd( aDados, XINSCFIR )
			Aadd( aDados, Recemov->Emis )
			Aadd( aDados, Tran( Recemov->VlrFatu,"@E 999,999,999.99" ))
			Aadd( aDados, Recemov->Fatura )
			Aadd( aDados, Tran( Recemov->Vlr,"@E 999,999,999.99" ))
			Aadd( aDados, Recemov->Docnr )
			Aadd( aDados, Recemov->Vcto )
			Aadd( aDados, cMora )
			Aadd( aDados, Recemov->CodiVen )
			Aadd( aDados, Receber->Nome )
			Aadd( aDados, Receber->Codi )
			Aadd( aDados, Receber->Ende )
			Aadd( aDados, Receber->Bair )
			Aadd( aDados, Receber->Cida )
			Aadd( aDados, Receber->Cep )
			Aadd( aDados, Receber->Esta )
			Aadd( aDados, cCidaPagto )
			Aadd( aDados, Receber->Praca )
			Aadd( aDados, cEstaPagto )
			Aadd( aDados, cVar1 )
			Aadd( aDados, cVar2 )
			Aadd( aDados, Left( Vlr_Dup, Larg ))
			Aadd( aDados, Right( Vlr_Dup, Larg ))
			Aadd( aDados, Receber->Banco )
			nLen := (Len( anT )-2)
			For nA := 6 To nLen
				if nA = 30 // Valor Por Extenso
					IF( anT[nA, 01] >= 0, Write( anT[nA, 01],   anT[nA, 02], aDados[nA-5] ),)
					IF( anT[nA, 01] >= 0, Write( anT[nA, 01]+1, anT[nA, 02], aDados[nA-4] ),)
				Else
					IF( anT[nA, 01] >= 0, Write( anT[nA, 01], anT[nA, 02], aDados[nA-5] ),)
				endif
			Next
			IF( anT[32, 01] >= 0, Write( anT[32, 01], anT[32, 02], aDados[27]),)
			__Eject()
		#endif
	Next
	PrintOff()
	Recemov->(DbClearRel())
	Recemov->(DbGoTop())
	if PCount() != 0
		ResTela( cScreen )
		Return
	endif
EndDo

Proc SubDuplicata( cVar1, cVar2, nMoeda )
*****************************************
LOCAL nLargura  := 53
LOCAL nVlr_Dup  := Extenso( Recemov->Vlr, nMoeda, 3, nLargura )
LOCAL cDia		 := StrZero( Day( Recemov->Emis ), 2 )
LOCAL cMes		 := Mes( Recemov->Emis )
LOCAL cAno		 := StrZero( Year( Recemov->Emis ),4)

Write( 01, 96 , Recemov->Vcto )
Write( 03, 50 , cDia )
Write( 03, 56 , cMes )
Write( 03, 75 , Right( cAno, 1 ))
Write( 03, 85 , Left( Receber->Nome, 18))
Write( 04, 81 , Right( Receber->Nome, 22))
Write( 06, 85 , Tran( Recemov->Vlr,"@E 9,999,999,999.99" ))
Write( 07, 00 , Tran( Recemov->VlrFatu,"@E 999,999,999.99" ))
Write( 07, 19 , Recemov->Fatura )
Write( 07, 32 , Tran( Recemov->Vlr,"@E 9,999,999,999.99" ))
Write( 07, 52 , Recemov->Docnr )
Write( 07, 65 , Recemov->Vcto )
Write( 10, 27 , AllTrim( Tran( Recemov->Vcto - Recemov->Emis, "999")) + " DIAS * " + Recemov->Fatura )
Write( 11, 81 , Recemov->Docnr )
Write( 13, 23 , Receber->Nome + Space(07) + Receber->Codi )
Write( 14, 23 , Receber->Ende + Space(12) + Right( Receber->Fone, 8))
Write( 15, 23 , Receber->Cep + "/" + Receber->Cida + Space(11) + Receber->Esta )
Write( 16, 23 , Receber->Cep + "/" + Receber->Cida + Space(11) + Receber->Esta )
Write( 17, 23 , cVar1 )
Write( 17, 57 , cVar2 )
Write( 18, 96 , Recemov->Vcto )
Write( 19, 23 , Left( nVlr_Dup, nLargura ))
Write( 20, 23 , SubStr( nVlr_Dup, nLargura + 1, nLargura ))
Write( 20, 85 , Left( Receber->Nome, 18))
Write( 21, 23 , Right(	nVlr_Dup, nLargura ))
Write( 21, 81 , Right( Receber->Nome, 22))
Write( 23, 85 , Tran( Recemov->Vlr,"@E 9,999,999,999.99" ))
Write( 26, 11 , "TRAB: " + Receber->Trabalho + " CARGO: " + Receber->Cargo )
Write( 28, 81 , Recemov->Docnr )
return

*+----------------------+*
def ProxCodigo( cCodigo )
*+----------------------+*
	return( StrZero( Val( cCodigo ) + 1, 6 ))

Function PedePermissao( nNivel, cAutorizado )
*********************************************
LOCAL GetList	:= {}
LOCAL Arq_Ant	:= Alias()
LOCAL Ind_Ant	:= IndexOrd()
LOCAL cScreen	:= SaveScreen()
LOCAL cRetorno := FALSO
LOCAL cNome    := Space(10)
LOCAL cPasse   := Space(10)
LOCAL cSenha
LOCAL Passe
LOCAL cPara 	:= ""
LOCAL aPara    := {;
						 {10,  "ALTERAR REGISTROS           "},;
						 {11,  "EXCLUIR REGISTROS           "},;
                   {12,  "FAZER DEVOLUCAO DE FATURA   "},;
                   {13,  "FAZER PAGAMENTOS            "},;
                   {14,  "FAZER RECEBIMENTOS          "},;
                   {40,  "FAZER RECIBO VLR ZERADO OU A MENOR "},;
                   {20,  "FATURA COM ESTOQUE NEGATIVO OU ZERADO"},;
                   {21,  "VENDER COM LIMITE ESTOURADO "},;
                   {25,  "EXCEDER DESCONTO MAXIMO     "},;
                   {26,  "FAZER DEVOLUCAO DE ENTRADAS "},;
                   {27,  "ALTERAR EMISSAO DA FATURA   "},;
                   {28,  "ALTERAR DATA RECEBIMENTO    "},;
                   {30,  "ALTERAR DATA DO FATURAMENTO "},;
                   {31,  "ALTERAR DATA DE RECEBIMENTO "},;
                   {120, "VERIFICAR PRECO DE CUSTO    "},;
                   {200, "USAR TECLAS CTRL+P          "},;
                   {300, "VISUALIZAR DETALHE DE CAIXA "},;
                   {400, "VENDER COM DEBITO EM ATRASO "},;
                   {500, "IMPRIMIR RELATORIO DE COBRANCA"}}
FIELD Senha						 
						 
if !AbreUsuario()
	AreaAnt( Arq_Ant, Ind_Ant )
	return( FALSO )
endif

oMenu:Limpa()
Area("Usuario")
Usuario->(Order( USUARIO_NOME ))

WHILE OK
   nPos   := Ascan2( aPara, nNivel, 1 )
	
	if nPos != 0
		cPara := aPara[nPos,2 ]
	endif
   
	MaBox( 10, 15, 14, 70, "SOLICITACAO DE PERMISSAO" )
	@ 11, 16 Say "Para....:   " + cPara
   @ 12, 16 Say "Usuario.:  " Get cNome  Pict "@!" Valid UsuarioErrado( @cNome )
	@ 13, 16 Say "Senha...:  " Get cPasse Pict "@S" Valid SenhaErrada(cNome, cPasse)	
	Read
	
	if LastKey() = ESC
		Usuario->(DbCloseArea())
		AreaAnt( Arq_Ant, Ind_Ant )
		Restela( cScreen )
		Return( FALSO )
	endif
	
	cNome    := Alltrim(cNome)
	cRetorno := FALSO
   if     nNivel = SCI_EXCLUSAO_DE_REGISTROS
      cRetorno := IF( Usuario->(MSDecrypt( NivelA)) = "S", OK, FALSO )
      if !cRetorno
         cRetorno := TIniNew(cNome + ".INI"):ReadBool('permissao','PodeExcluirRegistros', FALSO )
      endif
	elseif nNivel = SCI_ALTERACAO_DE_REGISTROS
      cRetorno := IF( Usuario->(MSDecrypt( Nivel0)) = "S", OK, FALSO )
      if !cRetorno
         cRetorno := TIniNew(cNome + ".INI"):ReadBool('permissao','PodeAlterarRegistros', FALSO )
      endif
   Elseif nNivel = SCI_DEVOLUCAO_FATURA  
	   cRetorno := IF( Usuario->(MSDecrypt( NivelB)) = "S", OK, FALSO )
   Elseif nNivel = SCI_ALTERAR_DATA_FATURA
		 cRetorno := IF( Usuario->(MSDecrypt( NivelB)) = "S", OK, FALSO )
	 Elseif nNivel = SCI_PAGAMENTOS		  
		 cRetorno := IF( Usuario->(MSDecrypt( NivelC)) = "S", OK, FALSO )
	 Elseif nNivel = SCI_RECEBIMENTOS	  
		 cRetorno := IF( Usuario->(MSDecrypt( NivelD)) = "S", OK, FALSO )
	 Elseif nNivel = SCI_VENDER_COM_LIMITE_ESTOURADO  
		 cRetorno := IF( Usuario->(MSDecrypt( NivelK)) = "S", OK, FALSO )
	 Elseif nNivel = SCI_DEVOLUCAO_ENTRADAS 
		 cRetorno := IF( Usuario->(MSDecrypt( NivelP)) = "S", OK, FALSO )
	 Elseif nNivel = SCI_PODE_EXCEDER_DESCONTO_MAXIMO
		 cRetorno := IF( Usuario->(MSDecrypt( NivelO)) = "S", OK, FALSO )
	 Elseif nNivel = SCI_FATURAR_COM_ESTOQUE_NEGATIVO
		 cRetorno := IF( Usuario->(MSDecrypt( NivelJ)) = "S", OK, FALSO )
	 Elseif nNivel = SCI_ALTERAR_DATA_FATURA
		 cRetorno := IF( Usuario->(MSDecrypt( NivelQ)) = "S", OK, FALSO )
	 Elseif nNivel = SCI_ALTERAR_DATA_BAIXA
		 cRetorno := IF( Usuario->(MSDecrypt( NivelR)) = "S", OK, FALSO )
	 Elseif nNivel = SCI_VERIFICAR_PCUSTO 
		 cRetorno := IF( Usuario->(MSDecrypt( NivelB)) = "S", OK, FALSO )
	 Elseif nNivel = SCI_USARTECLACTRLP
       cRetorno := TIniNew( cNome + ".INI"):ReadBool('permissao','usarteclactrlp', FALSO )
	 Elseif nNivel = SCI_VISUALIZAR_DETALHE_CAIXA
       cRetorno := TIniNew( cNome + ".INI"):ReadBool('permissao','visualizardetalhecaixa', FALSO )
	 Elseif nNivel = SCI_VENDERCOMDEBITOEMATRASO
       cRetorno := TIniNew( cNome + ".INI"):ReadBool('permissao','vendercomdebito', FALSO )
	 Elseif nNivel = SCI_IMPRIMIRROLCOBRANCA
       cRetorno := TIniNew( cNome + ".INI"):ReadBool('permissao','imprimirrolcobranca', FALSO )
	 Elseif nNivel = SCI_PODE_RECIBO_ZERADO
       cRetorno := TIniNew( cNome + ".INI"):ReadBool('permissao','recibozerado', FALSO )
	 endif
	 Usuario->(DbCloseArea())

    if !cRetorno
       cRetorno := TIniNew(cNome + ".INI"):ReadBool('permissao','usuarioadmin', FALSO)
    endif

	 if !cRetorno
		 AreaAnt( Arq_Ant, Ind_Ant )
		 ErrorBeep()
       Alert("ERRO: Solicite autorizacao para a tarefa.")
		 ResTela( cScreen )
		 Return( FALSO )
	 endif
	 
	 if cAutorizado != NIL
		 cAutorizado := cNome
	 endif
	 
	 AreaAnt( Arq_Ant, Ind_Ant )
	 ResTela( cScreen )
	 return( cRetorno )
EndDo



Function PickTam2( aNatu, aCfop, aTxIcms, cCfop, cNatu, nTxIcms )
****************************************************************
LOCAL GetList	 := {}
LOCAL cScreen	 := SaveScreen()
LOCAL nLen		 := Len( aCfop )
LOCAL aJunto	 := {}
LOCAL nPos
LOCAL nChoice

if LastKey() = UP
	Return( OK )
endif

if cCfop == '0.000'
	IncluiCfop()
	aNatu   := LerNatu()
	aCfop   := LerCFop()
	aTxIcms := LerIcms()
	ResTela( cScreen )
	Return( FALSO )
endif

if cCfop != Space(05)
	nPos := Ascan( aCfop, cCfop )
	if nPos != 0
		cNatu := aNatu[nPos]
		if aTxIcms[nPos] != 0 .OR. cCfop != Space(05) .OR. cCfop != ' .   ' .OR. !Empty( cNatu )
			nTxIcms := aTxIcms[nPos]
			Return( OK )
		endif
	endif
endif
nLen := Len( aCfop )
For i := 1 To nLen
	Aadd( aJunto, Tran(aCfop[i],'9.999') + '|' + Tran( aTxIcms[i], '99.99') + '|' + aNatu[i] )
Next
MaBox( 10, 01, 12+nLen, 45, NIL, NIL, Roloc( Cor()) )
if (nChoice := AChoice( 11, 03, 10+nLen, 44, aJunto )) != 0
	cCfop   := aCfop[ nChoice ]
	cNatu   := aNatu[ nChoice ]
	nTxIcms := aTxIcms[ nChoice ]
	if cCfop == '0.000'
		IncluiCfop()
		aNatu   := LerNatu()
		aCfop   := LerCFop()
		aTxIcms := LerIcms()
		ResTela( cScreen )
		Return( FALSO )
	endif
endif
ResTela( cScreen )
Return( OK )

Function VerCfop( xcFop)
***********************
LOCAL GetList := {}
LOCAL aCfop   := LerCfop()

if xcFop == Space(05) .OR. xcFop = ' .   '
	ErrorBeep()
	Alerta('Erro: Cfop invalido.')
	Return( FALSO )
endif
if Ascan( aCfop, xcFop ) <> 0
	ErrorBeep()
	Alerta('Erro: Cfop ja registrado.')
	Return( FALSO )
endif
Return( OK )

Function LerCfop()
******************
LOCAL GetList := {}
LOCAL cFile   := 'cfop.ini'
LOCAL aCfop   := {'0.000','5.102','6.102','5.915', '6.915'}
LOCAL nCampos := 0
LOCAL n		  := 0
LOCAL cCfop   := ''
LOCAL oCfop

FChDir( oAmbiente:xBaseDoc )
Set Defa To ( oAmbiente:xBaseDoc )
oCfop   := TIniNew( cFile )
nCampos := oCfop:ReadInteger("configuracao", "campos", 0 )
For n := 1 To nCampos
  cCfop := oCfop:ReadString("campos", "campo" + StrZero(n, 3), NIL, 1)
  Aadd( acfop, cCFop )
Next
oCfop:Close()
FChDir( oAmbiente:xBaseDados )
Set Defa To ( oAmbiente:xBaseDados )
Return( acFop )

Function LerIcms()
******************
LOCAL GetList := {}
LOCAL cFile   := 'cfop.ini'
LOCAL nCampos := 0
LOCAL aIcms   := {00.00, 17.00, 12.00, 17.00, 12.00 }
LOCAL oCfop

FChDir( oAmbiente:xBaseDoc )
Set Defa To ( oAmbiente:xBaseDoc )
oCfop   := TIniNew( cFile )
nCampos := oCfop:ReadInteger("configuracao", "campos", 0 )
For n := 1 To nCampos
  nTx_Icms := Val( oCfop:ReadString("campos", "campo" + StrZero(n, 3), NIL, 2))
  Aadd( aIcms, nTx_Icms )
Next
oCfop:Close()
FChDir( oAmbiente:xBaseDados )
Set Defa To ( oAmbiente:xBaseDados )
Return( aIcms )

Function LerNatu()
******************
LOCAL GetList := {}
LOCAL cFile   := 'cfop.ini'
LOCAL nCampos := 0
LOCAL oCfop
LOCAL aNatu := {'[INCLUIR NOVO]           ','VENDA DENTRO ESTADO      ','VENDA FORA ESTADO        ','REMESSA CONSERTO DENTRO  ','REMESSA CONSERTO FORA    '}

FChDir( oAmbiente:xBaseDoc )
Set Defa To ( oAmbiente:xBaseDoc )
oCfop   := TIniNew( cFile )
nCampos := oCfop:ReadInteger("configuracao", "campos", 0 )
For n := 1 To nCampos
  cNatu	:= oCfop:ReadString("campos", "campo" + StrZero(n, 3), NIL, 3)
  Aadd( aNatu, cNatu )
Next
oCfop:Close()
FChDir( oAmbiente:xBaseDados )
Set Defa To ( oAmbiente:xBaseDados )
Return( aNatu )

Function AscancNatu( aCfop, cCfop, aNatu )
******************************************
LOCAL nPos	:= Ascan( aCfop, cCfop )
LOCAL cNatu := ''

if nPos <> 0
	cNatu := aNatu[nPos]
endif
Return( cNatu )

Procedure IncluiCFop()
**********************
LOCAL GetList	:= {}
LOCAL cScreen	:= SaveScreen()
LOCAL cFile 	:= 'cfop.ini'
LOCAL cFop		:= Space(05)
LOCAL cNatu 	:= Space(20)
LOCAL nTx_Icms := 0
LOCAL nCampos	:= 0
LOCAL cBuffer
LOCAL oCfop

oMenu:Limpa()
WHILE OK
	MaBox( 10, 10, 14, 52 )
	@ 11, 11 Say "Cfop..............:" Get cFop     Pict '9.999' Valid VerCfop( cFop )
	@ 12, 11 Say "Natureza Operacao.:" Get cNatu    Pict '@!'    Valid EntradaInvalida({|| Empty( cNatu )}, NIL )
	@ 13, 11 Say "Taxa Icms.........:" Get nTx_Icms Pict '99.99'
	Read
	if LastKey() = ESC
		ResTela( cScreen )
		Return
	endif
	ErrorBeep()
	if Conf('Pergunta: Incluir registro ?')
		FChDir( oAmbiente:xBaseDoc )
		Set Defa To ( oAmbiente:xBaseDoc )
		oCfop := TIniNew( cFile )
      oCFop:ShowVar()
		nCampos := oCfop:ReadInteger("configuracao", "campos", 0 )
		nCampos++
		cTx_Icms := Tran( nTx_Icms, '99.99')
		cBuffer := cFop
		cBuffer += ';'
		cBuffer += cTx_Icms
		cBuffer += ';'
		cBuffer += cNatu
		oCfop:WriteInteger("configuracao", "campos", nCampos )
		oCfop:WriteString("campos","campo" + StrZero( nCampos, 3 ), cBuffer )
		oCFop:Close()
		FChDir( oAmbiente:xBaseDados )
		Set Defa To ( oAmbiente:xBaseDados )
	endif
EndDO

Function EntradaInvalida( oBloco, cMensagem )
*********************************************
IfNil( cMensagem, 'Erro: Entrada Invalida.')
Return( IF( Eval( oBloco ), ( ErrorBeep(), Alerta( cMensagem ), FALSO ), OK ))

Proc BaixasRece( cCaixa, cVendedor )
************************************
LOCAL cScreen := SaveScreen()
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
LOCAL GetList := {}
LOCAL aLog	  := {}
LOCAL aMenu   := Array(3)
LOCAL cCodiCx
LOCAL lEmitir
LOCAL nAtraso
LOCAL nDebito
LOCAL lComissao
LOCAL nRecno
LOCAL cCodi
LOCAL nRecoCli
LOCAL dEmis
LOCAL dData
LOCAL dVcto
LOCAL cVcto
LOCAL nVpag
LOCAL nVlr
LOCAL cPort
LOCAL cFatu
LOCAL cTipo
LOCAL cTipoParcial
LOCAL cCodiVen
LOCAL nJuro
LOCAL Comis_Lib
LOCAL cNossoNr
LOCAL nOpcao
LOCAL cBordero
LOCAL nPorc
LOCAL nTotJuros
LOCAL nVlrTotal
LOCAL nVlrPago
LOCAL nChSaldo
LOCAL nRecno1
LOCAL cDocnr
LOCAL nLocaliza
LOCAL nCotacao
LOCAL cDc
LOCAL nSobra	 := 0
LOCAL cCodiCob  := Space(04)
LOCAL cCobSN	 := "N"
LOCAL cObs		 := Space(40)
LOCAL nDesconto := 0
LOCAL nMulta	 := 0
LOCAL nEscolha  := 0
LOCAL cNome
LOCAL cEnde
LOCAL cCida
LOCAL cCodiCx1
LOCAL cDc1
LOCAL cDc2
LOCAL cHist
LOCAL cLcJur
LOCAL cDcJur
LOCAL cCodiJur
LOCAL nCol
LOCAL nRow
LOCAL nCarencia
LOCAL nJuroDia
LOCAL nVlrSemJuro
LOCAL cCodiCx2
LOCAL cHist2
LOCAL xAtraso
LOCAL nVlrLcto
LOCAL nDiferenca
LOCAL nRecRecebido
LOCAL cRegiao
LOCAL cParcial 	:= "Q"
LOCAL cString		:= 'BX ' + AllTrim(cVendedor) + '.'
LOCAL nPercentual := 0
LOCAL lExcluir 	:= OK
LOCAL xAgenda
LOCAL nComissao1	:= 0
LOCAL nComissao2	:= 0
LOCAL nComissao3	:= 0
LOCAL nDiaIni1 	:= 0
LOCAL nDiaIni2 	:= 0
LOCAL nDiaIni3 	:= 0
LOCAL nDiaFim1 	:= 0
LOCAL nDiaFim2 	:= 0
LOCAL nDiaFim3 	:= 0
LOCAL nRecibo		:= 1
LOCAL nAutenticar := 2
LOCAL nNenhum		:= 3
LOCAL lDesconto	:= FALSO
FIELD Vlr
FIELD Port
FIELD Tipo
FIELD Juro
FIELD NossoNr
FIELD Bordero
FIELD Porc
FIELD Emis
FIELD Vcto
FIELD Codi
FIELD Fatura
FIELD ComDisp
FIELD Comissao
FIELD CodiVen
FIELD ComBloq
FIELD Docnr

if !PodeReceber()
	 ResTela( cScreen )
	 Return
endif

lDesconto			 := oIni:ReadBool('baixasrece','campodesconto', FALSO )
nRecibo				 := oIni:ReadInteger('baixasrece','recibo', 1 )
nAutenticar 		 := oIni:ReadInteger('baixasrece','autenticar', 2 )
nNenhum				 := oIni:ReadInteger('baixasrece','nenhum', 3 )
aMenu[nRecibo] 	 := 'Recibo'
aMenu[nAutenticar] := 'Autenticar'
aMenu[nNenhum] 	 := 'Nenhum'
WHILE OK
	cDocnr := Space(09)
	MaBox( 10, 10, 12, 40 )
	@ 11, 11 Say "Documento N§....: " Get cDocnr Pict "@!" Valid DocErrado( @cDocnr )
	Read
	if LastKey() = ESC
		AreaAnt( Arq_Ant, Ind_Ant )
		ResTela( cScreen )
		Exit
	endif
	oMenu:Limpa()
	Receber->(Order( RECEBER_CODI ))
	Area("ReceMov")
	Recemov->(Order( RECEMOV_DOCNR ))
	Set Rela To Codi Into Receber
	cNome 	:= Receber->Nome
	cEnde 	:= Receber->Ende
	cCida 	:= Receber->Cida
	nRecno	:= Recno()
	nRecoCli := Receber->(Recno())
	dData 	:= Date()
	nVpag 	:= Vlr
	cPort 	:= Port
	cTipo 	:= Recemov->Tipo
	cTipoParcial := Recemov->Tipo
	nJuro 	:= Juro
	cNossoNr := NossoNr
	cBordero := Bordero
	nPorc 	:= Porc
	cCodiCx	:= "0000"
	cCodiCx1 := Space(04)
	cCodiCx2 := Space(04)
	cDc		:= "C"
	cDc1		:= "C"
	cDc2		:= "C"
	cHist 	:= "REC " + cNome
	cCodiCob := IF( Recemov->RelCob, Recemov->Cobrador, Space(04))
	cCobSN	:= IF( Recemov->RelCob, "S", "N")
	cLcJur	:= "N"
	cObs		:= cString + Space(40-Len(cString))
	cDcJur	:= "C"
	cCodiJur := cCodiCx
	WHILE OK
		nCol := 05
		nRow := 05
		MaBox( 04, 04 , nRow+18 , 78, "RECEBIMENTOS" )
		@ nRow+00, nCol	 SAY "Cliente.....: " + Receber->Codi + " " + Receber->Nome
		@ nRow+01, nCol	 SAY "Tipo........: " + cTipo
		@ nRow+01, nCol+35 SAY "Docto N§....: " + cDocnr
		@ nRow+02, nCol	 SAY "Nosso N§....: " + cNossoNr
		@ nRow+02, nCol+35 SAY "Bordero.....: " + cBordero
		@ nRow+03, nCol	 SAY "Emissao.....: " + Dtoc( Emis )
		@ nRow+03, nCol+35 SAY "Vencto......: " + Dtoc( Vcto )
		@ nRow+04, nCol	 SAY "Juros Mes...: " + Tran( nJuro , "@E 9,999,999,999.99" )
		@ nRow+04, nCol+35 SAY "Dias Atraso.: "
		@ nRow+05, nCol	 SAY "Valor.......: " + Tran( Vlr ,   "@E 9,999,999,999.99" )
		@ nRow+06, nCol	 SAY "Jrs Devidos.: "
		@ nRow+07, nCol	 SAY "Vlr c/Juros.: "
		@ nRow+08, nCol	 SAY "Data Pgto...: " Get dData Pict "##/##/##" Valid PodeRecDataDif( dData )
		Read
		if LastKey() = ESC
			Exit
		endif
		nAtraso		:= Atraso( dData, Vcto )
		nCarencia	:= Carencia( dData, Vcto )
		nJuroDia 	:= JuroDia( Vlr, Juro )
		nDesconto	:= VlrDesconto( dData, Vcto, Vlr )
		nPercentual := PercDesconto( dData, Vcto, Vlr )
		//nMulta 	  := VlrMulta( dData, Vcto, Vlr )
		nMulta		:= 0
		nVlrSemJuro := Recemov->Vlr

		if lDesconto = FALSO
			if nAtraso <= 0
				nTotJuros := 0
				nVlrTotal := ( Vlr + nMulta ) - nDesconto
			Else
				nTotJuros := nJurodia * nCarencia
				nVlrTotal := (( Vlr + nTotJuros ) + nMulta )- nDesconto
			endif
		Elseif lDesconto = OK
			if nAtraso <= 0
				nTotJuros := 0
				nVlrTotal := ( Vlr + nMulta )
			Else
				nTotJuros := nJurodia * nCarencia
				nVlrTotal := (( Vlr + nTotJuros ) + nMulta )
			endif
		endif
		nMulta		:= VlrMulta( dData, Vcto, nVlrTotal )
		nVlrTotal	+= nMulta

		Write( nRow+04, nCol+35, "Dias Atraso.: " + Tran( nAtraso,   "99999") + " Dias" )
		Write( nRow+05, nCol+35, "Desconto....: " + Tran( nDesconto, "@E 9,999,999,999.99"))
		Write( nRow+06, nCol,	 "Jrs Devidos.: " + Tran( nTotJuros, "@E 9,999,999,999.99"))
		Write( nRow+06, nCol+35, "Multa.......: " + Tran( nMulta,    "@E 9,999,999,999.99"))
		Write( nRow+07, nCol,	 "Vlr c/juros.: " + Tran( nVlrTotal, "@E 9,999,999,999.99"))

		nVlrPago := nVlrTotal
		if lDesconto = OK
			@ nRow+08, nCol+35 Say "Desconto....: " GET nPercentual Pict '999.99' Valid (nVlrPago := ( nVlrTotal - ((nVlrTotal * nPercentual) / 100 ))) >= 0 .OR. (nVlrPago := ( nVlrTotal - ((nVlrTotal * nPercentual) / 100 ))) <= 0
		endif
		@ nRow+09, nCol	 Say "Valor Pago..: " GET nVlrPago Pict "@E 9,999,999,999.99"
		@ nRow+09, nCol+35 Say "Bordero.....: " GET cBordero Pict "@!"
		@ nRow+10, nCol	 Say "Tipo........: " GET cTipo    Pict "@!" Valid  PickTam({"DinHeiro","Nota Promissoria","Duplicata Mercantil","CHeque a Vista","ReQuisicao","BoNus","Cheque Pre-Datado","DiFerenca Rec/Pag","Direta Livre","CarTao", "OUtros"}, {"DH    ","NP    ","DM    ","CH    ","RQ    ","BN    ","CP    ","DF    ","DL    ","CT    ","OU    "}, @cTipo )
		@ nRow+10, nCol+35 Say "Portador....: " GET cPort    Pict "@!"
		@ nRow+11, nCol	 Say "Conta Caixa.: " GET cCodiCx  Pict "9999" Valid CheErrado( @cCodiCx,, Row(), nCol+28 )
		@ nRow+11, nCol+20 Say "D/C.:"          GET cDc      Pict "!"    Valid PickTam({'Credito em conta','Debito em conta'}, {'C','D'}, @cDc )

		@ nRow+12, nCol	 Say "C. Partida..: " GET cCodiCx1 Pict "9999" Valid CheErrado( @cCodiCx1,, Row(), nCol+28, OK )
		@ nRow+12, nCol+20 Say "D/C.:"          GET cDc1     Pict "!"    Valid PickTam({'Credito em conta','Debito em conta'}, {'C','D'}, @cDc1 )

		@ nRow+13, nCol	 Say "C. Partida..: " GET cCodiCx2 Pict "9999" Valid CheErrado( @cCodiCx2,, Row(), nCol+28, OK )
		@ nRow+13, nCol+20 Say "D/C.:"          GET cDc2     Pict "!"    Valid PickTam({'Credito em conta','Debito em conta'}, {'C','D'}, @cDc2 )

		@ nRow+14, nCol	 Say "Historico...: " GET cHist    Pict "@!"   Valid !Empty( cHist )
		@ nRow+15, nCol	 Say "Observacoes.: " GET cObs     Pict "@!"
		@ nRow+16, nCol	 Say "Com. Cobr...: " GET cCobSN   Pict "!"    Valid PickSimNao( @cCobSN )
		@ nRow+16, nCol+20 Say "Cob...:"        GET cCodiCob Pict "9999" WHEN cCobSN = "S" Valid FunErrado( @cCodiCob,, Row(), Col() + 1 )
		@ nRow+17, nCol	 Say "Separar Jrs.: " GET cLcJur   Pict "!"    Valid PickSimNao( @cLcJur )
		@ nRow+17, nCol+20 Say "Conta.:"        GET cCodiJur Pict "9999" WHEN cLcJur = "S" Valid CheErrado( @cCodiJur,, Row(), Col() + 1 )
		Read
		if LastKey() = ESC
			Exit
		endif
		cCodiVen 	 := Recemov->CodiVen
		cCodi 		 := Recemov->Codi
		cRegiao		 := Recemov->Regiao
		dEmis 		 := Recemov->Emis
		dVcto 		 := Recemov->Vcto
		nVlr			 := Recemov->Vlr
		cTipoParcial := Recemov->Tipo
		cFatu 		 := Recemov->Fatura
		lComissao	 := Recemov->Comissao
		nOpcao		 := Conf( "Pergunta: Confirma a baixa deste Titulo ?", { " Sim ", " Alterar ", " Cancelar "})
		lEmitir		 := 1
		if nOpcao = 1 // Baixar
			if nVlrPago <> nVlrTotal
				ErrorBeep()
				lEmitir := Conf("Valor pago diferente que o devido.;;Pergunta: Fazer Baixa como:",;
										{"Quitando", "Parcial", "Diferenca C/C", "Cancelar"})
				if lEmitir = 0 .OR. lEmitir = 4
					Loop
				endif
				Do Case
				Case lEmitir = 1
					cParcial := "Q"
				Case lEmitir = 2
					cParcial := "P"
				Case lEmitir = 3
					cParcial := "D"
				EndCase
				if lEmitir = 3
					cCodiCx2 := Space(04)
					cDc2		:= " "
					cHist2	:= cHist
					MaBox( nRow+15, 05 , nRow+18 , 74, "LANCAMENTOS DIFERENCA C/C")
					@ nRow+16, nCol	 Say "Conta Caixa.: " GET cCodiCx2  Pict "9999" Valid CheErrado( @cCodiCx2,, Row(), nCol+28 )
					@ nRow+16, nCol+20 Say "D/C.:"          GET cDc2      Pict "!" Valid cDc2 $ "DC"
					@ nRow+17, nCol	 Say "Historico...: " GET cHist2    Pict "@!" Valid !Empty( cHist2 )
					Read
					if LastKey() = ESC
						Loop
					endif
					ErrorBeep()
					if !Conf("Pergunta: Confirma Lancamento ?")
						Loop
					endif
				endif
			endif
			Receber->(DbGoTo( nRecoCli )) 		  // Localiza Cliente
			if Cheque->(!TravaArq())	; DbUnLockAll() ; Loop ; endif
			if Chemov->(!TravaArq())	; DbUnLockAll() ; Loop ; endif
			*:-------------------------------------------------------
			nLocaliza := Recemov->(Recno())
			xAtraso	 := Receber->Matraso
			if nAtraso > 999
				nAtraso := 999
			endif
			if xAtraso < nAtraso 					  // Se o Atraso Anterior for menor que o atual
				if Receber->(TravaReg())
					Receber->Matraso := IF( nAtraso > 999, 999, nAtraso )
					Receber->(Libera())
				endif
			endif
			*:-------------------------------------------------------
			Cheque->(Order( CHEQUE_CODI ))
			if cLcJur == "S" // Lancar Juros em conta Separada
				nVlrLcto := ( nVlrPago - nVlrSemJuro )
				if Cheque->(DbSeek( cCodiJur )) .OR. !Empty( cCodiJur )
					if Cheque->(TravaReg())
						nChSaldo := Cheque->Saldo
						if Chemov->(Incluiu())
							if cDc = "C"
								nChSaldo 	  += nVlrLcto
								Cheque->Saldo += nVlrLcto
								Chemov->Cre   := nVlrLcto
							Else
								nChSaldo 	  -= nVlrLcto
								Cheque->Saldo -= nVlrLcto
								Chemov->Deb   := nVlrLcto
							endif
							Chemov->Codi	:= cCodiJur
							Chemov->Docnr	:= cDocnr
							Chemov->Emis	:= dData
							Chemov->Data	:= dData
							Chemov->Baixa	:= Date()
							Chemov->Hist	:= "REC JUROS TITULO N§ " + cDocnr
							Chemov->Saldo	:= nChSaldo
							Chemov->Tipo	:= cTipo
							Chemov->Caixa	:= IF( cCaixa = Nil, Space(4), cCaixa )
							Chemov->Fatura := cFatu
						endif
						Chemov->(Libera())
					endif
					Cheque->(Libera())
				endif
			endif
			*:-------------------------------------------------------
			if Cheque->(DbSeek( cCodiCx )) .OR. !Empty( cCodiCx )
				if Cheque->(TravaReg())
					nVlrLcto := nVlrPago
					if cLcJur == "S" // Lancar Juros em conta Separada
						nVlrLcto := nVlrSemJuro
					endif
					nChSaldo := Cheque->Saldo
					if Chemov->(Incluiu())
						if cDc = "C"
							nChSaldo 	  += nVlrLcto
							Cheque->Saldo += nVlrLcto
							Chemov->Cre   := nVlrLcto
						Else
							nChSaldo 	  -= nVlrLcto
							Cheque->Saldo -= nVlrLcto
							Chemov->Deb   := nVlrLcto
						endif
						Chemov->Codi	:= cCodiCx
						Chemov->Docnr	:= cDocnr
						Chemov->Emis	:= dData
						Chemov->Data	:= dData
						Chemov->Baixa	:= Date()
						Chemov->Hist	:= cHist
						Chemov->Saldo	:= nChSaldo
						Chemov->Tipo	:= cTipo
						Chemov->Caixa	:= IF( cCaixa = Nil, Space(4), cCaixa )
						Chemov->Fatura := cFatu
					endif
					Chemov->(Libera())
				endif
				Cheque->(Libera())
			endif
			*:-------------------------------------------------------
			if Cheque->(DbSeek( cCodiCx1 )) .OR. !Empty( cCodiCx1 )
				if Cheque->(TravaReg())
					nChSaldo := Cheque->Saldo
					if Chemov->(Incluiu())
						if cDc1 = "C"
							nChSaldo 	  += nVlrPago
							Cheque->Saldo += nVlrPago
							Chemov->Cre   := nVlrPago
						Else
							nChSaldo 	  -= nVlrPago
							Cheque->Saldo -= nVlrPago
							Chemov->Deb   := nVlrPago
						endif
						Chemov->Codi	:= cCodiCx1
						Chemov->Docnr	:= cDocnr
						Chemov->Emis	:= dData
						Chemov->Data	:= dData
						Chemov->Baixa	:= Date()
						Chemov->Hist	:= cHist
						Chemov->Saldo	:= nChSaldo
						Chemov->Tipo	:= cTipo
						Chemov->Caixa	:= IF( cCaixa = Nil, Space(4), cCaixa )
						Chemov->Fatura := cFatu
					endif
					Chemov->(Libera())
				endif
				Cheque->(Libera())
			endif
			*:-------------------------------------------------------
			if Cheque->(DbSeek( cCodiCx2 )) .OR. !Empty( cCodiCx2 )
				if Cheque->(TravaReg())
					nChSaldo := Cheque->Saldo
					if Chemov->(Incluiu())
						if cDc2 = "C"
							nChSaldo 	  += nVlrPago
							Cheque->Saldo += nVlrPago
							Chemov->Cre   := nVlrPago
						Else
							nChSaldo 	  -= nVlrPago
							Cheque->Saldo -= nVlrPago
							Chemov->Deb   := nVlrPago
						endif
						Chemov->Codi	:= cCodiCx2
						Chemov->Docnr	:= cDocnr
						Chemov->Emis	:= dData
						Chemov->Data	:= dData
						Chemov->Baixa	:= Date()
						Chemov->Hist	:= cHist
						Chemov->Saldo	:= nChSaldo
						Chemov->Tipo	:= cTipo
						Chemov->Caixa	:= IF( cCaixa = Nil, Space(4), cCaixa )
						Chemov->Fatura := cFatu
					endif
					Chemov->(Libera())
				endif
				Cheque->(Libera())
			endif
			*:-------------------------------------------------------
			if lEmitir = 3
				if Cheque->(DbSeek( cCodiCx2 )) .OR. !Empty( cCodiCx2 )
					if Cheque->(TravaReg())
						nChSaldo   := Cheque->Saldo
						if nVlrTotal < nVlrPago
							nDiferenca := ( nVlrPago - nVlrTotal )
						Else
							nDiferenca := ( nVlrTotal - nVlrPago )
						endif
						if Chemov->(Incluiu())
							if cDc2 = "C"
								nChSaldo 	  += nDiferenca
								Cheque->Saldo += nDiferenca
								Chemov->Cre   := nDiferenca
							Else
								nChSaldo 	  -= nDiferenca
								Cheque->Saldo -= nDiferenca
								Chemov->Deb   := nDiferenca
							endif
							Chemov->Codi	:= cCodiCx2
							Chemov->Docnr	:= cDocnr
							Chemov->Emis	:= dData
							Chemov->Data	:= dData
							Chemov->Baixa	:= Date()
							Chemov->Hist	:= cHist2
							Chemov->Saldo	:= nChSaldo
							Chemov->Tipo	:= "DF"       // Tipo Diferenca de Caixa
							Chemov->Caixa	:= IF( cCaixa = Nil, Space(4), cCaixa )
							Chemov->Fatura := cFatu
						endif
						Chemov->(Libera())
					endif
					Cheque->(Libera())
				endif
			endif
			*:-------------------------------------------------------
			if Recebido->(Incluiu())
				Recebido->Codi 	 := cCodi
				Recebido->Caixa	 := IF( cCaixa = Nil, Space(4), cCaixa )
				Recebido->Regiao	 := cRegiao
				Recebido->CodiVen  := cCodiVen
				Recebido->Docnr	 := cDocnr
				Recebido->Emis 	 := dEmis
				Recebido->Vcto 	 := dVcto
				Recebido->Baixa	 := Date()
				Recebido->Vlr		 := nVlr
				Recebido->DataPag  := dData
				Recebido->VlrPag	 := nVlrPago
				Recebido->Port 	 := cPort
				Recebido->Tipo 	 := cTipo
				Recebido->Juro 	 := nJuro
				Recebido->NossoNr  := cNossoNr
				Recebido->Bordero  := cBordero
				Recebido->Fatura	 := cFatu
				Recebido->Obs		 := cObs
				Recebido->Parcial  := cParcial
				Recebido->Docnr	 := cParcial + Right(cDocnr, 8)
				nRecRecebido		 := Recebido->(Recno())
				Recebido->(Libera())
			endif
			*:-------------------------------------------------------
			nRecno1	:= Recno()
			Recemov->(DbGoTo( nLocaliza))
			if Recemov->(TravaReg())
				if nVlrPago < nVlrTotal .AND. lEmitir = 2 // Parcial
					nSobra				:= ( nVlrTotal - nVlrPago )
					nCotacao 			:= 0
					Recemov->Vcto		:= IF( nAtraso <= 0, Recemov->Vcto, dData )
					Recemov->Vlr		:= nSobra
					Recemov->VlrDolar := nSobra
					Recemov->Jurodia	:= JuroDia( nSobra, nJuro )
					Recemov->Docnr 	:= 'R' + Recemov->(Right(Docnr, 8))
					Recemov->Obs		:= 'RESTANTE PARCELA: ' + Docnr
				Else
					Recemov->(DbDelete())
				endif
			endif
			Recemov->(Libera())
			/*-------------------------------------------------------
			  Inicio da Liberacao de comissoes bloqueadas
			  -------------------------------------------------------*/
			if nPorc <> 0															// Vair Pagar Comissao ?
				if !Empty( cFatu )												// Eh Venda ?
					Vendemov->(Order( VENDEMOV_DOCNR ))
					if Vendemov->(DbSeek( cFatu ))							// Localiza Fatura.
						if Vendemov->Comdisp < Vendemov->Comissao 		// Disponivel menor que o total ?
							if lComissao											// Pagar Comissao deste titulo ?
								if Vendemov->(TravaReg())
									cCodiVen  := Vendemov->CodiVen
									if nVlrPago >= nVlr
										Comis_Lib := ( nVlr * nPorc) / 100
									Else
										Comis_Lib := ( nVlrPago * nPorc) / 100
									endif
									Vendemov->ComBloq := ( Vendemov->ComBloq - Comis_Lib )
									Vendemov->ComDisp := ( Vendemov->ComDisp + Comis_Lib )
									if Vendemov->ComBloq < 0
										Vendemov->ComBloq := 0
										Vendemov->ComDisp := Vendemov->Comissao
									endif
								endif
								Vendemov->(Libera())
								Vendedor->(Order( VENDEDOR_CODIVEN ))
								if Vendedor->(DbSeek( cCodiVen ))
									if Vendedor->(TravaReg())
										Vendedor->ComBloq 	:= ( Vendedor->ComBloq - Comis_Lib )
										Vendedor->ComDisp 	:= ( Vendedor->ComDisp + Comis_Lib )
										if Vendedor->ComBloq < 0
											Vendedor->ComBloq := 0
											Vendedor->ComDisp := Vendedor->Comissao
										endif
									endif
									Vendedor->(Libera())
								endif
							endif
						endif
					endif
				endif
			endif
			/*-------------------------------------------------------
			  Inicio de Pagamento de Comissao a Cobradores
			  -------------------------------------------------------*/
			if cCobSn = "S"  // Lancar Comissao a Cobrador
				lProcessarComissao := OK
				nComissao1 := oIni:ReadInteger('comissaoperiodo1', 'comissao', 0 )
				nComissao2 := oIni:ReadInteger('comissaoperiodo2', 'comissao', 0 )
				nComissao3 := oIni:ReadInteger('comissaoperiodo3', 'comissao', 0 )
				nDiaIni1   := oIni:ReadInteger('comissaoperiodo1', 'diaini', 0 )
				nDiaIni2   := oIni:ReadInteger('comissaoperiodo2', 'diaini', 0 )
				nDiaIni3   := oIni:ReadInteger('comissaoperiodo3', 'diaini', 0 )
				nDiaFim1   := oIni:ReadInteger('comissaoperiodo1', 'diafim', 0 )
				nDiaFim2   := oIni:ReadInteger('comissaoperiodo2', 'diafim', 0 )
				nDiaFim3   := oIni:ReadInteger('comissaoperiodo3', 'diafim', 0 )
				nPorcCob   := 0
				Do Case
				Case nAtraso >= nDiaIni1 .AND. nAtraso <= nDiaFim1
					if nComissao1 <= 0
						ErrorBeep()
						Alerta('Erro: Informe ao Supervisor que nao foi definido;comissao para cobrador em Arquivos/Configuracao ;da Base de Dados/Financeiro.;;Nao sera lancado comissao do cobrador!')
						lProcessarComissao := FALSO
					endif
					nPorcCob := nComissao1
				Case nAtraso >= nDiaIni2 .AND. nAtraso <= nDiaFim2
					if nComissao2 <= 0
						ErrorBeep()
						Alerta('Erro: Informe ao Supervisor que nao foi definido;comissao para cobrador em Arquivos/Configuracao ;da Base de Dados/Financeiro.;;Nao sera lancado comissao do cobrador!')
						lProcessarComissao := FALSO
					endif
					nPorcCob := nComissao2
				Case nAtraso >= nDiaIni3
					if nComissao3 <= 0
						ErrorBeep()
						Alerta('Erro: Informe ao Supervisor que nao foi definido;comissao para cobrador em Arquivos/Configuracao ;da Base de Dados/Financeiro.;;Nao sera lancado comissao do cobrador!')
						lProcessarComissao := FALSO
					endif
					nPorcCob := nComissao3
				EndCase
				if lProcessarComissao
					Vendedor->(Order( VENDEDOR_CODIVEN ))
					if Vendedor->(DbSeek( cCodiCob ))
						if Vendedor->(TravaReg())
							Comis_Lib := ( nVlrPago * nPorcCob ) / 100
							Area("Vendemov")
							if Vendemov->(Incluiu())
								Vendemov->Docnr	  := cDocnr
								Vendemov->Dc		  := 'C'
								Vendemov->Descricao := cHist
								Vendemov->Regiao	  := cRegiao
								Vendemov->Pedido	  := cDocnr
								Vendemov->DataPed   := dData
								Vendemov->CodiVen   := cCodiCob
								Vendemov->Vlr		  := nVlrPago
								Vendemov->Data 	  := dData
								Vendemov->Porc 	  := nPorcCob
								Vendemov->Fatura	  := cFatu
								Vendemov->Codi 	  := cCodi
								Vendemov->Combloq   := 0
								Vendemov->Comissao  := Comis_Lib
								Vendedor->Comissao  += Comis_Lib
								Vendemov->Comdisp   := Comis_Lib
								Vendedor->ComDisp   += Comis_Lib
							endif
							Vendemov->(Libera())
						endif
						Vendedor->(Libera())
					endif
				endif
			endif
			Recemov->(Order( RECEMOV_CODI ))
			/* Funcao desativada em 19.02.2015
			// Limpeza do Agendamento
			lExcluir := OK
			if Recemov->(DbSeek( cCodi ))
				While Recemov->Codi = cCodi
					if Recemov->Vcto <= Date() // Continua Devendo ?
						lExcluir := FALSO
						Exit							// Vaza
					endif
					Recemov->(DbSkip(1))
				EndDo
			endif
			Receber->(Order( RECEBER_CODI ))
			if lExcluir
				xAgenda	:= oAmbiente:xBaseDados + '\AGE' + cCodi + '.INI'
				Ferase( xAgenda )
				if Receber->(DbSeek( cCodi ))
					if Receber->(TravaReg())
						Receber->ProxCob := Ctod('')
						Receber->(Libera())
					endif
			  endif
			endif
			*/
			oMenu:Limpa()
			if Receber->(DbSeek( cCodi ))
				if Receber->Spc
					Recemov->(Order( RECEMOV_CODI ))
					if Recemov->(!DbSeek( cCodi ))
						Alerta('Informa: Cliente sem debito e negativado SPC.')
					endif
				endif
			endif
			aLog	:= {}
			cVcto := Dtoc( dVcto )
			Aadd( aLog, "BAIXAS" )
			Aadd( aLog, cCodi )
			Aadd( aLog, cNome)
			Aadd( aLog, cDocnr )
			Aadd( aLog, cVcto )
			Aadd( aLog, Time())
			Aadd( aLog, Dtoc(Date()))
			Aadd( aLog, oAmbiente:xUsuario + Space( 10 - Len( oAmbiente:xUsuario )))
			Aadd( aLog, cCaixa	)
			Aadd( aLog, Tran( nVlrPago,'@E 999,999,999,999.99'))
			Aadd( aLog, cObs )
			Aadd( aLog, cEnde )
			Aadd( aLog, cCida )
			Aadd( aLog, cFatu )
			LogRecibo( aLog )
			M_Title("Pergunta: DESEJA IMPRIMIR ?")
			nEscolha := FazMenu( 10, 10, aMenu )
			if nEscolha = nRecibo // 1
				//ReciboReceber( nRecRecebido, nSobra, aLog )
				aLog[ALOG_TIPO] := oAmbiente:cTipoRecibo
				aLog[ALOG_HIST] := "PAG PARCIAL PARCELA CONTRATO SERVICOS DE INTERNET."
				ReciboIndividual( cCaixa, cVendedor, aLog, nRecRecebido )
			Elseif nEscolha = nAutenticar // 2
				Autenticar( nRecRecebido, nSobra )
			endif
		Elseif nOpcao = 2 // Alterar
			Loop
		endif
		  Exit
	EndDo
	Recemov->(DbClearRel())
	Recemov->(DbGoTop())
	ResTela( cScreen )
EndDo

Function SplitCor( cColor, nForeGround, nBackGround )
*****************************************************
LOCAL aCores := {{'N',  0, 'Black',  'Preto'},;
					  {'B',  1, 'Blue',   'Azul'},;
					  {'G',  2, 'Green',  'Verde'},;
					  {'BG', 3, 'Cyan',   'Ciano'},;
					  {'R',  4, 'Red',    'Vermelho'},;
					  {'RB', 5, 'Magenta','Magenta'},;
					  {'GR', 6, 'Brown',  'Marrom'},;
					  {'W',  7, 'White',  'Branco'},;
					  {'N+', 8, 'Gray',   'Cinza'},;
					  {'B+', 9, 'Bright Blue','Azul Intenso'},;
					  {'G+', 10, 'Bright Green','Verde Intenso'},;
					  {'BG+', 11, 'Bright Cyan','Ciano Intenso'},;
					  {'R+',  12, 'Bright Red', 'Vermelho Intenso'},;
					  {'RB+', 13, 'Bright Magenta', 'Magenta Intenso'},;
					  {'GR+', 14, 'Yellow', 'Amarelo'},;
					  {'W+',  15, 'Bright White', 'Branco Intenso'}}
LOCAL aSplit		:= Array(5,2)
LOCAL cStandard
LOCAL cEnhanced
LOCAL cBorder
LOCAL cBackGround
LOCAL cUnseleted

IfNil( cColor, SetColor())
IfNil( nForeGround, 1 )
IfNil( nBackGround, 1 )

cStandard	:= SubStr(cColor, 1, At(',',cColor)-1)
cTemp 		:= SubStr(cStandard, 1, At('/',cStandard)-1)
aSplit[1,1] := cTemp
aSplit[1,2] := DelAntesdaVirgula(cStandard, '/')
cColor		:= DelAntesdaVirgula(cColor, ',')

cEnhanced	:= SubStr(cColor, 1, At(',',cColor)-1)
cTemp 		:= SubStr(cEnhanced, 1, At('/',cEnhanced)-1)
aSplit[2,1] := cTemp
aSplit[2,2] := DelAntesdaVirgula(cEnhanced, '/')
cColor		:= DelAntesdaVirgula(cColor, ',')

cBorder		:= SubStr(cColor, 1, At(',',cColor)-1)
cTemp 		:= SubStr(cBorder, 1, At('/',cBorder)-1)
aSplit[3,1] := cTemp
aSplit[3,2] := DelAntesdaVirgula(cBorder, '/')
cColor		:= DelAntesdaVirgula(cColor, ',')

cBackGround := SubStr(cColor, 1, At(',',cColor)-1)
cTemp 		:= SubStr(cBackGround, 1, At('/',cBackGround)-1)
aSplit[4,1] := cTemp
aSplit[4,2] := DelAntesdaVirgula(cBackGround, '/')
cColor		:= DelAntesdaVirgula(cColor, ',')

cUnseleted	:= cColor
cTemp 		:= SubStr(cUnseleted, 1, At('/',cUnseleted)-1)
aSplit[5,1] := cTemp
aSplit[5,2] := DelAntesdaVirgula(cUnseleted, '/')

/*

? cStandard
? cEnhanced
? cBorder
? cBackGround
? cUnseleted
? cColor
? acores[1,1]
? acores[2,1]
? acores[3,1]
? acores[4,1]

For i := 1 to 5
  ? aSplit[i, nForeGround]
  ? aSplit[i, nBackGround]
Next
? Ascan2(aSplit, nForeGround, 2)
? Ascan2(aSplit, nBackGround, 2)
*/

Return( aSplit )

Function DelAntesdaVirgula(cString, cStrLocate)
***********************************************
LOCAL cDeletar := SubStr(cString, 1, At(cStrLocate,cString))
Return(cString := Stuff(cString, 1, Len(cDeletar), ""))

Function ReciboIndividual( cCaixa, cVendedor, aLog, xVlrRecibo, xDocnr, lLancarJurosNaoPago, nVlrPago, dDataPag, xObs, lAjustarValorOriginal)
*********************************************************************************************************************************************
LOCAL Arq_Ant       := Alias()
LOCAL Ind_Ant       := IndexOrd()
LOCAL cScreen       := SaveScreen()
LOCAL GetList       := {}
LOCAL nVlr          := 0
LOCAL aRecibo       := {}
LOCAL nOpcao        := 1
LOCAL cVlr          := Space(0)
LOCAL cVlrLog       := Space(0)
LOCAL cValor        := Space(0)
LOCAL cHist         := Space(60)
LOCAL cObs          := Space(60)
LOCAL cString       := Space(60)
LOCAL lCalcular     := FALSO
LOCAL lParcial      := FALSO
LOCAL dDeposito     := Date()
LOCAL nVlrComJuros  := 0
LOCAL lSucesso      := FALSO
LOCAL cLetraParcial := Space(0)
LOCAL cNewDocnr     := Space(0)
LOCAL nContaLetra   := 0
LOCAL nSomaParcial  := 0
LOCAL nPercentual   := 0
LOCAL lRetVal       := OK
LOCAL nValorDoRecibo
LOCAL nDividendo
LOCAL nPos
LOCAL lSelecao
LOCAL nY 
LOCAL nLenSelecao
LOCAL cTitulo
LOCAL xTitulo
LOCAL nRecno
LOCAL nRow
LOCAL nCol
LOCAL lSair
LOCAL dVcto
LOCAL cCodi
LOCAL cNome
LOCAL cEnde
LOCAL cCida
LOCAL cFatu
DEFAU xVlrRecibo            TO 0
DEFAU nVlrPago              TO 0
DEFAU lLancarJurosNaoPago   TO FALSO
DEFAU lSelecao              TO FALSO
DEFAU dDataPag              TO nil
DEFAU lAjustarValorOriginal TO true

if !lLancarJurosNaoPago
   aLog := NIL
endif

if ValType( xDocnr ) = 'A' // Array de Recibo Selecionados
	Mensagem("INFO: Aguarde somando...")
	cDocnr      := xDocnr[1]
	nVlrRecibo  := Atotal( xVlrRecibo )
	xTitulo     := "IMPRESSAO SELECAO DE "
	lSelecao    := OK
	nLenSelecao := Len(xDocnr)
else
    cDocnr      := xDocnr
	nVlrRecibo  := xVlrRecibo 
	xTitulo     := "IMPRESSAO INDIVIDUAL DE "
endif	

WHILE OK
	if !lLancarJurosNaoPago	
	   oMenu:Limpa()
	endif	
	if aLog == NIL
		lSair        := IF( cDocnr = NIL, FALSO, OK )
		cDocnr       := IF( cDocnr = NIL, Space(09), cDocnr)
		nRow         := 11
		nCol         := 27
		nVlr         := Round(nVlr,2)
		nVlrComJuros := Round(nVlrRecibo, 2)
		nVlrRecibo   := Round(nVlrRecibo, 2)
		
		if !lLancarJurosNaoPago
		   if lSelecao // Array de Recibo Selecionados
				MaBox( 01, 00, 09, MaxCol(), "RELACAO DOS TITULOS SELECIONADOS")
				nPos       := 2
				nDividendo := if(MaxCol() <= 80, 2 , if(MaxCol() > 80 .and. MaxCol() <= 132, 4 , 5))
				SetPos( nPos, 01)
				for nY := 1 to nLenSelecao
					if nY % nDividendo == 0
						SetPos( ++nPos, 01)
					endif
				   QQout( '[' + StrZero(nY,2) + ']' + xDocnr[nY], space(1), Tran(xVlrRecibo[ny], '@E 9,999,999.99'),Space(02))
				next
			endif          		
			if 	 oAmbiente:cTipoRecibo == "RECCAR"
				cTitulo := "RECIBO PAGTO EM CARTEIRA"
				Mabox( 10, 00, 15, Maxcol(), Xtitulo + Ctitulo )
			Elseif oAmbiente:cTipoRecibo == "RECBCO"
				cTitulo := "RECIBO VIA DEP BANCARIO"
				MaBox( 10, 00, 17, MaxCol(), xTitulo + cTitulo )
			Elseif oAmbiente:cTipoRecibo == "RECOUT"
				cTitulo := "RECIBO PAGTO VIA OUTROS"
				MaBox( 10, 00, 17, MaxCol(), xTitulo + cTitulo )
			endif // oAmbiente:cTipoRecibo
			
			@ 11, 01 Say "Documento N§....:" Get cDocnr     Pict "@!"           Valid DocErrado( @cDocnr, @nVlr, @nVlrRecibo, NIL, @cHist, Row(), Col()+1)
			@ 12, 01 Say "Valor...........:" Get nVlr       Pict "999999999.99" Valid lPodeReciboZerado(@nVlr, nVlrComJuros, lSelecao) .AND. lPrtExtenso(nVlr, NIL , NIL , Row(), Col()+1, 45, xVlrRecibo)			
			@ 13, 01 Say "Valor Recibo....:" Get nVlrRecibo Pict "999999999.99" Valid lPrtExtenso(nVlr, @nVlrRecibo, lSelecao, Row(), Col()+1, 45, xVlrRecibo)
			@ 14, 01 Say "Referente.......:" Get cHist      Pict "@!"				
			
			if 	 oAmbiente:cTipoRecibo == "RECCAR"
			Elseif oAmbiente:cTipoRecibo == "RECBCO"
				@ 15, 01 Say "Data Deposito...:" Get dDeposito  Pict "##/##/##"     Valid lValidDep1( dDeposito, @cObs )
				@ 16, 01 Say "Observacoes.....:" Get cObs       Pict "@!"
			Elseif oAmbiente:cTipoRecibo == "RECOUT"
				@ 15, 01 Say "Data Pagamento..:" Get dDeposito  Pict "##/##/##"     Valid lValidDep2( dDeposito, @cObs )
				@ 16, 01 Say "Observacoes.....:" Get cObs       Pict "@!"
			endif // oAmbiente:cTipoRecibo			
			Read
			if LastKey() = ESC .OR. !(Instru80()) .OR. !(LptOk())
				Recemov->(DbClearRel())
				AreaAnt( Arq_Ant, Ind_Ant )
				ResTela( cScreen )
				return lSucesso
			endif
			
		else // Somente LancarJurosNaoPago	
			if !(DocErrado( @cDocnr, @nVlr, @nVlrRecibo, NIL, @cHist, NIL, NIL, lLancarJurosNaoPago))
				lSair    := OK
				lSucesso := FALSO
				exit
			endif
			nVlr         := Round(CalcJuros(dDataPag, NIL),2)
			nVlrRecibo   := Round(nVlrPago,2)
			nVlrComJuros := nVlr
			
		endif // !lLancarJurosNaoPago	
		
		Mensagem("Aguarde, Ajustando base de dados.")
		
		if !lSelecao
		   xDocnr     := {}
			xVlrRecibo := {}
			xObs       := {}
			Aadd( xDocnr, cDocnr )
			Aadd( xVlrRecibo, nVlrRecibo )
			Aadd( xObs, cHist )			
			nLenSelecao := Len( xDocnr )
		endif
		
		Receber->(Order( RECEBER_CODI ))
		Area("Recemov")
		Recemov->(Order( RECEMOV_DOCNR ))
		Set Rela To Codi Into Receber     
      
		nSomaParcial   := 0
		nVlrGet        := nVlr
		nVlrReciboGet  := nVlrRecibo
		xHist          := cHist
      
		for nY := 1 to nLenSelecao
			Recemov->(DbSeek( xDocnr[nY]))    
			nTam		    := Len(AllTrim(Recemov->Obs))
			cComplemento := "PAG PARCIAL "
			cString		 := "PARCELA CONTRATO SERVICOS DE INTERNET."			
			cHist 		 := cString + Space(60-Len(cString))			
			cHist 	    := IF( Empty(Recemov->Obs), cComplemento + cHist, cComplemento + Left(Recemov->Obs,nTam) + Space((60-12-nTam)))
			//cHist        := xObs[nY]
			cDocnr       := Recemov->Docnr
			nRecno       := Recemov->(Recno())
			nVlr         := Round( nVlr,2)
			nVlrRecibo   := Round( iif( nVlrRecibo == 0, nVlrRecibo, xVlrRecibo[nY]),2)
			nVlrComJuros := nVlr

			if nVlrReciboGet < nVlrGet .AND. !lSelecao   // Recibo Parcial?
				if nVlrReciboGet != 0                    // Ajustar fatura para renegociacao ou zerar mensalidade internet				
					if !lLancarJurosNaoPago              // Recibo Normal														
						Mensagem("Aguarde, Ajustando registro parcial.")							
					endif	
					lSucesso := LancaParcial( cDocnr, nRecno, nVlr, nVlrRecibo, nVlrComJuros, dDataPag, lLancarJurosNaoPago, lSucesso, lAjustarValorOriginal )
				endif	
			endif				
			
			if !lLancarJurosNaoPago                // Recibo Normal									
			   if lSelecao
					if nVlrReciboGet == nVlrGet      // modo Selecao e valor recibo igual vlrcomjuros      
					 // nao fazer nada
					 
					elseif nVlrReciboGet == 0        // Ajustar fatura para renegociacao ou zerar mensalidade internet	
					   nVlrRecibo     := 0											
						xVlrRecibo[nY] := nVlrRecibo  // Ajusta novo valor do recibo no array da selecao 					
					elseif nVlrReciboGet > nVlrGet   // modo Selecao e valor recibo maior que vlrcomjuros, necessario ajuste proporcional
						nPercentual  := ((nVlrReciboGet / nVlrGet ) * 100 ) - 100
						nVlrRecibo   := Round(xVlrRecibo[nY],2) 					
						nVlrRecibo   += Round((nVlrRecibo * nPercentual ) / 100, 2)
						nSomaParcial += nVlrRecibo							
						
						if nY == nLenSelecao        // Ultimo registro
							nVlrRecibo  += ( nVlrReciboGet - nSomaParcial )
						endif							
						xVlrRecibo[nY] := nVlrRecibo // Ajusta novo valor do recibo no array da selecao 					
						
					elseif nVlrReciboGet < nVlrGet 
						nVlrRecibo   := Round(xVlrRecibo[nY],2) 													
						nSomaParcial += nVlrRecibo
						
						if nY == nLenSelecao .OR. nSomaParcial >= nVlrReciboGet      // Ultimo registro
							nVlr         := nVlrRecibo
							nVlrComJuros := nVlr
							nVlrRecibo   -= ( nSomaParcial - nVlrReciboGet )																
							Mensagem("Aguarde, Ajustando registro parcial.")
							lSucesso     := LancaParcial( cDocnr, nRecno, nVlr, nVlrRecibo, nVlrComJuros, dDataPag, lLancarJurosNaoPago, lSucesso, lAjustarValorOriginal )						
						endif		
						xVlrRecibo[nY]  := nVlrRecibo // Ajusta novo valor do recibo no array da selecao					
						if nSomaParcial >= nVlrReciboGet						   
							Asize( xDocnr, nY)
							Asize( xVlrRecibo, nY)
							Asize( xObs, nY )
							nLenSelecao := nY
						endif														
					endif														
				endif				
			endif
         
         /*
         AlertaPy( ;
         TrimStr(nVlrGet) + ";" + ;
         TrimStr(nVlrReciboGet) + ";" + ;
         TrimStr(nVlrRecibo) + ";" + ;
         TrimStr(nVlr) + ";" )
         */
      
				
			if !lLancarJurosNaoPago	// Recibo Normal
				lSucesso := AjustaReceber( nRecno, nVlrRecibo, xHist, nVlr )						
				cCodi    := Recemov->Codi
				cFatu    := Recemov->Fatura
				cNome    := Receber->Nome
				cEnde    := Receber->Ende
				cCida    := Receber->Cida
				cVcto    := Dtoc(Recemov->Vcto)
				nMoeda   := 1
				
				if nLenSelecao == 1  // Mesmo usando modo selecao, somente 1 registro?
				   lSelecao := FALSO // Impressao normal
				endif	
				
				if lSelecao				
					// nValorDoRecibo := iif( nVlrRecibo == 0, nVlrRecibo, Atotal(xVlrRecibo))	
					// nValorDoRecibo := iif( nVlrReciboGet > nValorDoRecibo, nVlrReciboGet, nValorDoRecibo)	
					nValorDoRecibo := nVlrReciboGet					
				   cVlr           := AllTrim( Tran( nValorDoRecibo,'@E 999,999,999,999.99'))
					cVlrLog        := AllTrim( Tran( xVlrRecibo[nY],'@E 999,999,999,999.99'))
					cValor         := Extenso( nValorDoRecibo, nMoeda, 3, 132 )					
				else
					cVlr           := AllTrim( Tran( nVlrRecibo, '@E 999,999,999,999.99'))
				   cVlrLog        := cVlr 
					cValor         := Extenso( nVlrRecibo, nMoeda, 3, 80 )
				endif
				
				aLog := {}
				Aadd( aLog, oAmbiente:cTipoRecibo )
				Aadd( aLog, cCodi )
				Aadd( aLog, cNome)
				Aadd( aLog, cDocnr )
				Aadd( aLog, cVcto )
				Aadd( aLog, Time())
				if oAmbiente:cTipoRecibo == "RECBCO" .OR. oAmbiente:cTipoRecibo == "RECOUT"
					Aadd( aLog, Dtoc(dDeposito))
				else
					Aadd( aLog, Dtoc(Date()))
				endif
				Aadd( aLog, oAmbiente:xUsuario + Space( 10 - Len( oAmbiente:xUsuario )))
				Aadd( aLog, cCaixa )
				Aadd( aLog, Tran( nVlrRecibo,'@E 999,999,999,999.99'))
				Aadd( aLog, (AllTrim(cHist) + Space(1)+ AllTrim(cObs)))
				Aadd( aLog, cEnde )
				Aadd( aLog, cCida )
				Aadd( aLog, cFatu )
				
				if lSelecao
					aAgenda := { cCodi, Date(), "PAG PARCIAL {DOC:" + cDocnr + " - VCTO:" + cVcto + " - PAGO:" + cVlrLog + " - RECIBO COMBO:" + cVlr + "}", cCaixa, oAmbiente:xUsuario, OK }
				else	
					aAgenda := { cCodi, Date(), "PAG PARCIAL {DOC:" + cDocnr + " - VCTO:" + cVcto + " - PAGO:" + cVlrLog + " - RECIBO INDIV:" + cVlr + "}", cCaixa, oAmbiente:xUsuario, OK }
				endif
				while !LogRecibo( aLog    ) ; enddo
				While !LogAgenda( aAgenda ) ; enddo
				
			endif // !lLancarJurosNaoPago	
		next	
	Else // aLog = NIL
		if !Instru80() .OR. !LptOk()
			Recemov->(DbClearRel())
			AreaAnt( Arq_Ant, Ind_Ant )
			Restela( cScreen )
			return lSucesso
		endif
		lSair    := OK
		lSucesso := OK
		cCodi    := aLog[ALOG_CODI]
		cNome    := aLog[ALOG_NOME]
		cDocnr   := aLog[ALOG_DOCNR]
		cVcto    := aLog[ALOG_VCTO]
		cHist    := aLog[ALOG_HIST]
		cEnde    := aLog[ALOG_ENDE]
		cCida    := aLog[ALOG_CIDA]
		cFatu    := aLog[ALOG_FATURA]
		nMoeda   := 1
		cVlr	   := AllTrim( aLog[ALOG_VLR])
		cValor   := Extenso( nVlrRecibo, nMoeda, 2, Larg )
		aAgenda := { cCodi, Date(), "PAG PARCIAL {DOC:" + cDocnr + " - VCTO:" + cVcto + " - PAGO:" + cVlr + "}", cCaixa, oAmbiente:xUsuario, OK }
		LogRecibo( aLog )
		LogAgenda( aAgenda )
	endif // aLog = NIL
	
	if !lLancarJurosNaoPago	// Recibo Normal		
		cTela := Mensagem("Aguarde, Emitindo Recibo.", Cor())
		PrintOn()
		FPrInt( Chr(ESC) + "C" + Chr( 33 ))
		if lSelecao
		   //FPrint( PQ )
			nTamForm := 80
			nRow     :=-1
			SetPrc(0,0)
		else
		   nTamForm := 80
			nRow     := 0
			SetPrc(0,0)		
			Write( nRow+00, 00, Repl("=", nTamForm))
		endif		
		Write( nRow+01, 00, GD + Padc(AllTrim(oAmbiente:xFanta), nTamForm / 2) + CA )
		Write( nRow+02, 00, Padc(XENDEFIR + " - " + XCCIDA + " - " + XCESTA, nTamForm ))
		Write( nRow+03, 00, Repl("-", nTamForm ))
		Write( nRow+04, 00, GD + Padc(cTitulo, nTamForm / 2 ) + CA )
		if lSelecao
			nForCol := 0						
		   for nY := 1 to nLenSelecao
				xVlr := AllTrim( Tran( xVlrRecibo[nY],'@E 999,999,999,999.99'))
				Write( nRow+05, nForCol, PQ + "N§ " + xDocnr[nY] + Space(1) + 'R$ ' + xVlr + NR + _CPI10 )				
				if nY < nLenSelecao
				   nForCol += 30 
				   if nForCol >= 132
   				   nForCol := 0
	   				nRow++
					endif
				endif
			next				
		else
			Write( nRow+05, 00, Padr("N§ " + NG + cDocnr + NR + " VCTO " + NG + cVcto + NR, nTamForm))
			Write( nRow+05, 00, Padl("R$ " + NG + cVlr + NR, nTamForm))
		endif	
		nRow++
		Write( nRow+06, 00, "Recebemos de    : " + NG + cNome + NR )
		Write( nRow+07, 00, "Estabelecido  a : " + NG + AllTrim(cEnde) + if(lSelecao, ' - ' + cCida, '') + NR )
		if lSelecao
		   nRow--
		else	
		   Write( nRow+08, 00, "na Cidade de    : " + NG + cCida + NR )
		endif		
		Write( nRow+10, 00, "A Importancia por extenso abaixo relacionada : " + NG + "R$ " + cVlr + NR )
		Write( nRow+11, 00, NG + Left( cValor, nTamForm ) + NR  )
		Write( nRow+12, 00, NG + Right( cValor, nTamForm ) + NR  )
		Write( nRow+14, 00, "Referente a")
		Write( nRow+15, 00, NG + cHist + NR )
		
		if oAmbiente:cTipoRecibo == "RECBCO" .OR. oAmbiente:cTipoRecibo == "RECOUT"
			Write( nRow+16, 00, NG + AllTrim(cObs) + NR )
		else
		   nRow--
		endif 
		
		if oAmbiente:cTipoRecibo == "RECBCO" .OR. oAmbiente:cTipoRecibo == "RECOUT"
			dDataIMpressao := dDeposito		   
		Else
			dDataIMpressao := Date()			
		endif		      
		Write( nRow+18, 00, NG + Padl(DataExt( dDataImpressao ) + NR, nTamForm))
      FPrint(C18)
		Write( nRow+21, nTamForm / 2 , Repl("-", nTamform/2))
		Write( nRow+22, 00, "1§ VIA - CLIENTE" )
		Write( nRow+22, nTamForm / 2 , oAmbiente:xUsuario )
		Write( nRow+23, 00, Repl("=", nTamForm))
		Write( nRow+24, 00, Padc("ESTE RECIBO NAO QUITA EVENTUAIS DEBITOS/MENSALIDADES ANTERIORES", nTamForm))
		__Eject()
		PrintOff()
		Recemov->(DbSkip(1))
		Recemov->(DbClearRel())
		Recemov->(DbGoTop())
		ResTela( cTela )
	endif // !lLancarJurosNaoPago	
	aLog := NIL
	if lSair
		Exit
	endif	
EndDo
ResTela( cScreen )
AreaAnt( Arq_Ant, Ind_Ant )
return lSucesso

def AjustaReceber( nRecno, nVlrRecibo, xHist, nVlr )
*********************************************************
   LOCAL cStr 

   Recemov->(DbGoto( nRecno))
   cStr := Alltrim( Recemov->Obs)
   iif(len(cStr) != 0, cStr += iif(right(cStr,1) != '.', '. ', ' '), cStr += '')							

   if nVlrRecibo == 0 .AND. nVlr == 0 // .AND. !lSelecao // Zerar fatura?
      if Recemov->(TravaReg())
         Recemov->Obs        := iif(Empty(xHist), cStr + xHist, xHist )
         Recemov->VlrOrigina := Recemov->Vlr
         Recemov->Vlr        := 0
         Recemov->Datapag    := Date()
         Recemov->StPag      := OK
         Recemov->(Libera())
         return OK
      endif
      return FALSO
   endif

   if nVlrRecibo == 0 .AND. nVlr > 0 
      if Recemov->(TravaReg())
         Recemov->Obs        := cStr + xHist // iif(Empty(xHist), cStr + cHist, xHist )
         Recemov->VlrOrigina := Recemov->Vlr
         Recemov->Vlr        := 0
         Recemov->VlrPag     := 0      
         Recemov->Datapag    := Date()
         Recemov->StPag      := OK
         Recemov->(Libera())
         return OK
      endif
      return FALSO
   endif
   if Recemov->(TravaReg())	
      Recemov->VlrPag  := nVlrRecibo
      Recemov->Datapag := Date()
      Recemov->StPag   := OK
      Recemov->(Libera())
      return OK
   endif
   return FALSO
endef   

Function lPodeReciboZerado(nVlr, nVlrComJuros, lSelecao)
********************************************************
LOCAL nNivel  := SCI_PODE_RECIBO_ZERADO
LOCAL lAdmin  := TIniNew(oAmbiente:xUsuario + ".INI"):ReadBool('permissao','usuarioadmin', FALSO)
LOCAL lRetVal := OK

if lSelecao != NIL .AND. lSelecao == OK
	if nVlr < nVlrComJuros
		nVlr := nVlrComJuros		
		Alerta("ERRO: Nao se pode alterar o valor de varios recibos.") 
		return FALSO
	endif	
endif

if !lAdmin   
   if ArredondarParaCima( nVlr ) < nVlrComJuros
      nVlr := IF((lRetVal := PedePermissao(nNivel)), nVlr, nVlrComJuros)		
   endif
endif
Return(lRetVal)

def ArredondarParaCima(nVlr)
****************************
	return(Int(nVlr) + 1) // Arredondar para cima
endef	

function LancaParcial( cDocnr, nRecno, nVlr, nVlrRecibo, nVlrComJuros, dDataPag, lLancarJurosNaoPago, lSucesso, lAjustarValorOriginal )
***************************************************************************************************************************************
LOCAL nContaLetra   := 1
LOCAL cLetraParcial := Chr(Asc(Left( cDocnr,1)) + nContaLetra)
LOCAL cNewDocnr     := cLetraParcial + Right( cDocnr, 8)
LOCAL lRetVal       := OK
LOCAL nVlrAnt       := Recemov->Vlr

while lRetVal
	if Recemov->(!DbSeek( cNewDocnr )) // nao existe?
		lRetVal := FALSO
	else
		cLetraParcial := Chr(Asc(Left( cDocnr,1)) + (++nContaLetra))
		cNewDocnr     := cLetraParcial + Right( cDocnr, 8)
	endif	
enddo

Recemov->(DbGoto( nRecno))
if lAjustarValorOriginal
	if Recemov->(TravaReg())		
		Recemov->VlrOrigina := iif(Recemov->VlrOrigina <= 0, nVlrAnt, Recemov->VlrOrigina) 
		Recemov->Vlr        -= (nVlr - nVlrRecibo)			
		Recemov->(Libera())
	endif
	lSucesso := OK
endif
if DuplicaReg( cLetraParcial, nVlr, nVlrRecibo, nVlrComJuros, dDataPag)
	Recemov->(DbGoto( nRecno))
	if Recemov->(TravaReg())			
		Recemov->VlrOrigina := iif(Recemov->VlrOrigina <= 0, nVlrAnt, Recemov->VlrOrigina ) 
		if nVlrRecibo < Recemov->Vlr			
			Recemov->Vlr        := nVlrRecibo
		endif							
		if !lLancarJurosNaoPago	// Recibo Normal
			Recemov->VlrPag  := nVlrRecibo
			Recemov->Datapag := Date()
			Recemov->StPag   := OK
		endif
		Recemov->(Libera())
	endif
	lSucesso := OK
endif
return lSucesso

function lPrtExtenso( nVlr, nVlrRecibo, lSelecao, nRow, nCol, nLarg, xVlrRecibo)
********************************************************************************
LOCAL nNivel     := SCI_PODE_RECIBO_ZERADO
LOCAL lAdmin     := TIniNew(oAmbiente:xUsuario + ".INI"):ReadBool('permissao','usuarioadmin', FALSO)
LOCAL Arq_Ant    := Alias()
LOCAL Ind_Ant    := IndexOrd()
LOCAL lRetVal    := OK
LOCAL nMoeda     := 1
LOCAL nLinhas    := 1
LOCAL cMsg       := NIL
LOCAL cMsg1      := "ERRO: Percebo que voce usou o modo selecao e o valor nao paga nem o primeiro RECIBO!;A maneira correta de emitir recibo parcial seria individualmente.;De qualquer forma selecionou somente 1 recibo, assim vou quebrar teu galho!;;Voce sabe o que esta fazendo?"
LOCAL cMsg2      := "ERRO: Percebo que voce usou o modo selecao e o valor nao paga nem o primeiro RECIBO!;A maneira correta de emitir recibo parcial seria individualmente.;;Voce sabe o que esta fazendo?"
LOCAL nLenRecibo := 1
LOCAL cHist      := "RENEGOCIACAO EXTRAJUDICIAL. SUBSTITUIDA PELA FATURA" 

IfNil(nLarg, 45)
Write( nRow, nCol, Extenso( If(nVlrRecibo = NIL, nVlr, nVlrRecibo), nMoeda, nLinhas, nLarg))

/*
if lSelecao != NIL .AND. lSelecao == OK
	if nVlrRecibo < nVlr 
	   if nVlrRecibo != 0
	      nVlrRecibo := nVlr
	      Alerta("ERRO: Nao se pode alterar o valor de varios recibos.") 
	      return FALSO
		endif	
	endif
endif	
*/

if lSelecao != NIL .AND. lSelecao == OK
	if nVlrRecibo < nVlr 
	   if nVlrRecibo != 0
		   if nVlrRecibo < xVlrRecibo[1]
				nLenRecibo := Len(xVlrRecibo)
			   cMsg := iif( nLenRecibo <= 1, cMsg1, cMsg2)
				if alerta( cMsg, aYesNo ) == 1
					return OK
				endif	
				nVlrRecibo := nVlr
				return FALSO				
			endif	
		endif	
	endif
endif	

if !lAdmin	
	if nVlrRecibo != NIL .AND. nVlrRecibo == 0
	   nVlrRecibo := IF((lRetVal := PedePermissao(nNivel)), nVlrRecibo, nVlr)	
	endif	
endif
if nVlrRecibo != NIL .AND. lSelecao != NIL .AND. lSelecao == OK
   if nVlrRecibo == 0
		if alerta("Deseja lan‡ar movimento a receber em substituicao a selecao?;  uma ¢tima oportunidade! - (Lancamento semi automatico)", aYesNo ) == 1
			ReceNormal( OK, cCaixa, {Recemov->Codi, nVlr}, cHist)
			AreaAnt( Arq_Ant, Ind_Ant )
		endif  
	endif  
endif
Return(lRetVal)


// if lSelecao != NIL .AND. lSelecao == OK
	// if nVlrRecibo < nVlr
		// Alerta("ERRO: Nao se pode alterar o valor de varios recibos.; CTRL+U restaurar valor.") 
		// return FALSO
	// endif	
// endif
// Return( OK )

*------------------------------------------------------------------------------

Function lValidDep1( dDeposito, cObs )
**************************************
cObs := "EFETUADO DEP BANCO CREDIP EM DATA DE "
cObs += Dtoc( dDeposito ) + '.'
cObs += Space(60-Len(cObs))
Return(OK)

*------------------------------------------------------------------------------

def lValidDep2( dDeposito, cObs )
   cObs := "PAGO EM MAOS A TIAGO TIMOTEO DE OLIVEIRA EM DATA DE "
   cObs += Dtoc( dDeposito ) + '.'
   cObs += Space(60-Len(cObs))
   Return(OK)
endef

*------------------------------------------------------------------------------

def DuplicaReg( cLetraParcial, nVlr, nVlrRecibo, nVlrComJuros, dAtual )
   LOCAL Arq_Ant := Alias()
   LOCAL Ind_Ant := IndexOrd()
   LOCAL xTemp   := FTempName()
   LOCAL aStru   := Recemov->(DbStruct())
   LOCAL nConta  := Recemov->(FCount())
   LOCAL cDocnr  := Recemov->Docnr
   LOCAL cObs    := 'REST FATURA ' + cDocnr
   LOCAL XObs    := 'REST FATURA ' 
   LOCAL xTrim
   LOCAL lRet	  := FALSO
   LOCAL nAt     := 0
   LOCAL aJuro   := {}
   LOCAL xRegistro
   LOCAL cStr
   LOCAL cTrim
   LOCAL xCampo
   LOCAL xType

   hb_default(@dAtual, Date())
   xTrim := AllTrim(Recemov->Obs)
   nAt   += RAt(AllTrim(xObs), xTrim)
   if nAt > 0
     xTrim := AllTrim(StrTran(xTrim, SubStr(xTrim, nAt, nAt + 21), ''))
   endif
   xRegistro := Recemov->(Recno())
   DbCreate( xTemp, aStru )
   Use (xTemp) Exclusive Alias xAlias New
   xAlias->(DbAppend())
   For nField := 1 To nConta
      xType  := xAlias->(FieldType( nField ))
      // xCampo := xAlias->(FieldName( nField ))
      // if xCampo != "ID"
      if xType != "+"
         xAlias->(FieldPut( nField, Recemov->(FieldGet( nField ))))
      endif   
   Next
   if Recemov->(Incluiu())   
      For nField := 1 To nConta
         xType  := xAlias->(FieldType( nField ))
         // xCampo := xAlias->(FieldName( nField ))
         // if xCampo != "ID"
         if xType != "+"
            Recemov->(FieldPut( nField, xAlias->(FieldGet( nField ))))
         endif   
      Next
      Recemov->VlrOrigina := 0
      Recemov->Docnr   := cLetraParcial + Right( cDocnr, 8)
      Recemov->Vlr     := (nVlr - nVlrRecibo)
      Recemov->VlrPag  := 0
      Recemov->DataPag := Ctod("//")
      Recemov->StPag   := FALSO	
      //Recemov->Vcto  := IF( nVlr == nVlrComJuros, dAtual, Recemov->Vcto)
      Recemov->Vcto    := Recemov->Vcto
      cStr             := xTrim ; iif(len(cStr)!= 0, cStr += iif(right(cStr,1) != '.', '. ' + cObs, ' ' + cObs), cStr += cObs)						
      Recemov->Obs     := cStr	
      aJuro := CalcCmJuros( 1 , NIL , Recemov->Vlr, Recemov->Vcto, dAtual)
      Recemov->Juro      := aJuro[1]
      Recemov->JuroDia   := aJuro[2]
      Recemov->JuroTotal := aJuro[3]
      Recemov->(Libera())
      lRet := OK	
   endif
   xAlias->(DbCloseArea())
   Ferase(xTemp)
   AreaAnt( Arq_Ant, Ind_Ant )
   Recemov->(DbGoto( xRegistro ))
   Return( lRet )
endef   

*------------------------------------------------------------------------------

def FoneTroca()
   LOCAL nConta := 0

   ErrorBeep()
   if !Conf("Pergunta: Tem absoluta certeza?")
      Return
   endif
   oMenu:Limpa()
   Area("RECEBER")
   Receber->(DbgoTop())
   While !Eof()
      cFone 	 := TrocaFone( Receber->Fone )
      cFax		 := TrocaFone( Receber->Fax )
      cFone1	 := TrocaFone( Receber->Fone1 )
      cFone2	 := TrocaFone( Receber->Fone2 )
      cFoneAval := TrocaFone( Receber->FoneAval )
      if Receber->(TravaReg())
         Receber->Fone		:= cFone
         Receber->Fax		:= cFax
         Receber->Fone1 	:= cFone1
         Receber->Fone2 	:= cFone2
         Receber->FoneAval := cFoneAval
         Receber->(Libera())
         Receber->(DbSkip(1))
      endif
   EnddO
endef   

*------------------------------------------------------------------------------

Function TrocaFone( cFone )
***************************
//(0069)451-2286
if Left(cFone, 6) == "(0069)" .AND. ;
	SubStr( cFone, 10,1) == "-"  .AND. ;
	SubStr( cFone, 07,1) != "9" .AND. ;
	SubStr( cFone, 07,1) != "8"
	cTroca := "(69)93" + Substr(cFone,7,8)
	? cFone, cTroca

ElsEif Left(cFone, 6) == "(0069)" .AND. ;
	SubStr( cFone, 10,1) = "-" .AND. ;
	SubStr( cFone, 07,1) = "9" .OR. ;
	SubStr( cFone, 07,1) = "8"
	cTroca := "(69)99" + Substr(cFone,7,8)
	? cFone, cTroca

Elseif Left(cFone, 6) == "(069 )" .AND. ;
	SubStr( cFone, 10,1) == "-"  .AND. ;
	SubStr( cFone, 07,1) != "9" .AND. ;
	SubStr( cFone, 07,1) != "8"
	cTroca := "(69)93" + Substr(cFone,7,8)
	? cFone, cTroca

ElsEif Left(cFone, 6) == "(069 )" .AND. ;
	SubStr( cFone, 10,1) = "-" .AND. ;
	SubStr( cFone, 07,1) = "9" .OR. ;
	SubStr( cFone, 07,1) = "8"
	cTroca := "(69)99" + Substr(cFone,7,8)
	? cFone, cTroca

ElsEif Left(cFone, 6) == "(0693)" .AND. ;
	SubStr( cFone, 10,1) = "-"
	cTroca := "(69)93" + Substr(cFone,7,8)
	? cFone, cTroca
ElsEif Left(cFone, 6) == "(0699)" .AND. ;
	SubStr( cFone, 10,1) = "-"
	cTroca := "(69)99" + Substr(cFone,7,8)
	? cFone, cTroca
ElsEif Left(cFone, 6) == "(0698)" .AND. ;
	SubStr( cFone, 10,1) = "-"
	cTroca := "(69)98" + Substr(cFone,7,8)
	? cFone, cTroca
Else
	 cTroca := cFone
	 Qout(cFone, "Sem troca")
endif
Return( cTroca )

function SeekLog(xTodos, aTodos, nIndex, lRecepago)
***************************************************
LOCAL xLog		 := 'recibo.log'
LOCAL Arq_Ant	 := Alias()
LOCAL Ind_Ant	 := IndexOrd()
LOCAL nLen
LOCAL cDocnr
LOCAL nVlrDevido
LOCAL nJurosPago
LOCAL nSaldo
LOCAL x
LOCAL cFull := ""

if nIndex == NIL
	nLen  := Len( oRecePosi:aTodos )
	nIni  := 1
else
	nLen := nIndex
	nIni := nIndex
endif	

for x := nIni To nLen	
	if oAmbiente:lReceber // consulta titulos a receber
		if !oReceposi:xTodos[x,XTODOS_ATIVO] // Registros do RECEBIDO.DBF
		   cFull := cSeekRecebido(x)
			Loop
		endif
		cFull := cSeekRecibo(x)
	else				  // consulta titulos recebidos		
		cSeekNil(x)
	endif
	if oReceposi:nOrdem == 3 .OR. lRecepago != NIL
		oRecePosi:aAtivoSwap[x]  := OK
		oRecePosi:aAtivo[x]		 := OK
	endif
next

if oAmbiente:lK_Ctrl_Ins
	K_Ctrl_Ins()
endif

AreaAnt( Arq_Ant, Ind_Ant )
return cFull

function cSeekRecebido(x)
*************************
	LOCAL nPrincipal := oReceposi:xTodos[x,XTODOS_VLR]
	LOCAL nSaldo	  := 0
	LOCAL nJurosPago := (oReceposi:xTodos[x,XTODOS_SOMA] - nPrincipal)
	LOCAL nAtraso	  := oReceposi:xTodos[x,XTODOS_ATRASO]	
	LOCAL cFull   	  := strFormatRecebido({x, nAtraso, nJurosPago, nSaldo})	
	LOCAL cDocnr     := oReceposi:xTodos[x,XTODOS_DOCNR]
	
	oReceposi:aHistRecibo[x]          := oReceposi:xTodos[x,XTODOS_OBS]
	oReceposi:aUserRecibo[x]          := oReceposi:xTodos[x,XTODOS_OBS]
	oReceposi:aReciboImpresso[x]      := FALSO			
	oRecePosi:aAtivoSwap[x]           := FALSO
	oRecePosi:aAtivo[x]		          := FALSO
	oRecePosi:aDatapag[x]		       := oReceposi:xTodos[x,XTODOS_DATAPAG]
	oRecePosi:nAberto 		          += nSaldo
	oRecePosi:nPrincipal    	       += nPrincipal
	oRecePosi:nRecebido	     	       += oReceposi:xTodos[x,XTODOS_SOMA]
	oRecePosi:nJurosPago 	          += nJurosPago
	oRecePosi:nQtdDoc++
	oReceposi:aTodos[x]		          := cFull			
	oReceposi:alMulta[x]					 := FALSO
	oReceposi:xTodos[x,XTODOS_MULTA]	 := oReceposi:xTodos[x,XTODOS_SOMA]
	oReceposi:xTodos[x,XTODOS_JUROS]	 := nJurosPago
	oReceposi:xTodos[x,XTODOS_SOMA]	 := nSaldo
	return cFull
	
function cSeekNil(x)
*******************
	LOCAL cDocnr     := oReceposi:xTodos[x,XTODOS_DOCNR]
	
	Area("RECIBO")
	Recibo->(Order( RECIBO_DOCNR))
	oRecePosi:aAtivo[x]		:= FALSO
	oRecePosi:aAtivoSwap[x] := FALSO
	if Recibo->(DbSeek(cDocnr))
		oRecePosi:aAtivoSwap[x]      := OK
		oRecePosi:aAtivo[x]		     := OK
		oRecePosi:aHistRecibo[x]     := Recibo->Hist
		oRecePosi:aUserRecibo[x]     := AllTrim(Recibo->Usuario) + '/' + Recibo->Hora
		oReceposi:aReciboImpresso[x] := OK				
	endif
	return NIL	
	
function cSeekRecibo(x)
**********************
	LOCAL nPrincipal := oReceposi:xTodos[x,XTODOS_VLR]
	LOCAL nJurosPago := 0
	LOCAL nSaldo	  := 0
	LOCAL nVlrDevido := 0
	LOCAL nAtraso    := 0
	LOCAL cFull	     := oReceposi:sTrFormataATodos(x) 
	LOCAL cDocnr     := oReceposi:xTodos[x,XTODOS_DOCNR]
	
	Area("RECIBO")
	Recibo->(Order( RECIBO_DOCNR))
	if Recibo->(DbSeek( cDocnr ))
		While Recibo->Docnr = cDocnr
			if Recibo->Vlr == 0 // 13.02.2017 Recibo zerado para substituicao fatura e/ou desconto total 
				nVlrDevido              := 0
				oRecePosi:aAtivoSwap[x] := FALSO
				oRecePosi:aAtivo[x]		:= FALSO
				oRecePosi:nQtdDoc++
			else
				nVlrDevido := (nPrincipal - Recibo->Vlr)
				if nVlrDevido <= 0
					nJurosPago              := ( Recibo->Vlr - nPrincipal)
					oRecePosi:aAtivoSwap[x] := FALSO
					oRecePosi:aAtivo[x]		:= FALSO
					oRecePosi:nQtdDoc++
					oRecePosi:nRecebido		+= Recibo->Vlr
					oRecePosi:nJurosPago 	+= nJurosPago
				else
					nSaldo						:= nVlrDevido
					oRecePosi:nAberto 		+= nSaldo
				endif
			endif
			
			nAtraso		:= Atraso( Recibo->Data, oReceposi:xTodos[x,XTODOS_VCTO])  // 26.01.2017						
			cFull 		:= strFormatRecebido({x, nAtraso, nJurosPago, nSaldo})

			oReceposi:aTodos[x]		          := cFull
			oReceposi:alMulta[x]			     	 := FALSO
			oRecePosi:aDatapag[x]		       := oReceposi:xTodos[x,XTODOS_DATAPAG]
			oReceposi:xTodos[x,XTODOS_MULTA]	 := Recibo->Vlr
			oReceposi:xTodos[x,XTODOS_JUROS]	 := nJurosPago
			oReceposi:xTodos[x,XTODOS_SOMA]	 := nSaldo
			oReceposi:aHistRecibo[x]          := Recibo->Hist
			oReceposi:aUserRecibo[x]          := AllTrim(Recibo->Tipo) + '/' + AllTrim(Recibo->Usuario) + '/' + Recibo->Hora
			oReceposi:aReciboImpresso[x]      := OK				
			oRecePosi:nPrincipal 	          += nPrincipal	
			Recibo->(DbSkip(1))
		EndDo
	endif
	return cFull

*------------------------------*	
def strFormatRecebido(aParam)
*------------------------------*
   LOCAL cFull := ""
	
	cFull += Left( oReceposi:aTodos[aParam[1]], 24) + Space(1)
	cFull += StrZero(aParam[2], 4 )
	cFull += SubStr( oReceposi:aTodos[aParam[1]], 30, 22) + Space(1)
	cFull += Dtoc( Recibo->Data ) + Space(1)
	cFull += Tran(aParam[3],   "@E 9,999.99") + Space(1)
	cFull += Tran(Recibo->Vlr, "@E 99,999.99") + Space(1)
	cFull += Tran(aParam[4],   "@E 999,999.99") + Space(1)
	cFull += oReceposi:xTodos[aParam[1],XTODOS_OBS]
	return cFull
enddef	

Function AchaCor(nCor, nPos)
	return((aCor:= Pattern())[Ascan(aCor[nCor,1]), nPos]) 

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

def AscanCor(nPos)	  
***********************
   LOCAL aPattern := AllColors()
   LOCAL nCor     := int(oAmbiente:CorMenu/16)+1
   LOCAL nX
   LOCAL nY

   //nX := Ascan( aPattern, {|aPattern|aPattern[11] == xCor })
   return aPattern[nCor, nPos]

   for nX := 1 To 16
      for nY := 1 To 16
         if nCor = aPattern[nX,nY] 
            return( aPattern[nX,nPos])
         endif
      next
   next
   return( 0 )
endef

def Pattern() 
*************
   LOCAL aPattern := {}
   LOCAL nCorIni
   LOCAL nCorFim
   LOCAL nCorHKLightBar
   LOCAL nCorHotKey
   LOCAL nCorDesativada
   LOCAL nAzul
   LOCAL x

   For x:= 0 To 255 step 16
      nCorIni        := x      
      nCorFim        := x + 15 
      nCorHKLightBar := x + 12 // encarnado
      nCorHotKey     := x + 10 // verdola
      nCorDesativada := x + 08 // cinza
      
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
      Aadd( aPattern, { /* 01 */ nCorIni,;
                        /* 02 */ nCorFim,;
                        /* 03 */ nCorHKLightBar,;
                        /* 04 */ nCorHotKey,;
                        /* 05 */ nCorDesativada,;							
                        /* 06 */ nBlack,;
                        /* 07 */ nBlue,;          
                        /* 08 */ nGreen,;        
                        /* 09 */ nCyan,;          
                        /* 10 */ nRed,;           
                        /* 11 */ nMagenta,;
                        /* 12 */ nBrown,;         
                        /* 13 */ nWhite,;         
                        /* 14 */ nGray,;          
                        /* 15 */ nBrightBlue,;    
                        /* 16 */ nBrightGreen,;   
                        /* 17 */ nBrightCyan,;    
                        /* 18 */ nBrightRed,;     
                        /* 19 */ nBrightMagenta,; 	
                        /* 20 */ nYellow,;        
                        /* 21 */ nBrightWhite})
   next
   return ( aPattern )
endef

Function AscanCorHKLightBar(nCor)	  
*********************************
LOCAL aPattern := Pattern()
LOCAL nX

For nX := 1 To Len( aPattern)
   if nCor >= aPattern[nX,1] .AND. nCor <= aPattern[nX,2]
	   return( aPattern[nX,3])
	endif
next
return( 0 )
  
Function AscanCorHotKey(nCor)	  
***************************
LOCAL aPattern := Pattern()
LOCAL nX

For nX := 1 To Len( aPattern)
   if nCor >= aPattern[nX,1] .AND. nCor <= aPattern[nX,2]
	   return( aPattern[nX,4])
	endif
next
return( 0 )

Function AscanCorDesativada(nCor)	  
*********************************
LOCAL aPattern := Pattern()
LOCAL nX

For nX := 1 To Len( aPattern)
   if nCor >= aPattern[nX,1] .AND. nCor <= aPattern[nX,2]
	   return( aPattern[nX,5])
	endif
next
return( 0 )

Function AscanCorMenu(nCor)	  
***************************
LOCAL aPattern := Pattern()
LOCAL nX

For nX := 1 To Len( aPattern)
   if nCor >= aPattern[nX,1] .AND. nCor <= aPattern[nX,2]
	   return( aPattern[nX,5])
	endif
next
return( 0 )

Function AscanCorBlue(nCor)	  
***************************
LOCAL aPattern := Pattern()
LOCAL nX

For nX := 1 To Len( aPattern)
   if nCor >= aPattern[nX,1] .AND. nCor <= aPattern[nX,2]
	   return( aPattern[nX,15])
	endif
next
return( 0 )

def FichaAtendimento(cCaixa, cVendedor, xTodos, nCurElemento)
**************************************************************
   LOCAL Arq_Ant	 := Alias()
   LOCAL Ind_Ant	 := IndexOrd()
   LOCAL cScreen	 := SaveScreen()
   LOCAL GetList	 := {}
   LOCAL cVisita	 := Space(60)
   LOCAL cObs		 := Space(60)
   LOCAL cTitulo	 := "FICHA DE ATENDIMENTO/ATIVACAO"
   LOCAL lEject    := true
         cCodi 	 := Space(05)

   Area("Receber")
   Receber->(Order( RECEBER_CODI))
   WHILE OK
      oMenu:Limpa()

      if xTodos = NIL
         dData   := Date()
         cHora   := Time()
         cVisita := AllTrim(cVisita) + Space(60-Len(AllTrim(cVisita)))
         cObs	  := AllTrim(cObs)	 + Space(60-Len(AllTrim(cObs)))
      Else
         cCodi   := xTodos[nCurElemento,1]
         dData   := xTodos[nCurElemento,2]
         cHora   := xTodos[nCurElemento,3]
         cVisita := Left(xTodos[nCurElemento,4],60)
      endif
      MaBox( 10, 00, 14, 80, 'IMPRESSAO ' +cTitulo )
      @ 11, 01 Say "Codigo Cliente..:" Get cCodi   Pict PIC_RECEBER_CODI Valid RecErrado( @cCodi,, Row(), Col()+1)
      @ 12, 01 Say "Motivo Visita...:" Get cVisita Pict "@!" Valid !Empty(cVisita)
      @ 13, 01 Say "Observacoes.....:" Get cObs    Pict "@!"
      Read
      if LastKey() = ESC
        AreaAnt( Arq_Ant, Ind_Ant )
        ResTela( cScreen )
        Return
      endif
      if Conf("Pergunta: Confirma Impressao ?")      
         if !(Instru80()) .or. !(LptOk())
            loop
         endif
         cTela := Mensagem("Aguarde, Imprimindo Ficha.", Cor())
         PrintOn()
         FPrInt( Chr(ESC) + "C" + Chr( 33 ))
         SetPrc(0,0)
         nRow := 1
         cVisita := AllTrim(cVisita)
         
         if Len( cVisita) > 0
            cVisita += IF(Right(cVisita,1) = '.', ' ','. ')
         endif
         
         cObs	  := AllTrim(cObs)
         if Len( cObs) > 0
            cObs	  += IF(Right(cObs,1) = '.', '','.')
         endif
         
         Write( nRow+00, 00, Repl("=",80))
         Write( nRow+01, 00, GD + Padc(AllTrim(oAmbiente:xFanta), 40) + CA )
         Write( nRow+02, 00, Padc( XENDEFIR + " - " + XCCIDA + " - " + XCESTA, 80 ))
         Write( nRow+03, 00, Repl("-",80))
         Write( nRow+04, 00, GD + Padc( cTitulo, 40) + CA )
         Write( nRow+06, 00, "DATA     : " + NG + Dtoc(dData) + NR)
         Write( nRow+06, 58, "HORA   : " + NG + cHora + NR)
         Write( nRow+07, 00, "NOME     : " + NG + Receber->Nome + NR )
         Write( nRow+07, 58, "FONE   : " + NG + Receber->Fone + NR )
         Write( nRow+08, 00, "ENDERECO : " + NG + Receber->Ende + NR )
         Write( nRow+08, 58, "BAIRRO : " + NG + Left(AllTrim(Receber->Bair),17) + NR )
         Write( nRow+09, 00, "CIDADE   : " + NG + Receber->Cida + NR )
         Write( nRow+09, 58, "FONE   : " + NG + Receber->Fax + NR )
         Write( nRow+11, 00, "MOTIVO VISITA : " + NG + cVisita + NR )
         Write( nRow+12, 00, "OBSERVACOES   : " + NG + cObs + NR )
         Write( nRow+14, 00, "FOI ATENDIDA RECLAMACAO ?: " + NG + "___________" + NR )
         Write( nRow+14, 48, "INTERNET FUNCIONANDO ?: " + NG + "___________" + NR )
         Write( nRow+16, 00, "NOME/ASSINATURA  : " + NG + Repl("_",60) + NR )
         Write( nRow+18, 00, "RELATORIO TECNICO: " + NG + Repl("_",60) + NR )
         Write( nRow+20, 00, "DATA ATIVACAO    : " + NG + Dtoc(Receber->Data) + NR)
         Write( nRow+20, 48, "ATENDIDO POR: " + NG + "_____________________" + NR )
         Write( nRow+21, 00, Repl("-",80))
         Write( nRow+22, 00, "O CLIENTE declara expressamente e garante, para todos os fins de direito, que as")
         Write( nRow+23, 00, "informacoes  aqui  prestadas sao  verdadeiras, e possui  capacidade  plena  pela")
         Write( nRow+24, 00, "utilizacao dos servicos prestados pela CONTRATADA.")
         Write( nRow+25, 00, Repl("=",80))
         Write( nRow+26, 00, "Impresso por: " + cCaixa + ' ' + cVendedor)         
         __Eject()
         PrintOff()
         if xTodos = NIL
            if Agenda->(Incluiu())
               Agenda->Codi	 := cCodi
               Agenda->Data	 := dData
               Agenda->Hora	 := cHora
               Agenda->Hist	 := cVisita + cObs
               Agenda->Caixa	 := cCaixa
               Agenda->Usuario := cVendedor
               Agenda->(Libera())
            endif
         endif
      endif
   EndDo
   ResTela( cScreen )
   AreaAnt( Arq_Ant, Ind_Ant )
   return nil
endef   

Function AchaUltVcto( cCodi, dFim )
***********************************
LOCAL cScreen	  := SaveScreen()
LOCAL GetList	  := {}
LOCAL Arq_Ant	  := Alias()
LOCAL Ind_Ant	  := IndexOrd()
LOCAL nRecno     := Recemov->(Recno())
LOCAL aReg       := {}

Recemov->(Order(RECEMOV_CODI))
if Recemov->( DbSeek( cCodi ))
   While Recemov->Codi = cCodi
		Aadd( aReg, Recemov->Vcto)
		Recemov->(DbSkip( 1 ))
	enddo	
endif
if len( aReg) > 0
   Asort( aReg,,, {|x,y|y < x })
	dFim :=  aReg[1]
endif
AreaAnt( Arq_Ant, Ind_Ant )
return OK

*------------------------------------------------------------------------------

def DuplicaDocnr()
*------------------*
	LOCAL cScreen := SaveScreen()
	LOCAL Arq_Ant := Alias()
	LOCAL Ind_Ant := IndexOrd()
	LOCAL xTemp   := FTempName()
	LOCAL aStru   := Recemov->(DbStruct())
	LOCAL nConta  := Recemov->(FCount())
	LOCAL cCodi
	LOCAL xRegistro
	LOCAL xRegLocal
   LOCAL xCampo
   LOCAL xType

	ErrorBeep()
	if !Conf('Pergunta: Duplicar registro sob o cursor ?')
		Return( FALSO )
	endif
	xRegistro := Recemov->(Recno())
	DbCreate( xTemp, aStru )
	Use (xTemp) Exclusive Alias xAlias New
	xAlias->(DbAppend())   
	for nField := 1 To nConta      
      xType  := xAlias->(FieldType( nField ))
      if xType != "+"
         xAlias->(FieldPut( nField, Recemov->(FieldGet( nField ))))
      endif
	next
	if Recemov->(Incluiu())
		for nField := 1 To nConta
         xType  := xAlias->(FieldType( nField ))
         if xType != "+"
            Recemov->(FieldPut( nField, xAlias->(FieldGet( nField ))))
         endif
		next
		xRegLocal := Recemov->(Recno())
		Recemov->(Libera())
	endif
	xAlias->(DbCloseArea())
	Ferase(xTemp)
	AreaAnt( Arq_Ant, Ind_Ant )
	Recemov->(DbGoto( xRegistro ))
	Return( OK )
endef
	
*:------------------------------------------------------------------------------

def DuplicaAgenda()
   LOCAL cScreen := SaveScreen()
   LOCAL Arq_Ant := Alias()
   LOCAL Ind_Ant := IndexOrd()
   LOCAL xTemp   := FTempName()
   LOCAL aStru   := Agenda->(DbStruct())
   LOCAL nConta  := Agenda->(FCount())
   LOCAL xCampo
   LOCAL xType
   LOCAL cCodi
   LOCAL xRegistro
   LOCAL xRegLocal

   ErrorBeep()
   if !Conf('Pergunta: Duplicar registro sob o cursor ?')
      Return( FALSO )
   endif
   xRegistro := Agenda->(Recno())
   DbCreate( xTemp, aStru )
   Use (xTemp) Exclusive Alias xAlias New
   xAlias->(DbAppend())
   For nField := 1 To nConta
      xType  := Agenda->(FieldType( nField ))
      // xCampo := Agenda->(FieldName( nField ))
      // if xCampo != "ID"
      if xType != "+"
         xAlias->(FieldPut( nField, Agenda->(FieldGet( nField ))))
      endif	
   Next
   if Agenda->(Incluiu())
      For nField := 1 To nConta
         xType  := Agenda->(FieldType( nField ))
         // xCampo := Agenda->(FieldName( nField ))         
         // if xCampo != "ID"
         if xType != "+"
            Agenda->(FieldPut( nField, xAlias->(FieldGet( nField ))))
         endif	
      Next
      xRegLocal := Agenda->(Recno())
      Agenda->(Libera())
   endif
   xAlias->(DbCloseArea())
   Ferase(xTemp)
   AreaAnt( Arq_Ant, Ind_Ant )
   Agenda->(DbGoto( xRegistro ))
   return( OK )
endef   

*:------------------------------------------------------------------------------

Function NewPosiAgeInd( cCodi, nRecno, lRecarregar )
****************************************************
PRIVA oReceposi := TReceposiNew(07, 00, MaxRow()-4, MaxCol())
PosiAgeInd( cCodi, nRecno, lRecarregar )
oAmbiente:PosiAgeInd := FALSO
return NIL

Function PosiAgeInd( cCodi, nRecno, lRecarregar )
*********************************************
LOCAL GetList	:= {}
LOCAL cScreen	:= SaveScreen()
LOCAL nConta	:= 0
LOCAL dCalculo := Date()
LOCAL cString	:= ""
LOCAL lPilha
LOCAL nValorTotal
LOCAL nTotalGeral
LOCAL aCabec
LOCAL nJuros
LOCAL cTela
LOCAL oBloco
LOCAL cRegiao
LOCAL dIni
LOCAL dFim
LOCAL Col
LOCAL cFilter
FIELD Regiao
FIELD Vcto
FIELD Juro
FIELD Codi
FIELD Docnr
FIELD Emis
FIELD Vlr

lPilha := cCodi != NIL
WHILE OK		
 	oReceposi:RenewVar()	
	oAmbiente:PosiAgeInd := OK
	dIni		:= Date()-30
	dFim		:= Date()
	dCalculo := Date()
	if !lPilha
		oMenu:Limpa()
		cCodi 	:= Space(05)
		MaBox( 14, 45, 16, 75 )
		@ 15, 46 Say "Cliente......:" Get cCodi    Pict PIC_RECEBER_CODI Valid RecErrado( @cCodi )
		Read
		if LastKey() = ESC
			DbClearRel()
			ResTela( cScreen )
			Exit
		endif
	endif
	Area("Agenda")
	Agenda->(Order( AGENDA_CODI_DATA ))
	if Agenda->(!DbSeek( cCodi ))
		Nada()
		if lPilha
			DbClearRel()
			ResTela( cScreen )
			Exit			
		Else
			Loop
		endif
	endif	
	oBloco  := {|| Field->Codi == cCodi }
	cFilter := 'Field->Codi == cCodi.'	
   Col                  := 12
   nConta               := 0
   cTela                := Mensagem("Aguarde... ", Cor())
   Try Eval( oBloco ) .AND. !Eof() .AND. !Tecla_ESC()
		if nConta > 65535
			Alerta("Erro: Impossivel mostrar mais do que 65535 registros.")
			Exit
		endif
		nConta++
		cSep		:= '|'
		cAgenda1 := Dtoc(Agenda->Data)
		cAgenda2 := Agenda->Hora
		cAgenda3 := Agenda->Usuario
		cAgenda4 := Agenda->Hist
		
		cString1 := StrZero( nConta, 3)
		cString1 += cSep
		cString1 += cAgenda1
		cString1 += cSep
		cString1 += cAgenda2
		cString1 += cSep
		cString1 += Left(cAgenda3,6)
		cString1 += cSep
		cString1 += cAgenda4
		
		Aadd( oRecePosi:aAtivo, OK )
      Aadd( oRecePosi:aAtivoSwap, OK )
      Aadd( oRecePosi:aRecno, Agenda->(Recno()))
		Aadd( oReceposi:aCodi, cCodi )
		Aadd( oReceposi:aTodos, cString1 )
		Aadd( oReceposi:xTodos, {cCodi, Agenda->Data, Agenda->Hora, Agenda->Hist})
		Agenda->(DbSkip(1))
		oMenu:ContaReg()
	EndTry
	//m6_SetFilter()
	restela( cTela )
	if Len( oReceposi:aTodos ) > 0
		oReceposi:PosiAgeInd  := OK
		oMenu:StatInf()
		oMenu:ContaReg(nConta)
		oReceposi:CloneVarColor()
		
		if lRecarregar != NIL .AND. !lRecarregar
			return
		endif
		
		MaBox( 00, 00, 06, MaxCol())		
		oRecePosi:aBottom 	 := oReceposi:BarraSoma()	
		oRecePosi:cTop := " # |DATA    |HORA    |USER  |OBSERVACOES AGENDADA"		
		oRecePosi:cTop += Space( MaxCol() - Len( cString ))
		oRecePosi:Redraw_()
		__Funcao( 0, 1, 1 )
		lPageCircular := FALSO	
		oRecePosi:aChoice_(oReceposi:aTodos, oRecePosi:aAtivo, "__Funcao", lPageCircular )		
		oRecePosi:PosiAgeInd := FALSO
		oAmbiente:PosiAgeInd := FALSO
		oReceposi:Reset()
	endif
	ResTela( cScreen )
	if lPilha		
		Return
	endif
EndDo

*:------------------------------------------------------------------------------

function NewPosiAgeAll( lRecarregar )
*************************************
PRIVA oRecePosi	 := TReceposiNew(07, 00, MaxRow()-4, MaxCol())
PosiAgeAll( lRecarregar )
oAmbiente:PosiAgeALL := FALSO
return	
	
function PosiAgeAll( lRecarregar )
**********************************
LOCAL GetList	:= {}
LOCAL cScreen	:= SaveScreen()
LOCAL nConta	:= 0
LOCAL cString	:= ""
LOCAL cAgenda1 := ""
LOCAL cAgenda2 := ""
LOCAL cAgenda3 := ""
LOCAL cCodi    := Space(05)
LOCAL NewTodos
LOCAL cSep
LOCAL xLen
LOCAL cTela
LOCAL oBloco
STATI dIni     
STATI dFim     
STATI nOrdem
FIELD Data
FIELD Codi
FIELD Hist

lPilha := lRecarregar != NIL
WHILE OK
	oRecePosi:RenewVar()
	oAmbiente:PosiAgeAll := OK
	if !lPilha
		dIni := Date()-30
		dFim := Date()
		MaBox( 15, 45, 18, 75 )
		@ 16, 46 Say "Data Inicial.:" Get dIni Pict "##/##/##"
		@ 17, 46 Say "Data Final...:" Get dFim Pict "##/##/##" Valid IF((Empty(dIni) .OR. dFim < dIni), ( ErrorBeep(), Alerta("Ooops!: Entre com uma data valida!"), FALSO ), OK ) 
		Read
		if LastKey() = ESC
			DbClearRel()
			ResTela( cScreen )
			Exit
		endif
		aMenu := {'Data {Ultimo Agendamento}','Data {Todos Agendamentos}','Codigo {Ultimo Agendamento}','Codigo {Todos Agendamentos}',;
		  		    'Data {Ultimo Agendamento} - Ultimos por primeiro','Data {Todos Agendamentos} - Ultimos por primeiro','Codigo {Ultimo Agendamento} - Ultimos por primeiro','Codigo {Todos Agendamentos} - Ultimos por primeiro'}																		  
		
		
		M_Title("ESCOLHA ORDEM DE AMOSTRAGEM")
		nOrdem := FazMenu( 19 , 45 , aMenu)																		  
	
		if LastKey() = ESC
			ResTela( cScreen )
			Exit
		endif
	endif	
	
	Receber->(Order( RECEBER_CODI ))
	Area("Agenda")
   nConta   := 0 
   NewTodos := {} 	
   oBloco   := {|| Agenda->Data >= dIni .AND. Agenda->Data <= dFim }   
	Agenda->(Order( AGENDA_DATA_CODI ))
	Sx_SetScope( S_TOP, dTos(dIni))
	Sx_SetScope( S_BOTTOM, dTos(dFim))	
	cTela  := Mensagem("Pass #1 Aguarde... Filtrando registros. ESC cancela.")
	Agenda->(DbGoTop())
	if Sx_KeyCount() == 0
		Sx_ClrScope( S_TOP )
		Sx_ClrScope( S_BOTTOM )
		Nada()
		ResTela( cScreen )
		Loop
	endif	
   While Eval( oBloco ) .AND. !Tecla_ESC()
		if nConta > 65535
			Alerta("Erro: Impossivel mostrar mais do que 65535 registros.")
			Exit
		endif
		cCodi := Agenda->Codi
		nConta++
		Aadd( oReceposi:xTodos, {cCodi, Agenda->Data, Agenda->Hora, Agenda->Hist, Agenda->Usuario, Agenda->(Recno())})
		aadd( oReceposi:Color_pFore,  oReceposi:CorDuplicado )			
		oMenu:ContaReg()
		Agenda->(DbSkip(1))
	endDo	
	Sx_ClrScope( S_TOP )
	Sx_ClrScope( S_BOTTOM )
	cCodi 	:= Agenda->Codi
	cSep		:= '|'
	ResTela( cTela )
	
	// Ordenando	
	cTela := Mensagem("Pass #2 Aguarde... Indexando registros.")
	if     nOrdem = 1  .OR. nOrdem = 5// Data {Ultimo Agendamento
		asort( oReceposi:xTodos,,, {|x,y|y[1] > x[1]})			
		xLen := Len(oReceposi:xTodos)		
		NewTodos := {}		
		for nT := 2 To xLen
			cCodi := oReceposi:xTodos[nT-1 , 1]
			if oReceposi:xTodos[nT-1 , 4] != 'PAG PARCIAL'
				if oReceposi:xTodos[nT, 1] != cCodi				
					aadd( NewTodos, oReceposi:xTodos[nT-1])
					aadd( oReceposi:Color_pFore,  oReceposi:CorDuplicado )			
				endif
			endif
		next
		oReceposi:xTodos := NewTodos
		if nOrdem = 1
			asort( oReceposi:xTodos,,, {|x,y|y[2] > x[2]})		
		else
			asort( oReceposi:xTodos,,, {|x,y|y[2] < x[2]})		
		endif		
		
	elseif nOrdem = 2  .OR. nOrdem = 6 // Data {Todos Agendamentos
		asort( oReceposi:xTodos,,, {|x,y|y[1] > x[1]})				
		xLen := Len(oReceposi:xTodos)						
		for nT := 2 To xLen
			cCodi := oReceposi:xTodos[nT-1 , 1]						
			if oReceposi:xTodos[nT, 1] == cCodi			   
				oReceposi:Color_pFore[nT-1] := oReceposi:CorRecibo
			endif
		next
		if nOrdem = 2
			asort( oReceposi:xTodos,,, {|x,y|y[2] > x[2]})						
		else	
			asort( oReceposi:xTodos,,, {|x,y|y[2] < x[2]})						
		endif	
		
	elseif nOrdem = 3 .OR. nOrdem = 7  // Codigo {Ultimo Agendamento
		asort( oReceposi:xTodos,,, {|x,y|y[1] > x[1]})		
		xLen := Len(oReceposi:xTodos)		
		NewTodos := {}		
		for nT := 2 To xLen
			cCodi := oReceposi:xTodos[nT-1 , 1]
			if oReceposi:xTodos[nT-1 , 4] != 'PAG PARCIAL'
				if oReceposi:xTodos[nT, 1] != cCodi
					aadd( NewTodos, oReceposi:xTodos[nT-1])
					aadd( oReceposi:Color_pFore,  oReceposi:CorDuplicado )			
				endif
			endif
		next
		if nOrdem = 3
			oReceposi:xTodos := NewTodos
		else	
			oReceposi:xTodos := NewTodos
			asort( oReceposi:xTodos,,, {|x,y|y[2] < x[2]})						
		endif	
		
	elseif nOrdem = 4  .OR. nOrdem = 8// Codigo {Todos Agendamentos
		asort( oReceposi:xTodos,,, {|x,y|y[1] > x[1]})				
		xLen := Len(oReceposi:xTodos)				
		for nT := 2 To xLen
			cCodi := oReceposi:xTodos[nT-1 , 1]						
			if oReceposi:xTodos[nT, 1] == cCodi		
				oReceposi:Color_pFore[nT-1] := oReceposi:CorRecibo
			endif
		next
		if nOrdem = 8
			asort( oReceposi:xTodos,,, {|x,y|y[1] < x[1]})
		endif		
		
	endif
	
	xLen := Len(oReceposi:xTodos)
	for nT := 1 To xLen			
		cAgenda1 := Dtoc(oReceposi:xTodos[nT, 2])
		cAgenda2 := oReceposi:xTodos[nT, 3]
		cAgenda3 := oReceposi:xTodos[nT, 5]		
		cAgenda4 := oReceposi:xTodos[nT, 4]		
		
		cString1 := StrZero( nT, 3)
		cString1 += cSep
		cString1 += cAgenda1
		cString1 += cSep
		cString1 += cAgenda2
		cString1 += cSep
		cString1 += Left(cAgenda3, 6)
		cString1 += cSep
		cString1 += cAgenda4		
		aadd( oReceposi:aTodos,       cString1 )
		aadd( oReceposi:Color_pBack,  oAmbiente:CorLightBar )	
		aadd( oReceposi:Color_pUns,   oReceposi:CorRecibo )	
		aadd( oReceposi:aCodi,        oReceposi:xTodos[nT, 1])
		aadd( oRecePosi:aRecno,       oReceposi:xTodos[nT, 6])				
		aadd( oRecePosi:aAtivo,       OK )
      aadd( oRecePosi:aAtivoSwap,   OK )      
	next
		
	ResTela( cTela )
	if nConta = 0
		Nada()
		Loop
	endif
	if Len(oReceposi:aTodos) > 0
		oReceposi:PosiAgeAll := OK		
		oMenu:StatInf()
		oMenu:ContaReg(nConta)
		oReceposi:CloneVarColor()						
		
		if lRecarregar != NIL .AND. !lRecarregar					
			return 
		endif		
		
		MaBox( 00, 00, 06, MaxCol())		
		oRecePosi:aBottom 	 := oReceposi:BarraSoma()
		oRecePosi:cTop := " # |DATA    |HORA    |USER  |OBSERVACOES AGENDADA"		
		oRecePosi:cTop += Space( MaxCol() - Len( cString ))		
		oRecePosi:Redraw_()
		__Funcao( 0, 1, 1 )
		lPageCircular := FALSO	
		oRecePosi:aChoice_(oReceposi:aTodos, oRecePosi:aAtivo, "__Funcao", lPageCircular )
		oRecePosi:PosiAgeAll := FALSO
		oAmbiente:PosiAgeAll := FALSO
		oReceposi:Reset()
	endif
	ResTela( cScreen )
	if lPilha
		Return
	endif
EndDo

*:---------------------------------------------------------------------------------------------------------------------------------

function NewPosiAgeReg( lRecarregar)
************************************
PRIVA oRecePosi := TReceposiNew(07, 00, MaxRow()-4, MaxCol())
PosiAgeReg( lRecarregar)
oAmbiente:PosiAgeAll := FALSO
return

function PosiAgeReg( lRecarregar)
*********************************
LOCAL GetList	:= {}
LOCAL cScreen	:= SaveScreen()
LOCAL nConta	:= 0
LOCAL cString	:= ""
LOCAL cAgenda1 := ""
LOCAL cAgenda2 := ""
LOCAL cAgenda3 := ""
LOCAL cAgenda4 := ""
LOCAL cRegiao  := Space(2)
LOCAL dIni     := Date()-30
LOCAL dFim     := Date()
LOCAL cCodi
LOCAL cTela
LOCAL oBloco
LOCAL oBloco2
LOCAL oBloco3
FIELD Data
FIELD Codi
FIELD Hist

lPilha := cCodi != NIL
WHILE OK
	oRecePosi:RenewVar()
	oAmbiente:PosiAgeAll := OK	
	MaBox( 15, 45, 19, 75 )
	@ 16, 46 Say "Regiao.......:" Get cRegiao Pict "99" Valid RegiaoErrada( @cRegiao )
	@ 17, 46 Say "Data Inicial.:" Get dIni    Pict "##/##/##"
	@ 18, 46 Say "Data Final...:" Get dFim    Pict "##/##/##"
	Read
	if LastKey() = ESC
		DbClearRel()
		ResTela( cScreen )
		Exit
	endif
	Receber->(Order(RECEBER_REGIAO))
   if Receber->(!DbSeek(cRegiao))
		Nada()
		ResTela( cScreen )
		Loop
	endif
   nConta               := 0
   oReceposi:aTodos     := {}
   oReceposi:xTodos     := {}
   oReceposi:aCodi      := {}
   oRecePosi:aAtivo     := {}
   oRecePosi:aAtivoSwap := {}
   oRecePosi:aRecno     := {}
   oBloco               := {|| Receber->Regiao = cRegiao }   
   cTela                := Mensagem("Aguarde... Filtrando registros. ESC cancela.")
   While Eval(oBloco) .AND. !Tecla_ESC()
      cCodi := Receber->Codi
		Agenda->(Order(AGENDA_CODI_DATA))
      if Agenda->(!DbSeek(cCodi))
			Receber->(DbSkip(1))
			Loop
		endif
      oBloco2 := {|| Agenda->Codi = cCodi }
      While Eval( oBloco2 ) .AND. !Tecla_ESC()
			if nConta > 65535
				Alerta("Erro: Impossivel mostrar mais do que 65535 registros.")
				Exit
			endif
         oBloco3 := {|| Agenda->Data >= dIni .AND. Agenda->Data <= dFim}
         if !(Eval(oBloco3))
            Agenda->(DbSkip(1))
            Loop
         endif
			cSep		:= '|'			
			cAgenda1 := Dtoc(Agenda->Data)
			cAgenda2 := Agenda->Hora
			cAgenda3 := Agenda->Usuario
			cAgenda4 := Agenda->Hist			
			cString1 := StrZero( nConta, 3)
			cString1 += cSep
			cString1 += cAgenda1
			cString1 += cSep
			cString1 += cAgenda2
			cString1 += cSep
			cString1 += Left(cAgenda3,6)
			cString1 += cSep
			cString1 += cAgenda4					
         nConta++
         Aadd( oReceposi:aCodi, cCodi )
         Aadd( oRecePosi:aAtivo, OK )
         Aadd( oRecePosi:aAtivoSwap, OK )
         Aadd( oRecePosi:aRecno, Agenda->(Recno()))
         Aadd( oReceposi:aTodos, cString1 )
         Aadd( oReceposi:xTodos, {cCodi, Agenda->Data, Agenda->Hora, Agenda->Hist})
         Agenda->(DbSkip(1))
			oMenu:ContaReg()
		EndDo
		Receber->(DbSkip(1))
	EndDo
	Sx_ClrScope( S_TOP )
	Sx_ClrScope( S_BOTTOM )
	ResTela( cTela )
	if nConta = 0
		Nada()
		Loop
	endif
	if Len(oReceposi:aTodos) > 0
		oReceposi:PosiAgeAll := OK		
		oMenu:StatInf()
		oMenu:ContaReg(nConta)		
		oReceposi:CloneVarColor()				
		
		if lRecarregar != NIL .AND. !lRecarregar						
			return 
		endif		
		
		MaBox( 00, 00, 06, MaxCol())
		oRecePosi:aBottom 	 := oReceposi:BarraSoma()
		oRecePosi:cTop := " # |DATA    |HORA    |USER  |OBSERVACOES AGENDADA"		
		oRecePosi:cTop += Space( MaxCol() - Len( cString ))		
		oRecePosi:Redraw_()
		__Funcao( 0, 1, 1 )
		lPageCircular := FALSO	
		oRecePosi:aChoice_(oReceposi:aTodos, oRecePosi:aAtivo, "__Funcao", lPageCircular )
		oRecePosi:PosiAgeAll := FALSO
		oAmbiente:PosiAgeAll := FALSO
		oReceposi:Reset()
	endif
	ResTela( cScreen )
	if lPilha
		//Return(AC_CONT)
		Return
	endif
EndDo

function NewPosiReceber( nChoice, xParam, cCaixa, lRescisao, nASort, cTipoRecibo, lRecarregar, lRecepago, xOrdem)
*****************************************************************************************************************
PRIVA oReceposi := TReceposiNew(07, 00, MaxRow()-4, MaxCol())
PosiReceber( nChoice, xParam, cCaixa, lRescisao, nASort, cTipoRecibo, lRecarregar, lRecepago, xOrdem )
oAmbiente:lReceber := FALSO
return NIL

function PosiReceber( nChoice, xParam, cCaixa, lRescisao, nASort, cTipoRecibo, lRecarregar, lRecepago, xOrdem )
***************************************************************************************************************
LOCAL GetList	 := {}
LOCAL cScreen	 := SaveScreen()
LOCAL nConta	 := 0
LOCAL nT 		 := 0
LOCAL xLen		 := 0
LOCAL nJuroDia  := 0
LOCAL cColor	 := SetColor()
LOCAL nMaxCol   := MaxCol()
LOCAL aMenu     := {'Todos Lancamentos - Inclusive recibos emitidos', 'Somente em aberto - Nao incluir recibos emitidos', 'Somente Recebidos - Nao incluir em aberto'}		
LOCAL lSair     := OK
LOCAL linhaembranco   := ';'
LOCAL linhahorizontal := '-'
LOCAL Ind_Recemov
LOCAL Ind_Recebido
LOCAL lCalcular
LOCAL nValorTotal
LOCAL nTotalGeral
LOCAL aCabec
LOCAL nJuros
LOCAL cTela
LOCAL oBloco
LOCAL oBloco2
LOCAL Col
LOCAL xObs
LOCAL cStr
LOCAL xDataPag
LOCAL lMsg
LOCAL nJuroMesComposto
STATI dIni
STATI dFim
STATI cRegiao
STATI dCalculo
STATI nOrdem
STATI cTipo
STATI cFatu
STATI cCodi
STATI xSeek
FIELD Regiao
FIELD Vcto
FIELD Juro
FIELD Codi
FIELD Docnr
FIELD Emis
FIELD Vlr
DEFAU cTipoRecibo TO nil


IfNil( lRescisao, FALSO )
Receber->(Order( RECEBER_CODI ))
Recemov->(DbGoTop())
if Recemov->(Eof())
	Nada()
	ResTela( cScreen )
	Return
endif

IFNIL(cCodi,Space(05))
WHILE OK   		
	oReceposi:RenewVar()	
	oAmbiente:lReceber := OK	
	lSair              := OK   
   Do Case
	Case nChoice = 1
		if xParam != NIL
			cCodi    := xParam
			xSeek    := cCodi
         dFim     := Ctod("31/12/" + Right(Dtoc(Date()),2))
			dCalculo := Date()
			AchaUltVcto(cCodi, @dFim)
			if oAmbiente:Ano2000
            dIni := Ctod("01/01/80")
			Else
            dIni := Ctod("01/01/01")
			endif
			if xOrdem == nil
				nOrdem := 1
			else
				nOrdem := xOrdem
			endif
		else
		   cCodi    := Space(5)
         dIni     := Ctod("01/01/91")
         dFim     := Ctod("31/12/" + Right(Dtoc(Date()),2))
         dCalculo := Date()
			if lRescisao
				cStr		:= "Data Rescisao:"
			Else
				cStr		:= "Calcular ate.:"
			endif
			MaBox( 14, 45, 19, 75 )
         @ 15, 46 Say "Cliente......:" Get cCodi    Pict PIC_RECEBER_CODI Valid RecErrado(@cCodi)
         @ 16, 46 Say "Data Inicial.:" Get dIni     Pict PIC_DATA         Valid AchaUltVcto(cCodi, @dFim)
         @ 17, 46 Say "Data Final...:" Get dFim     Pict PIC_DATA         Valid IF((Empty(dFim) .OR. dFim < dIni), ( ErrorBeep(), Alerta("Ooops!: Entre com uma data valida! Maior ou igual data inicial"), FALSO ), OK ) 
         @ 18, 46 Say cStr             Get dCalculo Pict PIC_DATA 
			Read
			if LastKey() = ESC
				DbClearRel()
				resTela( cScreen )
				Exit
			endif			
			mensagem("Informa: Verifique a opcao de ativar mostrar ou nao clientes desativados.", 31, 14, 76)
			M_Title("ESCOLHA ORDEM DE AMOSTRAGEM")
			nOrdem := FazMenu( 20 , 45 , aMenu)																		  	
			if nOrdem = 0 .OR. LastKey() = ESC
				ResTela( cScreen )
				loop
			endif			
			xParam := cCodi
			lSair  := FALSO 
			xSeek  := cCodi
			oReceposi:nOrdem := nOrdem
		endif
		
		Recebido->(Order(RECEBIDO_CODI))
		Recemov->(Order(RECEMOV_CODI))
		if lRecepago == NIL
			if Recemov->(!DbSeek(xSeek))
				if Recebido->(!DbSeek(xSeek))
					Nada()
					if xParam != NIL
						Exit
					else
						Loop
					endif
				endif
			endif	
		else
			if Recebido->(!DbSeek(xSeek))
				xParam := NIL
				Nada()
				ResTela( cScreen )
				Loop
			endif
		endif
		
		Ind_Recebido := Recebido->(IndexOrd())
		Ind_Recemov  := Recemov->(IndexOrd())
		oBloco		 := {|| Recemov->Codi  = xSeek }
		oBloco2		 := {|| Recebido->Codi = xSeek }
		oReceposi:PosiReceber := OK

	Case nChoice = 2 // NCHOICE_REGIAO
		if xParam == NIL			
			cRegiao	:= Space(02)
			dIni		:= Ctod("01/01/91")
			dFim		:= Ctod("31/12/" + Right(Dtoc(Date()),2))
			dCalculo := Date()
			MaBox( 14, 45, 19, 75 )
			@ 15, 46 Say "Regiao.......:" Get cRegiao  Pict "99"       valid RegiaoErrada( @cRegiao )
			@ 16, 46 Say "Data Inicial.:" Get dIni     Pict "##/##/##"
			@ 17, 46 Say "Data Final...:" Get dFim     Pict "##/##/##" valid IF((Empty(dFim) .OR. dFim < dIni), ( ErrorBeep(), Alerta("Ooops!: Entre com uma data valida! Maior ou igual data inicial"), FALSO ), OK ) 
			@ 18, 46 Say "Calcular ate.:" Get dCalculo Pict "##/##/##"
			Read
			if LastKey() = ESC
				DbClearRel()
				ResTela( cScreen )
				Exit
			endif
			mensagem("Informa: Verifique a opcao de ativar mostrar ou nao clientes desativados.", 31, 14, 76)
			M_Title("ESCOLHA ORDEM DE AMOSTRAGEM")
			nOrdem := FazMenu( 20 , 45 , aMenu)																		  	
			if nOrdem = 0 .OR. LastKey() = ESC				
				ResTela( cScreen )
				loop
			endif
			xParam := cRegiao
			lSair  := FALSO 
			oReceposi:nOrdem := nOrdem
		endif	
		Recebido->(Order(RECEBIDO_REGIAO))
		Recemov->(Order(RECEMOV_REGIAO))
		xSeek := cRegiao
		if lRecepago == NIL
			if Recemov->(!DbSeek(xSeek))
				if Recebido->(!DbSeek(xSeek))
					xParam := NIL
					Nada()					
					Loop
				endif
			endif
		else				
			if Recebido->(!DbSeek(xSeek))
				xParam := NIL
				Nada()
				ResTela( cScreen )
				Loop
			endif			
		endif				
		Ind_Recebido := Recebido->(IndexOrd())
		Ind_Recemov  := Recemov->(IndexOrd())
		oBloco  := {|| Recemov->Regiao  = xSeek }
		oBloco2 := {|| Recebido->Regiao = xSeek }
		// oReceposi:PosiReceber := FALSO
		oReceposi:PosiReceber := OK

	Case nChoice = 3 // NCHOICE_PERIODO
		if xParam == NIL			
			dIni		:= Ctod("01/" + StrZero(Month(Date()),2) + "/" + Right(Dtoc(Date()),2))
			dFim		:= Date()
			dCalculo := Date()		
			MaBox( 14, 45, 18, 75 )
			@ 15, 46 Say "Data Inicial.:" Get dIni     Pict "##/##/##"
			@ 16, 46 Say "Data Final...:" Get dFim     Pict "##/##/##" Valid IF((Empty(dFim) .OR. dFim < dIni), ( ErrorBeep(), Alerta("Ooops!: Entre com uma data valida! Maior ou igual data inicial"), FALSO ), OK ) 
			@ 17, 46 Say "Calcular ate.:" Get dCalculo Pict "##/##/##"
			Read
			if LastKey() = ESC
				DbClearRel()
				ResTela( cScreen )
				Exit
			endif
			mensagem("Informa: Verifique a opcao de ativar mostrar ou nao clientes desativados.", 31, 14, 76)
			M_Title("ESCOLHA ORDEM DE AMOSTRAGEM")
			nOrdem := FazMenu( 19 , 45 , aMenu)																		  
			if nOrdem = 0 .OR. LastKey() = ESC				
				ResTela( cScreen )
				loop
			endif	
			xParam := dIni
			lSair  := FALSO 
			oReceposi:nOrdem := nOrdem
		endif	
		
		cTela := Mensagem("Aguarde... Filtrando registros. ESC cancela.")		
		Recibo->(Order(RECIBO_DATA))
		Recebido->(Order( RECEBIDO_DATAPAG ))
		nIndex := IIF( cTipoRecibo = nil , RECEMOV_VCTO, RECEMOV_DATAPAG)
		nIndex := IIF( nOrdem == 3, RECEMOV_DATAPAG, nIndex)		
		Recemov->(Order(nIndex))			
		xSeek := dIni
		if lRecepago == NIL
			if Recemov->(!SeekData( dIni, dFim, IIF( nIndex == RECEMOV_VCTO, "Vcto", "Datapag")))		
				if Recebido->(!SeekData( dIni, dFim, "Datapag"))				
					xParam := NIL
					Nada()
					xParam := NIL
					ResTela( cScreen )
					Loop
				endif
			endif
		else	
			if Recibo->(!SeekData( dIni, dFim, "Data"))				
				if Recebido->(!SeekData( dIni, dFim, "Datapag"))				
					xParam := NIL
					Nada()				
					ResTela( cScreen )
					Loop		
				endif			
			endif			
		endif			
		
		Ind_Recebido := Recebido->(IndexOrd())
		Ind_Recemov  := Recemov->(IndexOrd())
		
		if cTipoRecibo != NIL
			oBloco		 := {|| Recemov->DataPag  >= dIni .AND. Recemov->DataPag <= dFim }		
		else
			if nOrdem == 3
				oBloco	 := {|| Recemov->DataPag  >= dIni .AND. Recemov->DataPag <= dFim }
			else		
				oBloco	 := {|| Recemov->Vcto     >= dIni .AND. Recemov->Vcto    <= dFim }				
			endif				
		endif		
		oBloco2         := {|| Recebido->DataPag >= dIni .AND. Recebido->DataPag <= dFim }
		oReceposi:PosiReceber        := OK
		oRecePosi:lReceberPorPeriodo := OK

	Case nChoice = 4 // NCHOICE_TIPO
		if xParam == NIL			
			cTipo 	:= Space(06)
			dIni		:= Ctod("01/01/91")
			dFim		:= Ctod("31/12/" + Right(Dtoc(Date()),2))
			dCalculo := Date()
			MaBox( 14, 45, 19, 75 )
			@ 15, 46 Say "Tipo.........:" Get cTipo Pict "@!" Valid AchaTipo( cTipo )
			@ 16, 46 Say "Data Inicial.:" Get dIni     Pict "##/##/##"
			@ 17, 46 Say "Data Final...:" Get dFim     Pict "##/##/##" Valid IF((Empty(dFim) .OR. dFim < dIni), ( ErrorBeep(), Alerta("Ooops!: Entre com uma data valida! Maior ou igual data inicial"), FALSO ), OK ) 
			@ 18, 46 Say "Calcular ate.:" Get dCalculo Pict "##/##/##"
			Read
			if LastKey() = ESC
				Recemov->(DbClearRel())
				Recemov->(DbGoTop())
				ResTela( cScreen )
				Exit
			endif			
			mensagem("Informa: Verifique a opcao de ativar mostrar ou nao clientes desativados.", 31, 14, 76)
			M_Title("ESCOLHA ORDEM DE AMOSTRAGEM")
			nOrdem := FazMenu( 20 , 45 , aMenu)																		  	
			if nOrdem = 0 .OR. LastKey() = ESC				
				ResTela( cScreen )
				loop
			endif
			xParam := cTipo
			lSair  := FALSO 
			oReceposi:nOrdem := nOrdem
		endif	
		Recebido->(Order(RECEBIDO_TIPO))
		Recemov->(Order(RECEMOV_TIPO))
		xSeek := cTipo
		if lRecepago == NIL
			if Recemov->(!DbSeek(xSeek))
				if Recebido->(!DbSeek(xSeek))
					xParam := NIL
					Nada()
					Loop
				endif
			endif
		else
			if Recebido->(!DbSeek(xSeek))
				xParam := NIL
				Nada()
				ResTela( cScreen )
				Loop
			endif
		endif		
		Ind_Recebido := Recebido->(IndexOrd())
		Ind_Recemov  := Recemov->(IndexOrd())
		oBloco  := {|| Recemov->Tipo = xSeek }
		oBloco2 := {|| Recebido->Tipo = xSeek }
		// oReceposi:PosiReceber := FALSO
		oReceposi:PosiReceber := OK

	Case nChoice = 5 // NCHOICE_FATURA
		if xParam == NIL			
			dCalculo := Date()		
			cFatu    := Space(7)
			MaBox( 14, 45, 16, 67 )
			@ 15, 46 Say "Fatura N§.:" Get cFatu Pict "@!" Valid VisualAchaFatura( @cFatu )
			Read
			if LastKey() = ESC
				Recemov->(DbClearRel())
				Recemov->(DbGoTop())
				ResTela( cScreen )
				Exit
			endif
			mensagem("Informa: Verifique a opcao de ativar mostrar ou nao clientes desativados.", 31, 14, 76)
			M_Title("ESCOLHA ORDEM DE AMOSTRAGEM")
			nOrdem := FazMenu( 19 , 45 , aMenu)																		  	
			if nOrdem = 0 .OR. LastKey() = ESC				
				ResTela( cScreen )
				Loop
			endif
			xParam := cFatu
			lSair  := FALSO 
			oReceposi:nOrdem := nOrdem
		else
			cFatu := xParam
		endif
		Area("Recebido")
		Recebido->(Order( RECEBIDO_FATURA ))
		Ind_Recebido := Recebido->(IndexOrd())
		Area("Recemov")
		Recemov->(Order( RECEMOV_FATURA ))
		Ind_Recemov  := Recemov->(IndexOrd())
		oBloco		 := {|| Recemov->Fatura = cFatu }
		oBloco2		 := {|| Recebido->Fatura = cFatu }
		xSeek 		 := cFatu
		if lRecepago == NIL		
			if Recemov->(!DbSeek(cFatu))
				if Recebido->(!DbSeek(cFatu))
					Nada()
					if xParam != NIL
						ResTela( cScreen )
						Exit
					Else
						Loop
					endif
				endif
			endif
		else			
			if Recebido->(!DbSeek(cFatu))
				Nada()
				if xParam != NIL
					ResTela( cScreen )
					Exit
				Else
					Loop
				endif
			endif
		endif	
		
		//oReceposi:PosiReceber := FALSO
		oReceposi:PosiReceber := OK

	Case nChoice = 6 // NCHOICE_GERAL
	   if xParam == NIL
			dCalculo := Date()
			MaBox( 14, 45, 16, 75 )
			@ 15, 46 Say "Calcular ate.:" Get dCalculo Pict "##/##/##" Valid IF(Empty(dCalculo), ( ErrorBeep(), Alerta("Ooops!: Entre com uma data valida!"), FALSO ), OK ) 
			Read
			if LastKey() = ESC
				Recemov->(DbClearRel())
				Recemov->(DbGoTop())
				ResTela( cScreen )
				Exit
			endif
			mensagem("Informa: Verifique a opcao de ativar mostrar ou nao clientes desativados.", 31, 14, 76)
			M_Title("ESCOLHA ORDEM DE AMOSTRAGEM")
			nOrdem := FazMenu( 19 , 45 , aMenu)																		  	
			if nOrdem = 0 .OR. LastKey() = ESC				
				ResTela( cScreen )
				Loop
			endif
			xParam := dCalculo
			lSair  := FALSO 
			oReceposi:nOrdem := nOrdem
		endif
		Recebido->(Order(RECEBIDO_CODI))
		Recebido->(DbGotop())
		Recemov->(Order(RECEMOV_CODI))
		if lRecepago == NIL		
			if Recemov->(Eof())
				if Recebido->(Eof())
					xParam := NIL
					Nada()
					Loop
				endif
			endif
		else
			if Recebido->(Eof())
				xParam := NIL
				Nada()
				ResTela( cScreen )
				Loop
			endif		
		endif		
		Ind_Recebido := Recebido->(IndexOrd())
		Ind_Recemov  := Recemov->(IndexOrd())
		oBloco		 := {|| Recemov->(!Eof()) }
		oBloco2		 := {|| Recebido->(!Eof()) }
		//oReceposi:PosiReceber := FALSO
		oReceposi:PosiReceber := OK
		
	Case nChoice = 7 // NCHOICE_DOCNR_PARCIAL
		cFatu := Right(xParam[1], 8)
		cCodi := xParam[2]
		dIni  := xParam[3]
		dFim  := xParam[4]
		
		Area("Recebido")
		Recebido->(Order( RECEBIDO_DOCNR ))
		Ind_Recebido := Recebido->(IndexOrd())
		Area("Recemov")
		Recemov->(Order( RECEMOV_RIGHT_DOCNR ))
		Ind_Recemov  := Recemov->(IndexOrd())
		oBloco		 := {|| Right(Recemov->Docnr,  8) = cFatu }
		oBloco2		 := {|| Right(Recebido->Docnr, 8) = cFatu }
		xSeek 		 := cFatu
	
		if lRecepago == NIL		
			if Recemov->(!DbSeek(cFatu))
				if Recebido->(!DbSeek(cFatu))
					alertaPy(' INFO: Nada encontrado nos parametros informados abaixo: ;-;;' + ;
								' Fatura: ' + cFatu + ';' + ;				
            				' Codigo: ' + cCodi + ';' + ;				
								'  Busca: ' + xSeek + ';' + ;				
            				'   Data: ' + dToc(dIni), 31 , false)	
					if xParam != NIL
						ResTela( cScreen )
						Exit
					Else
						Loop
					endif
				endif
			endif
		else			
			if Recebido->(!DbSeek(cFatu))
				alertaPy(' INFO: Nada encontrado nos parametros informados abaixo: ;-;;' + ;
							' Fatura: ' + cFatu + ';' + ;				
            			' Codigo: ' + cCodi + ';' + ;				
							'  Busca: ' + xSeek + ';' + ;				
            			'   Data: ' + dToc(dIni), 31 , false)	
				if xParam != NIL
					ResTela( cScreen )
					Exit
				Else
					Loop
				endif
			endif
		endif	
		
		//oReceposi:PosiReceber := FALSO
		oReceposi:PosiReceber := OK		
		
	Case nChoice = 8 // NCHOICE_DATAPAG
      cCodi := xParam[1]
      dIni  := xParam[2]
		dFim  := xParam[3]
		
		xSeek := iif(nOrdem == 3, dIni, cCodi + dTos(dIni))
		Recebido->(Order(iif(nOrdem == 3, RECEBIDO_DATAPAG, RECEBIDO_CODI_DATAPAG)))
		Recemov->(Order(iif(nOrdem == 3, RECEMOV_DATAPAG, RECEMOV_CODI_DATAPAG)))
		if lRecepago == NIL		   
			if Recemov->(!DbSeek(xSeek))
				if Recebido->(!DbSeek(xSeek))
					alertaPy(' INFO: Nada encontrado nos parametros informados abaixo: ;-;;' + ;
            				' Codigo: ' + cCodi + ';' + ;				
								'  Busca: ' + xSeek + ';' + ;				
            				'   Data: ' + dToc(dIni), 31 , false)			
					if xParam != NIL
						Exit
					else
						Loop
					endif
				endif
			endif	
		else
			if Recebido->(!DbSeek(xSeek))
				xParam := NIL
				alertaPy(' INFO: Nada encontrado nos parametros informados abaixo: ;-;;' + ;
            				' Codigo: ' + cCodi + ';' + ;				
								'  Busca: ' + xSeek + ';' + ;				
            				'   Data: ' + dToc(dIni), 31 , false)			
				ResTela( cScreen )
				Loop
			endif
		endif
		
		Ind_Recebido := Recebido->(IndexOrd())
		Ind_Recemov  := Recemov->(IndexOrd())
		if nOrdem == 3
			oBloco	    := {|| Recemov->DataPag  >= dIni .AND. Recemov->DataPag  <= dFim }		
			oBloco2		 := {|| Recebido->DataPag >= dIni .AND. Recebido->DataPag <= dFim }
		else
			oBloco	    := {|| Recemov->Codi  = cCodi .AND. Recemov->DataPag  >= dIni .AND. Recemov->DataPag  <= dFim }		
			oBloco2		 := {|| Recebido->Codi = cCodi .AND. Recebido->DataPag >= dIni .AND. Recebido->DataPag <= dFim }
		endif
		oReceposi:PosiReceber := OK
	
	EndCase

	nRecebido	:= 0
	nValorTotal := 0
	nTotalGeral := 0
	nJuros		:= 0
	nMulta		:= 0
	nAtraso		:= 0
	nDesconto	:= 0
	nSoma 		:= 0
	Col			:= 12	
	nConta		:= 0
	xObs			:= Space(0)
	cTela 		:= Mensagem("Aguarde, Localizando registros em aberto", Cor())
	lCalcular	:= (dCalculo != Ctod("00/00/00")) // Nao calcular juros ou descontos
	dCalculo 	:= IF(!lCalcular, Date(), dCalculo)
	
	if lRecepago == NIL
	
		*-----RECEMOV.DBF------------------------------------------------------------
		Receber->(Order( RECEBER_CODI ))
		Recibo->(Order( RECIBO_DOCNR))
		if nChoice != NCHOICE_PERIODO .AND. nChoice != NCHOICE_GERAL
			Area("Recemov")
			Recemov->(Order( Ind_Recemov ))
			Recemov->(DbSeek( xSeek ))
		endif
		
		WHILE Recemov->(Eval(oBloco))
			
			if nConta >= 65535
				alerta("Erro: Impossivel mostrar mais de 65535 registros.")
				exit
			endif
			
			cCodi    := Recemov->Codi
			cDocnr   := Recemov->Docnr
			xDataPag := Ctod("31/12/2099") // Para fins de indexacao
			xId      := 0
			
			Recibo->(Order(RECIBO_DOCNR))
			if Recibo->(DbSeek( Recemov->Docnr ))		   
				xDataPag := Recibo->Data
				xId      := Recibo->id			
			else
				if nChoice != NCHOICE_FATURA .AND. nChoice != NCHOICE_GERAL
					if Recemov->Vcto < dIni .OR. Recemov->Vcto > dFim
						Recemov->(DbSkip(1))
						Loop
					endif
				endif
			endif
						
			if cTipoRecibo != NIL
				if Recibo->(DbSeek(cDocnr)) .AND. Recibo->Data >= dIni .AND. Recibo->Data <= dFim
					xDataPag := Recibo->Data				
					if oAmbiente:cTipoRecibo != "RECALL"
						if Recibo->Tipo != oAmbiente:cTipoRecibo					
							Recemov->(DbSkip(1))
							Loop
						endif			
					endif 			
				else
					Recemov->(DbSkip(1))
					Loop
				endif
			endif
			
			if cTipoRecibo == NIL
				if !oAmbiente:Mostrar_Desativados .AND. nOrdem <> 3
					if nChoice != NCHOICE_CODI
						if nChoice != NCHOICE_FATURA			
							Receber->(Order( RECEBER_CODI ))
							if Receber->(DbSeek( cCodi ))
								if !Receber->Suporte
									Recemov->(DbSkip(1))
									Loop
								endif	
							endif
						endif
					endif
				endif
			endif	
			
			if     nOrdem == NIL .OR. nOrdem == 1 .OR. oAmbiente:PosiAgeInd .OR. oAmbiente:PosiAgeAll  // todos 
				// nada a fazer    
			elseif nOrdem == 2 // somente em aberto
				if Recibo->(DbSeek(cDocnr)) 
					Recemov->(DbSkip(1))
					Loop		
				endif		
				
			elseif nOrdem == 3 // somente recibo
				if Recibo->(!DbSeek(cDocnr)) 
					Recemov->(DbSkip(1))
					Loop		
				endif
				if Recibo->Data < dIni .OR. Recibo->Data > dFim	 // DataPag
					Recemov->(DbSkip(1))
					Loop		
				endif			
			endif	
			
			xObs    := Recemov->Obs
			cCodi   := Recemov->Codi
			nAtraso := Atraso( dCalculo, Recemov->Vcto )
			nVlr	  := Recemov->Vlr
			if lRescisao
				if nAtraso < 0
					if nAtraso < -30
						nVlr *= 0.5  // Metade da Mensalidade de Rescisao
					Else
						nDiaComUso := (30 + nAtraso)
						nDiaSemUso := (30 - nDiaComUso)
						nVlrComUso := (nDiaComUso * (nVlr/30))
						nVlrSemUso := (nDiaSemUso * (nVlr/30)*0.5)
						nVlr		  := (nVlrComUso + nVlrSemUso)
					endif
				endif
			endif
			if lCalcular
				nCarencia	:= Carencia( dCalculo, Recemov->Vcto )		 
				nMulta		:= 0
				nDesconto	:= VlrDesconto( dCalculo, Recemov->Vcto, nVlr )
				nJurodia 	:= Recemov->Jurodia
				nJuros		:= IF( nAtraso <= 0, 0, ( nCarencia * nJurodia ))
			endif

			nValorTotal += nVlr
			nTotalGeral += nVlr
			nTotalGeral += nJuros
			nTotalGeral += nMulta
			nTotalGeral -= nDesconto
			nSoma 		:= ((nVlr + nMulta ) + nJuros ) - nDesconto
			nMulta		:= VlrMulta( dCalculo, Recemov->Vcto, nSoma )
			nSoma 		+= nMulta
			nTotalGeral += nMulta
			nConta++
			lAtivo		:= OK

			Recemov->(Aadd( oReceposi:xTodos,;
							  { /*01*/ Docnr,;
								 /*02*/ Emis,;
								 /*03*/ Vcto,;
								 /*04*/ nAtraso,;
								 /*05*/ nVlr,;
								 /*06*/ nDesconto,;
								 /*07*/ nMulta,;
								 /*08*/ nJuros,;
								 /*09*/ nSoma,;
								 /*10*/ Codi,;
								 /*11*/ xObs,;
								 /*12*/ dTos(xDataPag)+dTos(Vcto)+Docnr,;
								 /*13*/ dTos(Vcto)+Docnr,;
								 /*14*/ dTos(xDataPag)+dTos(Vcto),;
								 /*15*/ Fatura,;
								 /*16*/ xDataPag,;
								 /*17*/ lAtivo,;
								 /*18*/ Recno(),;
								 /*19*/ dTos(xDataPag)+Docnr+dTos(Vcto),;
								 /*20*/ dTos(xDataPag)+Fatura+Docnr+dTos(Vcto),;
								 /*21*/ dTos(xDataPag)+Right(Docnr,8)+dTos(Vcto),;
								 /*22*/ dTos(xDataPag)+codi+Right(Docnr,8)+dTos(Vcto),;
								 /*23*/ xId,;
								 /*24*/ VlrOrigina,;								 
								 }))
			Recemov->(DbSkip(1))
		EndDo
		Restela( cTela )
	endif

	*-----RECEBIDO.DBF------------------------------------------------------------

	cTela := Mensagem("Aguarde, Localizando registros Recebidos")
	if nChoice != 3 .AND. nChoice != 6
		Area("Recebido")
		Recebido->(Order( Ind_Recebido ))
		Recebido->(DbSeek( xSeek ))
	endif

	WHILE Recebido->(Eval(oBloco2))
		if nConta >= 65535 // Tamanho Max. Array
			Alerta("Informa: Impossivel mostrar mais do que 65535 registros.")
			Exit
		endif
		cDocnr   := Recebido->Docnr
		cCodi    := Recebido->Codi		
		lAtivo 	:= OK
		
		if     nOrdem == NIL .OR. nOrdem == 1 .OR. oAmbiente:PosiAgeInd .OR. oAmbiente:PosiAgeAll  // todos 
		   // nada a fazer    
		elseif nOrdem == 2 // somente em aberto
			if Recibo->(DbSeek(cDocnr)) 
				Recebido->(DbSkip(1))
				Loop		
			endif		
		
		elseif nOrdem == 3 // somente recibo
			if Recibo->(!DbSeek(cDocnr)) 
				Recebido->(DbSkip(1))
				Loop		
			endif
			if Recibo->Data < dIni .OR. Recibo->Data > dFim	 // DataPag
				Recebido->(DbSkip(1))
				Loop		
			endif			
		endif	

		nValorTotal += Recebido->Vlr
		nTotalGeral += Recebido->VlrPag		
		xId         := 0
		xVlrOrigina := 0

		Recebido->(Aadd( oReceposi:xTodos,;
              		{  /*01*/ Docnr,;
							/*02*/ Emis,;
							/*03*/ Vcto,;
							/*04*/ (DataPag-Vcto),;
							/*05*/ Vlr,;
							/*06*/ 0,;
							/*07*/ 0,;
							/*08*/ 0,;
							/*09*/ VlrPag,;
							/*10*/ Codi,;
							/*11*/ Obs,;
							/*12*/ dTos(DataPag)+dTos(Vcto)+Docnr,;
							/*13*/ dTos(Vcto)+Docnr,;
							/*14*/ dTos(DataPag)+dTos(Vcto),;
							/*15*/ Fatura,;
							/*16*/ Datapag,;
                     /*17*/ lAtivo,;
                     /*18*/ Recno(),;
							/*19*/ dTos(DataPag)+Docnr+dTos(Vcto),;
							/*20*/ dTos(DataPag)+Fatura+Docnr+dTos(Vcto),;
							/*21*/ dTos(DataPag)+Right(Docnr,8)+dTos(Vcto),;
							/*22*/ dTos(DataPag)+codi+Right(Docnr,8)+dTos(Vcto),;
							/*23*/ xId,;
							/*24*/ xVlrOrigina,;								 
						}))
		nConta++
		Recebido->(DbSkip(1))
	EndDo
	
	lRegistroEmBranco := FALSO
	*-----REGISTRO BRANCO--------------------------------------------------------
	
	lRegistroEmBranco := oRecePosi:RegistroEmBranco(ccodi, cFatu)

	*-----END REGISTRO-----------------------------------------------------------	
	ResTela( cTela )

	Recemov->(Sx_ClrScope(S_TOP))  ; Recemov->(Sx_ClrScope(S_BOTTOM))
	Recebido->(Sx_ClrScope(S_TOP)) ; Recebido->(Sx_ClrScope(S_BOTTOM))

	if Len( oReceposi:xTodos ) > 0
		cTela := Mensagem('Informa: Aguarde, ordenando.')
		if nChoice = 5 // por Fatura
			Asort( oReceposi:xTodos,,, {|x,y|y[XTODOS_VCTO_DOCNR] > x[XTODOS_VCTO_DOCNR]})
		elseif nChoice = 3 // Periodo
		   if nOrdem = 1
				Asort( oReceposi:xTodos,,, {|x,y|y[XTODOS_DATAPAG_VCTO_DOCNR] > x[XTODOS_DATAPAG_VCTO_DOCNR]})				
			elseif nOrdem = 2	
				Asort( oReceposi:xTodos,,, {|x,y|y[XTODOS_DATAPAG_VCTO_DOCNR] > x[XTODOS_DATAPAG_VCTO_DOCNR]})								
			elseif nOrdem = 3	
				Asort( oReceposi:xTodos,,, {|x,y|y[XTODOS_ID] > x[XTODOS_ID]})				
			endif	
		else
		   if nChoice = 1 .AND. xParam != NIL .AND. nAsort != NIL			
			   Asort( oReceposi:xTodos,,, {|x,y|y[nAsort] > x[nAsort]})
			else			   
				if cTipoRecibo == nil				 
					Asort( oReceposi:xTodos,,, {|x,y|y[XTODOS_DATAPAG_VCTO_DOCNR] > x[XTODOS_DATAPAG_VCTO_DOCNR]})
				else
					Asort( oReceposi:xTodos,,, {|x,y|y[XTODOS_DATAPAG_CODI_RIGHT_DOCNR_8_VCTO] > x[XTODOS_DATAPAG_CODI_RIGHT_DOCNR_8_VCTO]})
				endif
			endif	
		endif
		
		if lRegistroEmBranco
			if nConta > 1
				nPos := Ascan( oReceposi:xTodos, {|aVal|Aval[10] == "00000"})
				oReceposi:xTodos[nPos,10] := oReceposi:xTodos[2,10]
			endif	
		endif	

		xLen := Len(oReceposi:xTodos)		
		nCor := iif(lRecepago        == NIL , NIL , oReceposi:CorDuplicado)				
		nCor := iif(oReceposi:nOrdem == 3 , oReceposi:CorDesativado, nCor)				
		For nT := 1 To xLen
		   oReceposi:addcolor(nCor)			
			Aadd( oReceposi:aHistRecibo, Space(0))
			Aadd( oReceposi:aUserRecibo, Space(0))
			Aadd( oReceposi:aReciboImpresso, FALSO )			
			Aadd( oReceposi:aAtivoSwap,  oReceposi:xTodos[nT,XTODOS_ATIVO])
			Aadd( oReceposi:aAtivo, 	  oReceposi:xTodos[nT,XTODOS_ATIVO])
			Aadd( oReceposi:aDatapag, 	  oReceposi:xTodos[nT,XTODOS_DATAPAG])
         Aadd( oReceposi:aRecno,      oReceposi:xTodos[nT,XTODOS_RECNO])
			Aadd( oReceposi:alMulta,    (oReceposi:xTodos[nT,XTODOS_MULTA] <> 0)) // Multa?
         Aadd( oReceposi:aCodi,       oReceposi:xTodos[nT,XTODOS_CODI] )
			Aadd( oReceposi:aTodos,{}) 
			oRecePosi:sTrFormataATodos(nT)
		Next
		Restela( cTela )
		cTela                 := Mensagem('Informa: Aguarde, Calculando...')
		oReceposi:CloneVarColor()
		nJuroMesComposto      := oAmbiente:aSciArray[1,SCI_JUROMESCOMPOSTO]
		nJuroMesComposto      := IF( nJuroMesComposto <= 0 .OR. nJuroMesComposto == nil , 1 , nJuroMesComposto)   		
		oReceposi:dini        := dini
		oReceposi:dfim        := dfim
		oReceposi:dcalculo    := dcalculo      
		oReceposi:nChoice     := nChoice
		oReceposi:xParam      := xParam
		oReceposi:lRescisao   := lRescisao
		
		if oAmbiente:Mostrar_Recibo
			SeekLog(oReceposi:xTodos, oReceposi:aTodos, nil, lRecepago)
		endif
		
		ResTela( cTela )		
		oMenu:StatInf()
		oMenu:ContaReg(xLen)			

		AltJrInd(1,NIL, oReceposi:aCodi[1], (lMsg := FALSO), oSender := oReceposi)
				
		if lRecarregar != NIL .AND. !lRecarregar		   							
			return
		endif		
	
		oRecePosi:cTop := " DOCTO N§  EMIS   VENCTO ATRA   ORIGINAL  PRINCIPAL DESC/PAG    JUROS  PG/MULTA     ABERTO       SOMA OBSERVACAO"		
		MaBox( 00, 00, 06, nMaxCol )		
		oRecePosi:cTop 	+= Space( MaxCol() - Len(oRecePosi:cTop))
		oRecePosi:cBottom := Space(13) + "PRINCIPAL             JUROS  PG/MULTA     ABERTO       SOMA"		
		oRecePosi:aBottom := oReceposi:BarraSoma()
		__Funcao( 0, 1, 1 )
		//cSetColor(",,,,R+/")
		lPageCircular := FALSO	      
		oRecePosi:aChoice_(oReceposi:aTodos, oRecePosi:aAtivo, "__Funcao", lPageCircular )
		SetColor(cColor)
		oReceposi:PosiReceber := FALSO		
		oAmbiente:lReceber	 := FALSO		
		oReceposi:Reset()		
	endif
	resTela( cScreen )
	if !lSair
		xParam := NIL
	endif	
	if lSair
		oReceposi:nOrdem := NIL
		exit
	endif	
EndDo

*===============================================================================

Function __Funcao( nMode, nCurElemento)
***************************************
LOCAL Arq_Ant      := Alias()
LOCAL Ind_Ant      := IndexOrd()
LOCAL cString		 := Space(0)
LOCAL cObs			 := Space(0)
LOCAL cObs1 		 := Space(0)
LOCAL nTamAtivo	 := Len(oRecePosi:aAtivo)
LOCAL pFore 		 := Cor( 1 ) // oAmbiente:CorMenu
LOCAL pBack 		 := Cor( 5 ) // oAmbiente:CorLightBar
//LOCAL pUns  		 := AscanCorHotKey( pFore) 
//LOCAL pUns  		 := AscanCorDesativada( pFore)
//LOCAL pUns  		 := ColorStrToInt("R+/")
LOCAL pUns  		 := AscanCorHKLightBar( pFore)
LOCAL oVenlan      := TIniNew( oAmbiente:xUsuario + ".INI")
LOCAL lAdmin       := oVenlan:ReadBool('permissao','usuarioadmin', FALSO )
LOCAL nReg         := 0
LOCAL x
LOCAL nLen
LOCAL lLancarJurosNaoPago
LOCAL nJuroMesComposto
LOCAL cCodi
STATIC lStack
STATIC nRecno
FIELD UltCompra
FIELD Matraso
FIELD VlrCompra


/*
Achoice() Modes
0 AC_IDLE		 Idle
1 AC_HITTOP 	 Tentativa do cursor passar topo da lista
2 AC_HITBOTTOM  Tentativa do cursor passar fim da lista
3 AC_EXCEPT 	 Keystroke exceptions
4 AC_NOITEM 	 No selectable item

ACHOICE() User Function Return Values
// ---------------------------------------------------------------------
Value   Achoice.ch	  Action
---------------------------------------------------------------------
0		  AC_ABORT		  Abort selection
1		  AC_SELECT 	  Make selection
2		  AC_CONT		  Continue ACHOICE()
3		  AC_GOTO		  Go to the next item whose first character matches the key pressed
4		  AC_REDRAW
5       AC_REPAINT
10      AC_CURELEMENTO
---------------------------------------------------------------------
*/
#define AC_REPAINT           5
#define AC_REDRAW            5
#define AC_CURELEMENTO       10

//SetKey( K_F1, NIL )
SetKey( K_F2,       nil )
SetKey( K_F5,       nil )
SetKey( K_CTRL_P,   nil )

nJuroMesComposto  := oAmbiente:aSciArray[1,SCI_JUROMESCOMPOSTO]
nJuroMesComposto  := IF( nJuroMesComposto <= 0 .OR. nJuroMesComposto == nil , 1 , nJuroMesComposto)
x                 := nCurElemento
cCodi             := oReceposi:aCodi[x]
nReg              := oReceposi:aRecno[x]
oReceposi:CurElemento := x
if oReceposi:PosiAgeInd
   if nRecno != nil 
	   Agenda->(DbGoto(nRecno))
	endif	
endif	

//nKey := EventStateAchoice()
nKey := UltimaTecla()

*==================================================================================================
Do Case
Case nMode = AC_IDLE // 0	
	cString := Space(0)
	if lStack != NIL
      cString += 'MOSTRA INDIVIDUAL|'
	endif
	if !oAmbiente:Mostrar_Desativados
      cString += 'FILTRO ATIVADO|'
	endif
	if oAmbiente:Mostrar_Recibo
		if oAmbiente:lReceber
         cString += 'RECIBO[vm=localizado]|'
		Else
         cString += 'RECIBO[vm=NAO localizado]|'
		endif
	endif
   cString += 'ESC RETORNA|'   
   cString := 'F2-TXJURO|F3-EDIT|F4-DUP|F5-ATUAL|CTRL+F5=VLR ORIGINAL|F6-ORDEM|F7=VISFATURA|SPC-FATURA|' + cString
	StatusSup( cString, Cor(2))
	Receber->(Order( RECEBER_CODI ))
	nMaxCol := MaxCol()
	cCodi   := oReceposi:aCodi[nCurElemento]
	if Receber->(DbSeek( cCodi ))
	   Write( 01, 01, Space(nMaxCol-2))
		Write( 02, 01, Space(nMaxCol-2))
		Write( 03, 01, Space(nMaxCol-2))
		Write( 04, 01, Space(nMaxCol-2))
		Write( 05, 01, Space(nMaxCol-2))
		Write( 01, 01, cCodi + " " + Receber->Nome )
		Write( 02, 01, Receber->Ende + " " + Receber->Bair )
		Write( 03, 01, Receber->Cep  + "/" + Receber->Cida + " " + Receber->Esta )
		Write( 04, 01, Receber->Obs  )
		Write( 05, 01, Receber->Obs1 )
		Write( 01, nMaxCol-28, "Inicio      : " + Dtoc( Receber->Data ))
		Write( 02, nMaxCol-28, "Telefone #1 : " + Receber->Fone )
		Write( 03, nMaxCol-28, "Telefone #2 : " + Receber->Fax )
		Write( 04, nMaxCol-28, "Vlr Fatura  : " )
		#IFDEF MICROBRAS
			if !oRecePosi:PosiAgeInd
				if !oReceposi:PosiAgeAll
					if oRecePosi:aAtivo[nCurElemento] // Item ativado
						cColor := SetColor()
						Write( 04, 01, Space(nMaxCol-2))
						Write( 05, 01, Space(nMaxCol-2))
						cObs	  := Alltrim(oReceposi:xTodos[nCurElemento,POS_OBS])
						cObs1   := AllTrim(oReceposi:aUserRecibo[nCurElemento]) + '/'
						cObs1   += AllTrim(Left(oReceposi:aHistRecibo[nCurElemento],(nMaxCol-4)))
						Write( 04, 01, "{" + Left(cObs1,(nMaxCol-28)) + "}", pUns)						
						if Len( cObs ) != 0
							Write( 05, 01, "{" + Left(cObs,(nMaxCol-4)) + "}", pUns)
						Else
							cObs := Right(oReceposi:xTodos[nCurElemento,1],02)
							Write( 05, 01, "{" + cObs + "¦ PARCELA DE SERVICOS DE INTERNET.}", pUns)
						endif
					endif
				endif
			endif
		#endif
	Else
	   Write( 01, 01, Space(nMaxCol-2))
		Write( 02, 01, Space(nMaxCol-2))
		Write( 03, 01, Space(nMaxCol-2))
		Write( 03, 01, "***** CLIENTE NAO LOCALIZADO ***** TALVEZ DELETADO?")
		Write( 04, 01, Space(nMaxCol-2))
		Write( 05, 01, Space(nMaxCol-2))
	endif	
	return( AC_REPAINT)

*==================================================================================================   
   
Case nMode = AC_HITTOP
	return( AC_CONT)

*==================================================================================================   
   
Case nMode = AC_HITBOTTOM
	return( AC_CONT)

*==================================================================================================
	
Case LastKey() = K_ESC
   SetKey( K_CTRL_P,   {|| AcionaSpooler() })   
	return( AC_ABORT)

*==================================================================================================   
   
Case LastKey() = K_CTRL_UP
	if nCurElemento <= 1
		nCurElemento := 1
		return(AC_CONT)
	endif
	if !oRecePosi:aAtivo[--nCurElemento] // Item Desativado
		oRecePosi:aAtivo[nCurElemento] := OK
	endif	
	PutKey(K_UP)
	return( AC_REPAINT)

*==================================================================================================
	
Case LastKey() = K_CTRL_DOWN
	if nCurElemento >= nTamAtivo
		nCurElemento := nTamAtivo
		return( AC_CONT)
	endif
	if !oRecePosi:aAtivo[++nCurElemento] // Item Desativado
		oRecePosi:aAtivo[nCurElemento] := OK
	endif	
	PutKey(K_DOWN)
	return( AC_REPAINT)

*==================================================================================================   
   
#define SHIFT_F1 -10   
Case LastKey() = K_F1 .or. LastKey() = SHIFT_F1
	HelpReceposi()	
	return( AC_CONT)
	
*==================================================================================================   
   
Case LastKey() = 10 /*K_CTRL_ENTER*/ .AND. oReceposi:PosiAgeAll
	cCodi := oReceposi:aCodi[ nCurElemento ]
	oReceposi:PosiAgeAll := FALSO
	NewPosiAgeInd( cCodi, nReg )
	oReceposi:PosiAgeAll := OK
	return( AC_CONT)

*==================================================================================================   
   
Case LastKey() = 10 /*K_CTRL_ENTER*/ .AND. oReceposi:PosiAgeInd
	if !ladmin
		if !PodeAlterar()
			alertaPy(' INFO: Utilize as teclas CTRL + P para imprimir RECIBO! ;-;; Use ESC para retornar.;', 31 , false)			
		endif	
	else
		cCodi  := oReceposi:aCodi[ nCurElemento ]
	   nRecno := oReceposi:aRecno[nCurElemento]
      Agenda->(DbGoto(nRecno))
		AgendaDbedit(nRecno)
		oReceposi:Color_pFore[x] := oReceposi:CorAlterado			
		Repaint(NIL , x + 1)
		oReceposi:Color_pFore[x] := oReceposi:CorAlterado			
		return( AC_REDRAW )
	endif	
	return( AC_CONT)

*==================================================================================================   
   
Case LastKey() = 10 .or. LastKey() = 284 /*K_CTRL_ENTER* .or K_ALT_ENTER*/ .AND. oReceposi:Posireceber
	if !ladmin
		if !PodeAlterar()
			nNivel = SCI_ALTERACAO_DE_REGISTROS
			if !PedePermissao(nNivel)
				alertaPy(' INFO: Utilize as teclas CTRL + P para imprimir RECIBO! ;-;; Use ESC para retornar.;', 31 , false)			
				Return( AC_CONT)
			endif   
		endif	
	endif	
	x     := nCurElemento
	cCodi := oReceposi:aCodi[x]			
	nReg  := oReceposi:aRecno[x]					
	if AlteraReceber(oReceposi:xTodos[x, XTODOS_DOCNR], nReg)			
	   AtualizaReg(nReg)				   
		if cCodi != oReceposi:aCodi[x] // Mudou de cliente?			
			oReceposi:DeleteReg(x)
			return( AC_CURELEMENTO )
		endif	
		oReceposi:Color_pFore[x] := oReceposi:CorAlterado									
		//Repaint(NIL , x + 1)			
		return( AC_REDRAW )			
	endif					
	return( AC_CONT)
	
*==================================================================================================
	
Case LastKey() = -3 /*K_F4*/ .AND. oReceposi:PosiReceber// Duplicar
	if !ladmin
		if !PodeIncluir()
			alertaPy(' INFO: Utilize as teclas CTRL + P para imprimir RECIBO! ;-;; Use ESC para retornar.;', 31 , false)			
         return( AC_CONT)
		endif	
	endif
	Recemov->(DbGoto(nReg))
   if DuplicaDocnr()
	   oReceposi:AddColor(oReceposi:CorDuplicado) 			
		Repaint(NIL , x + 1)
		oReceposi:Color_pFore[x]     := oReceposi:CorDuplicado			
		oReceposi:Color_pFore[x + 1] := oReceposi:CorDuplicado
		return( AC_REDRAW )				
	endif		
	return( AC_CONT)

*======== K_F3 ==========================================================================================   

Case LastKey() = -2 /*K_F3*/ .AND. oReceposi:PosiReceber 
	RecemovDbedit( cCodi, nReg)
	if AtualizaReg(nReg)	
		ReleaseSelecao()
		Repaint(NIL , x)
	endif	
	return( AC_REDRAW )				
	
Case LastKey() = -2 /*K_F3*/ .AND. oReceposi:PosiAgeInd 
	ReceposiAgendaDbedit(cCodi, nReg)
   Repaint(NIL , x)
	return( AC_REDRAW )

*==================================================================================================
	
Case LastKey() = -90 .AND. oReceposi:PosiReceber 
	RecemovDbedit( cCodi, nReg)
	if AtualizaReg(nReg)	
		ReleaseSelecao()
		Repaint(NIL , x)
	endif	
	return( AC_REDRAW )					
	
*==================================================================================================
	
Case LastKey() = -3 /*K_F4*/ .AND. oReceposi:PosiAgeInd .OR. LastKey() = K_F4 .AND. oReceposi:PosiAgeAll // Duplicar
	if !ladmin
		if !PodeIncluir()
			alertaPy(' INFO: Utilize as teclas CTRL + P para imprimir RECIBO! ;-;; Use ESC para retornar.;', 31 , false)			
		endif	
	else
		Agenda->(DbGoto(nReg))
      if DuplicaAgenda()
			oReceposi:AddColor(oReceposi:CorDuplicado)		
			Repaint(NIL , x + 1 )
			oReceposi:Color_pFore[x]     := oReceposi:CorDuplicado			
			oReceposi:Color_pFore[x + 1] := oReceposi:CorDuplicado			
			return( AC_REDRAW )				
		endif	
	endif	
	return( AC_CONT)

*==================================================================================================
	
Case LastKey() = -4 /*K_F5*/ .AND. oReceposi:PosiReceber // Atualizar tela
   if oAmbiente:lReceber
		if AtualizaReg(nReg)	
			ReleaseSelecao()
			Repaint(cCodi, x)
		endif	
	endif	
	return( AC_REDRAW )					
		
*======================K_CTRL_P====================================================================
		
Case LastKey() = 16 /*K_CTRL_P*/ 
   if oReceposi:PosiReceber
      if len(oReceposi:aDocnr_Selecao_Imprimir) > 0 // Selecao a imprimir
         if (ReciboIndividual( cCaixa, NIL, NIL, oReceposi:aSoma_Selecao_Imprimir, oReceposi:aDocnr_Selecao_Imprimir, nil , nil , nil , oReceposi:aObs_Selecao_Imprimir ))
            oReceposi:ResetSelecao()
            return( AC_REDRAW)		
         endif	
      else
         x := nCurElemento
         if oReceposi:xTodos[x, XTODOS_DOCNR] == "000000-00"
            ErrorBeep()
            alertaPy(' ERRO: Escolha uma fatura valida. ;-;; Use ESC para retornar.;', 31 , false)	
            return( AC_REPAINT)		
         endif	
         ReciboIndividual( cCaixa, NIL, NIL, oReceposi:xTodos[nCurElemento,9], oReceposi:xTodos[nCurElemento,1])
      endif	
      return( AC_REPAINT)		
   endif
   
   if oReceposi:PosiAgeInd .or. oReceposi:PosiAgeAll
      FichaAtendimento( cCaixa, cVendedor, oReceposi:xTodos, nCurElemento)
      return( AC_CONT)
   endif
   
   return( AC_CONT)
   
*==================================================================================================		
		
Case LastKey() = 22 /*K_INS*/ .AND. oReceposi:PosiReceber
	AgeCobranca( cCodi)	
	//NewPosiAgeInd( cCodi)
	return( AC_REDRAW)

Case LastKey() = 22 /*K_INS*/ .AND. oReceposi:PosiAgeInd
	if AgeCobranca( cCodi )
		oReceposi:AddColor(oReceposi:CorDuplicado)
		Repaint()
		return( AC_REDRAW)
	endif
	return( AC_CONT)	
	
Case LastKey() = 22 /*K_INS*/ .AND. oReceposi:PosiAgeAll
	if AgeCobranca( cCodi )
		Repaint()
		return( AC_REDRAW)
	endif	
	return( AC_CONT)	
	
*===============================================================================					
		
Case LastKey() = K_CTRL_INS .or. LastKey() = 418 /* K_ALT_INS */ 
	if oReceposi:PosiAgeInd .OR. oReceposi:PosiAgeAll
		AgeCobranca( cCodi )
		return( AC_CONT)
	else
	   K_Ctrl_Ins()		
		return( AC_REPAINT )
	endif
	return( AC_CONT)
	
*===============================================================================			

Case LastKey() = 403 .or. LastKey() = 419 /*K_CTRL_DEL .or. K_ALT_DEL*/ 
	K_Ctrl_Del()	
	return( AC_REPAINT)

*=======================K_ENTER========================================================				
		
Case LastKey() = 13 /*K_ENTER*/ .AND. oReceposi:PosiAgeAll
	if oReceposi:PosiReceber .AND. oReceposi:PosiAgeInd	
		return( AC_CONT)
	endif
	NewPosiReceber(NCHOICE_CODI, cCodi)
	return( AC_CONT)

Case LastKey() = 13 /*K_ENTER*/ .AND. oReceposi:PosiAgeInd
 	if oAmbiente:lReceber .OR. oReceposi:PosiReceber
		alertaPy(' INFO: Novamente? rsrs  ;-;; Use ESC para retornar.;', 31 , false)	
		return( AC_CONT)		
	endif		
	if oAmbiente:lRecepago
		alertaPy(' INFO: Novamente? rsrs  ;-;; Use ESC para retornar.;', 31 , false)	
	else
		NewPosiReceber(NCHOICE_CODI, cCodi)	
	endif	
	return( AC_CONT)

Case LastKey() = 13 /*K_ENTER*/ .AND. oReceposi:PosiReceber
	if oAmbiente:PosiAgeInd .OR. oReceposi:PosiAgeInd .OR. oReceposi:PosiAgeAll
		alertaPy(' INFO: Novamente? rsrs  ;-;; Use ESC para retornar.;', 31 , false)	
		return( AC_CONT)
	endif
	if oRecePosi:lReceberPorPeriodo			   
	   NewPosiReceber(NCHOICE_CODI, cCodi)
		return( AC_CONT)
	endif 	
	NewPosiAgeInd( cCodi)
	return( AC_CONT)

Case LastKey() = 13 /*K_ENTER*/
	if lStack = NIL
		lStack := OK
		NewPosiReceber(NCHOICE_CODI, cCodi)
		lStack := NIL
		oRecePosi:Redraw_()
		return( AC_REPAINT)
	else
		alertaPy(' ERRO: ESC retornar, apos escolha outro cliente ou CTRL+P imprimir.INFO: Novamente? rsrs  ;-;; Use ESC para retornar.;', 31 , false)	
	endif
	return( AC_CONT)

*=======================K_F6========================================================					
Case LastKey() = -5  /*K_F6*/
	if oReceposi:PosiAgeInd .OR. oReceposi:PosiAgeAll
		Return( AC_CONT)
	endif

	if oReceposi:PosiReceber
		aMenu := {;
						"Mostrar em Ordem [VCTO   ][DOCNR ]",;
						"Mostrar em Ordem [DATAPAG][VCTO  ]",;
						"Mostrar em Ordem [DATAPAG][VCTO  ][DOCNR]",;
						"Mostrar em Ordem [DATAPAG][DOCNR ][VCTO ]",;
						"Mostrar em Ordem [DATAPAG][FATURA][DOCNR][VCTO]",;
						"Mostrar em Ordem [VCTO]",;
						"Mostrar em Ordem [DOCNR]";
					 }
					 
		M_Title("ESCOLHA A ORDEM DE VISUALIZACAO")
		nOp := FazMenu( 10,10, aMenu, Cor())
		Do Case
		Case nOp = 0
			Return(AC_CONT)
		Case nOp = 1
		   PosiReceber(NCHOICE_CODI, cCodi, nil, nil, XTODOS_VCTO_DOCNR )			
		Case nOp = 2     
		   PosiReceber(NCHOICE_CODI, cCodi, nil, nil, XTODOS_DATAPAG_VCTO )			
		Case nOp = 3     
		   PosiReceber(NCHOICE_CODI, cCodi, nil, nil, XTODOS_DATAPAG_VCTO_DOCNR )
		Case nOp = 4     
		   PosiReceber(NCHOICE_CODI, cCodi, nil, nil, XTODOS_DATAPAG_DOCNR_VCTO )			
		Case nOp = 5     
		   PosiReceber(NCHOICE_CODI, cCodi, nil, nil, XTODOS_DATAPAG_FATURA_DOCNR_VCTO )	
		Case nOp = 6     
		   PosiReceber(NCHOICE_CODI, cCodi, nil, nil, XTODOS_VCTO )							
		Case nOp =7      
		   PosiReceber(NCHOICE_CODI, cCodi, nil, nil, XTODOS_DOCNR )				
		EndCase
		oRecePosi:Redraw_()
      return( AC_REPAINT)
	endif
	return( AC_REPAINT)

*=======================K_F2========================================================					

Case LastKey() =-1 /*K_F2*/
	if oReceposi:PosiAgeInd .OR. oReceposi:PosiAgeAll
	 	return( AC_CONT)
	endif

	if oReceposi:PosiReceber	   
      if AltJrInd(1,NIL, cCodi, nil, oSender := oReceposi)
			Repaint( cCodi, x)         
			return( AC_REDRAW)
      endif
	endif
	return( AC_CONT)
	
*=======================K_DEL========================================================

Case LastKey() = 7 /*K_DEL*/ .AND. oReceposi:Posireceber
	if oReceposi:PosiReceber
		if !PodeExcluir()
         nNivel = SCI_EXCLUSAO_DE_REGISTROS
         if !PedePermissao(nNivel)
            Return( AC_CONT)
         endif
      endif		
      if Conf("Pergunta: Deletar registro RECEMOV?")
         Recemov->(DbGoto(oReceposi:aRecno[x]))
         if Recemov->(TravaReg())
            Recemov->(DbDelete())
				Recemov->(Libera())
				oReceposi:DeleteReg(x)
				//Repaint( cCodi, x)
				return( AC_CURELEMENTO)
			endif	
      endif
   endif
	return( AC_CONT )
	
Case LastKey() = 7 /*K_DEL*/ .AND. oReceposi:PosiAgeInd .OR. oReceposi:PosiAgeAll
	if oReceposi:PosiAgeInd .OR. oReceposi:PosiAgeAll	
      if !PodeExcluir()
         nNivel = SCI_EXCLUSAO_DE_REGISTROS
         if !PedePermissao(nNivel)
            return( AC_CONT )
         endif
      endif
      if Conf("Pergunta: Deletar registro AGENDA?")
         Agenda->(DbGoto(oReceposi:aRecno[nCurElemento]))
         if Agenda->(TravaReg())
            Agenda->(DbDelete())
				Agenda->(Libera())
				if Agenda->(!DbSeek( cCodi ))
					return( AC_ABORT)
				endif	
				Repaint( cCodi, x)
				return( AC_REDRAW )
			endif	
		endif
   endif
	return( AC_CONT )

*=======================K_CTRL_ASTERISK========================================================
   
//Case LastKey() = 406 // K_CTRL_ASTERISK // ASTERISTICO
Case LastKey() = 8 // K_CTRL_ASTERISK // ASTERISTICO
	if oReceposi:PosiReceber
	   if Conf("Pergunta: Lancar juros nao pagos?")			
	      nLen  := Len( oReceposi:xTodos)
			cTela := Mensagem("Aguarde, Lancando juros nao pagos.")
		   for x := 2 to nLen
				if oReceposi:aAtivoSwap[x] != NIL .AND. oRecePosi:aAtivoSwap[x]			   
					loop					
				endif	
		      Recemov->(DbGoto(oReceposi:aRecno[x]))
		      if (Carencia( oReceposi:xTodos[x, XTODOS_DATAPAG], oReceposi:xTodos[x, XTODOS_VCTO])) > 0 // Atraso maior que a carencia?
   				lLancarJurosNaoPago   := OK
					lAjustarValorOriginal := OK					
	   			if (ReciboIndividual( cCaixa, NIL, NIL, oReceposi:xTodos[x,9], oReceposi:xTodos[x,1], lLancarJurosNaoPago, oReceposi:xTodos[x, XTODOS_MULTA], oReceposi:xTodos[x, XTODOS_DATAPAG], NIL, lAjustarValorOriginal))
					   oReceposi:AddColor(oReceposi:CorDuplicado)
					endif
				endif
			next	
			Restela( cTela )
			AltJrInd(1, NIL, cCodi, (lMsg := FALSO), oSender := oReceposi)
			Repaint( cCodi, x)         
         return( AC_REDRAW)
		endif		
	endif	
   return( AC_REPAINT)

*======================= ASTERISK ========================================================
	
Case LastKey() = 42 /*ASTERISTICO*/
	if oReceposi:PosiReceber		
		if !(oRecePosi:aReciboImpresso[x])
		//if oReceposi:aAtivoSwap[x] != NIL .AND. oRecePosi:aAtivoSwap[x]
			alertaPy(' ERRO: Selecione uma parcela paga! ;-;; Use ESC para retornar.;', 31 , false)			
			return( AC_REPAINT)	
		endif
	   if Conf("Pergunta: Lancar juros nao pagos desta parcela?")			
			//if oReceposi:aAtivoSwap[x] != NIL .AND. !oRecePosi:aAtivoSwap[x]
				cTela := Mensagem("Aguarde, Lancando juros nao pagos.")				
				Recemov->(DbGoto(oReceposi:aRecno[x]))
				if (Carencia( oReceposi:xTodos[x, XTODOS_DATAPAG], oReceposi:xTodos[x, XTODOS_VCTO])) > 0 // Atraso maior que a carencia?
					lLancarJurosNaoPago   := OK
					lAjustarValorOriginal := OK
					if (ReciboIndividual( cCaixa, NIL, NIL, oReceposi:xTodos[x,XTODOS_SOMA], oReceposi:xTodos[x,XTODOS_DOCNR], lLancarJurosNaoPago, oReceposi:xTodos[x, XTODOS_MULTA], oReceposi:xTodos[x, XTODOS_DATAPAG], NIL, lAjustarValorOriginal))
						Restela( cTela )
						AltJrInd(1, NIL, cCodi, (lMsg := FALSO), oSender := oReceposi)
						oReceposi:AddColor(oReceposi:CorDuplicado)
						Repaint( cCodi, x)         
						return( AC_REDRAW)
					endif	
				endif
				Restela( cTela )
			//endif		
		endif
	endif	
   return( AC_REPAINT)	
	
*=======================K_CTRL_F5========================================================   
   
Case LastKey() =  -24 /*K_CTRL_F5*/ // Ajustar valor original parcela paga 
	if oReceposi:PosiReceber		
		if !(oRecePosi:aReciboImpresso[x])
		//if oReceposi:aAtivoSwap[x] != NIL .AND. oRecePosi:aAtivoSwap[x]
			alertaPy(' ERRO: Selecione uma parcela paga! ;-;; Use ESC para retornar.;')			
			return( AC_REPAINT)	
		endif
	   if Conf("Pergunta: Ajustar valor original?")			
			//if oReceposi:aAtivoSwap[x] != NIL .AND. !oRecePosi:aAtivoSwap[x]
				cTela := Mensagem("Aguarde, Lancando juros nao pagos.")				
				Recemov->(DbGoto(oReceposi:aRecno[x]))
				if (Carencia( oReceposi:xTodos[x, XTODOS_DATAPAG], oReceposi:xTodos[x, XTODOS_VCTO])) > 0 // Atraso maior que a carencia?
					lLancarJurosNaoPago   := OK
					lAjustarValorOriginal := OK					
					if (ReciboIndividual( cCaixa, NIL , NIL , oReceposi:xTodos[x,XTODOS_SOMA], oReceposi:xTodos[x,XTODOS_DOCNR], lLancarJurosNaoPago, oReceposi:xTodos[x, XTODOS_MULTA], oReceposi:xTodos[x, XTODOS_DATAPAG], NIL , lAjustarValorOriginal))
						Restela( cTela )
						AltJrInd(1, NIL, cCodi, (lMsg := FALSO), oSender := oReceposi)
						oReceposi:AddColor(oReceposi:CorAlterado)
						Repaint( cCodi, x)         
						return( AC_REDRAW)
					endif	
				endif
				Restela( cTela )
			//endif		
		endif
	endif	
   return( AC_REPAINT)		

*=======================K_F7========================================================
	
Case LastKey() = -6 /*K_F7*/ .AND. oReceposi:Posireceber
   x := nCurElemento
	if oReceposi:xTodos[x, XTODOS_DOCNR] == "000000-00"
		ErrorBeep()
		alertaPy(' ERRO: Escolha uma fatura valida. ;-;; Use ESC para retornar.;', 31 , false)	
		return( AC_REPAINT)		
	endif	
	Ped_Cli9_2(oReceposi:xTodos[x, XTODOS_FATURA])
   return( AC_REPAINT)			


*=======================K_CTRL_F7========================================================
	
#define SHIFT_F7 -16   
Case LastKey() = -26 /*K_CTRL_F7*/ .or. lastkey() = SHIFT_F7 .and. oReceposi:Posireceber
	x := nCurElemento
	if oReceposi:xTodos[x, XTODOS_DOCNR] == "000000-00"
		ErrorBeep()
		alertaPy(' ERRO: Escolha uma fatura valida. ;-;; Use ESC para retornar.;', 31 , false)	
		return( AC_REPAINT)		
	endif	
	if oReceposi:PosiReceber		
		if (ManuFatura( cCaixa, NIL , OK, oReceposi:xTodos[x, XTODOS_FATURA]))
			AreaAnt( Arq_Ant, Ind_Ant )
			AltJrInd(1 , NIL , cCodi, (lMsg := FALSO), oSender := oReceposi)
			Repaint( cCodi, x)
		endif	
	endif
	return( AC_REDRAW)			

*=======================K_CTRL_F10========================================================   
   
Case LastKey() = -29 /*K_CTRL_F10*/ .AND. oReceposi:Posireceber
	x := nCurElemento	
	if oReceposi:PosiReceber		
		Orcamento(OK, cCaixa)
		AreaAnt( Arq_Ant, Ind_Ant )
		AltJrInd(1 , NIL , cCodi, (lMsg := FALSO), oSender := oReceposi)	
		Repaint( cCodi, x)
	endif
	return( AC_REDRAW)			
   
*=======================TECLA_MAIS========================================================   
	
Case LastKey() = 43 /*TECLA_MAIS*/ .AND. oReceposi:Posireceber
	x := nCurElemento
	if oReceposi:xTodos[x, XTODOS_DOCNR] == "000000-00"
		ErrorBeep()
		alertaPy(' ERRO: Escolha uma fatura valida. ;-;; Use ESC para retornar.;', 31 , false)	
		return( AC_REPAINT)		
	endif	
	
	if oReceposi:PosiReceber
      oReceposi:aAtivo[nCurElemento] := FALSO
		Aadd( oReceposi:aDocnr_Selecao_Imprimir, oReceposi:xTodos[nCurElemento, 1])
		Aadd( oReceposi:aSoma_Selecao_Imprimir,  oReceposi:xTodos[nCurElemento, 9])
		Aadd( oReceposi:aObs_Selecao_Imprimir,   oReceposi:xTodos[nCurElemento, XTODOS_OBS])		
		Aadd( oReceposi:aCurElemento_Selecao,    nCurElemento )		
		oReceposi:nSoma_Total_Imprimir        += oReceposi:xTodos[nCurElemento, 9]
		oReceposi:nPrincipalSelecao           += oReceposi:xTodos[nCurElemento, 5] 
		oReceposi:nMultaSelecao               += oReceposi:xTodos[nCurElemento, XTODOS_MULTA]
		oReceposi:nJurosSelecao               += oReceposi:xTodos[nCurElemento, XTODOS_JUROS]
		oReceposi:nRescisaoSelecao            += oReceposi:aRescisao[nCurElemento]		
		oReceposi:RedrawSelecao()	
		oReceposi:Color_pUns[nCurElemento]    := oReceposi:CorSelecao 		
		oReceposi:CloneVarColor()
		//oReceposi:Displine( oReceposi:aTodos[nCurElemento], oReceposi:nTop + oReceposi:nPos - oReceposi:nAtTop, oReceposi:nLeft, .T., .T., oReceposi:nNumCols, nCurElemento )				
		return( AC_REDRAW)							
   endif
	return( AC_CONT)
	
*=======================TECLA_MENOS========================================================   
   
Case LastKey() = 45 /*TECLA_MENOS*/ .AND. oReceposi:Posireceber
	if oReceposi:PosiReceber	
		x := nCurElemento
		x := len(oReceposi:aDocnr_Selecao_Imprimir) 		
		if x > 0                                                       // Algum item selecionado?
			nCurElemento := oReceposi:aCurElemento_Selecao[x]           // Ultimo item selecionado
			oReceposi:nSoma_Total_Imprimir        -= oReceposi:xTodos[nCurElemento, 9]
			oReceposi:nPrincipalSelecao           -= oReceposi:xTodos[nCurElemento, 5] 
			oReceposi:nMultaSelecao               -= oReceposi:xTodos[nCurElemento, XTODOS_MULTA]
			oReceposi:nJurosSelecao               -= oReceposi:xTodos[nCurElemento, XTODOS_JUROS]			
			oReceposi:nRescisaoSelecao            -= oReceposi:aRescisao[nCurElemento]		
			Asize( oReceposi:aDocnr_Selecao_Imprimir,  (x-1))
			Asize( oReceposi:aSoma_Selecao_Imprimir,   (x-1))
			Asize( oReceposi:aObs_Selecao_Imprimir,    (x-1))
			Asize( oReceposi:aCurElemento_Selecao,     (x-1))
			oReceposi:aAtivo[nCurElemento]             := OK						
			oReceposi:RedrawSelecao()		
			oReceposi:CurElemento := nCurElemento
			oReceposi:CloneVarColor()
			//oReceposi:Displine( oReceposi:aTodos[nCurElemento], oReceposi:nTop + oReceposi:nPos - oReceposi:nAtTop, oReceposi:nLeft, .T., .T., oReceposi:nNumCols, nCurElemento )
			
			if (x-1) = 0 // Nao sobrou nenhuma selecao
				oReceposi:ResetAll()			
			endif			
			return( AC_CURELEMENTO)			
		endif
	endif
	return( AC_CONT)
   
*=======================K_SPACE========================================================   

Case LastKey() = 32 /*K_SPACE*/
	x := nCurElemento
	if oReceposi:xTodos[x, XTODOS_DOCNR] == "000000-00"
		ErrorBeep()
		alertaPy(' ERRO: Escolha uma fatura valida. ;-;; Use ESC para retornar.;', 31 , false)	
		return( AC_REPAINT)		
	endif	
	if oReceposi:PosiAgeInd .OR. oReceposi:PosiAgeAll
		return( AC_CONT)
	endif
	if oReceposi:PosiReceber
		if !oAmbiente:lK_Insert			
			if oAmbiente:lReceber  //Contas a Receber	         
				oAmbiente:lK_Insert := OK
				oAmbiente:ZebrarAmostragem := OK 				
				NewPosiReceber(NCHOICE_FATURA, oReceposi:xTodos[nCurElemento, XTODOS_FATURA])			   
				oAmbiente:lReceber := OK
				oAmbiente:ZebrarAmostragem := FALSO
				Repaint( cCodi, x)
			else						  // Contas recebidas
				NewPosiReceber(NCHOICE_FATURA, oReceposi:xTodos[nCurElemento, XTODOS_FATURA])			   				
			endif
			oAmbiente:lK_Insert := FALSO
		else
			if !oAmbiente:lK_Insert_Plus			   
			   oAmbiente:lK_Insert_Plus   := OK			
				NewPosiReceber(NCHOICE_DOCNR_PARCIAL, {oReceposi:xTodos[nCurElemento, XTODOS_DOCNR], oReceposi:xTodos[nCurElemento, XTODOS_CODI], oReceposi:xTodos[nCurElemento, XTODOS_DATAPAG], oReceposi:xTodos[nCurElemento, XTODOS_DATAPAG]})			   
				oAmbiente:lK_Insert_Plus   := FALSO
			else
				alertaPy(' INFO: Novamente? rsrs ;-;; Use ESC para retornar.;', 31 , false)	
			endif						
		endif
	endif
	return( AC_REDRAW )			

*=======================K_CTRL_+========================================================	
	
Case LastKey() = 400 // K_CTRL_+
	if oReceposi:PosiAgeInd .OR. oReceposi:PosiAgeAll
		return( AC_CONT)
	endif
	if oReceposi:PosiReceber
		if !oAmbiente:lK_Insert
			oAmbiente:lK_Insert := OK
			if oAmbiente:lReceber  //Contas a Receber	         
				NewPosiReceber(NCHOICE_DATAPAG, {oReceposi:xTodos[nCurElemento, XTODOS_CODI], oReceposi:xTodos[nCurElemento, XTODOS_DATAPAG], oReceposi:xTodos[nCurElemento, XTODOS_DATAPAG]})
				oAmbiente:lK_Insert := FALSO
				oAmbiente:lReceber := OK
				iif(oReceposi:nOrdem == 3, NIL , Repaint(cCodi, x))
				if oAmbiente:lK_Ctrl_Ins 
				   K_Ctrl_Ins() 
				endif	
			else						  // Contas recebidas
				NewPosiReceber(NCHOICE_DATAPAG, {oReceposi:xTodos[nCurElemento, XTODOS_CODI], oReceposi:xTodos[nCurElemento, XTODOS_DATAPAG], oReceposi:xTodos[nCurElemento, XTODOS_DATAPAG]})
			endif
			oAmbiente:lK_Insert := FALSO
		else
			alertaPy(' INFO: Novamente? rsrs ;-;; Use ESC para retornar.;', 31 , false)	
		endif
	endif
	return( AC_REDRAW )				
	
OtherWise
   return( AC_CONT)
	
EndCase
return nil

*===============================================================================					

def Repaint(cCodi, nCurElemento, nChoice)
*****************************************
	LOCAL lRecarregar := FALSO
	LOCAL nLen
	LOCAL xParam
	DEFAU cCodi   TO oReceposi:aCodi[oReceposi:CurElemento]
	DEFAU nChoice TO oReceposi:nChoice

	hb_default(@xParam, iif(nChoice == 1, cCodi, oReceposi:xParam))
	oReceposi:ColorToAmbiente()		
	if oReceposi:Posireceber
		PosiReceber(nChoice, xParam, NIL, NIL, NIL, NIL, FALSO)
	elseif oReceposi:PosiAgeInd 
		PosiAgeInd(cCodi, NIL, FALSO)
	elseif oReceposi:PosiAgeAll
		PosiAgeAll(FALSO)
	endif	
	nLen := Len(oReceposi:aTodos)
	DEFAU nCurElemento TO nLen 

	oReceposi:CurElemento := iif(nCurElemento > nlen, nLen, nCurElemento)
	oRecePosi:ImprimeSoma()
	//oReceposi:RedrawSelecao()
	return NIL
endef

def AtualizaReg(nReg)
*********************
	LOCAL aJuro := {}
	LOCAL nT    := oReceposi:CurElemento 

	Recemov->(DbGoto(nReg))
	aJuro := CalcCmJuros( 1 , NIL , Recemov->Vlr, Recemov->Vcto, Date())

	if Recemov->(TravaReg())   
		Recemov->Juro      := aJuro[1]
		Recemov->JuroDia   := aJuro[2]
		Recemov->JuroTotal := aJuro[3]
		if Recibo->(DbSeek(Recemov->Docnr))
			Recemov->Datapag := Recibo->Data
			Recemov->VlrPag  := Recibo->Vlr
			Recemov->StPag   := OK
		endif	
		Recemov->(Libera())
		oReceposi:xTodos[nT, XTODOS_CODI]   := Recemov->Codi
		oReceposi:xTodos[nT, XTODOS_DOCNR]  := Recemov->Docnr
		oReceposi:xTodos[nT, XTODOS_EMIS]   := Recemov->Emis
		oReceposi:xTodos[nT, XTODOS_VCTO]   := Recemov->Vcto	
		oReceposi:xTodos[nT, XTODOS_OBS]    := Recemov->Obs
		oReceposi:xTodos[nT, XTODOS_VLR]    := Recemov->Vlr	
		oReceposi:xTodos[nT, XTODOS_ATRASO] := Date() - Recemov->Vcto
		oReceposi:xTodos[nT, XTODOS_SOMA]   := AtualizaSoma(oReceposi)[3]	
		oReceposi:xTodos[nT, XTODOS_MULTA]  := AtualizaSoma(oReceposi)[1]
		oReceposi:xTodos[nT, XTODOS_JUROS]  := AtualizaSoma(oReceposi)[2]		
		oReceposi:xTodos[nT, XTODOS_SOMA]   := AtualizaSoma(oReceposi)[3]
		oRecePosi:sTrFormataATodos(nT)
		SeekLog(oReceposi:xTodos, oReceposi:aTodos, nT)
		oReceposi:Displine( oReceposi:aTodos[nT], oReceposi:nTop + oReceposi:nPos - oReceposi:nAtTop, oReceposi:nLeft, .T., .T., oReceposi:nNumCols, nT )
		oRecePosi:aBottom := oReceposi:BarraSoma()
		return OK
	endif	
	return FALSO
endef

function AtualizaSoma(oSender)
******************************
LOCAL nAtraso    := Atraso( oSender:dCalculo, Recemov->Vcto )
LOCAL nVlr       := Recemov->Vlr
LOCAL nDiaComUso := 0
LOCAL nDiaSemUso := 0
LOCAL nVlrComUso := 0
LOCAL nVlrSemUso := 0
LOCAL nCarencia  := 0
LOCAL nMulta     := 0
LOCAL nDesconto  := 0
LOCAL nJuroDia   := 0
LOCAL nJuros     := 0
LOCAL nSoma      := 0

if oSender:lRescisao
	if nAtraso < 0
		if nAtraso < -30
			nVlr *= 0.5  // Metade da Mensalidade de Rescisao
		else
			nDiaComUso := (30 + nAtraso)
			nDiaSemUso := (30 - nDiaComUso)
			nVlrComUso := (nDiaComUso * (nVlr/30))
			nVlrSemUso := (nDiaSemUso * (nVlr/30)*0.5)
			nVlr		  := (nVlrComUso + nVlrSemUso)
		endif
	endif
endif
if oSender:lCalcular
	nCarencia	:= Carencia( oSender:dCalculo, Recemov->Vcto )		 
	nMulta		:= 0
	nDesconto	:= VlrDesconto( oSender:dCalculo, Recemov->Vcto, nVlr )
	nJurodia 	:= Recemov->Jurodia
	nJuros		:= IF( nAtraso <= 0, 0, ( nCarencia * nJurodia ))
endif
nSoma 		:= ((nVlr + nMulta ) + nJuros ) - nDesconto
nMulta		:= VlrMulta( oSender:dCalculo, Recemov->Vcto, nSoma )
nSoma 		+= nMulta
return {nMulta, nJuros, nSoma}

function ReleaseSelecao()
*************************
nLen := len(oReceposi:aDocnr_Selecao_Imprimir) 				
if nLen > 0                                                   
   for x := 1 to nLen				
		nCurElemento                       := oReceposi:aCurElemento_Selecao[x]       
		oReceposi:Color_pUns[nCurElemento] := oReceposi:CorRecibo
		oReceposi:aAtivo[nCurElemento]     := OK						
		oReceposi:RedrawSelecao()		
	next	
	oReceposi:ResetAll()			
	oReceposi:CloneVarColor()
endif	

def RecemovDbedit(cCodi, nRecno)
   LOCAL Arq_Ant	:= Alias()
   LOCAL Ind_Ant	:= IndexOrd()
   LOCAL cScreen	:= SaveScreen()
   LOCAL oBrowse	:= MsBrowse():New()
   LOCAL cDocnr   
   Set Key -2 To

   oMenu:Limpa()
   Area("Recemov")
   Recemov->(Order( RECEMOV_CODI ))
   Recemov->(Sx_ClrScope( S_TOP, cCodi))
   Recemov->(Sx_ClrScope( S_BOTTOM, cCodi))
   Recemov->(DbGoto(nRecno))
   oBrowse:Add( "CODI",       "Codi")
   oBrowse:Add( "TIPO",       "Tipo")
   oBrowse:Add( "DOCNR",      "Docnr")
   oBrowse:Add( "FATURA",     "Fatura")
   oBrowse:Add( "EMIS",       "Emis")
   oBrowse:Add( "VCTO",       "Vcto")
   oBrowse:Add( "VLR",        "Vlr")
   oBrowse:Add( "VLR ORIGINAL","VlrOrigina")
   oBrowse:Add( "DATAPAG",    "Datapag")
   oBrowse:Add( "VLRPAG",     "Vlrpag")
   oBrowse:Add( "OBS",        "Obs")
   oBrowse:Titulo   := "CONSULTA/ALTERACAO DE TITULOS A RECEBER"
   oBrowse:Show()
   oBrowse:Processa()
   Recemov->(Sx_ClrScope(S_TOP))
   Recemov->(Sx_ClrScope(S_BOTTOM))
   Recemov->(DbGoTop())
   AreaAnt( Arq_Ant, Ind_Ant )
   return(resTela(cScreen))
endef

def ReceposiAgendaDbedit(cCodi, nRecno)
   LOCAL Arq_Ant	:= Alias()
   LOCAL Ind_Ant	:= IndexOrd()
   LOCAL cScreen	:= SaveScreen()
   LOCAL oBrowse	:= MsBrowse():New()
   LOCAL cDocnr   
   Set Key -2 To
  
   oMenu:Limpa()
   Area("Agenda")
   Agenda->(Order( AGENDA_CODI ))
   Agenda->(Sx_ClrScope( S_TOP, cCodi))
   Agenda->(Sx_ClrScope( S_BOTTOM, cCodi))
   Agenda->(DbGoto(nRecno))
   oBrowse:Add( "DATA",       "Data")
   oBrowse:Add( "HORA",       "Hora")
   oBrowse:Add( "USER",       "Usuario")
   oBrowse:Add( "OBSERVACOES AGENDADA",      "Hist")   
   oBrowse:Titulo   := "CONSULTA/ALTERACAO DE AGENDAMENTO"   
   oBrowse:PreDoGet := nil
   oBrowse:PosDoGet := nil
   oBrowse:PreDoDel := nil
   oBrowse:PosDoDel := nil
   oBrowse:Show()
   oBrowse:Processa()   
   Agenda->(Sx_ClrScope(S_TOP))
   Agenda->(Sx_ClrScope(S_BOTTOM))
   Agenda->(DbGoTop())
   AreaAnt( Arq_Ant, Ind_Ant )
   return(resTela(cScreen))
endef

def RefreshTela()
*****************
   LOCAL xLen		   := Len(oRecePosi:xTodos)
   LOCAL aJuro       := {}
   LOCAL nReg

   for nT := 1 To xLen
      nReg  := oReceposi:aRecno[nT]
      AtualizaReg(nReg)
   next	
   //oRecePosi:aBottom := oReceposi:BarraSoma()
   return OK
endef

def K_Ctrl_Ins() 
****************
   LOCAL nTamAtivo := Len(oRecePosi:aAtivo)
         
   for x := 1 To nTamAtivo
      oRecePosi:aAtivo[x] := OK
      if !oRecePosi:aAtivoSwap[x]
         oReceposi:Color_pFore[x] := oReceposi:CorDesativado
      endif
   next		
   oReceposi:ResetSelecao()
   oAmbiente:lK_Ctrl_Ins := OK
   oAmbiente:lK_Ctrl_Del := FALSO
   return NIL
endef
   
def K_Ctrl_Del() 
****************		
   LOCAL nTamAtivo := Len(oRecePosi:aAtivo)

   For x := 1 To nTamAtivo
      oRecePosi:aAtivo[x] := oRecePosi:aAtivoSwap[x]
   Next	
   oReceposi:ResetSelecao()
   oAmbiente:lK_Ctrl_Ins := FALSO
   oAmbiente:lK_Ctrl_Del := OK
   return NIL	
endef
   
def HelpReceposi		
****************
	linhaembranco   := ';'
	linhahorizontal := '-'
	alertaPy(   '           F1 : ESTE HELP                         ' + ';' + ;
					'           F2 : ATUALIZAR TAXAS DE JUROS          ' + ';' + ;
					'           F3 : EDITAR LANCAMENTOS                ' + ';' + ;
					'           F4 : DUPLICAR REGISTRO                 ' + ';' + ;
					'           F5 : ATUALIZAR TELA                    ' + ';' + ;
					'           F6 : ESCOLHER ORDEM AMOSTRAGEM         ' + ';' + ;				
					'           F7 : VISUALIZAR FATURA                 ' + ';' + ;				
					'          F10 : CALCULADORA                       ' + ';' + ;								
					linhahorizontal + ';' + ;								
					'          INS : INSERIR REGISTRO                  ' + ';' + ;
					'          DEL : EXCLUIR REGISTRO                  ' + ';' + ;				
					'      TECLA + : SELECIONAR REGISTRO               ' + ';' + ;								
					'      TECLA - : DE-SELECIONAR REGISTRO            ' + ';' + ;
					'      TECLA * : LANCAR JUROS NŽO PAGOS PARCELA    ' + ';' + ;					
					'  BARRA SPACO : FILTRAR FATURA                    ' + ';' + ;				
					linhahorizontal + ';' + ;								
					'   CTRL+ENTER : ALTERAR REGISTRO                  ' + ';' + ;				
					'       CTRL+P : IMPRIMIR RECIBO                   ' + ';' + ;								
					'      CTRL+F5 : AJUSTAR VALOR ORIGINAL PARCELA    ' + ';' + ;
					'CTRL/SHIFT+F7 : ALTERAR FATURA                    ' + ';' + ;				
               '     CTRL+F10 : FATURAR                           ' + ';' + ;
				   '       CTRL+* : LANCAR JUROS NAO PAGOS GERAL      ' + ';' + ;
					'       CTRL_+ : FILTRAR RECEBIDO POR DATAPAG      ', 31, OK)			
	return nil
endef	
	
def UltimaTecla()	
   LOCAL nKey := LastKey()
	//MS_SetConsoleTitle("TECLA # " + TrimStr(nKey))
   oMenu:ContaReg(TrimStr(nKey))
	return nKey
endef	

*==================================================================================================*
	
def EventStateAchoice()
	#include "hbgtinfo.ch"
	hb_gtInfo( HB_GTI_INKEYFILTER, { | nKey |			
			SWITCH nKey			
			CASE K_CTRL_INS				
				RETURN nKey
			ENDSWITCH
			RETURN nKey
		})
endef		

*==================================================================================================*

