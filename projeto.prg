//2016.07.20 - 22:24:08
#include <hbclass.ch>
#include <translate.ch>
#include <pragma.ch>

REQUEST HB_GT_WIN_DEFAULT

FUNCTION Main()
   LOCAL oMenu := Menu():New()
   Ambiente()
	? "Hello, World"
	Alert("Alo, mundo!")
	
	Msg("Vilmar Catafesta", "Informacao")
   Teste_menu()
	return NIL

Class Menu
    data cHello init 'Hello, World'
    data cDbf  init 'agenda.dbf'
    data cNtx  init 'agenda.ntx'
    data aDbf  init {{'Name'      , 'C',40, 00} ,;
                     {'date'      , 'D',08,00 } ,;
                     {'time_Start', 'C',05,00 } ,;
                     {'time_End'  , 'C',05,00 } }
    method new() constructor
    //method CreateDbf()
    //method SeekData( dDate, cTime1, cTime2  )
    //Method FillData( aData  )
    //Method Close()
EndClass

Method New()
		
		return Self
		
	

Proc Teste_menu()
*****************	
LOCAL mp

	
do while .t.
   cls
	//set color to w+/b
   set message to 20 CENTER
   //set color to n/w,w/g+
   mp = 0
   @ 09,22 prompt " 1: TBrowse          "     MESSAGE ' Imprimir a cada 10 Registros    '
   @ 10,22 prompt " 2: Calculo Juros    "     MESSAGE ' Imprimir todos o Registros      '
   set inte on
   menu to mp
   set inte off
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
           BrowseMain()
			  
      case mp= 2
           Calc()
   endcase
enddo
return Nil



Class tCal
    data cName init ''
    data cDbf  init 'agenda.dbf'
    data cNtx  init 'agenda.ntx'
    data aDbf  init {{'Name'      , 'C',40, 00} ,;
                     {'date'      , 'D',08,00 } ,;
                     {'time_Start', 'C',05,00 } ,;
                     {'time_End'  , 'C',05,00 } }
    //method new() constructor
    //method CreateDbf()
    //method SeekData( dDate, cTime1, cTime2  )
    //Method FillData( aData  )
    //Method Close()
EndClass


Proc Calc()
***************
LOCAL GetList := {}
LOCAL Valor
LOCAL nValor
LOCAL JuroMes
LOCAL Vcto
LOCAL Hoje
LOCAL N
LOCAL nDias
LOCAL nMeses
LOCAL nValorCm
LOCAL Atraso
LOCAL Jurodia
LOCAL nJuros

WHILE .T.
   Cls
   Valor    := 0
   nValor   := 0
   JuroMes  := 0
   Vcto     := Date()
   Hoje     := Date()+30
   n        := 0
   @ 02, 10 Say "Valor Principal....: " Get Valor    Pict "9999999.99"
   @ 03, 10 Say "Tx Juros...........: " Get JuroMes  Pict "999.99999"
   @ 04, 10 Say "Periodo............: " Get n        Pict "999"
   @ 05, 10 Say "Vencimento.........: " Get Vcto     Pict "##/##/##"
   @ 06, 10 Say "Calcular ate.......: " Get Hoje     Pict "##/##/##"
   Read
   if LastKey() = 27
      return
   endif

   Qout(Repl('=', 79))

   ndias     := hoje-vcto
   nMeses    := ndias/30
   nValorCm  := CalculaCm(Valor)
   AntComposto( nValorCm, JuroMes, Vcto, Hoje)
   TxEfetiva(nValor, JuroMes, Vcto, hoje, 6 )

/*
   aArray := aJuroSimples(nValor, JuroMes, nDias, (1/30))
   Qout("aJuroSimples", Repl('=', 65))
   Qout("Montante      : ", aArray[1])
   Qout("Principal     : ", aArray[2])
   Qout("Tx Juros      : ", aArray[3])
   Qout("Periodos      : ", aArray[4])
   Qout("Juros Total   : ", aArray[5])
   Qout("Juros Periodo : ", aArray[6])

   aArray := aJuroComposto(nValor, JuroMes, nDias, (12/1))
   Qout("aJuroComposto", Repl('=', 64))
   Qout("Montante      : ", aArray[1])
   Qout("Principal     : ", aArray[2])
   Qout("Tx Juros      : ", aArray[3])
   Qout("Periodos      : ", aArray[4])
   Qout("Juros Total   : ", aArray[5])
   Qout("Juros Periodo : ", aArray[6])
   Qout(Repl('=', 79))


   ? Jurodia( aarray[2], aarray[3])
*/


   Inkey(0)
   Loop
EndDO
return NIL


