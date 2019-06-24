*****************
function calcula()
*****************
*
*  calculad()
*
*  Sintaxe:    calculad([<ExpN1>] [,<ExpN2>] [,<ExpC>])
*
*  Argumentos: ExpN1 e ExpN2 sao argumentos numericos que definem
*              a posicao inicial de coordenadas de linha e coluna
*              do canto superior direito da calculadora, a partir
*              da qual a calculadora sera' pintada na tela. Sao
*              parametros opcionais. Caso nao sejam definidos a
*              calculadora sera' pintada no canto superior direito
*              da tela.
*              A calculadora mede 16 linhas x 24 colunas!
*              ExpC - um dos codigos de cores no qual a calculadora
*              devera' ser pintada .
*                   Cor                    Codigo padrao dBASE
*                   -------------------------------------
*                   Black   (Preto)        N/Space
*                   Blue    (Azul)         B
*                   Green   (Verde)        G
*                   Cyan    (Azul Claro)   BG
*                   Red     (Vermelho)     R
*                   Magenta (Lilas)        RB
*                   Brown   (Marrom)       GR
*                   White   (Branco)       W
*              Trata-se tambem de parametro opcional. Se nada for
*              passado o default e' a cor preta ('N').
*
* Proposito:   Colocar em tela as facilidades de uma calculadora de
*              mao a qualquer tempo.
*
* Retorna:     Valor "dummy"  .t.
*
* Obs.:        O usuario podera' M O V I M E N T A R(!) a calculadora
*              a qualquer tempo, bastando para isso usar as teclas
*              de setas para movimentacao do cursor! Este recurso e'
*              bastante util quando o usuario quiser deixar livre
*              uma area da tela (para conferi_la, p. explo.) ,
*              posicionando a calculadora numa outra area mais
*              conveniente!
*
* Exemplo:     * Para obter a calculadora inicialmente a partir da
*              * linha 3, coluna 18 e na cor predominante vermelha:
*
*              calculad(3, 18, 'r')
*
*              * Para chamar na maneira default (cor preta, canto
*              * superior direito):
*
*              calculad()
*
*
****************
calc_lin = 3
calc_col = 60
calc_cor = 'RB'
corHel  = SetColor()

private calc_cor, c_cor_ant, clin, decimal, ult_char,;
        operador, primeiro, tecla_press, dp,  calc_char, corvisor, ;
        corcalc, corteccalc, COR_CALC, COR_TECLA_CALC, COR_VISOR_CALC,;
        ENTER, IGUAL, ESC, SETADIR, SETAESQ, SETABAIXO, SETACIMA,;
        MOVE_TECLAS, PGDN, Num_Saida, cortemp, lowcortemp, cont_operador,;
        tl_calc, tl_ant

if pCount() < 2 .or. (Type('calc_lin') != 'N' .or. ;
                      Type('calc_col') != 'N')
    calc_lin = 1
    calc_col = 53

else
    if calc_lin > 8
       calc_lin = 8
    End

    if calc_col > 53
       calc_col = 53
    End
End
corvisor   = 'n/w, n/w, '      && cores default para o visor
corcalc    = 'w+/n, w+/n, '   &&   "      "    para a calculadora
corteccalc = corcalc         &&   "      "    para as teclas

if type('calc_cor') == 'C'
    lowcortemp = lower(calc_cor)
    if lowcortemp $ 'n\b\g\bg\r\rb\gr\w'
        cortemp    = 'w+'
        corteccalc = 'n/' + calc_cor + ', n/' + calc_cor + ', '
        if lowcortemp == 'n'
            corteccalc = 'w+/n, w+/n, '

        elseif lowcortemp == 'w' .or. lowcortemp == 'bg' .or. ;
               lowcortemp = 'gr'

            if lowcortemp == 'w'
                corvisor = 'w+/n, w+/n, '

            endif
            cortemp = 'n'

        endif
        corcalc = cortemp + '/' + calc_cor + ', ' + cortemp + '/' + ;
                  calc_cor + ', '

    endif
endif

* declaracao de constantes:

COR_CALC       = corcalc
COR_TECLA_CALC = corteccalc
COR_VISOR_CALC = corvisor
ESC            = 27
ENTER          = 13
IGUAL          = 61
SETADIR        = 4
SETAESQ        = 19
SETACIMA       = 5
SETABAIXO      = 24
PGDN           = 3
MOVE_TECLAS = chr(SETADIR) + chr(SETAESQ) + chr(SETACIMA) + ;
              chr(SETABAIXO)
