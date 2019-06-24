#include "common.ch"
#include "inkey.ch"

static Static1:= ""
static Static2, Static3:= .F., Static4, Static5, Static6, Static7, ;
   Static8, Static9, Static10, Static11

********************************
procedure CUPOM99

   clear screen
   clear gets
   set scoreboard off
   set date british
   private he[47], esc[47]
   name:= "ifSWEDA"
   avisao:= ;
      "Pressione [ESC] para retornar ou outra tecla para executar"
   finaliza:= "}"
   esc[1]:= ".01"
   esc[2]:= ".02"
   esc[3]:= ".03"
   esc[4]:= ".04"
   esc[5]:= ".05"
   esc[6]:= ".07"
   esc[7]:= ".08"
   esc[8]:= ".09"
   esc[9]:= ".10"
   esc[10]:= ".11"
   esc[11]:= ".12"
   esc[12]:= ".13"
   esc[13]:= ".14"
   esc[14]:= ".15"
   esc[15]:= ".16"
   esc[16]:= ".17"
   esc[17]:= ".18"
   esc[18]:= ".19"
   esc[19]:= ".20"
   esc[20]:= ".21"
   esc[21]:= ".22"
   esc[22]:= ".23"
   esc[23]:= ".24"
   esc[24]:= ".25"
   esc[25]:= ".26"
   esc[26]:= ".27"
   esc[27]:= ".28"
   esc[28]:= ".29"
   esc[29]:= ".30"
   esc[30]:= ".31"
   esc[31]:= ".33"
   esc[32]:= ".34"
   esc[33]:= ".35"
   esc[34]:= ".36"
   esc[35]:= ".37"
   esc[36]:= ".38"
   esc[37]:= ".39"
   esc[38]:= ".40"
   esc[39]:= ".41"
   esc[40]:= ".42"
   esc[41]:= ".43"
   esc[42]:= ".44"
   esc[43]:= ".45"
   esc[44]:= ".46"
   esc[45]:= ".47"
   esc[46]:= ".50"
   crlf:= Chr(13) + Chr(10)
   he[1]:= "ESC1  = Registrar item vendido"
   he[2]:= "ESC2  = Desconto sobre item anterior"
   he[3]:= "ESC3  = Desconto sobre cupom"
   he[4]:= "ESC4  = Cancelar  item vendido"
   he[5]:= "ESC5  = Cancelar cupom anterior"
   he[6]:= "ESC7  = Somar em acumulador n„o-fiscal"
   he[7]:= "ESC8  = Impress„o de texto n„o-fiscal"
   he[8]:= "ESC9  = Impress„o de indicadores"
   he[9]:= "ESC10 = Totalizar cupom"
   he[10]:= "ESC11 = Lan‡amento de acr‚scimo"
   he[11]:= "ESC12 = Fechar cupom"
   he[12]:= "ESC13 = LEITURA 'X'"
   he[13]:= "ESC14 = REDU€O 'Z'"
   he[14]:= "ESC15 = LEITURA DA MEM¢RIA FISCAL-REDU€O"
   he[15]:= "ESC16 = LEITURA DA MEM¢RIA FISCAL-DATA"
   he[16]:= "ESC17 = Abrir cupom fiscal"
   he[17]:= "ESC18 = Imprimir parƒmetros do ECF"
   he[18]:= "ESC19 = Abrir cupom n„o-fiscal"
   he[19]:= "ESC20 = Autentica‡„o"
   he[20]:= "ESC21 = Abrir gaveta"
   he[21]:= "ESC22 = Status da gaveta"
   he[22]:= "ESC23 = Status da impressora"
   he[23]:= "ESC24 = Impress„o de cheque"
   he[24]:= "ESC25 = Fechar impress„o em folha solta"
   he[25]:= "ESC26 = Repete Autentica‡„o"
   he[26]:= "ESC27 = Leitura dos totais"
   he[27]:= "ESC28 = Status de transa‡„o"
   he[28]:= "ESC29 = Leitura de tabelas"
   he[29]:= "ESC30 = Programar parƒmetros de venda"
   he[30]:= "ESC31 = Programar cabe‡alho"
   he[31]:= "ESC33 = Programar tabela de taxas"
   he[32]:= "ESC34 = Programar Dados Cadastrais"
   he[33]:= "ESC35 = Programar rel¢gio"
   he[34]:= "ESC36 = Programar hor rio de ver„o"
   he[35]:= "ESC37 = Grava‡„o do n£mero de matr¡cula"
   he[36]:= "ESC38 = Programar legenda de opera‡„o n„o-fiscal"
   he[37]:= "ESC39 = Programar legendas de modalidade pagamento"
   he[38]:= "ESC40 = Logotipo do lojista na autentica‡„o"
   he[39]:= "ESC41 = Confirmar comando/Interromper leitura"
   he[40]:= "ESC42 = Abrir gaveta acoplada ao ECF"
   he[41]:= "ESC43 = Status da gaveta acoplada ao ECF"
   he[42]:= "ESC44 = Altera     Dados   do cheque"
   he[43]:= "ESC45 = Altera     formato do cheque"
   he[44]:= "ESC46 = Leitura do formato do cheque"
   he[45]:= "ESC47 = Programar legenda n„o fiscal"
   he[46]:= "ESC50 = Parƒmetros n„o fiscais"
   codigo01:= Space(13)
   descricao0:= Space(24)
   qtde01:= unitario01:= valor01:= 0
   tri01:= Space(3)
   unica01:= Space(2)
   nome201:= Space(40)
   texto02:= Space(10)
   valor02:= 0
   texto03:= Space(10)
   valor03:= 0
   subt03:= "N"
   lanc04:= Space(3)
   contador07:= Space(2)
   valor07:= 0
   nome07:= Space(40)
   atributo08:= Space(1)
   lf08:= Space(1)
   texto08:= Space(48)
   atributo09:= Space(1)
   private tipo09[5], identifica[5]
   afill(tipo09, Space(2))
   afill(identifica, Space(40))
   private tipo10[10], mvalor10[10]
   afill(tipo10, Space(2))
   afill(mvalor10, 0)
   adic110:= Space(40)
   adic210:= Space(40)
   contador11:= Space(2)
   perc11:= 0
   valor11:= 0
   linun11:= "N"
   vinc12:= "N"
   seg12:= "N"
   private atributo12[8], linha12[8]
   afill(atributo12, " ")
   afill(linha12, Space(40))
   rel13:= "N"
   rel14:= "N"
   data114:= CToD("  /  /  ")
   reduc115:= reduc215:= Space(4)
   data116:= data216:= CToD("  /  /  ")
   cpf17:= Space(20)
   titulo19:= "01"
   coo19:= "    "
   mod19:= Space(2)
   cpf19:= Space(20)
   atributo20:= logo20:= Space(1)
   cliche20:= "0"
   textau20:= Space(15)
   liq20:= "N"
   banco24:= Space(3)
   valor24:= 0
   adic124:= Space(60)
   adic224:= Space(60)
   ano24:= "2"
   verso24:= "N"
   data24:= CToD("  /  /  ")
   tipo27:= tipo29:= Space(1)
   caixa30:= 0
   centa30:= Space(1)
   cifrao30:= Space(5)
   wcif30:= " "
   wtit30:= " "
   inter30:= "0000"
   sec31:= gui31:= Space(1)
   private atributo31[5], linha31[5]
   afill(atributo31, " ")
   afill(linha31, Space(40))
   private tri33[15], aliq33[15]
   afill(aliq33, 0)
   afill(tri33, Space(3))
   ie34:= Space(21)
   cgc34:= Space(22)
   im34:= Space(16)
   hora35:= Space(6)
   data135:= CToD("  /  /  ")
   verao36:= Space(1)
   matricula3:= Space(8)
   letra37:= Space(1)
   ind38:= "S"
   private lnfis38[25]
   afill(lnfis38, Space(15))
   private lnfis39[20]
   afill(lnfis39, Space(15))
   ext40:= Space(3)
   logos40:= Space(200)
   tipo41:= Space(1)
   favor144:= Space(40)
   favor244:= Space(40)
   local44:= Space(30)
   moeda44:= Space(20)
   moedas44:= Space(20)
   banco45:= "001"
   lfval45:= "1"
   mval45:= "s"
   cval45:= "54"
   lfext145:= "1"
   mext145:= "n"
   cext145:= "23"
   lfext245:= "0"
   mext245:= "s"
   cext245:= "07"
   lffav45:= "1"
   mfav45:= "n"
   cfav45:= "03"
   lfloc45:= "0"
   mloc45:= "s"
   cloc45:= "25"
   dia45:= "01"
   mes45:= "05"
   ano45:= "08"
   banco46:= Space(1)
   numero46:= Space(3)
   private tipo47[10], titulo47[10], legant47[10], newleg47[10]
   afill(tipo47, " ")
   afill(titulo47, Space(15))
   afill(legant47, Space(15))
   afill(newleg47, Space(15))
   tipo50:= "N"
   erro50:= "N"
   cheq50:= "N"
   troco50:= "N"
   do while (.T.)
      setcursor(0)
      set color to w+/b
      clear screen
      clear gets
      set color to b/w
      @  0,  0 say ;
         " CUPOM99 Vers„o 1.0  -  Utilit rio para testes de comandos    -    SWEDA ECF "
      set color to w+/b
      @  2,  1 say "Este utilit rio foi escrito em CLIPPER 5"
      set color to GR+/b
      @  4,  1 say "Observa‡”es: "
      set color to w+/b
      @  5,  1 say ;
         "             1) Para cada comando enviado ao  ECF, ser  retornado um status."
      @  6,  1 say ;
         "Para que haja acesso ao m¢dulo impressor,  redirecione  os  comandos  para o"
      @  7,  1 say ;
         "dispositivo ifSWEDA e fa‡a a impress„o. O status retornado poder  ser lido  "
      @  8,  1 say "no arquivo: ifSWEDA.PRN."
      @ 10,  1 say ;
         "             2) Para ter acesso ao dispositivo (ifSWEDA), acrescente a linha"
      @ 11,  1 say "abaixo no arquivo CONFIG.SYS:"
      @ 12,  1 say "             DEVICE=C:\SERSWEDA.SYS /Tnnnn "
      @ 13,  1 say "                                      ³      "
      @ 14,  1 say "                                      ³      "
      @ 15,  1 say ;
         "                                      ÀÄÄ Time-out:"
      @ 16,  1 say ;
         "                                       Deve ser expresso em unidades de  55 "
      @ 17,  1 say ;
         "                                       milissegundos,transformadas em hexa. "
      @ 18,  1 say ;
         "                                       Ex.: /T00C8 (200 x 55 = 11 segundos)."
      @ 19,  1 say ;
         "                                       00C8 =  1  1  0  0  1  0  0  0         "
      @ 20,  1 say ;
         "                                              128+64+      8             =200 "
      set color to g+/b
      @ 22,  1 say "Pressione [ESC] para Sair do programa "
      @ 23,  1 say "ou outra tecla para continuar."
      set color to W/b
      tecla:= InKey(0)
      if (tecla == 27)
         exit
      endif
      executa()
   enddo
   setcursor(1)
   set color to 
   clear screen
   clear gets