Function AntComposto( Valor, JuroMes, Vcto, Hoje)
*************************************************
   LOCAL Atraso  := Hoje - Vcto
   //jurodia := (Valor*(JuroMes/100)/30)
   LOCAL Jurodia := Jurodia( Valor, JuroMes, (1/30))
   LOCAL nJuros  := 0
   LOCAL nBase   := 31
   LOCAL nTotJr  := 0
   LOCAL x       := 0
   LOCAL y       := 0
   LOCAL nValor  := Valor
   For x := 1 To Atraso
      if x = nBase
         Atraso  -= 30
         x       := 0
         Valor   += nJuros
         nJuros  := 0
         Jurodia := Jurodia( Valor, JuroMes, (1/30))
         Loop
      endif
      y ++
      nJuros += Jurodia
      nTotJr += JuroDia
      Qout( y, Valor, nJuros, nTotJr )
   Next
   Qout(Repl('=', 79))
   Qout('Vencimento : ', Vcto )
   Qout('Dias       : ', Hoje-Vcto )
   Qout('Juro Mes   : ', JuroMes)
   Qout('Capital    : ', nValor )
   Qout('Juros      : ', nTotJr )
   Qout('Total      : ', nValor + nTotJr )
   Qout(Repl('=', 79))
   
   return NIL

Function Jurodia( nVlr, nJuro, nPeriodo )
********************************************
LOCAL j           // Juros
LOCAL p := nVlr   // Principal
LOCAL i := nJuro  // Taxa de Juros
LOCAL jp          // Juros Por Periodo
LOCAL n           // Periodo (Dias, Meses, Anos - Depende do contexto do nJuro, se por mes/ano/etc)
      n := (12/1) // 12meses/1mes=1ano
      n := (6/1)  // 06meses/1mes=1semestre
      n := 1      // 1mes
      n := (1/30) // 1mes/30dias=1dia

return((j := (p * (i/100) * n)))
return NIL

Function aJuroSimples( nPrincipal, nTaxa, nTempo, nPeriodo)
***********************************************************
LOCAL aArray := {}
LOCAL Jp
LOCAL p      := nPrincipal // Principal
LOCAL i      := nTaxa      // Taxa de Juros
LOCAL f      := nPrincipal // Montante
LOCAL j                    // Juros
LOCAL n           // Periodo (Dias, Meses, Anos - Depende do contexto do nTaxa, se por mes/ano/etc)
      n := 1      // 1mes
      n := (1/4)  // 01meses/4semanas=1semana
      n := (1/3)  // 01meses/3=10dias
      n := (1/2)  // 01meses/2semanas=1quinzena
      n := (2/1)  // 02meses/1mes=1bimestre
      n := (3/1)  // 03meses/1mes=1trimestre
      n := (6/1)  // 06meses/1mes=1semestre
      n := (12/1) // 12meses/1mes=1ano
      n := (1/30) // 1mes/30dias=1dia

if nPeriodo = NIL
   nPeriodo := n
else
   n := nPeriodo
endif
if nTempo = NIL
   nTempo := 0
endif
//? ntempo
Aadd( aArray, (f:=(p * (1+(i/100)*(n*nTempo))))) // Valor Futuro ou Montante
Aadd( aArray, (p:=(f / (1+(i/100)*(n*nTempo))))) // Valor Presente ou Principal
Aadd( aArray, (i:=((f - p)/(p*n)/nTempo*100)))   // Taxa de Juros

//Aadd( aArray, (f:=(p * (1+(i/100)*(nPeriodo*nTempo))))) // Valor Futuro ou Montante
//Aadd( aArray, (p:=(f / (1+(i/100)*(nPeriodo*nTempo))))) // Valor Presente ou Principal
//Aadd( aArray, (i:=((f - p)/(p*nPeriodo)/nTempo*100)))   // Taxa de Juros

//Aadd( aArray, (f:=(p * (1+(i/100)*n))))                 // Valor Futuro ou Montante
//Aadd( aArray, (p:=(f / (1+(i/100)*n))))                 // Valor Presente ou Principal
//Aadd( aArray, (i:=(f - p)/(p*n)*100))                       // Taxa de Juros

//Qout("Taxa   ", i)
//Qout("Periodo", n)
//Qout("Tempo  ", ntempo)

//Aadd( aArray, (n:=((f - p)/(p*i)*100*30)))            // Numero de Periodos
Aadd( aArray, (n:=((f - p)/(p*i)*100/nPeriodo)))        // Numero de Periodos
Aadd( aArray, (j:=(f - p)))                             // Juros
Aadd( aArray, (jp:=(j / n)))                            // Juros por Periodo

//Qout("Taxa   ", i)
//Qout("Periodo", n)
//Qout("Tempo  ", ntempo)
//Qout("Jr Periodo", jp)

return(aArray)

