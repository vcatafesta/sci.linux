*------------------------------------------------------------------------------*
* Autor        : Luciano Borges Mancini                                        *
*------------------------------------------------------------------------------*
use REGISTRO
index on NUMERO to registro
index on NUMERO to reg0000
clear
do fcalcula
set key -9 to calcula()
_sistema='@ D V A N C E     C E L L U L A R'
do while .t.
        tic000(_sistema,'Cadastro/EmissÆo Codigo Barra',procname())
        set color to w+/b
        set message to 20 CENTER
        @ 04,00 clear to 21,79
        set color to gr+/b
        @ 04,01 say "           ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
        @ 05,01 say "           ³    Escolha logo abaixo qual a op‡Æo que deseja usar.   ³"
        @ 06,01 say "           ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
        set color to n/w,w/g+
        mp =0
        @ 19,22 TO 21,56
        SHOWTIME(01,01,.F.,"GR+/B",.F.,.F.)             // CHAMA O RELÓGIO NA TELA
        @ 07,17 prompt " 1 INCLUSÇO "     MESSAGE '      InclusÆo de Registro       '
        @ 07,32 prompt " 2 EXCLUSÇO "     MESSAGE '      ExclusÆo de Registro       '
        @ 07,47 prompt " 3 RELATORIOS "   MESSAGE '  Relat¢rio de C¢digos de Barra  '
        set inte on
        menu to mp
        set inte off
*        SHOWTIME() // Passe em branco para desligar
        if lastkey()= 27
           set color to
           clear
           set cursor on
           return
        endif
        do case
           case mp= 0
                loop
           case mp= 1
                do CADASTRA
           case mp= 2
                do EXCLUIR
           case mp= 3
                do REL
        endcase
enddo

*------------------------------------------------------------------------------*

Procedure CADASTRA
*---------------*
*
* Inclusao de Registros
*
sele 1
* Indice REG0000  -  Numero
use REGISTRO index REG0000
_controle  = .t.
do while .t.
        if _controle
                set color to gr+/b
                @ 04,01 clear to 21,78
                _frase = 'Cadastro de Registros'
                tic222()
                _numero = space(10)
        endif
        set color to n/w
        @ 07,22 get _numero      pict '@!K'+ repl('x',10)  valid numero()
        set cursor on
        read
        set cursor off
        if Lastkey() = 27
                close data
                return
        endif
        if waitsn('Confirma Inclus„o? (S/N)') = 'S'
                sele  1
                append blank
                replace numero   with _numero
                _controle = .f.
        endif
        set color to w+/b
enddo
return

Function numero
*-------------*
set cursor off
if empty(_numero)
        return .f.
endif
set cursor off
@ 08,22 say ''
sele 1
seek _numero
if found()
        Msg(23,15,'N£mero j  cadastrado.')
        set cursor on
        set color to n/w
        return .f.
endif
set cursor on
return .t.

*------------------------------------------------------------------------------*

Procedure EXCLUIR
*---------------*
*
sele 1
use REGISTRO index REG0000
_controle  = .t.
do while .t.
        @ 08,22 say ''
        if _controle
                set color to gr+/b
                @ 04,00 clear to 21,79
                _frase = 'ExclusÆo de Registros'
                tic222()
                _numero = space(10)
        endif
        _controle = .t.
        set color to n/w
        @ 07,22 get _numero     pict '@K xxxxxxxxxx'      valid numer1()
        set cursor on
        read
        set cursor off
        if Lastkey() = 27
           close data
           return
        endif
        if waitsn('Confirma Exclus„o? (S/N)') = 'S'
                delete
                pack
                commit
                _controle = .f.
        endif
enddo
return


Function numer1
*-------------*
set cursor off
if empty(_numero)
        return .f.
endif
set cursor off
@ 08,22 say ''
sele 1
seek _numero
if .not. found()
        set order to 1
        sele 1
        Msg(23,15,'N£mero  j   cadastrado.')
        set cursor on
        set color to n/w
        return .f.
endif
set cursor on
return .t.
*------------------------------------------------------------------------------*

Procedure msg
*-------------*
priv l,c,m
para l,c,m
set color to w+/r*
t0=savescreen(l,c,l,77)
@ l,c say m
set color to gr+/b,b/w+
clear type
tone(150,2)
do while inkey(0)<>13
        tone(150,2)
enddo
set color to
restscreen(l,c,l,77,t0)
retu

Procedure tic000
*--------------*
private _sist,_modulo,_c,_prg
paramet _sist,_modulo,_prg
set color to w+/r
@ 01,00 clear to 03,79
_sist  =iif(type('_sist')='C',alltrim(_sist),'')
_c     =iif(len(_sist)>0,40-int(len(_sist)/2),40)
@ 01,_c say iif(type('_sist')='C',alltrim(_sist),'')
set color to w+/rb+
@ 01,62 say 'F10 = Calculadora'
set color to w+/r
@ 02,01 say ldata()
_modulo=iif(type('_modulo')='C','ş '+alltrim(_modulo)+' ş','')
_c     =iif(len(_modulo)>0,40-int(len(_modulo)/2),40)
@ 02,_c say _modulo                             && nome do modulo atual
@ 02,(79-len(_prg)) say _prg                    && nome do prg do modulo atual
set color to N/w+
@ 03,00 clear to 24,79
@ 22,01 say repl('Í',78)
@ 23,02 say "Mensagem ÍÍ"                      && linha de mensagem
@ 24,02 say "< Esc > Sair"
set color to
retu

Function impok
*------------*
private a
do while .not. isprinter()
        a=0
        tone(800,3)
        @ 23,15 say 'Impressora desligada ou mal conectada: verifique. Tecle <ENTER>...'
        do while a<>13 .and. a<>27
                a=inkey()
        enddo
        if a=27
                retu .f.
        endif
enddo
retu .t.

Function waitsn
*-------------*
private    a,w_msg,_l,_c
parameters w_msg
_l=23
_c=15
@ _l,_c say '                                                               '
set color to w+/r*
@ _l,_c say w_msg+' '
set color to w/n
* clear type
a=0
do while a#83 .and. a#115 .and. a#110 .and. a#78
        tone(500,2)
        a=inkey(0)
enddo
if a=83 .or. a=115
        set color to n/w+
        @ row(),col() say 'Sim'
        @ _l,_c say '                                                               '
        set color to
        retu 'S'
else
        set color to n/w+
        @ row(),col() say 'N„o'
        @ _l,_c say '                                                               '
        set color to
        retu 'N'
endif

Function ldata
*------------*
private _Dat_,_Dia_,_Mes_,_Mes_,_Ano_
_Dat_ = date()
_Dia_ = strzero(Day(_Dat_),2)
_Mes_ = 'JanFevMarAbrMaiJunJulAgoSetOutNovDez'
_Mes_ = substr(_Mes_,(month(_Dat_)*3)-2,3)
_Ano_ = str   (year(_Dat_),4)
retu(_Dia_+' '+_Mes_+' '+_Ano_)

Procedure Tic222
*--------------*
set color to w+/b
@ 05,23 say _frase
@ 07,04 say "N£mero.........:"
retu