********************************
procedure EXECUTA

   opcao:= 1
   do while (.T.)
      clear screen
      clear gets
      @  0,  0, 24, 79 box "ÉÍ»º¼ÍÈº"
      @  2,  0, 24, 79 box "ÌÍ¹º¼ÍÈº"
      opt:= opcao
      set color to gR+/b
      @ 24, 63 say " E  C  F "
      set color to bg+/b
      @  1,  2 say ;
         "Utilit rio: Executa comando gen‚rico                     CUPOM99 Vers„o 1.0 "
      set color to w+/b
      opcao:= achoice(3, 2, 23, 77, he, .T., "salva", opcao)
      do case
      case LastKey() == K_ESC
         return
      case LastKey() = K_PGDN .OR. LastKey() = K_PGUP .OR. LastKey() ;
            = K_CTRL_PGUP .OR. LastKey() = K_CTRL_PGDN .OR. ;
            LastKey() = K_CTRL_END .OR. LastKey() = K_CTRL_HOME
         loop
      case LastKey() == 1
         opcao:= 1
         loop
      case LastKey() == K_END
         opcao:= Len(he)
         loop
      case LastKey() == K_ENTER
      otherwise
         opcao:= 1
         loop
      endcase
      clear screen
      clear gets
      set color to W/b
      @  0,  0, 24, 79 box "ÉÍ»º¼ÍÈº"
      @  2,  0, 24, 79 box "ÌÍ¹º¼ÍÈº"
      set color to gR+/b
      @ 24, 63 say " E  C  F "
      set color to BG+/B
      @  1,  1 say "COMANDO: "
      @  1, 10 say he[opcao]
      set color to gr+/B
      @ 16,  2 say "Formato enviado ao  E  C  F:"
      @ 21,  2 say "Status:"
      set confirm on
      setcursor(1)
      set color to gr+/B
      comple:= ""
      do case
      case opcao = 1
         @  3,  1 say ;
            "ESC.01 [C¢digo] [Qtde] [Prunitario] [Prtotal] [Nome] [TTT] [EXT ou Nome2]"
         set color to w/B
         setcursor(1)
         @  5,  1 say "C¢digo         - com 13 posi‡”es           " ;
            get CODIGO01 picture "XXXXXXXXXXXXX"
         @  6,  1 say "Quantidade     - com  7 posi‡”es           " ;
            get QTDE01 picture "@E 9999.999"
         @  7,  1 say "Pre‡o Unit rio - com  9 posi‡”es           " ;
            get UNITARIO01 picture "@E 9999999.99"
         @  8,  1 say "Pre‡o total    - com 12 posi‡”es           " ;
            get VALOR01 picture "@E 9999999999.99"
         @  9,  1 say "Nome           - com 24 posi‡”es           " ;
            get DESCRICAO01 picture "@XS11"
         @ 10,  1 say "TTT=tributa‡„o - com  3 posi‡”es           " ;
            get TRI01 picture "XXX"
         @ 11,  1 say "EXT            = extens„o do c¢digo        " ;
            get UNICA01 picture "99"
         @ 11, 60 say "(OPCIONAL)"
         @ 12,  1 say "Nome2          - com 40 posi‡”es           " ;
            get NOME201 picture "@XS11"
         @ 12, 60 say "(OPCIONAL)"
         read
         setcursor(0)
         if (!Empty(unica01))
            unic:= unica01
         else
            unic:= ""
         endif
         if (!Empty(nome201))
            nomop:= nome201
            unic:= ""
         else
            nomop:= ""
         endif
         comple:= codigo01 + strtran(strtran(Str(qtde01, 8, 3), ".", ;
            ""), " ", "0") + strtran(strtran(Str(unitario01, 10, 2), ;
            ".", ""), " ", "0") + strtran(strtran(Str(valor01, 13, ;
            2), ".", ""), " ", "0") + descricao0 + tri01 + unic + ;
            nomop
      case opcao = 2
         @  3,  1 say "ESC.02 [Texto] [Valor]"
         set color to w/B
         setcursor(1)
         @  5,  1 say ;
            "Texto = texto a ser impresso depois da legenda            " ;
            get Texto02 picture "XXXXXXXXXX"
         @  6,  1 say "        'DESC:' com 10 posi‡”es"
         @  7,  1 say ;
            "Valor = valor do desconto - com 12 posi‡”es               " ;
            get VALOR02 picture "@E 9999999999.99"
         read
         setcursor(0)
         comple:= texto02 + strtran(strtran(Str(valor02, 13, 2), ;
            ".", ""), " ", "0")
      case opcao = 3
         @  3,  1 say "ESC.03   [Texto]   [Valor]   [Subtotal?]  "
         set color to w/B
         setcursor(1)
         @  5,  1 say ;
            "Texto = texto a ser impresso depois da legenda            " ;
            get Texto03 picture "XXXXXXXXXX"
         @  6,  1 say "        'DESCT:' com 10 posi‡”es"
         @  8,  1 say ;
            "Valor = valor do desconto - com 12 posi‡”es               " ;
            get VALOR03 picture "@E 9999999999.99"
         @ 10,  1 say "Imprime Subtotal ? " get SUBT03 picture "!" ;
            valid subt03 = "S" .OR. subt03 = "N"
         read
         setcursor(0)
         comple:= texto03 + strtran(strtran(Str(valor03, 13, 2), ;
            ".", ""), " ", "0") + subt03
      case opcao = 4
         @  3,  1 say "ESC.04 [Lanc] "
         set color to w/B
         setcursor(1)
         @  7,  1 say "Lanc = n£mero do lan‡amento.   " get LANC04 ;
            picture "999"
         read
         setcursor(0)
         comple:= alltrim(lanc04)
      case opcao = 5
         @  3,  1 say "ESC.05              (sem parƒmetro adicional)"
         set color to w/B
         @  6,  2 say avisao
         InKey(0)
      case opcao = 6
         @  3,  1 say "ESC.07   [C¢digo]   [Valor]   [Discrimina‡„o]"
         set color to w/B
         setcursor(1)
         @  5,  1 say ;
            "C ¢ d i g o  = n§cont/totalizador em  2 posi‡”es" get ;
            CONTADOR07 picture "99"
         @  7,  1 say ;
            "V a l o r    = valor da opera‡„o com 12 posi‡”es" get ;
            VALOR07 picture "@E 9999999999.99"
         @  9,  1 say ;
            "Discrimina‡„o= docs,datas,etc,   at‚ 40 posi‡”es" get ;
            NOME07 picture "@XS20"
         read
         setcursor(0)
         comple:= contador07 + strtran(strtran(Str(valor07, 13, 2), ;
            ".", ""), " ", "0") + nome07
      case opcao = 7
         @  3,  1 say "ESC.08   [Atributo]   [ LF ou Texto ]"
         set color to w/B
         setcursor(1)
         @  4, 15 say "ÕÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¸"
         @  5, 15 say "³ Atributo:   0    ³    40  caracteres    ³"
         @  6, 15 say "³             1    ³    33                ³"
         @  7, 15 say "³             2    ³    20                ³"
         @  8, 15 say "ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´"
         @  9, 15 say "³             9    ³  n£mero de avan‡os   ³"
         @ 10, 15 say "ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´"
         @ 11, 15 say "³           vazio  ³    F  I  M           ³"
         @ 12, 15 say "ÔÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¾"
         @ 13,  1 say "Atributo = " get ATRIBUTO08 picture "9"
         read
         if (atributo08 != Space(1))
            if (atributo08 != "9")
               @ 14,  1 say ;
                  "Texto = texto a ser impresso (o tamanho varia conforme o atributo)"
               @ 15, 13 get TEXTO08 picture "@XS48"
            else
               @ 14,  1 say "N£mero de avan‡os:" get LF08 picture "9"
            endif
            read
         endif
         setcursor(0)
         if (atributo08 != Space(1))
            comple:= atributo08
            if (atributo08 != "9")
               comple:= comple + texto08
            else
               comple:= comple + lf08
            endif
         else
            comple:= ""
         endif
      case opcao = 8
         comp:= ""
         @  3,  1 say ;
            "ESC.09 [Atributo] [Tipo1] [Ident1]...[Tipo5] [Ident5]"
         set color to w/B
         setcursor(1)
         @  4, 10 say "ÕÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¸"
         @  5, 10 say "³ Atributo ³ Caracteres por linha    ³"
         @  6, 10 say "ÆÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍµ"
         @  7, 10 say "³     0    ³    40                   ³"
         @  8, 10 say "³     1    ³    33                   ³"
         @  9, 10 say "³     2    ³    20                   ³"
         @ 10, 10 say "ÔÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¾"
         @ 11,  1 say "Atributo (modo de impress„o) =" get ;
            ATRIBUTO09 picture "9"
         @ 12,  1 say "Tipo = n£mero da mensagem (00 a 33)"
         @ 13,  1 say ;
            "Ident = identifica‡„o do elemento, aceita at‚ 39 d¡gitos e s¡mbolos."
         read
         for i:= 1 to 5
            set color to W+/b
            @ 14,  2 say Str(i, 2) + ;
               "§ Indicador                            [PgDn] - executa"
            set color to W/b
            @ 15,  2 say "Tipo:         " get TIPO09[i] picture "99"
            @ 15, 20 say "Identifica‡„o:" get IDENTifICA09[i] ;
               picture "@XS10"
            read
            if (i = 1 .AND. atributo09 != Space(1))
               comp:= "|" + atributo09 + "|"
            endif
            if (LastKey() == K_ESC)
               exit
            endif
            if (Empty(identifica[i]))
               identifica[i]:= "|"
            else
               identifica[i]:= Trim(identifica[i]) + "|"
            endif
            comp:= comp + tipo09[i] + SubStr(identifica[i], 1, ;
               At("|", identifica[i]))
            if (LastKey() == K_PGDN)
               if (i < 5)
                  for j:= i + 1 to 5
                     tipo09[j]:= Space(2)
                     identifica[j]:= Space(40)
                  next
               endif
               exit
            endif
         next
         setcursor(0)
         comple:= comp
      case opcao = 9
         comp:= ""
         @  3,  1 say ;
            "ESC.10 [Tipo1] [Valor1]...[Tipo10] [Valor10] [TEXTO]"
         set color to w/B
         @  5,  1 say ;
            "Tipo  = c¢digo da modalidade, com 2 posi‡”es (de 01 a 10)"
         @  6,  1 say "Valor = valor da modalidade, com 12 posi‡”es"
         @  7,  1 say ;
            "Texto = Informa‡”es adicionais com at‚ 80 caracteres."
         for i:= 1 to 10
            setcursor(1)
            set color to W+/b
            @  9,  2 say Str(i, 2) + ;
               "§ Indicador                            [PgDn] - executa"
            set color to W/b
            @ 10,  2 say "Modalidade: " get TIPO10[i] picture "99"
            @ 11,  2 say "Valor     : " get mVALOR10[i] picture ;
               "@E 9999999999.99"
            read
            if (LastKey() == K_ESC)
               exit
            endif
            if (tipo10[i] != "00" .AND. tipo10[i] != "  ")
               comp:= comp + tipo10[i] + ;
                  strtran(strtran(Str(mvalor10[i], 13, 2), ".", ""), ;
                  " ", "0")
            endif
            if (LastKey() == K_PGDN)
               if (i < 10)
                  for j:= i + 1 to 10
                     tipo10[j]:= Space(2)
                     mvalor10[j]:= 0
                  next
               endif
               exit
            endif
         next
         @ 13,  1 say "Informacoes Adicionais:"
         @ 13, 38 get ADIC110 picture "@XS40"
         @ 15, 38 get ADIC210 picture "@XS40"
         read
         if (LastKey() == K_ESC)
            loop
         endif
         if (adic110 != Space(40) .OR. adic210 != Space(40))
            comp:= comp + "{" + adic110 + adic210
         endif
         comple:= comp
      case opcao = 10
         @  3,  1 say "ESC.11 [C¢digo] [Perc] [Acres] [Subt]"
         set color to w/B
         setcursor(1)
         @  5,  1 say "C¢digo da legenda       ( 51 a 57 )        " ;
            get CONTADOR11 picture "99"
         @  6,  1 say "Percentual              2 int & 2 dec      " ;
            get PERC11 picture "@E 99.99"
         @  7,  1 say "Acr‚scimo              11 posi‡”es         " ;
            get VALOR11 picture "@E 999999999.99"
         @  9,  1 say "Subt = imprime Subtotal (S/N) ?            " ;
            get LINUN11 picture "!" valid linun11 = "S" .OR. linun11 ;
            = "N"
         read
         setcursor(0)
         if (linun11 = "S")
            unic:= "S"
         else
            unic:= "N"
         endif
         comple:= contador11 + strtran(strtran(Str(perc11, 5, 2), ;
            ".", ""), " ", "0") + strtran(strtran(Str(valor11, 12, ;
            2), ".", ""), " ", "0") + unic
      case opcao = 11
         comp:= ""
         comple:= ""
         @  3,  1 say ;
            "ESC.12 [Vinc] [Seg] [Atributo1] [Linha1]...[Atributo8] [Linha8]"
         set color to w/B
         setcursor(1)
         @  4,  5 say ;
            "Vinc = Tem comprovante nao-fiscal vinculado(S/N) ?" get ;
            VINC12 picture "!" valid vinc12 = "S" .OR. vinc12 = "N" ;
            .OR. vinc12 = " "
         read
         if (vinc12 != Space(1) .AND. LastKey() != K_ESC)
            @  5,  5 say "Seg  = Impress„o do Segundo Cupom : " get ;
               SEG12 picture "!" valid seg12 = "S" .OR. seg12 = "N"
            read
            if (LastKey() != K_ESC)
               @  7, 15 say "ÕÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¸"
               @  8, 15 say "³ Atributo:   0   =  40 caract/linha ³"
               @  9, 15 say "³             1   =  33 caract/linha ³"
               @ 10, 15 say "³             2   =  20 caract/linha ³"
               @ 11, 15 say "ÔÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¾"
               for i:= 1 to 8
                  set color to W+/b
                  @ 12, 60 say "[PgDn] - executa"
                  set color to W/b
                  setcursor(1)
                  @ 13,  5 say "Atributo:" get ATRIBUTO12[i] picture ;
                     "9"
                  @ 13, 20 say Str(i, 2) + "§ Linha de cortesia:"
                  @ 13, 43 get linha12[i] picture "@XS13"
                  read
                  setcursor(0)
                  if (LastKey() == K_ESC)
                     exit
                  endif
                  comp:= comp + atributo12[i] + linha12[i]
                  if (LastKey() == K_PGDN)
                     if (i < 8)
                        for j:= i + 1 to 8
                           atributo12[j]:= Space(1)
                           linha12[j]:= Space(40)
                        next
                     endif
                     exit
                  endif
               next
               comple:= vinc12 + seg12 + comp
            endif
         endif
      case opcao = 12
         @  3,  1 say "ESC.13  [Relat]"
         set color to w/B
         setcursor(1)
         @  6,  1 say "Relat = Imprime Relat¢rio Gerencial ? " get ;
            REL13 picture "!" valid rel13 = "S" .OR. rel13 = "N"
         read
         setcursor(0)
         comple:= rel13
      case opcao = 13
         @  3,  1 say "ESC.14 [Relat]  [Data]"
         set color to w/B
         setcursor(1)
         @  6,  1 say "Relat = Imprime Relat¢rio Gerencial ? " get ;
            REL14 picture "!" valid rel14 = "S" .OR. rel14 = "N"
         data114:= CToD("  /  /  ")
         @  8,  1 say "Data = data de hoje -OPCIONAL " get data114 ;
            picture "99/99/99"
         setcursor(1)
         read
         setcursor(0)
         comple:= rel14 + Trim(strtran(DToC(data114), "/", ""))
      case opcao = 14
         @  3,  1 say "ESC.15 [Redu‡„o1] [Redu‡„o2]"
         set color to w/B
         setcursor(1)
         reduc115:= "0000"
         reduc215:= "9999"
         @  5,  1 say ;
            "Redu‡„o1 = redu‡„o inicial para impress„o do relat¢rio" ;
            get REDUC115 picture "9999"
         @  6,  1 say ;
            "Redu‡„o2 = redu‡„o final para impress„o do relat¢rio  " ;
            get REDUC215 picture "9999"
         read
         setcursor(0)
         comple:= reduc115 + reduc215
      case opcao = 15
         @  3,  1 say "ESC.16 [Data1] [Data2]"
         set color to w/B
         setcursor(1)
         data116:= CToD("01/01/98")
         data216:= CToD("31/12/30")
         @  5,  1 say ;
            "Data1 = data inicial para impress„o do relat¢rio" get ;
            data116 picture "99/99/99"
         @  6,  1 say ;
            "Data2 = data final para impress„o do relat¢rio  " get ;
            data216 picture "99/99/99"
         read
         setcursor(0)
         comple:= strtran(DToC(data116), "/", "") + ;
            strtran(DToC(data216), "/", "")
      case opcao = 16
         @  3,  1 say "ESC.17   [CGC/CPF] "
         set color to w/B
         @  8,  2 say "CGC/CPF consumidor:  " get CPF17 picture "@X"
         read
         comple:= cpf17
      case opcao = 17
         @  3,  1 say "ESC.18              (sem parƒmetro adicional)"
         set color to w/B
         @  6,  2 say avisao
         InKey(0)
      case opcao = 18
         @  3,  1 say "ESC.19  [Titulo]  [COO]  [tipo]  [CGC/CPF] "
         set color to w/B
         setcursor(1)
         @  6,  2 say "Titulo = Identificador do t¡tulo: " get ;
            TITULO19 picture "99"
         @  8,  2 say "COO(Cupom vinculado):" get COO19 picture "9999"
         @ 10,  2 say "TIPO: " get MOD19 picture "99"
         @ 12,  2 say "CGC/CPF consumidor:  " get CPF19 picture "@X"
         read
         comple:= titulo19 + coo19 + mod19 + cpf19
         setcursor(0)
      case opcao = 19
         @  3,  1 say ;
            "ESC.20 [Atributo] [Logotipo] [Codigo] [Cliche] [Vlr Liq]"
         set color to w/B
         @  5, 20 say "ÕÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¸"
         @  6, 20 say "³ Atributo ³ Caracteres por linha    ³"
         @  7, 20 say "ÆÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍµ"
         @  8, 20 say "³     0    ³          40             ³"
         @  9, 20 say "³     1    ³          33             ³"
         @ 10, 20 say "³     2    ³          20             ³"
         @ 11, 20 say "ÔÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¾"
         setcursor(1)
         @ 11,  1 say "Atributo=" get ATRIBUTO20 picture "9"
         @ 13,  1 say "Logotipo(S/N)=" get LOGO20 picture "!" valid ;
            logo20 = "S" .OR. logo20 = "N"
         @ 13, 18 say "Codigo=" get TEXTAU20 picture "@X"
         @ 13, 45 say "Cliche(0 a 5)=" get CLICHE20 picture "9"
         @ 13, 63 say "Vlr Liq(S/N)=" get LIQ20 picture "!" valid ;
            liq20 = "S" .OR. liq20 = "N"
         read
         setcursor(0)
         comple:= atributo20 + logo20 + textau20 + cliche20 + liq20
      case opcao = 20
         @  3,  1 say "ESC.21              (sem parƒmetro adicional)"
         set color to w/B
         @  6,  2 say avisao
         InKey(0)
      case opcao = 21
         @  3,  1 say "ESC.22              (sem parƒmetro adicional)"
         set color to w/B
         @  6,  2 say avisao
         InKey(0)
      case opcao = 22
         @  3,  1 say "ESC.23              (sem parƒmetro adicional)"
         set color to w/B
         @  6,  2 say avisao
         InKey(0)
      case opcao = 23
         @  3,  1 say ;
            "ESC.24  [Banco]  [Valor]  [verso?]  [Informacoes adicionais]  [ANO]  [data]"
         anterior:= ""
         anterior:= SetColor("w/B")
         setcursor(1)
         @  5,  3 say "Banco = " get BANCO24 picture "999"
         @  5, 54 say "Valor = " get VALOR24 picture ;
            "@E 9999999999.99"
         @  7,  3 say "D¡gitos do ano" get ANO24 picture "9" valid ;
            ano24 > "0" .AND. ano24 < "5"
         @  7, 54 say "d a t a    = " get DATA24 picture "99/99/99"
         set color to w/B,W/B
         @  9,  8 to 12, 72 double
         @  9, 28 say "Informa‡”es adicionais"
         @ 10, 10 get ADIC124 picture "@X"
         @ 11, 10 get ADIC224 picture "@X"
         @ 12, 29 say " Verso antes (S/N)? "
         set color to (anterior)
         @ 12, 49 get VERSO24 picture "!" valid verso24 = "S" .OR. ;
            verso24 = "N" .OR. verso24 = " "
         @ 12, 50 say " "
         read
         setcursor(0)
         if (SubStr(strtran(DToC(data24), "/", ""), 5, 1) == "9")
            milenio:= "19"
         else
            milenio:= "20"
         endif
         comple:= banco24 + strtran(strtran(Str(valor24, 13, 2), ;
            ".", ""), " ", "0") + verso24 + adic124 + adic224 + ano24
         comple:= comple + SubStr(strtran(DToC(data24), "/", ""), 1, ;
            4) + milenio + SubStr(strtran(DToC(data24), "/", ""), 5, ;
            2)
      case opcao = 24
         @  3,  1 say "ESC.25              (sem parƒmetro adicional)"
         set color to w/B
         @  6,  2 say avisao
         InKey(0)
      case opcao = 25
         @  3,  1 say "ESC.26              (sem parƒmetro adicional)"
         set color to w/B
         @  6,  2 say avisao
         InKey(0)
      case opcao = 26
         @  3,  1 say "ESC.27 [Tipo]"
         set color to w/B
         setcursor(1)
         @  5,  1 say "Tipo = (de 1 a F) " get TIPO27 picture "!"
         read
         setcursor(0)
         comple:= tipo27
      case opcao = 27
         @  3,  1 say "ESC.28              (sem parƒmetro adicional)"
         set color to w/B
         @  6,  2 say avisao
         InKey(0)
      case opcao = 28
         @  3,  1 say "ESC.29 [Tipo]"
         set color to w/B
         setcursor(1)
         @  5,  1 say "Tipo = (de 1 a L) " get TIPO29 picture "!"
         read
         setcursor(0)
         comple:= tipo29
      case opcao = 29
         @  3,  1 say ;
            "ESC.30 [Centav] [Caixa] [Impr cifrao] [unid] [cifr„o] [Interv]"
         set color to w/B
         setcursor(1)
         @  5,  1 say ;
            "Centavos = 'S' para ter centavos ou 'N' para n„o ter      " ;
            get CENTA30 picture "X"
         @  6,  1 say ;
            "Caixa    = n£mero do caixa com 3 posi‡”es                 " ;
            get CAIXA30 picture "999"
         @  8,  1 say ;
            "Imprime cifr„o nos cupons (S/N) ?  Ex. TOTAL  R$  100,00  " ;
            get WCif30 picture "!" valid wcif30 = "S" .OR. wcif30 = ;
            "N" .OR. wcif30 = " "
         @ 10,  1 say ;
            "Imprime TITULO do item inteiro -'Quant Preco/unid'- (S/N)?" ;
            get WTIT30 picture "!" valid wtit30 = "S" .OR. wtit30 = ;
            "N" .OR. wtit30 = " "
         @ 12,  1 say ;
            "Cifr„o   = Ex. R$(assumido pelo ECF) - OPCIONAL.          " ;
            get CifRAO30 picture "XXXXX"
         @ 14,  1 say ;
            "Intervalo de itens que imprime o total de itens:" get ;
            INTER30 picture "9999"
         read
         setcursor(0)
         comple:= centa30 + strzero(caixa30, 3) + wcif30 + wtit30 + ;
            cifrao30 + inter30
      case opcao = 30
         comp:= ""
         @  3,  1 say ;
            "ESC.31 [Jor] [Sec] [Seg] [Atributo1] [Linha1]...[Atributo5] [Linha5]"
         set color to w/B
         centa:= "S"
         @  5,  1 say ;
            "Sec = n§ de linhas a saltar entre os cupons - 1 posi‡„o        " ;
            get sec31 picture "9"
         @  6,  1 say "Seg = Imprime Segundo Cupom (S ou N) ? " get ;
            gui31 picture "X"
         @  7, 10 say "ÕÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¸"
         @  8, 10 say "³ Atributo ³ Caracteres por linha    ³"
         @  9, 10 say "ÆÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍµ"
         @ 10, 10 say "³     0    ³    40                   ³"
         @ 11, 10 say "³     1    ³    33                   ³"
         @ 12, 10 say "³     2    ³    20                   ³"
         @ 13, 10 say "ÔÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¾"
         @ 14,  1 say "linha = texto para cabecalho."
         read
         for i:= 1 to 5
            set color to W+/b
            @ 14, 50 say "[PgDn]-executa"
            set color to W/b
            setcursor(1)
            @ 15,  1 say "Atributo :" get ATRIBUTO31[i] picture "9"
            @ 15, 15 say Str(i, 2) + "§ Linha:" get linha31[i] ;
               picture "@XS13"
            read
            setcursor(0)
            if (LastKey() == K_ESC)
               exit
            endif
            comp:= comp + atributo31[i] + linha31[i]
            if (LastKey() == K_PGDN)
               if (i < 5)
                  for j:= i + 1 to 5
                     atributo31[j]:= Space(1)
                     linha31[j]:= Space(40)
                  next
               endif
               exit
            endif
         next
         comple:= centa + sec31 + gui31 + comp
      case opcao = 31
         comp:= ""
         @  3,  1 say "ESC.33 [TRIB1]...[TRIB15]"
         set color to w/B
         @  5,  1 say "TRIBn = T T T     P P P P "
         @  7,  1 say "TTT = c¢digo da tributa‡„o - 3 posi‡”es"
         @  8,  1 say "PPPP = al¡quota principal - 4 posi‡”es"
         for i:= 1 to 15
            set color to W+/b
            @ 12,  2 say Str(i, 2) + ;
               "§ Tributa‡„o                           [PgDn] - executa"
            set color to W/b
            setcursor(1)
            @ 14,  1 say "Trib.:" get tri33[i] picture "XXX"
            @ 14, 15 say "Taxa:" get aliq33[i] picture "@e 99.99"
            read
            setcursor(0)
            if (LastKey() == K_ESC)
               exit
            endif
            comp:= comp + tri33[i] + strtran(strzero(aliq33[i], 5, ;
               2), ".", "")
            if (LastKey() == K_PGDN)
               if (i < 15)
                  for j:= i + 1 to 15
                     tri33[j]:= Space(3)
                     aliq33[j]:= 0
                  next
               endif
               exit
            endif
         next
         comple:= comp
      case opcao = 32
         @  3,  1 say "ESC.34 [CGC]  [IE]  [IM]"
         set color to w/B
         setcursor(1)
         @  5,  1 say ;
            "CGC= Inscri‡„o C.G.C     com 22 caract          :" get ;
            cgc34 picture "@X"
         @  7,  1 say ;
            "IE = Inscri‡„o ESTADUAL  com 21 caract          :" get ;
            ie34 picture "@X"
         @  9,  1 say ;
            "IM = Inscri‡„o MUNICIPAL com 16 caract(opcional):" get ;
            im34 picture "@X"
         read
         setcursor(0)
         comple:= cgc34 + ie34 + im34
      case opcao = 33
         @  3,  1 say "ESC.35 [Hora] [Data]"
         set color to w/B
         setcursor(1)
         @  5,  1 say "Hora = HHMMSS   " get hora35 picture "999999"
         @  6,  1 say "Data = DDMMAA   " get data135 picture ;
            "99/99/99"
         read
         setcursor(0)
         comple:= hora35 + strtran(DToC(data135), "/", "")
      case opcao = 34
         @  3,  1 say "ESC.36 [Modo]"
         set color to w/B
         setcursor(1)
         @  5,  1 say "Modo = 'S' - entrar Hor rio de Ver„o " get ;
            VERAO36 picture "!" valid verao36 = "S" .OR. verao36 = "N"
         @  6,  1 say "     = 'N' - sair Hor rio de Ver„o   "
         read
         setcursor(0)
         comple:= verao36
      case opcao = 35
         @  3,  1 say "ESC.37 [Matr¡cula]  [Opcional]"
         set color to w/B
         @  5,  1 say ;
            "Matr¡cula = n£mero de fabrica‡„o com 8 d¡gitos " get ;
            matricula37 picture "XXXXXXXX"
         @  8,  1 say "Opcional:  " get letra37 picture "!" valid ;
            isalpha(letra37) .OR. letra37 = " "
         read
         comple:= matricula3 + letra37
      case opcao = 36
         comp:= ""
         @  3,  1 say "ESC.38  [Zera?]  [Legenda01]...[Legenda25]"
         @  5,  1 say ;
            "NOTA: se houver mais de 25 legendas, informar o restante no comando seguinte"
         set color to w/B
         @  7,  1 say "Zera Tabela(S/N) ? :  " get IND38 picture "X"
         read
         @  9,  1 say "Legenda01, ...25 = nome com 15 caracteres."
         j:= 0
         for i:= 1 to 25
            set color to W+/b
            @ 11,  5 say Str(i + j, 2) + ;
               "§ Legenda                           [PgDn] - executa"
            set color to W/b
            setcursor(1)
            @ 13,  5 say "Legenda" + Str(i + j, 2) + " :" get ;
               lnfis38[i] picture "@xS10"
            read
            setcursor(0)
            if (LastKey() == K_ESC)
               exit
            endif
            comp:= comp + lnfis38[i]
            if (LastKey() == K_PGDN)
               if (i < 25)
                  for j:= i + 1 to 25
                     lnfis38[j]:= Space(15)
                  next
               endif
               exit
            endif
            ind38:= "N"
         next
         comple:= ind38 + comp
      case opcao = 37
         comp:= ""
         @  3,  1 say "ESC.39 [Legenda1]...[Legenda10]"
         set color to w/B
         @  5,  1 say "Legenda1..10 = nome com 15 caracteres"
         for i:= 1 to 10
            set color to W+/b
            @  7,  2 say Str(i, 2) + ;
               "§ Legenda                           [PgDn] - executa"
            set color to w/b
            setcursor(1)
            @  8,  2 say "Legenda" + Str(i, 2) + " :" get lnfis39[i] ;
               picture "@XS10"
            read
            setcursor(0)
            if (LastKey() == K_ESC)
               exit
            endif
            comp:= comp + lnfis39[i]
            if (LastKey() == K_PGDN)
               if (i < 10)
                  for j:= i + 1 to 10
                     lnfis39[j]:= Space(15)
                  next
               endif
               exit
            endif
         next
         comple:= comp
      case opcao = 38
         @  3,  1 say "ESC.40 [Tamanho] [Logotipo]"
         set color to w/B
         setcursor(1)
         @  5,  1 say "Tamanho :" get EXT40 picture "999"
         @  6,  1 say "LOGOTIPO:" get LOGOS40 picture "@XS10"
         read
         setcursor(0)
         comple:= ext40 + Trim(logos40)
      case opcao = 39
         @  3,  1 say "ESC.41 [Op‡„o]"
         set color to w/B
         @  5,  1 say ;
            "Op‡„o = 'S' - confirma execu‡„o comando anterior" get ;
            TIPO41 picture "X"
         @  6,  1 say "      = 'N' - cancelar comando anterior"
         read
         setcursor(0)
         comple:= tipo41
      case opcao = 40
         @  3,  1 say "ESC.42              (sem parƒmetro adicional)"
         set color to w/B
         @  6,  2 say avisao
         InKey(0)
      case opcao = 41
         @  3,  1 say "ESC.43              (sem parƒmetro adicional)"
         set color to w/B
         @  6,  2 say avisao
         InKey(0)
      case opcao = 42
         @  3,  1 say ;
            "ESC.44  [Favorecido]  [Munic¡pio]  [Moeda]  [Moedas]  [Centavos?]"
         anterior:= ""
         anterior:= SetColor("W/B,W/B")
         setcursor(1)
         @  5, 13 to  8, 63 double
         @  5, 30 say " Favorecido: "
         @  6, 18 get FAVOR144 picture "@x"
         @  7, 18 get FAVOR244 picture "@x"
         set color to (anterior)
         @ 10,  1 say "Municipio=  " get LOCAL44 picture "@x"
         @ 12,  1 say "Moeda(singular)= " get MOEDA44 picture "@x"
         @ 12, 42 say "Moeda(plural)= " get MOEDAS44 picture "@x"
         read
         setcursor(0)
         comp:= local44 + moeda44 + moedas44
         comple:= favor144 + favor244 + Trim(comp)
      case opcao = 43
         esc45()
         if (LastKey() == K_ESC)
            loop
         endif
      case opcao = 44
         @  3,  1 say ;
            "ESC.46  [Banco?]   [numero do banco ou registro]"
         set color to w/B
         setcursor(1)
         @  7,  3 say "N£mero do banco(S/N)? = " get BANCO46 picture ;
            "!" valid banco46 = "S" .OR. banco46 = "N"
         @  7, 40 say "N£mero = " get NUMERO46 picture "999"
         read
         setcursor(0)
         comple:= banco46 + numero46
      case opcao = 45
         comp:= ""
         @  3,  1 say ;
            "ESC.47 [Tipo1] [Tit1] [Leg1] [Nova1] ...[Tipo10] [Tit10] [Leg10] [Nova10]"
         for i:= 1 to 10
            set color to W+/b
            @  5, 10 say Str(i, 2) + "§ Legenda"
            @  5, 40 say "[PgDn]-executa"
            set color to W/b
            setcursor(1)
            @  7, 30 say "  (+) - INCLUSO                      "
            @  8, 30 say "  (=) - ALTERA€O  (MODO INTERVEN€O) "
            @  8,  5 say "Tipo: " get TIPO47[i] picture "X"
            @  9, 30 say "  (-) - EXCLUSO   (MODO INTERVEN€O) "
            @ 11,  5 say ;
               "Tit  = Nome do DOCUMENTO   g r a v a d o: " get ;
               TITULO47[i] picture "@X"
            @ 13,  5 say "Leg  = legenda   g r a v a d a:" get ;
               LEGANT47[i] picture "@X"
            @ 15,  5 say "Nova = N o v a   legenda/DOCUM:" get ;
               NEWLEG47[i] picture "@X"
            @ 16,  1 say Space(78)
            @ 21,  1 say Space(78)
            @ 17,  2 say ;
               "INCLUSO:  'Tit' e 'Leg' definem a localiza‡„o de 'Nova'."
            @ 18,  2 say ;
               "           'Nova' ser  incluida depois  de 'Leg'.        "
            @ 19,  2 say ;
               "           'Tit' dever  ser vazia na 1a.legenda se tabela vazia."
            @ 20,  2 say ;
               "           'Leg' dever  ser vazia se 'Nova' for a 1a. legenda ap¢s o t¡tulo."
            @ 21,  2 say ;
               "ALTERA€O: 'Nova' alterar  'Leg' caso tenha 'Tit' e 'Leg'."
            @ 22,  2 say ;
               "           'Nova' alterar  'Tit' se 'Leg' for vazia.    "
            @ 23,  2 say ;
               "EXCLUSO:  'Exclui 'tit' se 'leg' vazio                ."
            read
            setcursor(0)
            if (LastKey() == K_ESC)
               exit
            endif
            if (tipo47[i] != Space(1))
               comp:= comp + tipo47[i] + titulo47[i] + legant47[i] + ;
                  newleg47[i]
            endif
            if (LastKey() == K_PGDN)
               if (i < 10)
                  for j:= i + 1 to 10
                     titulo47[j]:= Space(15)
                     legant47[j]:= Space(15)
                     newleg47[j]:= Space(15)
                  next
                  exit
               endif
            endif
            sinal:= SubStr(newleg47[i], 1, 1)
            if (i < 10)
               if (titulo47[i + 1] = Space(15))
                  if (sinal = "&")
                     titulo47[i + 1]:= newleg47[i]
                  else
                     titulo47[i + 1]:= titulo47[i]
                     legant47[i + 1]:= newleg47[i]
                  endif
               endif
            endif
         next
         @ 17,  1 say Space(78)
         @ 18,  1 say Space(78)
         @ 19,  1 say Space(78)
         @ 20,  1 say Space(78)
         @ 21,  1 say Space(78)
         @ 22,  1 say Space(78)
         @ 23,  1 say Space(78)
         set color to gr+/B
         @ 16,  2 say "Formato enviado ao  E  C  F:"
         @ 21,  2 say "Status:"
         comple:= comp
      case opcao = 46
         @  3,  1 say "ESC.50 [papel]  [abrev]  [cheq]  [troco]"
         set color to w/B
         setcursor(1)
         gui:= "N"
         @  4,  1 say "PAPEL:  Op‡„o:"
         @  5,  8 say ;
            "'S' - imprime ap¢s receber comando '(ESC.41S)'."
         @  6,  8 say ;
            "'N' - imprime ap¢s ter papel com a tampa fechada ?" get ;
            tipo50 picture "!" valid tipo50 = "S" .OR. tipo50 = "N"
         @  8,  1 say ;
            "ABREV:  Exibe mensagem abreviada de erro(se for visor)  ?" ;
            get ERRO50 picture "!" valid erro50 = "S" .OR. erro50 = ;
            "N"
         @ 10,  1 say ;
            "CHEQ:   Impress„o  r pida    de  cheque(bidirecional)   ?" ;
            get CHEQ50 picture "!" valid cheq50 = "S" .OR. cheq50 = ;
            "N"
         @ 12,  1 say ;
            "TROCO:  Impress„o  imediata  do  troco (S ou N)         ?" ;
            get TROCO50 picture "!" valid troco50 = "S" .OR. troco50 ;
            = "N"
         read
         setcursor(0)
         comple:= tipo50 + erro50 + cheq50 + troco50
      endcase
      if (LastKey() != K_ESC)
         if (Len(comple) != 0)
            comando:= esc[opcao] + comple + finaliza
         else
            comando:= esc[opcao] + finaliza
         endif
         set color to g+/B
         @ 21,  2 say "Status:"
         if (Len(comando) > 78)
            resto:= mod(Len(comando), 78)
            vez:= (Len(comando) - resto) / 78
            nline:= 17
            ini:= 1
            fim:= 78
            for i:= 0 to vez
               @ nline,  1 say SubStr(comando, ini, 78)
               nline:= nline + 1
               ini:= fim + 1
               fim:= fim + 78
            next
         else
            @ 17,  1 say comando
         endif
         set device to printer
         set printer to (name)
         @ PRow(), PCol() say comando
         set device to screen
         resp:= Space(128)
         set color to gr+/B
         hand:= fopen("ifSWEDA.PRN", 2)
         resp:= freadstr(hand, 128)
         fclose(hand)
         set color to g+/b
         setcursor(1)
         if (SubStr(resp, 2, 1) = "-")
            tone(400, 2)
            if (Len(resp) == 7)
               if (SubStr(resp, 6, 1) = "2")
                  @ 23,  2 say ;
                     "Time-Out de Transmiss„o. Verifique o Impressor "
               elseif (SubStr(resp, 6, 1) = "6")
                  @ 23,  2 say ;
                     "Time-Out de Recep‡„o. Verifique  o impressor "
               endif
            endif
         elseif (SubStr(resp, 2, 1) = "+")
         endif
         set color to g+/b
         aut:= SubStr(resp, 4, 1)
         slip:= SubStr(resp, 5, 1)
         bob:= SubStr(resp, 6, 1)
         if (SubStr(resp, 3, 1) = "P")
            if (Len(Trim(resp)) > 10)
               do case
               case aut = "0"
                  @ 21, 45 say "AUT : H  documento para autenticar"
               case aut = "1"
                  @ 21, 45 say "AUT : Impressora  off-line        "
               case aut = "2"
                  @ 21, 45 say "AUT : Time-out de Transmissao     "
               case aut = "5"
                  @ 21, 45 say "AUT :Sem documento para autenticar"
               case aut = "6"
                  @ 21, 45 say "AUT :Sem documento ou resposta    "
               endcase
               do case
               case slip = "0"
                  @ 22, 45 say "SLIP: H  folha presente      "
               case slip = "1"
                  @ 22, 45 say "SLIP: Impressora  off-line    "
               case slip = "2"
                  @ 22, 45 say "SLIP: Time-out de Transmissao "
               case slip = "5"
                  @ 22, 45 say "SLIP: Sem folha solta presente"
               case slip = "6"
                  @ 22, 45 say "SLIP: Time-out de recepcao    "
               endcase
               do case
               case bob = "0"
                  @ 23, 45 say "BOBINA: Impressora tem papel"
               case bob = "1"
                  @ 23, 45 say "BOBINA:Impressora off-line"
               case bob = "2"
                  @ 23, 45 say "BOBINA:Time-out de Transmissao"
               case bob = "3"
                  @ 23, 45 say "BOBINA:Sem papel, lado Jornal"
               case bob = "4"
                  @ 23, 45 say "BOBINA:Sem papel, lado cupom"
               case bob = "5"
                  @ 23, 45 say "BOBINA:Sem papel, cupom e jornal"
               case bob = "6"
                  @ 23, 45 say "BOBINA:Time-out de recepcao"
               endcase
            endif
         elseif (SubStr(resp, 3, 1) = "G")
            if (SubStr(resp, 6, 1) = "0")
               @ 23, 45 say "Gaveta Aberta"
            elseif (SubStr(resp, 6, 1) = "1")
               @ 23, 45 say "Gaveta Fechada"
            endif
         endif
         set color to n/w
         @ 22,  1 say SubStr(resp, 1, 78)
         @ 23,  1 say SubStr(resp, 79, 50)
         set color to w+/b
         InKey(0)
      endif
   enddo

