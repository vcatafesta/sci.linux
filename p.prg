function main()


set devi to print
set print on
set printer to "|lpr -h -l -Plx300"

@ 0,0 say "LINHA1"
@ 1,0 say "LINHA2"
@ 2,0 say "LINHA3"

set print to
set print off
set devi to screen


*********************************
Function PrintWinPrn(cArq,cPrint)
*********************************
*
*
Local oPrn, aPrn:=GetPrinters(), n := 0
if empty(aPrn)
   MsgInfo('Não há impressoras instaladas')
   return .f.
endif
If cPrint == Nil
 cPrint := GetDefaultPrinter()
EndIf
   
oPrn := win_prn():New(cPrint)
oPrn :LandScape := .f.
oPrn :FormType  := FORM_A4
oPrn :Copies    :=  1
oPrn:CharSet(255)
oPrn:setfont('Courier New',,12,,,,255)

if !oPrn:Create()
    MsgInfo("Não foi criado documento")
    return nil
EndIf
if !oPrn:startDoc("Imprimindo Documento")
   MsgInfo("Erro na Impressora")
   return nil
EndIf

HB_CDPSelect("PT850")
  setprc(5,0)
  cText := memoread(cArq) 
  nLinh := mlcount(cText)
  For n := 1 to nLinh
     oPrn:TextOut(ansitooem(memoline(cText,,n)),.t.)
  Next
  oPrn:EndDoc()

HB_CDPSelect( "PTISO") 
Return .t.