TAM_MAX_NUM = 16

clin = 0
c_cor_ant = setcolor(COR_CALC)

tl_ant = savescreen(calc_lin, calc_col, calc_lin + 15, ;
                         calc_col + 23)

@ calc_lin, calc_col to calc_lin + 15, calc_col + 23  && Moldura.
*janela(calc_lin,calc_col,calc_lin+16,calc_col+24)
clin++
@ calc_lin + clin, calc_col + 1 to calc_lin + clin + 3, calc_col + 22
clin++
setcolor(COR_VISOR_CALC)
@ calc_lin + clin, calc_col + 2 say space(20)
clin++
@ calc_lin + clin, calc_col + 2 say space(20)
clin += 2
setcolor(COR_CALC)
@ calc_lin + clin, calc_col + 1 say '  C    cE   S' + chr(251)+;
        '     ' + chr(246) + '/ '
setcolor(COR_TECLA_CALC)
@ calc_lin + clin, calc_col + 5  say '³'
@ calc_lin + clin, calc_col + 10 say '³'
@ calc_lin + clin, calc_col + 15 say '³'
@ calc_lin + clin, calc_col + 22 say '³'
clin++
@ calc_lin + clin, calc_col + 1  say  ' ÄÄÄÙ ÄÄÄÙ ÄÄÄÙ   ÄÄÄÙ'
setcolor(COR_CALC)
clin++
@ calc_lin + clin, calc_col + 1  say  '  7    8    9      *  '
setcolor(COR_TECLA_CALC)
@ calc_lin + clin, calc_col + 5  say '³'
@ calc_lin + clin, calc_col + 10 say '³'
@ calc_lin + clin, calc_col + 15 say '³'
@ calc_lin + clin, calc_col + 22 say '³'
clin++
@ calc_lin + clin, calc_col + 1  say  ' ÄÄÄÙ ÄÄÄÙ ÄÄÄÙ   ÄÄÄÙ'
setcolor(COR_CALC)
clin++

@ calc_lin + clin, calc_col + 1  say  '  4    5    6      +  '
setcolor(COR_TECLA_CALC)
@ calc_lin + clin, calc_col + 5  say '³'
@ calc_lin + clin, calc_col + 10 say '³'
@ calc_lin + clin, calc_col + 15 say '³'
@ calc_lin + clin, calc_col + 22 say '³'
clin++
@ calc_lin + clin, calc_col + 1  say  ' ÄÄÄÙ ÄÄÄÙ ÄÄÄÙ   ÄÄÄÙ'
setcolor(COR_CALC)
clin++
@ calc_lin + clin, calc_col + 1  say  '  1    2    3      -  '
setcolor(COR_TECLA_CALC)
@ calc_lin + clin, calc_col + 5  say '³'
@ calc_lin + clin, calc_col + 10 say '³'
@ calc_lin + clin, calc_col + 15 say '³'
@ calc_lin + clin, calc_col + 22 say '³'
clin++
@ calc_lin + clin, calc_col + 1  say  ' ÄÄÄÙ ÄÄÄÙ ÄÄÄÙ   ÄÄÄÙ'
setcolor(COR_CALC)
clin++
@ calc_lin + clin, calc_col + 1  say  '  0    .    ^' + chr(252) + ;
       '     =  '
setcolor(COR_TECLA_CALC)
@ calc_lin + clin, calc_col + 5  say '³'
@ calc_lin + clin, calc_col + 10 say '³'
@ calc_lin + clin, calc_col + 15 say '³'
@ calc_lin + clin, calc_col + 22 say '³'
clin++
@ calc_lin + clin, calc_col + 1  say  ' ÄÄÄÙ ÄÄÄÙ ÄÄÄÙ   ÄÄÄÙ'

* Salvo calculadora ja' montada para possivel movimentacao posterior.
tl_calc = savescreen(calc_lin, calc_col, calc_lin + 15, calc_col + 23)

* inicializacoes das variaveis:

store 0 to tecla_press, dp
operador      = ' '
ult_char      = 'C'
decimal       = .f.
primeiro      = .t.
cont_operador = 0
algarismo     = .f.
corrente      = 0.00
atual         = 0.0000

