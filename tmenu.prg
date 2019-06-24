#include <sci.ch>

class TMenu from TAmbiente
	public:
		method New
	
	public Menu1
	
endclass

method New( oOwner ) class TMenu

   ::New( oOwner )
	//with Self
	    *
		 ::setvar()	
       ::StatusSup      := "MicroBras"
       ::StatusInf      := ""
		 ::Panos          := ::SetPano()
		 ::Menu           := ::xMenu()
       ::Disp           := ::xDisp()
       ::Alterando      := FALSO
       ::Ativo          := 1
       ::nPos           := 1
       ::NomeFirma      := "MICROBRAS COM DE PROD DE INFORMATICA LTDA"
       ::CodiFirma      := '0001'
       ::StSupArray     := { ::StatusSup }
       ::StInfArray     := { ::StatusInf }
       ::MenuArray      := { ::Menu }
       ::DispArray      := { ::Disp }
	//endwith
	
return(self)

Function TMenuNew()
	return( TMenu():New())
