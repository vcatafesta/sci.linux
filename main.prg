#include "common.ch"
#include "inkey.ch"
#include "box.ch"

#define CRLF            Chr(10)

REQUEST HB_GT_WIN_DEFAULT

FUNCTION Main
LOCAL GetList := {}
LOCAL cBotaoNovo := .t.
LOCAL cBotaoGravar := .t.
LOCAL cBotaoSair := .t.
LOCAL cLetraBotao := ""

Private cNome := Space(25)
Private cEndereco := Space(25)
Private cTelefone := Space(15)
Private lNovo := .F.

Private cCordoBotao:="GR+/B*,GR+/G,R+/N,GR+/R*"
Private cCordoGet:=("BG/N,W+/B"+"W+/R"+",,,"+"N/B")

ConfiguraAmbiente()
Setcolor("W/W")
CLS
SETKEY( K_ALT_G, { || SetaBotao('G') } )
SETKEY( K_ALT_S, { || SetaBotao('S') } )
SETKEY( K_ALT_N, { || SetaBotao('N') } )

Do While .T.

  @ 2, 8, 12, 47 BOX B_DOUBLE + Space(1) Color "N/BG"
  HB_Shadow(2, 8, 12, 47)
  SetColor(cCordoGet)
  SET CURSOR ON
  
  @ 4, 10 SAY "Nome" + Space(10 - Len("Nome")) Color "W+/BG" GET cNome PICTURE "@A" When lNovo
  @ 6, 10 SAY "Endereco" + Space(10 - Len("Endereco")) Color "W+/BG" GET cEndereco PICTURE "@A" When lNovo
  @ 8, 10 SAY "Telefone" + Space(10 - Len("Telefone")) Color "W+/BG" GET cTelefone PICTURE "###-###-###" when lNovo

  @ 10, 11 GET cBotaoNovo PushButton CAPTION " &Novo " Color cCordoBotao STYLE "[]" STATE {|| SetaBotao('N') }
  @ 10, 23 GET cBotaoGravar PushButton CAPTION " &Gravar " Color cCordoBotao STYLE "[]" STATE {|| SetaBotao('G')}
  @ 10, 35 GET cBotaoSair PushButton CAPTION " &Sair " Color cCordoBotao STYLE "[]" STATE {|| SetaBotao('S')}
  
  READ
  SET CURSOR OFF
  if LASTKEY() = K_ESC; return .F.; endif
Enddo
return NIL

Function SetaBotao(cLetraBotao)
DO CASE
   CASE Upper(cLetraBotao) == "G"
        lNovo:=.F.
		hb_ALERT("gravar os dados no DBF ou SQL ->"+CRLF+CRLF+;
		      "Nome: "+cNome+CRLF+;
		      "Endereco: "+cEndereco+CRLF+;
		      "Telefone: "+cTelefone )
	    KEYBOARD Chr(3)
   CASE Upper(cLetraBotao) == "S"
        CLS
        Keyboard(chr(K_ESC))   
   CASE Upper(cLetraBotao) == "N"
        if !Empty(Alltrim(cNome)) .and. !Empty(Alltrim(cEndereco)) .and. !Empty(Alltrim(cTelefone))
		   hb_ALERT("gravar os dados no DBF ou SQL ->"+CRLF+CRLF+;
		         "Nome: "+cNome+CRLF+;
		         "Endereco: "+cEndereco+CRLF+;
		         "Telefone: "+cTelefone )
		endif
        cNome := Space(25)
		cEndereco := Space(25)
		cTelefone := Space(15)
		lNovo := .T.
		KEYBOARD Chr(3)
ENDCASE
return

Procedure ConfiguraAmbiente()
  // REQUEST SQLRDD
  // REQUEST SR_PGS
  REQUEST HB_LANG_PT
  REQUEST HB_CODEPAGE_UTF8
  REQUEST HB_CODEPAGE_UTF8EX
  REQUEST HB_GT_WVT_DEFAULT

  HB_CDPSELECT( "UTF8EX")
  HB_LANGSELECT("PT")

  mSetCursor(.T.)

  SETMODE(25,80)

  SET CONFIRM ON
  SET CURSOR OFF
  SET TYPEAHEAD TO 0
  SET INTENSITY ON
  SET SCOREBOARD OFF
  SET DELETED ON
  SET SAFETY OFF
  SET DATE ANSI
  SET ESCAPE ON
  SET CENTURY ON
  SET DELIMITERS TO
  SET EXCLUSIVE OFF
  SET WRAP ON
  SET EPOCH TO 1920
  SET OPTIMIZE ON
  SET MESSAGE TO 24 CENTER
  SET(_SET_DATEFORMAT,"dd/mm/yyyy")
  SET SOFTSEEK ON
  SET AUTOPEN OFF
 
  SetColor("B/N")
  SET EventMask to INKEY_ALL
                                                       
return