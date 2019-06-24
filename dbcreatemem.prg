#include <sci.ch>

function main()
   nHandle := FTempMemory()	 
	xAlias  := FaturaNew(nHandle)
	xNtx	  := FTempMemory()	
	
	? 1, xALias
	? 2, (xalias)
	
	Area("xalias")
	? alias()
	Inde On Codigo To mem:(xNtx)
	
	? (xalias)->(Recno())
	? (xAlias)->Codigo 
	
	? xalias->(Recno())
	? xAlias->Codigo 
	FecharTemp(nHandle, xNtx)		   	
	
	
def FecharTemp(cDbf, cNtx)
*-------------------------*	   
	ms_mem_dbclosearea(cDbf)	
	return nil
endef	
	
def ms_mem_dbclosearea(cFile)
	(cFile)->(DbCloseArea())
	alert(cFile)
   dbDrop( "mem:" + (cFile))
	return nil 	
endef		

def FaturaNew(Handle, xALias)
*---------------------------*
	LOCAL _rddname 
	LOCAL aStru := {{ "CODIGO",     "C", 06, 0 }, ; // Codigo do Produto
						 { "UN",         "C", 02, 0 }, ;
						 { "CODI",       "C", 05, 0 }, ;
						 { "QUANT",      "N", 08, 2 }, ;
						 { "SERIE",      "C", 10, 0 }, ;
						 { "DESCONTO",   "N", 05, 2 }, ;
					 	 { "DESCRICAO",  "C", 40, 0 }, ;
						 { "PCOMPRA",    "N", 13, 2 }, ;
						 { "PCUSTO",     "N", 13, 2 }, ;
						 { "VAREJO",     "N", 13, 2 }, ;
						 {  "ATACADO",    "N", 13, 2 }, ;
						 { "UNITARIO",   "N", 13, 2 }, ;
						 { "CUSTOFINAL", "N", 13, 2 }, ;
						 { "TOTAL",      "N", 13, 2 }, ;
						 { "MARVAR",     "N", 06, 2 }, ;
						 { "MARATA",     "N", 06, 2 }, ;
						 { "IMPOSTO",    "N", 06, 2 }, ;
						 { "FRETE",      "N", 06, 2 }, ;
  						 { "UFIR",       "N", 07, 2 }, ;
						 { "IPI",        "N", 05, 2 }, ;
	 					 { "II",         "N", 05, 2 }, ;
						 { "FUNRURAL",   "N", 13, 2 }, ;
						 { "DESCMAX",    "N", 06, 2 }, ;
						 { "SIGLA",      "C", 10, 0 }, ;
						 { "LOCAL",      "C", 10, 0 }, ;
						 { "TAM",        "C", 06, 0 }, ;
						 { "N_ORIGINAL", "C", 15, 0 }, ;
						 { "FATURA",     "C", 09, 0 }, ; // Usado em FechaDiaEcf()
						 { "FORMA",      "C", 02, 0 }, ; // Usado em FechaDiaEcf()
						 { "IMPRESSO",   "L", 01, 0 }, ; // Usado em FechaDiaEcf()
						 { "EMIS",       "D", 08, 0 }, ; // Usado em FechaDiaEcf()
						 { "CLASSE",     "C", 01, 0 }, ; // Usado em FechaDiaEcf()
						 { "SERVICO",    "L", 01, 0 }, ; // Usado em FechaDiaEcf()
						 { "CODEBAR",    "C", 13, 0 }, ; // Usado em FechaDiaEcf()
						 { "PORC",       "N", 05, 2 }}

   Hb_default(@handle, FTempMemory())						 
	return ms_mem_dbCreate(handle, aStru, (xAlias), _rddname)
endef

def ms_mem_dbCreate(cFile, aStru, cAlias, _rddname)
	REQUEST HB_MEMIO
	hb_default(@cAlias, "XALIAS")	
	hb_default(@_rddname, nil)	// default sistema		
	dbCreate( "mem:" + (cFile), aStru, _rddname, true, cAlias)	
	return Alias()
endef

def FTempMemory()
*----------------*
	LOCAL cFile := ""	
	LOCAL nNumber 
	LOCAL cNumber 
	LOCAL snRandom := Seconds() / Exp(1) 
   LOCAL nLimit   := 65535 
	
	snRandom := Log( snRandom + Sqrt(2) ) * Exp(3) 
   snRandom := Val( Str(snRandom - Int(snRandom), 17, 15 ) ) 	
	nNumber  := HB_RandomInt(snRandom, 999999)	
	cNumber  := StrZero(nNumber, 7)	
	cFile    := 'MEM' + cNumber	
	return cFile
endef