********************************
function SALVA

   parameters modo
   if (modo = 0 .OR. modo = 3)
      do case
      case LastKey() == K_ESC
         return 0
      case LastKey() == K_ENTER
         return 1
      case LastKey() == K_DOWN
         opcao++
         if (opcao > Len(he))
            opcao--
         endif
         return 2
      case LastKey() == K_UP
         opcao--
         if (opcao < 1)
            opcao++
         endif
         return 2
      case LastKey() = K_PGDN .OR. LastKey() = K_PGUP .OR. LastKey() ;
            = K_CTRL_PGDN .OR. LastKey() = K_CTRL_PGUP .OR. ;
            LastKey() = K_CTRL_END .OR. LastKey() = K_CTRL_HOME
         return 1
      case LastKey() = 1 .OR. LastKey() = K_END
         return 1
      endcase
      return 2
   elseif (modo = 1 .OR. modo = 2)
      return 2
   endif
   if (LastKey() == K_ESC)
      return 0
   elseif (LastKey() == K_ENTER)
      return 1
   endif

********************************
function CMANDA

   parameters mensagem
   set device to printer
   set printer to (name)
   @ PRow(), PCol() say mensagem
   set printer to 
   set device to screen
   resp:= Space(128)
   arq:= fopen("ifSWEDA.PRN", 2)
   resp:= freadstr(arq, 128)
   fclose(arq)
   @ 22,  1 say "        ***   Emitindo Relatorio Gerencial..."
   anterior:= ""
   anterior:= SetColor("W/N*")
   @ 22, 50 say " >>> "
   set color to (anterior)
   @ 22, 55 say Space(15)
   @ 22, 55 say resp
   return .T.

