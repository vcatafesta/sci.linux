#include "hbclass.ch"
#Include "box.ch"
#Include "inkey.ch"

#Define  FALSO   .F.
#Define  OK      .T.
#define ENABLE   .T.
#define DISABLE  .F.


CLASS TRelato
    Export:
		  VAR RowPrn
		  VAR Pagina
		  VAR Tamanho
		  VAR NomeFirma
		  VAR Sistema
		  VAR Titulo
		  VAR Cabecalho
		  VAR Separador
		  VAR Registros

    Export:
        METHOD New CONSTRUCTOR
		  METHOD Inicio
		  METHOD Eject
		  METHOD PrintOn
		  METHOD PrintOff
		  MESSAGE cabec method Inicio

EndClass

Method New() class TRelato
		  ::RowPrn	  := 0
		  ::Pagina	  := 0
		  ::Tamanho   := 80
		  ::NomeFirma := if( XNOMEFIR = NIL, AllTrim(oAmbiente:xFanta), XNOMEFIR )
        ::Sistema   := "Macrosoft NOME DO PROGRAMA"
		  ::Titulo	  := "TITULO DO RELATORIO"
		  ::Cabecalho := "CODIGO DESCRICAO"
		  ::Separador := "="
		  ::Registros := 0
        return( Self )

Method Inicio() class TRelato
		LOCAL nTam := ::Tamanho / 2
		LOCAL Hora := Time()
		LOCAL Data := Dtoc( Date() )
		::Pagina++

		DevPos( 0, 0) ; QQout( Padc( ::NomeFirma, ::Tamanho ))
		Qout( Padc( ::Sistema, ::Tamanho ))
		Qout( Padc( ::Titulo, ::Tamanho ))
		Qout( Padr( "Pagina : " + StrZero( ::Pagina, 3 ), ( nTam     ) ) + Padl( Data + " - " + Hora, ( nTam  ) ) )
		Qout( Repl( ::Separador, ::Tamanho ))
		Qout( ::Cabecalho )
		Qout( Repl( ::Separador, ::Tamanho ))
      ::RowPrn := 7
      return( Self )
		
Method PrintOn(cCodigoControle) class TRelato
	PrintOn()
	if cCodigoControle != NIL
		Fprint( cCodigoControle)
	endif		
   SetPrc(0,0)
	return self
	
Method PrintOff(cCodigoControle) class TRelato
	if cCodigoControle != NIL
		Fprint( cCodigoControle)
	endif		   
	PrintOff()
	return self	
		
Method EJect() class TRelato
	::RowPrn := 0
   __Eject()
	SetPrc(0,0)
   return self

Function TRelatoNew()
*********************
return( TRelato():New())
