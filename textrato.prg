#include <sci.ch>

CLASS TExtratoImp
	VAR nRegTribunal              INIT 0
	VAR nRegRecibo                INIT 0
	VAR nRegVencido               INIT 0
	VAR nRegVencer                INIT 0
	VAR nVlrPrincipalTribunal     INIT 0
	VAR nVlrPrincipalRecibo       INIT 0
	VAR nVlrPrincipalVencido      INIT 0
	VAR nVlrPrincipalVencer       INIT 0
	VAR nTotalRecibo              INIT 0 
	VAR nTotalVencido             INIT 0 
	VAR nTotalVencer              INIT 0 
	VAR nVlrCorrigido             INIT 0
	VAR nVlrCorrigidoTotal        INIT 0
	VAR nSoJuros                  INIT 0
	VAR nSoJurosTotal             INIT 0
	VAR nVlrCorrigidoMaisnSoJuros INIT 0
	VAR nMultaTotal               INIT 0
	VAR nTotalGeral               INIT 0
	VAR nAtraso                   INIT 0
	VAR nCarencia                 INIT 0
	VAR nDesconto                 INIT 0
	VAR nJuros	                  INIT 0
	VAR nSoma 		               INIT 0
	VAR nMulta		               INIT 0
	VAR nValorCm                  INIT 0
	VAR nCm                       INIT 0
	VAR nDias                     INIT 0
	VAR nJuro 			            INIT 0
	VAR aJuro                     INIT {}
	VAR nJuroDia                  INIT 0
	VAR nJuroTotal                INIT 0
	VAR nVlr                      INIT 0	
	VAR dVcto                     INIT Date()	
	VAR dCalculo                  INIT Date()  	
	METHOD New() INLINE Self
	METHOD Zerar() 
	METHOD CalculaPorraToda()
	METHOD ContaTribunal() 
	METHOD ContaRecibo() 
	METHOD ContaVencido() 
	METHOD ContaVencer() 	
ENDCLASS

METHOD Zerar() class TExtratoImp
**************
	::nRegTribunal              := 0
	::nRegRecibo                := 0
	::nRegVencido               := 0
	::nRegVencer                := 0
	::nVlrPrincipalTribunal     := 0
	::nVlrPrincipalRecibo       := 0
	::nVlrPrincipalVencido      := 0
	::nVlrPrincipalVencer       := 0
	::nTotalRecibo              := 0 
	::nTotalVencido             := 0 
	::nTotalVencer              := 0 
	::nVlrCorrigido             := 0
	::nVlrCorrigidoTotal        := 0
	::nSoJuros                  := 0
	::nSoJurosTotal             := 0
	::nVlrCorrigidoMaisnSoJuros := 0
	::nMultaTotal               := 0
	::nTotalGeral               := 0
	::nMulta                    := 0
	::nSoma                     := 0
	::nAtraso                   := 0
	::nCarencia                 := 0
	::nDesconto                 := 0
	::nJuros	                   := 0
	::nSoma 		                := 0
	::nMulta		                := 0
	::nValorCm                  := 0
	::nCm                       := 0
	::nVlrCorrigido             := 0
	::nDias                     := 0
	::nJuro 			             := 0
	::aJuro                     := {}
	::nJuroDia                  := 0
	::nJuroTotal                := 0
	::nSoJuros                  := 0
	::nJuroTotal                := 0
	::nJuroDia                  := 0
	::nVlr                      := 0
	::dVcto                     := Date()
	::dVcto                     := Date()
return self

METHOD CalculaPorraToda() class TExtratoImp
   ::nAtraso       := Atraso(      ::dCalculo, ::dVcto )
	::nCarencia	    := Carencia(    ::dCalculo, ::dVcto )
	::nDesconto	    := VlrDesconto( ::dCalculo, ::dVcto, ::nVlr )

	::nJuros	       := if( ::nAtraso <= 0, 0, ( ::nCarencia * ::nJurodia ))
	::nSoma 		    := ((::nVlr + ::nJuros ) - ::nDesconto)		
	::nMulta		    := VlrMulta( ::dCalculo, ::dVcto, ::nSoma )		
	::nSoma 		    += ::nMulta
	
	::nValorCm      := CalculaCm(::nVlr, ::dVcto, ::dCalculo)
	::nCm           := (::nValorCm - ::nVlr)		
	::nVlrCorrigido := ::nValorCm		
	::nDias         := (::dCalculo - ::dVcto)
	::nJuro 			 := oAmbiente:aSciArray[1 , SCI_JUROMESCOMPOSTO] 
	::aJuro         := aAntComposto( ::nVlr, ::nJuro, ::nDias, XJURODIARIO)
	::nJuroDia      := ::aJuro[6]
	::nJuroTotal    := ::aJuro[5]		
	::nSoJuros      := ::aJuro[5]
	::nJuroTotal    += ::nCm
	::nJuroDia      := (::nJuroTotal / ::nDias)			
return self

METHOD ContaTribunal() class TExtratoImp
	::nRegTribunal++
	::nVlrPrincipalTribunal     += ::nVlr
	::nVlrCorrigidoTotal        += ::nVlrCorrigido
	::nSoJurosTotal             += ::nSoJuros
	::nVlrCorrigidoMaisnSoJuros += ::nVlrCorrigido + ::nSoJuros
	::nMultaTotal               += ::nMulta
	::nTotalGeral               += ::nVlrCorrigido + ::nSoJuros + ::nMulta
return self

METHOD ContaRecibo() class TExtratoImp
	::nRegRecibo++
	::nVlrPrincipalRecibo += ::nVlr
	::nTotalRecibo        += Recibo->Vlr
return self

METHOD ContaVencido() class TExtratoImp
	::nRegVencido++
	::nVlrPrincipalVencido += ::nVlr
	::nTotalVencido        += ::nSoma
return self

METHOD ContaVencer() class TExtratoImp
	::nRegVencer++
	::nVlrPrincipalVencer += ::nVlr
	::nTotalVencer        += ::nSoma
return self	

*:==================================================================================================================================