********************************
procedure CUP99


********************************
procedure SYSINIT

   return

********************************
function __GETHASFO

   return Len(qself()) == 13

********************************
procedure ESC45

   @  3,  1 say ;
      "ESC.45  [Banco]   [numero de lf antes]   [meio-lf antes?]   [coluna]"
   @  5, 38 say "Banco= " get BANCO45 picture "999"
   @  6,  1 say ;
      "    lf=         ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
   @  7,  1 say ;
      "    + meio ?  ->³                                       ***** 999.999,99  ³"
   @  8,  1 say ;
      "                ³                                                         ³"
   @  9,  1 say ;
      "    lf=         ³                                                         ³"
   @ 10,  1 say ;
      "    + meio ?  ->³  A importancia de ....................................  ³"
   @ 11,  1 say ;
      "                ³                                                         ³"
   @ 12,  1 say ;
      "    lf=         ³                                                         ³"
   @ 13,  1 say ;
      "    + meio ?  ->³  .....................................................  ³"
   @ 14,  1 say ;
      "                ³                                                         ³"
   @ 15,  1 say ;
      "    lf=         ³                                                         ³"
   @ 16,  1 say ;
      "    + meio ?  ->³  nominal a ...........................................  ³"
   @ 17,  1 say ;
      "                ³                                                         ³"
   @ 18,  1 say ;
      "    lf=         ³                                                         ³"
   @ 19,  1 say ;
      "    + meio ?  ->³                 ..........,  ...de..............de 19.. ³"
   @ 20,  1 say ;
      "                ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
   @  6, 10 get LFVAL45 picture "9"
   @  7, 14 get MVAL45 picture "x" valid mval45 = "S" .OR. mval45 = ;
      "N" .OR. mval45 = "s" .OR. mval45 = "n" .OR. mval45 = "0"
   @  9, 10 get LFEXT145 picture "9"
   @ 10, 14 get MEXT145 picture "x" valid mext145 = "S" .OR. mext145 ;
      = "N" .OR. mext145 = "s" .OR. mext145 = "n" .OR. mext145 = "0"
   @ 12, 10 get LFEXT245 picture "9"
   @ 13, 14 get MEXT245 picture "x" valid mext245 = "S" .OR. mext245 ;
      = "N" .OR. mext245 = "s" .OR. mext245 = "n" .OR. mext245 = "0"
   @ 15, 10 get LFFAV45 picture "9"
   @ 16, 14 get MFAV45 picture "x" valid mfav45 = "S" .OR. mfav45 = ;
      "N" .OR. mfav45 = "s" .OR. mfav45 = "n" .OR. mfav45 = "0"
   @ 18, 10 get LFLOC45 picture "9"
   @ 19, 14 get MLOC45 picture "x" valid mloc45 = "S" .OR. mloc45 = ;
      "N" .OR. mloc45 = "s" .OR. mloc45 = "n" .OR. mloc45 = "0"
   read
   if (LastKey() == K_ESC)
   else
      @  5, 46 say banco45
      @  6, 10 say lfval45
      @  7, 14 say mval45
      @  9, 10 say lfext145
      @ 10, 14 say mext145
      @ 12, 10 say lfext245
      @ 13, 14 say mext245
      @ 15, 10 say lffav45
      @ 16, 14 say mfav45
      @ 18, 10 say lfloc45
      @ 19, 14 say mloc45
      @  7, 51 get CVAL45 picture "99"
      @ 10, 37 get CEXT145 picture "99"
      @ 13, 20 get CEXT245 picture "99"
      @ 16, 31 get CFAV45 picture "99"
      @ 19, 35 get CLOC45 picture "99"
      read
      if (LastKey() == K_ESC)
      else
         @  7, 51 say cval45
         @ 10, 37 say cext145
         @ 13, 20 say cext245
         @ 16, 31 say cfav45
         @ 19, 35 say cloc45
         @ 19, 48 get DIA45 picture "99"
         @ 22,  7 say ;
            "quantas colunas ser„o acrescidas ao MUNICIPIO para imprimir o DIA?"
         read
         if (LastKey() == K_ESC)
         else
            @ 19, 48 say dia45
            @ 19, 60 get MES45 picture "99"
            @ 22,  7 say ;
               "quantas colunas ser„o acrescidas ao   D I A   para imprimir o MES?"
            read
            if (LastKey() == K_ESC)
            else
               @ 19, 60 say mes45
               @ 19, 73 get ANO45 picture "99"
               @ 22,  7 say ;
                  "quantas colunas ser„o acrescidas ao   M E S   para imprimir o ANO?"
               read
               if (LastKey() == K_ESC)
               else
                  setcursor(0)
                  @  6,  3 clear to 22, 78
                  @ 16,  2 say "Formato enviado ao  E  C  F:"
                  @ 20,  2 say "Status:"
                  comple:= banco45 + lfval45 + mval45 + cval45 + ;
                     lfext145 + mext145 + cext145 + lfext245 + ;
                     mext245 + cext245 + lffav45 + mfav45 + cfav45 + ;
                     lfloc45 + mloc45 + cloc45 + dia45 + mes45 + ano45
                  return
               endif
            endif
         endif
      endif
   endif