Proc Ambiente()
***************
	SetMode(25,132)
   Cls
   Set Date Brit
   Set Epoc To 1950
   Set Conf Off
   Set Bell On
   Set Scor Off
   Set Wrap On
   Set Mess To 22
   Set Dele On
   Set Date Brit
   Set Deci To 5
   Set Print To
   Set Fixed On
	return

Function aJuroComposto( nPrincipal, nTaxa, nTempo, nPeriodo)
************************************************************
LOCAL aArray := {}
LOCAL jP
LOCAL p      := nPrincipal // Principal
LOCAL i      := nTaxa      // Taxa de Juros
LOCAL f      := nPrincipal // Montante
LOCAL j                    // Juros
LOCAL n                    // Periodo (Dias, Meses, Anos - Depende do contexto do nTaxa, se por mes/ano/etc)
      n := 1               // 1mes
      n := (1/4)           // 01meses/4semanas=1semana
      n := (1/3)           // 01meses/3=10dias
      n := (1/2)           // 01meses/2semanas=1quinzena
      n := (2/1)           // 02meses/1mes=1bimestre
      n := (3/1)           // 03meses/1mes=1trimestre
      n := (6/1)           // 06meses/1mes=1semestre
      n := (12/1)          // 12meses/1mes=1ano
      n := (1/30)          // 1mes/30dias=1dia

if nPeriodo = NIL
   nPeriodo := n
else
   n := nPeriodo
endif
if nTempo = NIL
   nTempo := 0
endif

Aadd( aArray, (f:=(p * (1+(i/100))^(n*nTempo))))          // Valor Futuro ou Montante
Aadd( aArray, (p:=(f / (1+(i/100))^(n*nTempo))))          // Valor Presente ou Principal
Aadd( aArray, (i:=((f / p)^(1/(n*nTempo))-1)*100))        // Taxa de Juros

Aadd( aArray, (n:=((f / p)/(p*i)*100/nPeriodo)-1))        // Numero de Periodos
//Aadd( aArray, (n^=((f/p)/(1+i)/nperiodo)-1))                         // Numero de Periodos

Aadd( aArray, (j:=(f - p)))                               // Juros
Aadd( aArray, (jp:=(j / n)))                              // Juros por Periodo
return(aArray)

Function TxEfetiva( nValor, nJuroMes, dVcto, dAtual, nTipo )
****************************************************
LOCAL nTxJuros
LOCAL nTxEfetiva
LOCAL nDias
LOCAL nAtraso       := (dAtual - dVcto)
LOCAL nPeriodo      := nAtraso / 366 // nAtraso / (if(lAnoBissexto(dAtual), 366, 365))

ifNil( nTipo,   1 )
if nTipo = 1     //Anual
   nTxEfetiva := (((1 + nJuroMes/100)^12)-1)*100
   nTxJuros   := ((1 + nTxEfetiva/100)^nPeriodo)
elseif nTipo = 2 // Semestral
   nTxEfetiva := (((1 + nJuroMes/100)^6)-1)*100
elseif nTipo = 3 // Trimestral
   nTxEfetiva := (((1 + nJuroMes/100)^3)-1)*100
elseif nTipo = 4 // Bimestral
   nTxEfetiva := (((1 + nJuroMes/100)^2)-1)*100
elseif nTipo = 5 // Semanal
   nTxEfetiva := (((1 + nJuroMes/100)^(7/30))-1)*100
elseif nTipo = 6 // Diaria
   nTxEfetiva := (((1 + nJuroMes/100)^(1/30))-1)*100
   nTxJuros   := ((1 + nTxEfetiva/100)^nAtraso)
endif

Qout("Tx Efetiva        :", nTxEfetiva )
Qout("Dias              :", nDias )
Qout("Periodo de Dias   :", nPeriodo )
Qout("Capital           :", nValor)
Qout("Taxa de Juros     :", nTxJuros )
? nTxJuros                := ((1 + nTxEfetiva/100)^nAtraso)
? nValor

Qout("Capital           :", nValor)
Qout("Juros             :", (nValor * nTxJuros )- nValor )
Qout("Montante          :", nValor * nTxJuros )
Qout("===========================================")

return( nTxJuros )

Function CalculaCm(nValor, dVcto)
*********************************
LOCAL nCm := 4.09

return( nValor + (nValor * (nCm/100)))


/* UTF-8 */

// Harbour Class TBrowse and TBColumn sample

#include "inkey.ch"

PROCEDURE BrowseMain()

   LOCAL oBrowse := TBrowseNew( 5, 1, 16, 131 )
   LOCAL aTest0  := { "This", "is", "a", "browse", "on", "an", "array", "test", "with", "a", "long", "data" }
   LOCAL aTest1  := { 1, 2, 3, 4, 5, 6, 7, 8, 10000, - 1000, 54, 456342 }
   LOCAL aTest2  := { Date(), Date() + 4, Date() + 56, Date() + 14, Date() + 5, Date() + 6, Date() + 7, Date() + 8, Date() + 10000, Date() - 1000, Date() - 54, Date() + 456342 }
   LOCAL aTest3  := { .T., .F., .T., .T., .F., .F., .T., .F., .T., .T., .F., .F. }
   LOCAL n       := 1
   LOCAL nCursor
   LOCAL cColor
   LOCAL nRow, nCol