* corrente: sempre guarda o valor mais recente da variavel
* atual:    contem o tolaa ate' o presente momento (ou a diferenca ou
*           qualquer outro).
* Uma vez que um operador (+, -, /, ^, S, =) e' selecionado a rotina
* da function calc_math() e' chamada, o problema resolvido e a variavel
* corrente atualizada para refletir seu novo valor.

do while tecla_press != ESC .AND. tecla_press != PGDN

    setcolor(COR_VISOR_CALC)
    @ calc_lin + 3, calc_col + 2 say corrente ;
                                 pict '@ER 99,999,999,999.9999'

    tecla_press = 0

    * Para que a calculadora possa funcionar como tal, precisamos
    * pegar a entrada tecla a tecla. O comando READ nao funcionaria
    * de maneira tao adequada.

    tecla_press = inkey(0)
    if tecla_press = ENTER
       tecla_press = IGUAL
    endif

    * transformo a tecla pressionada para seu caracter ASCII:
    calc_char = upper(chr(tecla_press))


    * Verifico se os operadores foram teclados em sequencia, ou seja,
    * sem intercalar numeros entre eles. Isto pode ocorrer em alguns
    * casos como :
    *   -> o usuario se arrependeu de ter teclado '+' quando queria
    *      teclar '-' , por exemplo.
    *   -> o usuario sem querer teclou duas vezes seguidas um
    *      operador,  entre outros casos mais...
    * Em qualquer destes casos a rotina abaixo prendera' a execucao
    * neste trecho ate' que uma tecla diferente de operador seja
    * teclada. Ficara valendo o ULTIMO operador teclado:

    if calc_char $ '+-/*^'

        algarismo = .f.
        if cont_operador = 0
           cont_operador = 1
        else
            operador = calc_char
            loop
        endif
    else
        cont_operador = 0
    endif
    * fim da rotina de verificacao de operadores repetidos

    do case
        case tecla_press = ESC

            * Neste caso faca nada!


        case calc_char $ MOVE_TECLAS
            * deseja movimentar calculadora.

            if tecla_press = SETADIR
                restscreen(calc_lin, calc_col, calc_lin + 15, ;
                           calc_col + 23, tl_ant)
                calc_col = calc_col + 3
                if calc_col + 23 > 79
                    calc_col = 56

                endif
                tl_ant = savescreen(calc_lin, calc_col, ;
                                    calc_lin + 15, calc_col + 23 )
                restscreen(calc_lin, calc_col, calc_lin + 15, ;
                           calc_col + 23, tl_calc)

            elseif tecla_press = SETAESQ
                restscreen(calc_lin, calc_col, calc_lin + 15, ;
                           calc_col + 23, tl_ant)
                calc_col = calc_col - 3
                if calc_col < 0
                    calc_col = 0

                endif
                tl_ant = savescreen(calc_lin, calc_col, ;
                                    calc_lin + 15, calc_col + 23 )
                restscreen(calc_lin, calc_col, calc_lin + 15, ;
                           calc_col + 23, tl_calc)

            elseif tecla_press = SETACIMA
                restscreen(calc_lin, calc_col, calc_lin + 15, ;
                           calc_col + 23, tl_ant)
                calc_lin = calc_lin - 1
                if calc_lin < 0
                    calc_lin = 0

                endif
                tl_ant = savescreen(calc_lin, calc_col, ;
                                    calc_lin + 15, calc_col + 23 )
                restscreen(calc_lin, calc_col, calc_lin + 15, ;
                           calc_col + 23, tl_calc)

            elseif tecla_press = SETABAIXO
                restscreen(calc_lin, calc_col, calc_lin + 15, ;
                           calc_col + 23, tl_ant)
                calc_lin = calc_lin + 1
                if calc_lin + 15 > 24
                    calc_lin = 9

                endif
                tl_ant = savescreen(calc_lin, calc_col, ;
                                    calc_lin + 15, calc_col + 23 )
                restscreen(calc_lin, calc_col, calc_lin + 15, ;
                           calc_col + 23, tl_calc)

            endif

            * Para colaborar com a rotina que verifica repeticao
            * de teclagem de operadores mais acima.

            if !algarismo
                cont_operador = 1

            endif

        case calc_char = 'E'

            * clear Entry pressionada; inicialize a variavel corrente
            corrente = 0.0000
            dp = 0

        case calc_char = 'C'

            * tecla Clear pressionada; reinicialize as variaveis:
            ult_char = calc_char
            corrente = 0.0000
            atual    = 0.0000

        case calc_char == '='
            if atual = 0.0000 .and. operador != '^'
               atual    = corrente
               operador = ' '
            endif

            * tecla de "igual" pressionada; execute a operacao:
            calc_math()
            ult_char = '='

            * Faz-se uma especial excecao ao caso da tecla de "igual"
            * de maneira que o usuario possa realizar calculos a
            * partir do resultado.

        case calc_char = 'S'

            * Raiz quadrada:
            if ult_char = '='
                store sqrt(corrente) to corrente, atual

            else
                corrente = sqrt(corrente)

            endif

        case calc_char $ '+-/*^'

            * um dos operadores pressionados:

            if ult_char $ '=C'  && "igual" ou Clear

                * Apenas precisaremos executar calc_math(), caso
                * corrente seja o segundo operando:

                if ult_char = 'C'  && Clear

                    * Se "igual" foi pressionada, corrente ja'
                    * deveria estar igual a atual

                    atual = corrente

                endif
                ult_char = ' '
                primeiro = .t.

            else
                * execute calc_math() , corrente ira' mostrar:

                calc_math()

            endif
            store calc_char to operador, ult_char
            dp = 0

        case calc_char = '.'

            * Ponto decimal pressionado:
            decimal = .t.

        case calc_char $ '0123456789'

            * capturo o algarismo  entrado em corrente:
            algarismo = .t.
            get_corrente()

    endcase