#ifndef HB_COMPAT_C53
   LOCAL nKey
   LOCAL nTmpRow, nTmpCol
   LOCAL lEnd    := .F.
#endif

   oBrowse:colorSpec     := "W+/B, N/BG"
   oBrowse:ColSep        := hb_UTF8ToStrBox( "│" )
   oBrowse:HeadSep       := hb_UTF8ToStrBox( "╤═" )
   oBrowse:FootSep       := hb_UTF8ToStrBox( "╧═" )
   oBrowse:GoTopBlock    := {|| n := 1 }
   oBrowse:GoBottomBlock := {|| n := Len( aTest0 ) }
   oBrowse:SkipBlock     := {| nSkip, nPos | nPos := n, ;
      n := iif( nSkip > 0, Min( Len( aTest0 ), n + nSkip ), ;
      Max( 1, n + nSkip ) ), n - nPos }

   oBrowse:AddColumn( TBColumnNew( "First",  {|| n } ) )
   oBrowse:AddColumn( TBColumnNew( "Second", {|| aTest0[ n ] } ) )
   oBrowse:AddColumn( TBColumnNew( "Third",  {|| aTest1[ n ] } ) )
   oBrowse:AddColumn( TBColumnNew( "Forth",  {|| aTest2[ n ] } ) )
   oBrowse:AddColumn( TBColumnNew( "Fifth",  {|| aTest3[ n ] } ) )
   oBrowse:GetColumn( 1 ):Footing := "Number"

   oBrowse:GetColumn( 2 ):Footing := "String"
   oBrowse:GetColumn( 2 ):Picture := "@!"

   oBrowse:GetColumn( 3 ):Footing := "Number"
   oBrowse:GetColumn( 3 ):Picture := "@E 999,999.99"

   oBrowse:GetColumn( 4 ):Footing := "Dates"
   oBrowse:GetColumn( 5 ):Footing := "Logical"
   // needed since I've changed some columns _after_ I've added them to TBrowse object
   oBrowse:Configure()

   Alert( oBrowse:ClassName() )
   Alert( oBrowse:GetColumn( 1 ):ClassName() )

   oBrowse:Freeze := 1
   nCursor := SetCursor( 0 )
   cColor := SetColor( "W+/B" )
   nRow := Row()
   nCol := Col()
   hb_DispBox( 4, 0, 17, 132, hb_UTF8ToStrBox( "┌─┐│┘─└│ " ) )
#ifdef HB_COMPAT_C53
   oBrowse:SetKey( 0, {| ob, nkey | DefProc( ob, nKey ) } )
   WHILE .T.
      oBrowse:ForceStable()
      if oBrowse:applykey( Inkey( 0 ) ) == -1
         EXIT
      endif
   ENDDO
#else
   WHILE ! lEnd
      oBrowse:ForceStable()

      nKey := Inkey( 0 )

      DO CASE
      CASE nKey == K_ESC
         SetPos( 17, 0 )
         lEnd := .T.

      CASE nKey == K_DOWN
         oBrowse:Down()

      CASE nKey == K_UP
         oBrowse:Up()

      CASE nKey == K_LEFT
         oBrowse:Left()

      CASE nKey == K_RIGHT
         oBrowse:Right()

      CASE nKey == K_PGDN
         oBrowse:pageDown()

      CASE nKey == K_PGUP
         oBrowse:pageUp()

      CASE nKey == K_CTRL_PGUP
         oBrowse:goTop()

      CASE nKey == K_CTRL_PGDN
         oBrowse:goBottom()

      CASE nKey == K_HOME
         oBrowse:home()

      CASE nKey == K_END
         oBrowse:end()

      CASE nKey == K_CTRL_LEFT
         oBrowse:panLeft()

      CASE nKey == K_CTRL_RIGHT
         oBrowse:panRight()

      CASE nKey == K_CTRL_HOME
         oBrowse:panHome()

      CASE nKey == K_CTRL_END
         oBrowse:panEnd()

      CASE nKey == K_TAB
         hb_DispOutAt( 0, 0, Time() )

      ENDCASE

   ENDDO
#endif
   SetPos( nRow, nCol )
   SetColor( cColor )
   SetCursor( nCursor )

   return

#ifdef HB_COMPAT_C53

STATIC FUNCTION DefProc( oBrowse, nKey )

   if nKey == K_TAB
      hb_DispOutAt( 0, 0, Time() )
      oBrowse:Refreshall()
   endif

   return 1

#endif