enddo
restscreen(calc_lin, calc_col, calc_lin + 15, calc_col + 23, ;
               tl_ant)
setcolor(c_cor_ant)
if tecla_press = PGDN
   Num_Saida = LTRIM(STR(corrente,16,2))
   Num_Saida = STRTRAN(Num_Saida,".",",") && OPCIONAL: SUBSTITUI O PONTO DECIMAL POR VIRGULA
   KEYBOARD Num_Saida
endif

SetColor(corhel)
return .t.
*
*
*********************
function get_corrente
*********************
*
* get_corrente()
*
* Sintaxe:    get_corrente()
* Proposito:  rotina para pegar o digito entrado - calc_char - e
*             "uni'-lo" `a variavel corrente. Chamada pela function
*             calcula()
* Retorna:    Valor dummy .t.
* Autor:      Monique Verrier   (Creative Software Inc.)
* Modificado: Marcelo Zamith em 20/04/89
*
*********************

if decimal
    * Se estamos trabalhando com os numeros `a direita do ponto
    * decimal...

    if primeiro   &&  Nenhum numero `a esquerda do ponto decimal...
        primeiro = .f.
        corrente = val('0.' + calc_char)

    else
        * combino corrente com calc_char

        corrente = val(ltrim(str(corrente, TAM_MAX_NUM, 0)) + '.' + ;
                             calc_char)

    endif
    decimal = .f.
    dp = 1

else
    if primeiro   && corrente vale 0
        primeiro = .f.
        corrente = val(calc_char)

    else
        * caso contrario ena corrente com calc_char.

        corrente = val(ltrim(str(corrente, TAM_MAX_NUM, dp)) + ;
                             calc_char)
        if dp > 0
            * incremento casas decimais se estamos trabalhando `a
            * direita do ponto decimal.

            dp = dp + 1

        endif
    endif
endif

return .t.
*
*
******************
function calc_math
******************
*
* calc_math()
*
* Sintaxe:    calc_math()
* Proposito:  uma rotina simples para calcular as operacoes captadas
*             pela function calcula()
* Retorna:    Valor dummy  .t.
* Author:     Monique Verrier  (Creative Software Inc.)
* Modificado: Marcelo Zamith em 20/04/89.
*
******************

* atual e' o primeiro operando e corrente e' o segundo:

do case
    case operador = '+'
        atual = atual + corrente

    case operador = '-'
        atual = atual - corrente

    case operador = '*'
        atual = atual * corrente

    case operador = '/'
        if corrente = 0   && divisao por ZERO! ERRO!!!
            atual = 0
            corrente = 0
            tone(500)
            tone(300)
            tone(400)
            @ calc_lin + 3, calc_col + 2 say '          E r r o!!'
            inkey(0)

            * Simulo reinicializacao com tecla " 'C'lear"
            clear typeahead
            keyboard 'C'

        else
            atual = atual / corrente

        endif

    case operador = '^'  && Exponencial.
        atual = atual ^ corrente

endcase
corrente = atual
primeiro = .t.
dp = 0

return .t.

