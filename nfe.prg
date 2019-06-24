/* autor Luiz Rafael Culik Guimraes luiz at xharbour.com.br
classe para gerar  o xml de nfe
*/


#include "hbxml.ch"
#include "hbclass.ch"
#include "common.ch"

#ifdef TEST

func main
Local oXml :=NFEENVLOTE():New()
local n
local di :=oxml:CreateDi( 'nDI', 'dDi', 'xLocDesemb', 'UFDesemb', 'dDesemb', 'cExportador' )
local adi :=oXml:CreateADi('nAdicao', 'nSeqAdic', 'cFabricante', 'vDescDI')
Local amed:= oXml:CreateMed("nLote","qLote","dFab","dVal","vPMC")
Local aVei := oXml:CreateVeiculo("tpOp    ","chassi  ","cCor    ","xCor    ","pot     ","CM3     ","pesoL   ","pesoB   ","nSerie  ","tpComb  ","nMotor  ","CMKG    ","dist    ","RENAVAM ","anoMod  ","anoFab  ","tpPint  ","tpVeic  ","espVeic ","VIN     ","condVeic","cMod"    )
local adi1 :=oXml:CreateADi('nAdicao', 'nSeqAdic', 'cFabricante', 'vDescDI')
Local amed1:= oXml:CreateMed("nLote","qLote","dFab","dVal","vPMC")
Local aVei1 := oXml:CreateVeiculo("tpOp    ","chassi  ","cCor    ","xCor    ","pot     ","CM3     ","pesoL   ","pesoB   ","nSerie  ","tpComb  ","nMotor  ","CMKG    ","dist    ","RENAVAM ","anoMod  ","anoFab  ","tpPint  ","tpVeic  ","espVeic ","VIN     ","condVeic","cMod"    )
Local oICMSCons :=oXml:CreateICMSCons("vBCICMSSTCons" ,"vICMSSTCons"   ,"UFcons" )
Local oICMSInter :=oXml:CreateICMSInter( "vBCICMSSTDest", "vICMSSTDest"  )
Local oICMSCOMB :=oXml:CreateICMSCOMB( "vBCICMS"  ,"vICMS"    ,"vBCICMSST", "vICMSST"  )
Local oCide :=oXml:CreateCide( "qBCprod"  ,"vAliqProd", "vCIDE"    )
Local oComb :=oXml:CreateComb("cProdANP","CODif"   ,"qTemp" ,oCide,  oICMSComb,oICMSInter,oICMSCons )
Local oProd1,oProd2
Local o1 := oXml:CreateICMS00( "orig","CST","modBC","vBC","pICMS","vICMS ")
Local o2 := oXml:CreateICMS10( "orig","CST","modBC","vBC","pICMS","vICMS","modBCST","pMVAST ","pRedBCST","vBCST","pICMSST","vICMSST ")
Local o3 := oXml:CreateICMS20( "orig","CST","modBC","pRedBC","vBC","pICMS","vICMS ")
Local o4 := oXml:CreateICMS30( "orig","CST","modBCST","pMVAST","pRedBCST","vBCST","pICMSST","vICMSST")
Local o5 := oXml:CreateICMS40( "orig","CST ")
Local o6 := oXml:CreateICMS51( "orig","CST","modBC","pRedBC","vBC","pICMS","vICMS ")
Local o7 := oXml:CreateICMS60( "orig","CST","vBCST","vICMSST ")
Local o8 := oXml:CreateICMS70( "orig","CST","modBC","pRedBC","vBC","pICMS","vICMS ","modBCST","pMVAST","pRedBCST","vBCST","pICMSST","vICMSST ")
Local o9 := oXml:CreateICMS90( "orig ","CST ","modBC ","pRedBC ","vBC      ","pICMS    ","vICMS    ","modBCST  ","pMVAST   ","pRedBCST ","vBCST    ","pICMSST ","vICMSST " )
Local o10 := oXml:CreateICMS( o1, o2,o3,o4,o5,o6,o7,o8,o9)
Local o11 := oXml:CreatePISST("vBC      ","pPIS     ","qBCProd  ","vAliqProd","vPIS     ")
Local o12 := oXml:CreatePISOutr("CST","vBC","pPIS","qBCProd","vAliqProd","vPIS")
Local o13 := oXml:CreatePISNT( "CST ")
Local o14 := oXml:CreatePISQtde("CST","qBCProd","vAliqProd","vPIS")
Local o15 := oXml:CreatePISAliq("CST","vBC","pPIS","vPIS")
Local o16 := oXml:CreatePis(o15,o14,o13,o12,o11)
Local o17 := oXml:CreateII("vBC" )
Local o18 := oXml:CreateIPINT( "CST" )
Local o19 := oXml:CreateIPI( "clEnq   ","CNPJProd","cSelo   ","qSelo   ","cEnq    ","vIPI ",o18    )

Local o21 := oXml:CreateCOFINSAliq( "CST     ","vBC     ","pCOFINS ","vCOFINS  ")
Local o22 := oXml:CreateCOFINSQtde( "CST","qBCProd","vAliqProd","vCOFINS")
Local o23 := oXml:CreateCOFINSNT( "CST","qBCProd","vAliqProd","vCOFINS")
Local o24 := oXml:CreateCOFINSOutr( "CST","vBC","pCOFINS","qBCProd","vAliqProd","vCOFINS")
Local o25 := oXml:CreateCOFINSST( "vBC","pCOFINS","qBCProd","vAliqProd","vCOFINS")
Local o20 := oXml:CreateConfins(o21, o22,o23,o24,o25 )
Local o26 := oXml:CreateISSQN("vBC","vAliq","vISSQN","cMunFG","cListServ")

Local o27 := oXml:CreateImposto(o10,o19,o16, o20,o26)

local a1:=  oxml:CreateICMSTot(" vBC"," vICMS"," vBCST"," vST"," vProd"," vFrete"," vSeg"," vDesc"," vII"," vIPI"," vPIS"," vCOFINS"," vOutro"," vNF ")
local a12:= oxml:CreateISSQNtot("vServ"," vBC"," vISS"," vPIS"," vCOFINS" )
local a13:= oxml:CreateretTrib("vRetPIS   ","vRetCOFINS","vRetCSLL  ","vBCIRRF","vIRRF","vBCRetPrev","vRetPrev")
//local a14:= oxml:CreateTotal( a1, a12,a13 )
local a15:= oxml:Createtransporta("CNPJ      ","CPF       ","xNome ","IE    ","xEnder","xMun  ","UF   " )
local a16:= oxml:CreateretTransp("vServ","vBCRet","pICMSRet","vICMSRet","CFOP","cMunFG")
local a17:= oxml:CreateveicTransp("placa ","UF    ","RNTC " )
local a18:= oxml:Createreboque("placa ","UF    ","RNTC " )
local a19:= oxml:Createvol("qVol","esp","marca","nVol","pesoL","pesoB")
local a20:= oxml:Createlacres( "nLacre " )
////local a21:= oxml:Createtransp("modFrete",a15,a16,a17,a18,a19,a20)
local a22:= oxml:Createfat("nFat","vOrig","vDesc","vLiq")
local a23:= oxml:Createdup("nDup","dVenc","vDup")
//local a24:= oxml:Createcobr(a22,a23)
local a25:= oxml:CreateobsCont("xCampo","xTexto")
local a26:= oxml:CreateobsFisco("xCampo","xTexto" )
local a27:= oxml:CreateprocRef("nProc","indProc")
////local a28:= oxml:CreateinfAdic("infAdFisco","infCpl",a25,a26,a27)
////local a29:= oxml:Createexporta("UFEmbarq  ","xLocEmbarq")
////local a30:= oxml:CreateCompra("xNEmp ","xPed  ","xCont" )

Local s1:=consReciNFe():New("1.0","a","b")
Local s2:=cancNFe():New("1.0")
Local s3 := s2:CreateinfCanc("Id","tpAmb","xServ","chNFe","nProt","xJust" )




//oxml:InfNew("10")
oXml:enviNFe("10","11","12")
oXml:CreateIDe("cuf","cnf","&natOp",">indPag","<mod","'serie","nNF   ",date(),date(),"tpNF","cMunFG","refNFe","tpImp","tpEmis","cDV")
oXml:CreateEmit("1077180000172","xNome  ","xFant  ","  xLgr   ","nro    ","xBairro","cMun   ","xMun   ","UF     ","CEP    ","cPais  ","xPais  ","fone   ","IE" ,,,    )
oXml:CreateDest(1077180000172,"xNome  ","xFant  ","  xLgr   ","nro    ","xBairro","cMun   ","xMun   ","UF     ","CEP    ","cPais  ","xPais  ","fone   ","IE" ,,,    )
oXml:CreateDest("90756940087","xNome   ","xLgr    ","nro     ","xBairro ","cMun    ","xMun    ","UF      ","CEP     ","cPais   ","xPais   ","fone    ","IE"," ISUF" )

oprod1:=oXml:CreateProd( "cProd   "," cEAN    ","xProd   ","NCM     ","EXTIPI  ","genero  ","CFOP    ","uCom    ","qCom    ","vUnCom  ","vProd   ","cEANTrib","uTrib   ","qTrib   ","vUnTrib ","vFrete  ","vSeg    ","vDesc ",di,adi,avei ,amed     )
oProd2:=oXml:CreateProd( "cProd   "," cEAN    ","xProd   ","NCM     ","EXTIPI  ","genero  ","CFOP    ","uCom    ","qCom    ","vUnCom  ","vProd   ","cEANTrib","uTrib   ","qTrib   ","vUnTrib ","vFrete  ","vSeg    ","vDesc ",di,adi1,avei1 ,amed1,oComb )

oXml:CreateDet("001",oProd1,o27,"11")
oXml:CreateDet("002",oProd2,o27,"22")

oxml:CreateTotal( a1, a12,a13 )

oxml:Createtransp("modFrete",a15,a16,a17,a18,a19,a20)

oxml:Createcobr(a22,a23)
oxml:CreateinfAdic("infAdFisco","infCpl",a25,a26,a27)
oxml:Createexporta("UFEmbarq  ","xLocEmbarq")
oxml:CreateCompra("xNEmp ","xPed  ","xCont" )


oxml:write("aa.xml")

s1:write("bb.xml")
s2:write("cc.xml",s3)


return nil

function ConvertText(cText)

return Alltrim(cText)

#endif



**************************************************************************************
Create CLASS NFEENVLOTE
**************************************************************************************

   DATA oXml INIT TXmlDocument():New()
   DATA oNfe
   DATA oInfNfe
   DATA oemit
   DATA oIde
   DATA oDest

   //Data aProd INIT {}

   METHOD New()
   METHOD InfNew(id)
   METHOD enviNFe(Versao,idLote,infVersao)
   METHOD CreateIDe(cuf,cnf,natOp,indPag,mod,serie,nNF   ,dEmi,dSaiEnt,tpNF,cMunFG,refNFe,tpImp,tpEmis,cDV)
   METHOD CreateEmit(CNPJ   ,xNome  ,xFant  ,  xLgr   ,nro    ,xBairro,cMun   ,xMun   ,UF     ,CEP    ,cPais  ,xPais  ,fone   ,IE     )
   METHOD CreateDest(CNPJ   ,xNome  ,xFant  ,  xLgr   ,nro    ,xBairro,cMun   ,xMun   ,UF     ,CEP    ,cPais  ,xPais  ,fone   ,IE     )
   METHOD CreateADi(nAdicao, nSeqAdic, cFabricante, vDescDI)
   METHOD CreateDi( nDI, dDi, xLocDesemb, UFDesemb, dDesemb, cExportador )
   METHOD CreateProd( cProd   , cEAN    ,xProd   ,NCM     ,EXTIPI  ,genero  ,CFOP    ,uCom    ,qCom    ,vUnCom  ,vProd   ,cEANTrib,uTrib   ,qTrib   ,vUnTrib ,vFrete  ,vSeg    ,vDesc  ,Di,adi )
   METHOD CreateMed(nLote,qLote,dFab,dVal,vPMC)
   METHOD CreateVeiculo(tpOp    ,chassi  ,cCor    ,xCor    ,pot     ,CM3     ,pesoL   ,pesoB   ,nSerie  ,tpComb  ,nMotor  ,CMKG    ,dist    ,RENAVAM ,anoMod  ,anoFab  ,tpPint  ,tpVeic  ,espVeic ,VIN     ,condVeic,cMod    )
   METHOD CreateICMSCons(vBCICMSSTCons ,vICMSSTCons   ,UFcons )
   METHOD CreateICMSInter( vBCICMSSTDest, vICMSSTDest  )
   METHOD CreateICMSCOMB( vBCICMS  ,vICMS    ,vBCICMSST, vICMSST  )
   METHOD CreateCide( qBCprod  ,vAliqProd, vCIDE    )
   METHOD CreateComb(cProdANP,CODif   ,qTemp ,oCide,  oICMSComb,oICMSInter,oICMSCons )
   METHOD CreateICMS00( orig,CST,modBC,vBC,pICMS,vICMS )
   METHOD CreateICMS10( orig,CST,modBC,vBC,pICMS,vICMS,modBCST,pMVAST ,pRedBCST,vBCST,pICMSST,vICMSST )
   METHOD CreateICMS20( orig,CST,modBC,pRedBC,vBC,pICMS,vICMS )
   METHOD CreateICMS30( orig,CST,modBCST,pMVAST,pRedBCST,vBCST,pICMSST,vICMSST)
   METHOD CreateICMS40( orig,CST )
   METHOD CreateICMS51( orig,CST,modBC,pRedBC,vBC,pICMS,vICMS )
   METHOD CreateICMS60( orig,CST,vBCST,vICMSST )
   METHOD CreateICMS70( orig,CST,modBC,pRedBC,vBC,pICMS,vICMS ,modBCST,pMVAST,pRedBCST,vBCST,pICMSST,vICMSST )
   METHOD CreateICMS90( orig ,CST ,modBC ,pRedBC ,vBC      ,pICMS    ,vICMS    ,modBCST  ,pMVAST   ,pRedBCST ,vBCST    ,pICMSST ,vICMSST  )
   METHOD CreateICMS( oICMS00, oICMS10,oICMS20,oICMS30,oICMS40,oICMS51,oICMS60,oICMS70,oICMS90)
   METHOD CreatePISST(vBC      ,pPIS     ,qBCProd  ,vAliqProd,vPIS     )
   METHOD CreatePISOutr(CST,vBC,pPIS,qBCProd,vAliqProd,vPIS)
   METHOD CreatePISNT( CST )
   METHOD CreatePISQtde(CST,qBCProd,vAliqProd,vPIS)
   METHOD CreatePISAliq(CST,vBC,pPIS,vPIS)
   METHOD CreatePis(oPISAliq,oPISQtde,oPISNT,oPISOutr,oPISST)
   METHOD CreateII(vBC )
   METHOD CreateIPINT( CST )
   METHOD CreateIPI( clEnq   ,CNPJProd,cSelo   ,qSelo   ,cEnq    ,vIPI ,oIPINT    )
   METHOD CreateConfins(oCOFINSAliq, oCOFINSQtde,oCOFINSNT,oCOFINSOutr,oCOFINSST )
   METHOD CreateCOFINSAliq( CST     ,vBC     ,pCOFINS ,vCOFINS  )
   METHOD CreateCOFINSQtde( CST,qBCProd,vAliqProd,vCOFINS)
   METHOD CreateCOFINSNT( CST,qBCProd,vAliqProd,vCOFINS)
   METHOD CreateCOFINSOutr( CST,vBC,pCOFINS,qBCProd,vAliqProd,vCOFINS)
   METHOD CreateCOFINSST( vBC,pCOFINS,qBCProd,vAliqProd,vCOFINS)
   METHOD CreateISSQN(vBC,vAliq,vISSQN,cMunFG,cListServ)
   METHOD CreateImposto(oICMS,oIPI,oPIS, oCOFINS,oISSQN)
   METHOD CreateDet(nItem,oProd,oImposto,infAdProd)
   METHOD  CreateICMSTot( vBC, vICMS, vBCST, vST, vProd, vFrete, vSeg, vDesc, vII, vIPI, vPIS, vCOFINS, vOutro, vNF )
   METHOD CreateISSQNtot(vServ, vBC, vISS, vPIS, vCOFINS )
   METHOD CreateretTrib(vRetPIS   ,vRetCOFINS,vRetCSLL  ,vBCIRRF,vIRRF,vBCRetPrev,vRetPrev)
   METHOD CreateTotal( oICMSTot, oISSQNtot,oretTrib )
   METHOD Createtransporta(CNPJ      ,CPF       ,xNome ,IE    ,xEnder,xMun  ,UF    )
   METHOD CreateretTransp(vServ,vBCRet,pICMSRet,vICMSRet,CFOP,cMunFG)
   METHOD CreateveicTransp(placa ,UF    ,RNTC  )
   METHOD Createreboque(placa ,UF    ,RNTC  )
   METHOD Createvol(qVol,esp,marca,nVol,pesoL,pesoB)
   METHOD Createlacres( nLacre  )
   METHOD Createtransp(modFrete,otransporta,oretTransp,oveicTransp,oreboque,ovol,olacres)

   METHOD Createfat(nFat,vOrig,vDesc,vLiq)
   METHOD Createdup(nDup,dVenc,vDup)
   METHOD Createcobr(oFat,oDup)
   METHOD CreateobsCont(xCampo,xTexto)
   METHOD CreateobsFisco(xCampo,xTexto )
   METHOD CreateprocRef(nProc,indProc)
   METHOD CreateinfAdic(infAdFisco,infCpl,oobsCont,oobsFisco,oprocRef)
   METHOD Createexporta(UFEmbarq  ,xLocEmbarq)
   METHOD CreateCompra(xNEmp ,xPed  ,xCont )

   METHOD Write(cFile)

end class

**************************************************************************************
METHOD New()
**************************************************************************************

return self


**************************************************************************************
METHOD EnviNFe(Versao,idLote,infVersao)
**************************************************************************************
   Local hHash := hash()
   Local a:=hash()
   Local oNfe
   Local o

   hHash["versao"]:=Versao



   a["versao"]:="1.07"
   a["Id"]  := infVersao


   ::oXml:oRoot:AddBelow( TXMLNode():New( HBXML_TYPE_PI,'xml' , ,;
                                         '"version=1.0"  encoding="UTF-8"' ) )

   oenviNFe := TXMLNode( ) :New( HBXML_TYPE_TAG, "enviNFe",hHash )

   altd()

   oenviNFe:AddBelow( TXMLNode( ) :New( HBXML_TYPE_TAG, "idLote",,idLote ) )

   oNfe := TXMLNode( ) :New( HBXML_TYPE_TAG, "NFe" )

   ::oInfNfe := TXMLNode( ) :New( HBXML_TYPE_TAG, "infNFe" ,a)

   //oNFe:InsertBelow(::oInfNfe )
   //oNfe:oChild :=::oInfNfe
   //oNfe:oParent := oenviNFe

   oNFe:addBelow( ::oInfNfe )

   oenviNFe:addBelow(oNfe )

   oNfe:oParent := oenviNFe

   ::oXml:oRoot:AddBelow(oenviNFe )

return Self


**************************************************************************************
METHOD infNew(id1)
**************************************************************************************
   Local a:=Hash()
   Local oNfe


   a["Id"]  	:= id1
   a["versao"] := "1.07"

   ::oXml:oRoot:AddBelow( TXMLNodeEx():New( HBXML_TYPE_PI,'xml' , , 'version="1.0"  encoding="UTF-8"' ) )


   oNfe := TXMLNodeEx( ) :New( HBXML_TYPE_TAG, "NFe" )


   ::oInfNfe := TXMLNodeEx( ) :New( HBXML_TYPE_TAG, "infNFe" ,a)

   oNFe:AddBelow(::oInfNfe )


   ::oXml:oRoot:AddBelow(oNFe )

return Self

**************************************************************************************
METHOD CreateIDe(cUF   ,cNF    ,natOp  ,indPag ,mod    ,serie  ,nNF    ,dEmi   ,dSaiEnt,tpNF   ,cMunFG ,refNFe ,tpImp  ,tpEmis ,cDV    )
**************************************************************************************

   ::oIde := TXMLNodeEx( ) :New( HBXML_TYPE_TAG, "ide" )

   ::oIde:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG, "cUF",,cUF ) )
   ::oIde:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG, "cNF",,cNF ) )
   ::oIde:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG, "natOP",,natop ) )
   ::oIde:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG, "indPag",,indPag ) )
   ::oIde:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG, "mod",,mod     ) )
   ::oIde:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG, "serie",,serie   ) )
   ::oIde:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG, "nNF",,nNF     ) )
   ::oIde:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG, "dEmi",,dEmi    ) )
   ::oIde:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG, "dSaiEnt",,dSaiEnt ) )
   ::oIde:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG, "tpNF",,tpNF    ) )
   ::oIde:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG, "cMunFG",,cMunFG  ) )
   ::oIde:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG, "refNFe",,refNFe  ) )
   ::oIde:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG, "tpImp",,tpImp   ) )
   ::oIde:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG, "tpEmis",,tpEmis  ) )
   ::oIde:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG, "cDV",,cDV     ) )

   ::oInfNfe:AddBelow(::oIde)


return self

**************************************************************************************
METHOD Createemit(CNPJ   ,xNome  ,xFant  ,  xLgr   ,nro    ,xBairro,cMun   ,xMun   ,UF     ,CEP    ,cPais  ,xPais  ,fone   ,IE ,IEst,IM,CNAE    )
**************************************************************************************

Local oEnderemit := TXMLNodeEx( ):New( HBXML_TYPE_TAG, "enderEmit" )


   ::oemit := TXMLNodeEx( ):New( HBXML_TYPE_TAG, "emit" )

   ::oemit:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG, "CNPJ",,CNPJ    ) )
   ::oemit:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG, "xNome",,xNome   ) )
   ::oemit:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG, "xFant",,xFant   ) )


   oEnderEmit:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG, "xLgr",,xLgr    ) )
   oEnderEmit:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG, "nro",,nro     ) )
   oEnderEmit:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG, "xBairro",,xBairro ) )
   oEnderEmit:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG, "cMun",,cMun    ) )
   oEnderEmit:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG, "xMun",,xMun    ) )
   oEnderEmit:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG, "UF",,UF      ) )
   oEnderEmit:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG, "CEP",,CEP     ) )
   oEnderEmit:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG, "cPais",,cPais   ) )
   oEnderEmit:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG, "xPais",,xPais   ) )
   oEnderEmit:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG, "fone",,fone    ) )
   ::oemit:AddBelow(oenderEmit)
   ::oemit:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG, "IE",,IE      ) )
   ::oemit:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG, "IEST",,IEST      ) )
   if !empty(IM)
      ::oemit:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG, "IM",,IM      ) )
      ::oemit:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG, "CNAE",,CNAE      ) )
   endif
   ::oInfNfe:AddBelow(::oEmit)

return self

**************************************************************************************
METHOD CreateDest(CNPJCPF    ,xNome   ,xLgr    ,nro     ,xBairro ,cMun    ,xMun    ,UF      ,CEP     ,cPais   ,xPais   ,fone    ,IE, ISUF )
**************************************************************************************
   Local oEnderemit := TXMLNodeEx( ):New( HBXML_TYPE_TAG, "enderDest" )
   Local cTemp :=if(valtype(CNPJCPF) =="N",alltrim(str(CNPJCPF,14)),CNPJCPF)
   altd()
   ::oDest := TXMLNodeEx( ):New( HBXML_TYPE_TAG, "dest" )
   if len(Ctemp) <= 11
      cTEmp := CNPJCPF
      if Valtype( cTemp ) == "N"
         cTemp := Strzero( cTemp, 11 )
      elseif Valtype( cTemp ) == "C"
         cTemp := StrTran( cTemp,"/","")
         cTemp := StrTran( cTemp,"-","")
         cTemp := StrTran(cTemp,".","" )
         cTemp := Strzero(Val(cTemp),11)
      endif
      CNPJCPF :=  cTEmp

      ::oDest:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "CPF",,CNPJCPF    ) )
   else
      cTEmp := CNPJCPF
      if Valtype( cTemp ) == "N"
         cTemp := Strzero( cTemp, 14 )
      elseif Valtype( cTemp ) == "C"
         cTemp := StrTran( cTemp,"/","")
         cTemp := StrTran( cTemp,"-","")
         cTemp := StrTran(cTemp,".","" )
         cTemp := Strzero(Val(cTemp),14)
      endif
      CNPJCPF :=  cTEmp

      ::oDest:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "CNPJ",,CNPJCPF    ) )
   endif
   ::oDest:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "xNome",,xNome   ) )
   oEnderEmit:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG, "xLgr",,xLgr    ) )
   oEnderEmit:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG, "nro",,nro     ) )
   oEnderEmit:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG, "xBairro",,xBairro ) )
   oEnderEmit:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG, "cMun",,cMun    ) )
   oEnderEmit:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG, "xMun",,xMun    ) )
   oEnderEmit:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG, "UF",,UF      ) )
   oEnderEmit:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG, "CEP",,CEP     ) )
   oEnderEmit:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG, "cPais",,cPais   ) )
   oEnderEmit:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG, "xPais",,xPais   ) )
   oEnderEmit:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG, "fone",,fone    ) )
   ::oDest:AddBelow(oenderEmit)
   ::oDest:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "IE",,IE      ) )
   ::oDest:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "ISUF",,ISUF      ) )

   ::oInfNfe:AddBelow(::oDest)

return self


**************************************************************************************
METHOD Write(cFile)
**************************************************************************************
   Local n :=fcreate(cFile)

   //oNfe := TXMLNodeEx( ) :New( HBXML_TYPE_TAG, "NFe" )
   //oNFe:AddBelow(::oInfNfe )
   //::oXml:oRoot:InsertBefore(oNfe)
   //::oXml:oRoot:AddBelow( oNfe )

   fwrite(n,@::oXml:ToString( HBXML_STYLE_INDENT + HBXML_STYLE_THREESPACES  ) )

   fclose(n)

return self




**************************************************************************************
METHOD CreateProd( cProd   , cEAN    ,xProd   ,NCM     ,EXTIPI  ,genero  ,CFOP    ,uCom    ,qCom    ,vUnCom  ,vProd   ,cEANTrib,uTrib   ,qTrib   ,vUnTrib ,vFrete  ,vSeg    ,vDesc ,di,adi,aVei,amed,oComb  )
**************************************************************************************

   Local aTemp
   Local oProd := TXMLNodeEx( ):New( HBXML_TYPE_TAG, "prod" )

   //aadd(::aProd , )

   if !empty( cProd   ) ;oProd:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "cProd",,   cProd      ) ); endif
   if !empty( cEAN    ) ;oProd:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "cEAN",,    cEAN       ) ); endif
   if !empty( xProd   ) ;oProd:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "xProd",,   xProd      ) ); endif
   if !empty( NCM     ) ;oProd:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "NCM",,     NCM        ) ); endif
   if !empty( EXTIPI  ) ;oProd:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "EXTIPI",,  EXTIPI     ) ); endif
   if !empty( genero  ) ;oProd:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "genero",,  genero     ) ); endif
   if !empty( CFOP    ) ;oProd:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "CFOP",,    CFOP       ) ); endif
   if !empty( uCom    ) ;oProd:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "uCom",,    uCom       ) ); endif
   if !empty( qCom    ) ;oProd:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "qCom",,    qCom       ) ); endif
   if !empty( vUnCom  ) ;oProd:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "vUnCom",,  vUnCom     ) ); endif
   if !empty( vProd   ) ;oProd:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "vProd",,   vProd      ) ); endif
   if !empty( cEANTrib) ;oProd:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "cEANTrib",,cEANTrib   ) ); endif
   if !empty( uTrib   ) ;oProd:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "uTrib",,   uTrib      ) ); endif
   if !empty( qTrib   ) ;oProd:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "qTrib",,   qTrib      ) ); endif
   if !empty( vUnTrib ) ;oProd:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "vUnTrib",, vUnTrib    ) ); endif
   if !empty( vFrete  ) ;oProd:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "vFrete",,  vFrete     ) ); endif
   if !empty( vSeg    ) ;oProd:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "vSeg",,    vSeg       ) ); endif
   if !empty( vDesc   ) ;oProd:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "vDesc",,   vDesc      ) ); endif

   if valtype(di) == "O"

   oProd:AddBelow(di)
   endif

   if valtype(adi) == "O"

   oProd:AddBelow(adi)

   endif
   if valtype(aVei) =="O"
      oProd:AddBelow(avei)
   endif
   if valtype(aMed) == "O"

      oProd:AddBelow(amed)
   elseif Valtype(aMed) == "A"

      For each aTemp in amed
      if Valtype(aTemp) == "O"
   //   oamed :=TXMLNodeEx( ):New( HBXML_TYPE_TAG, "med" )
      //if !empty(aTemp["nLote" ]        ) ; oamed:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "nLote",,  aTemp["nLote" ]             ) ); endif
      //if !empty(aTemp["qLote" ]        ) ; oamed:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "qLote",,  aTemp["qLote" ]             ) ); endif
      //if !empty(aTemp["dFab" ]        )  ; oamed:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "dFab",,   aTemp["dFab" ]             ) ); endif
      //if !empty(aTemp["dVal" ]        )  ; oamed:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "dVal",,   aTemp["dVal" ]             ) ); endif
      //if !empty(aTemp["vPMC" ]        )  ; oamed:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "vPMC",,   aTemp["vPMC" ]             ) ); endif
      oProd:AddBelow(aTemp)
   endif

   next

   if valtype(oComb ) =="O"
      oProd:AddBelow(oComb)
   endif
   endif

   //::oInfNfe:AddBelow()

return oProd


**************************************************************************************
METHOD CreateDi( nDI, dDi, xLocDesemb, UFDesemb, dDesemb, cExportador )
**************************************************************************************

   Local oDi :=TXMLNodeEx( ):New( HBXML_TYPE_TAG, "DI" )

   if !empty(nDI           ) ; odi:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "nDI",,   nDI             ) ); endif
   if !empty(dDi           ) ; odi:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "dDi",,   dDi              ) ); endif
   if !empty(xLocDesemb    ) ; odi:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "xLocDesemb",,   xLocDesemb      ) ); endif
   if !empty(UFDesemb      ) ; odi:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "UFDesemb",,   UFDesemb         ) ); endif
   if !empty(dDesemb       ) ; odi:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "dDesemb",,   dDesemb          ) ); endif
   if !empty(cExportador   ) ; odi:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "cExportador",,   cExportador      ) ); endif

return odi


**************************************************************************************
METHOD CreateADi(nAdicao, nSeqAdic, cFabricante, vDescDI)
**************************************************************************************

   Local oAdi :=TXMLNodeEx( ):New( HBXML_TYPE_TAG, "adi" )

   if !empty( nAdicao     ) ; oAdi:addBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "nAdicao",,   nAdicao          ) ); endif
   if !empty( nSeqAdic    ) ; oAdi:addBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "nSeqAdic",,   nSeqAdic         ) ); endif
   if !empty( cFabricante ) ; oAdi:addBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "cFabricante",,cFabricante      ) ); endif
   if !empty( vDescDI     ) ; oAdi:addBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "vDescDI",,   vDescDI          ) ); endif

return oadi



**************************************************************************************
METHOD CreateVeiculo(tpOp    ,chassi  ,cCor    ,xCor    ,pot     ,CM3     ,pesoL   ,pesoB   ,nSerie  ,tpComb  ,nMotor  ,CMKG    ,dist    ,RENAVAM ,anoMod  ,anoFab  ,tpPint  ,tpVeic  ,espVeic ,VIN     ,condVeic,cMod    )
**************************************************************************************

Local oAvei := TXMLNodeEx( ):New( HBXML_TYPE_TAG, "veicProd" )

   if !empty( tpOp     ) ; oaVei:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "tpOp",,     tpOp      ) ); endif
   if !empty( chassi   ) ; oaVei:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "chassi",,   chassi    ) ); endif
   if !empty( cCor     ) ; oaVei:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "cCor",,     cCor      ) ); endif
   if !empty( xCor     ) ; oaVei:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "xCor",,     xCor      ) ); endif
   if !empty( pot      ) ; oaVei:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "pot",,      pot       ) ); endif
   if !empty( CM3      ) ; oaVei:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "CM3",,      CM3       ) ); endif
   if !empty( pesoL    ) ; oaVei:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "pesoL",,    pesoL     ) ); endif
   if !empty( pesoB    ) ; oaVei:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "pesoB",,    pesoB     ) ); endif
   if !empty( nSerie   ) ; oaVei:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "nSerie",,   nSerie    ) ); endif
   if !empty( tpComb   ) ; oaVei:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "tpComb",,   tpComb    ) ); endif
   if !empty( nMotor   ) ; oaVei:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "nMotor",,   nMotor    ) ); endif
   if !empty( CMKG     ) ; oaVei:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "CMKG",,     CMKG      ) ); endif
   if !empty( dist     ) ; oaVei:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "dist",,     dist      ) ); endif
   if !empty( RENAVAM  ) ; oaVei:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "RENAVAM",,  RENAVAM   ) ); endif
   if !empty( anoMod   ) ; oaVei:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "anoMod",,   anoMod    ) ); endif
   if !empty( anoFab   ) ; oaVei:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "anoFab",,   anoFab    ) ); endif
   if !empty( tpPint   ) ; oaVei:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "tpPint",,   tpPint    ) ); endif
   if !empty( tpVeic   ) ; oaVei:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "tpVeic",,   tpVeic    ) ); endif
   if !empty( espVeic  ) ; oaVei:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "espVeic",,  espVeic   ) ); endif
   if !empty( VIN      ) ; oaVei:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "VIN",,      VIN       ) ); endif
   if !empty( condVeic ) ; oaVei:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "condVeic",, condVeic  ) ); endif
   if !empty( cMod     ) ; oaVei:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "cMod",,     cMod      ) ); endif

return oaVei



**************************************************************************************
METHOD CreateMed(nLote,qLote,dFab,dVal,vPMC)
**************************************************************************************

Local oamed :=TXMLNodeEx( ):New( HBXML_TYPE_TAG, "med" )

   if !empty(nLote ) ; oamed:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "nLote",,  nLote ) ); endif
   if !empty(qLote ) ; oamed:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "qLote",,  qLote ) ); endif
   if !empty(dFab  ) ; oamed:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "dFab",,   dFab  ) ); endif
   if !empty(dVal  ) ; oamed:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "dVal",,   dVal  ) ); endif
   if !empty(vPMC  ) ; oamed:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "vPMC",,   vPMC  ) ); endif


return oamed


**************************************************************************************
METHOD CreateComb(cProdANP,CODif   ,qTemp ,oCide,  oICMSComb,oICMSInter,oICMSCons )
**************************************************************************************
Local oComb :=TXMLNodeEx( ):New( HBXML_TYPE_TAG, "comb" )

   if !empty(cProdANP) ; oComb:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "cProdANP",,  cProdANP             ) ); endif
   if !empty(CODif   ) ; oComb:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "CODif",,     CODif                ) ); endif
   if !empty(qTemp   ) ; oComb:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "qTemp",,     qTemp                ) ); endif

   if valtype( oCide ) == "O"
      oComb:AddBelow( oCide )
   endif
   if valtype( oICMSComb ) == "O"
      oComb:AddBelow( oICMSComb )
   endif
   if valtype( oICMSInter ) == "O"
      oComb:AddBelow( oICMSInter )
   endif

   if valtype( oICMSCons ) == "O"
      oComb:AddBelow( oICMSCons )
   endif

return oComb


**************************************************************************************
METHOD CreateCide( qBCprod  ,vAliqProd, vCIDE    )
**************************************************************************************
Local oCide :=TXMLNodeEx( ):New( HBXML_TYPE_TAG, "CIDE" )

   if !empty(qBCprod  ) ; oCide:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "qBCprod",,     qBCprod                  ) );endif
   if !empty(vAliqProd) ; oCide:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "vAliqProd",,   vAliqProd                ) );endif
   if !empty(vCIDE    ) ; oCide:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "vCIDE",,       vCIDE                    ) );endif

return oCide



**************************************************************************************
METHOD CreateICMSCOMB( vBCICMS  ,vICMS    ,vBCICMSST, vICMSST  )
**************************************************************************************

   Local oICMSComb :=TXMLNodeEx( ):New( HBXML_TYPE_TAG, "ICMSComb" )
   if !empty(vBCICMS  );oICMSComb:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "vBCICMS"   ,, vBCICMS  )) ;endif
   if !empty(vICMS    );oICMSComb:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "vICMS"     ,, vICMS     ));endif
   if !empty(vBCICMSST);oICMSComb:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "vBCICMSST" ,, vBCICMSST ));endif
   if !empty(vICMSST  );oICMSComb:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,    "vICMSST"   ,, vICMSST   ));endif

return oICMSComb


**************************************************************************************
METHOD CreateICMSInter( vBCICMSSTDest, vICMSSTDest  )
**************************************************************************************

   Local oICMSInter :=TXMLNodeEx( ):New( HBXML_TYPE_TAG, "ICMSInter" )
   if !empty(vBCICMSSTDest) ;oICMSInter:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vBCICMSSTDest" ,,vBCICMSSTDest ));endif
   if !empty(vICMSSTDest  ) ;oICMSInter:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vICMSSTDest"   ,,vICMSSTDest   ));endif

return oICMSInter

**************************************************************************************
METHOD CreateICMSCons(vBCICMSSTCons ,vICMSSTCons   ,UFcons )
**************************************************************************************

  Local oICMSCons :=TXMLNodeEx( ):New( HBXML_TYPE_TAG, "ICMSCons" )

  if !empty(vBCICMSSTCons) ; oICMSCons:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vBCICMSSTCons" ,,vBCICMSSTCons ));endif
  if !empty(vICMSSTCons  ) ; oICMSCons:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vICMSSTCons"   ,,vICMSSTCons   ));endif
  if !empty(UFcons       ) ; oICMSCons:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "UFcons"        ,,UFcons        ));endif

return oICMSCons





**************************************************************************************
METHOD CreateICMS( oICMS00, oICMS10,oICMS20,oICMS30,oICMS40,oICMS51,oICMS60,oICMS70,oICMS90)
**************************************************************************************

   Local oICMS :=TXMLNodeEx( ):New( HBXML_TYPE_TAG, "ICMS" )

   if valtype( oICMS00 ) == "O" ; oICMS:AddBelow( oICMS00) ; endif
   if valtype( oICMS10 ) == "O" ; oICMS:AddBelow( oICMS10) ; endif
   if valtype( oICMS20 ) == "O" ; oICMS:AddBelow( oICMS20) ; endif
   if valtype( oICMS30 ) == "O" ; oICMS:AddBelow( oICMS30) ; endif
   if valtype( oICMS40 ) == "O" ; oICMS:AddBelow( oICMS40) ; endif
   if valtype( oICMS51 ) == "O" ; oICMS:AddBelow( oICMS51) ; endif
   if valtype( oICMS60 ) == "O" ; oICMS:AddBelow( oICMS60) ; endif
   if valtype( oICMS70 ) == "O" ; oICMS:AddBelow( oICMS70) ; endif
   if valtype( oICMS90 ) == "O" ; oICMS:AddBelow( oICMS90) ; endif

return oICMS


**************************************************************************************
METHOD CreateICMS00( orig,CST,modBC,vBC,pICMS,vICMS )
**************************************************************************************

   Local oICMS00 :=TXMLNodeEx( ):New( HBXML_TYPE_TAG, "ICMS00" )

   if !empty(orig ) ;oICMS00:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "orig"  ,,orig  ));endif
   if !empty(CST  ) ;oICMS00:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "CST"   ,,CST   ));endif
   if !empty(modBC) ;oICMS00:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "modBC" ,,modBC ));endif
   if !empty(vBC  ) ;oICMS00:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vBC"   ,,vBC   ));endif
   if !empty(pICMS) ;oICMS00:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "pICMS" ,,pICMS ));endif
   if !empty(vICMS );oICMS00:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vICMS" ,,vICMS ));endif

return oICMS00

**************************************************************************************
METHOD CreateICMS10( orig,CST,modBC,vBC,pICMS,vICMS,modBCST,pMVAST ,pRedBCST,vBCST,pICMSST,vICMSST )
**************************************************************************************

	Local oICMS10 :=TXMLNodeEx( ):New( HBXML_TYPE_TAG, "ICMS10" )

   if !empty(orig ) ;oICMS10:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "orig"  ,,orig  ));endif
   if !empty(CST  ) ;oICMS10:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "CST"   ,,CST   ));endif
   if !empty(modBC) ;oICMS10:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "modBC" ,,modBC ));endif
   if !empty(vBC  ) ;oICMS10:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vBC"   ,,vBC   ));endif
   if !empty(pICMS) ;oICMS10:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "pICMS" ,,pICMS ));endif
   if !empty(vICMS );oICMS10:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vICMS" ,,vICMS ));endif
   if !empty(modBCST ) ;oICMS10:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "modBCST " ,,modBCST  ));endif
   if !empty(pMVAST  ) ;oICMS10:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "pMVAST"   ,,pMVAST   ));endif
   if !empty(pRedBCST) ;oICMS10:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "pRedBCST" ,,pRedBCST ));endif
   if !empty(vBCST   ) ;oICMS10:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vBCST"    ,,vBCST    ));endif
   if !empty(pICMSST ) ;oICMS10:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "pICMSST"  ,,pICMSST  ));endif
   if !empty(vICMSST  );oICMS10:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vICMSST"  ,,vICMSST  ));endif

return oICMS10


**************************************************************************************
METHOD CreateICMS20( orig,CST,modBC,pRedBC,vBC,pICMS,vICMS )
**************************************************************************************
   Local oICMS20 :=TXMLNodeEx( ):New( HBXML_TYPE_TAG, "ICMS20" )

   if !empty(orig ) ;oICMS20:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "orig"   ,,orig  ));endif
   if !empty(CST  ) ;oICMS20:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "CST"    ,,CST   ));endif
   if !empty(modBC) ;oICMS20:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "modBC"  ,,modBC ));endif
   if !empty(pRedBC);oICMS20:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "pRedBC" ,,pRedBC   ));endif
   if !empty(vBC  ) ;oICMS20:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vBC"    ,,vBC   ));endif
   if !empty(pICMS) ;oICMS20:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "pICMS"  ,,pICMS ));endif
   if !empty(vICMS );oICMS20:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vICMS"  ,,vICMS ));endif

return oICMS20


**************************************************************************************
METHOD CreateICMS30( orig,CST,modBCST,pMVAST,pRedBCST,vBCST,pICMSST,vICMSST)
**************************************************************************************

   Local oICMS30 :=TXMLNodeEx( ):New( HBXML_TYPE_TAG, "ICMS30" )

   if !empty( orig )     ;oICMS30:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "orig"     ,, orig  ));endif
   if !empty( CST )      ;oICMS30:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "CST"      ,, CST   ));endif
   if !empty( modBCST )  ;oICMS30:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "modBCST"  ,, modBCST ));endif
   if !empty( pMVAST )   ;oICMS30:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "pMVAST"   ,, pMVAST  ));endif
   if !empty( pRedBCST ) ;oICMS30:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "pRedBCST" ,, pRedBCST));endif
   if !empty( vBCST )    ;oICMS30:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vBCST"    ,, vBCST   ));endif
   if !empty( pICMSST )  ;oICMS30:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "pICMSST"  ,, pICMSST    ));endif
   if !empty( vICMSST )  ;oICMS30:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vICMSST"  ,, vICMSST ));endif

return oICMS30

**************************************************************************************
METHOD CreateICMS40( orig,CST )
**************************************************************************************

   Local oICMS40 :=TXMLNodeEx( ):New( HBXML_TYPE_TAG, "ICMS40" )
   if !empty( orig )     ;oICMS40:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "orig"     ,, orig  ));endif
   if !empty( CST )      ;oICMS40:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "CST"      ,, CST   ));endif

return  oICMS40

**************************************************************************************
METHOD CreateICMS51( orig,CST,modBC,pRedBC,vBC,pICMS,vICMS )
**************************************************************************************
   Local oICMS51 :=TXMLNodeEx( ):New( HBXML_TYPE_TAG, "ICMS51" )

   if !empty(orig ) ;oICMS51:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "orig"   ,,orig  ));endif
   if !empty(CST  ) ;oICMS51:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "CST"    ,,CST   ));endif
   if !empty(modBC) ;oICMS51:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "modBC"  ,,modBC ));endif
   if !empty(pRedBC);oICMS51:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "pRedBC" ,,pRedBC   ));endif
   if !empty(vBC  ) ;oICMS51:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vBC"    ,,vBC   ));endif
   if !empty(pICMS) ;oICMS51:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "pICMS"  ,,pICMS ));endif
   if !empty(vICMS );oICMS51:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vICMS"  ,,vICMS ));endif

return oICMS51

**************************************************************************************
METHOD CreateICMS60( orig,CST,vBCST,vICMSST )
**************************************************************************************
Local oICMS60 :=TXMLNodeEx( ):New( HBXML_TYPE_TAG, "ICMS60" )

   if !empty(orig ) ;oICMS60:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "orig"   ,,orig  ));endif
   if !empty(CST  ) ;oICMS60:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "CST"    ,,CST   ));endif
   if !empty(vBCST  ) ;oICMS60:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vBCST"    ,,vBCST   ));endif
   if !empty(vICMSST );oICMS60:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vICMSST"  ,,vICMSST ));endif

return oICMS60

**************************************************************************************
METHOD CreateICMS70( orig,CST,modBC,pRedBC,vBC,pICMS,vICMS ,modBCST,pMVAST,pRedBCST,vBCST,pICMSST,vICMSST )
**************************************************************************************
Local oICMS70 :=TXMLNodeEx( ):New( HBXML_TYPE_TAG, "ICMS70" )

   if !empty(orig ) ;oICMS70:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "orig"   ,,orig  ));endif
   if !empty(CST  ) ;oICMS70:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "CST"    ,,CST   ));endif
   if !empty(modBC) ;oICMS70:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "modBC"  ,,modBC ));endif
   if !empty(pRedBC);oICMS70:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "pRedBC" ,,pRedBC   ));endif
   if !empty(vBC  ) ;oICMS70:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vBC"    ,,vBC   ));endif
   if !empty(pICMS) ;oICMS70:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "pICMS"  ,,pICMS ));endif
   if !empty(vICMS );oICMS70:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vICMS"  ,,vICMS ));endif

   if !empty(modBCST ) ;oICMS70:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "modBCST"   ,,modBCST ));endif
   if !empty(pMVAST  ) ;oICMS70:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "pMVAST"    ,,pMVAST  ));endif
   if !empty(pRedBCST) ;oICMS70:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "pRedBCST"  ,,pRedBCST));endif
   if !empty(vBCST   ) ;oICMS70:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vBCST"     ,,vBCST      ));endif
   if !empty(pICMSST ) ;oICMS70:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "pICMSST"   ,,pICMSST ));endif
   if !empty(vICMSST ) ;oICMS70:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vICMSST"   ,,vICMSST ));endif

return oICMS70

**************************************************************************************
METHOD CreateICMS90( orig ,CST ,modBC ,pRedBC ,vBC      ,pICMS    ,vICMS    ,modBCST  ,pMVAST   ,pRedBCST ,vBCST    ,pICMSST ,vICMSST  )
**************************************************************************************

   Local oICMS90 :=TXMLNodeEx( ):New( HBXML_TYPE_TAG, "ICMS90" )
   if !empty(pRedBCST) ;oICMS90:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "orig"  ,,orig    ));endif
   if !empty(pRedBCST) ;oICMS90:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "CST"  ,,CST     ));endif
   if !empty(pRedBCST) ;oICMS90:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "modBC"  ,,modBC   ));endif
   if !empty(pRedBCST) ;oICMS90:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "pRedBC"  ,,pRedBC  ));endif
   if !empty(pRedBCST) ;oICMS90:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vBC"  ,,vBC     ));endif
   if !empty(pRedBCST) ;oICMS90:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "pICMS"  ,,pICMS   ));endif
   if !empty(pRedBCST) ;oICMS90:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vICMS"  ,,vICMS   ));endif
   if !empty(pRedBCST) ;oICMS90:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "modBCST"  ,,modBCST ));endif
   if !empty(pRedBCST) ;oICMS90:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "pMVAST"  ,,pMVAST  ));endif
   if !empty(pRedBCST) ;oICMS90:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "pRedBCST"  ,,pRedBCST));endif
   if !empty(pRedBCST) ;oICMS90:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vBCST"  ,,vBCST   ));endif
   if !empty(pRedBCST) ;oICMS90:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "pICMSST"  ,,pICMSST ));endif
   if !empty(pRedBCST) ;oICMS90:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vICMSST"  ,,vICMSST ));endif
return oICMS90


**************************************************************************************
METHOD CreateIPI( clEnq   ,CNPJProd,cSelo   ,qSelo   ,cEnq    ,vIPI ,oIPINT    )
**************************************************************************************

   Local oIPI :=TXMLNodeEx( ):New( HBXML_TYPE_TAG, "IPI" )
   if !empty(clEnq   ) ;oIPI:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "clEnq"    ,,clEnq       ));endif
   if !empty(CNPJProd) ;oIPI:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "CNPJProd" ,,CNPJProd    ));endif
   if !empty(cSelo   ) ;oIPI:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "cSelo"    ,,cSelo       ));endif
   if !empty(qSelo   ) ;oIPI:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "qSelo"    ,,qSelo       ));endif
   if !empty(cEnq    ) ;oIPI:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "cEnq"     ,,cEnq        ));endif
   if !empty(vIPI    ) ;oIPI:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vIPI"     ,,vIPI        ));endif

   if valtype( oIPINT ) == "O"
      oIPI:AddBelow( oIPINT )
   endif

return oIpi


**************************************************************************************
METHOD CreateIPINT( CST )
**************************************************************************************

	Local oIPINT :=TXMLNodeEx( ):New( HBXML_TYPE_TAG, "IPINT" )

	if !empty( CST   ) ;oIPINT:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "CST"    ,,CST       ));endif

return oIPINT

**************************************************************************************
METHOD CreateII(vBC )
**************************************************************************************

   Local oII :=TXMLNodeEx( ):New( HBXML_TYPE_TAG, "II" )
   if !empty(vBC   ) ;oII:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vBC"    ,,vBC       ));endif

return oII


**************************************************************************************
METHOD CreatePis(oPISAliq,oPISQtde,oPISNT,oPISOutr,oPISST)
**************************************************************************************

   Local oPIS :=TXMLNodeEx( ):New( HBXML_TYPE_TAG, "PIS" )

   if valtype(oPisAliq) == "O" ; oPIs:AddBelow(oPisAliq) ; endif
   if valtype(oPisQtde) == "O" ; oPIs:AddBelow(oPisQtde) ; endif
   if valtype(oPisNT  ) == "O" ; oPIs:AddBelow(oPisNT  ) ; endif
   if valtype(oPisOutr) == "O" ; oPIs:AddBelow(oPisOutr) ; endif
   if valtype(oPisST  ) == "O" ; oPIs:AddBelow(oPisST  ) ; endif

return oPis

**************************************************************************************
METHOD CreatePISAliq(CST,vBC,pPIS,vPIS)
**************************************************************************************

   Local oPISAliq :=TXMLNodeEx( ):New( HBXML_TYPE_TAG, "PISAliq" )

   if !empty( CST  ) ;oPISAliq:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "CST"     ,,CST        ));endif
   if !empty( vBC  ) ;oPISAliq:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vBC"     ,,vBC        ));endif
   if !empty( pPIS ) ;oPISAliq:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "pPIS"    ,,pPIS       ));endif
   if !empty( vPIS ) ;oPISAliq:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vPIS"    ,,vPIS       ));endif

return oPISAliq


**************************************************************************************
METHOD CreatePISQtde(CST,qBCProd,vAliqProd,vPIS)
**************************************************************************************

   Local oPISQtde :=TXMLNodeEx( ):New( HBXML_TYPE_TAG, "PISQtde" )
   if !empty( CST  ) ;oPISQtde:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "CST"     ,,CST        ));endif
   if !empty( qBCProd    ) ;oPISQtde:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "qBCProd"     ,,qBCProd          ));endif
   if !empty( vAliqProd  ) ;oPISQtde:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vAliqProd"     ,,vAliqProd        ));endif
   if !empty( vPIS       ) ;oPISQtde:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vPIS"     ,,vPIS             ));endif

return oPISQtde

**************************************************************************************
METHOD CreatePISNT( CST )
**************************************************************************************
   Local oPISNT :=TXMLNodeEx( ):New( HBXML_TYPE_TAG, "PISNT" )

   if !empty( CST  ) ;oPISNT:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "CST"     ,,CST        ));endif

return oPISNT

**************************************************************************************
METHOD CreatePISOutr(CST,vBC,pPIS,qBCProd,vAliqProd,vPIS)
**************************************************************************************

   Local oPISOutr :=TXMLNodeEx( ):New( HBXML_TYPE_TAG, "PISOutr" )
   if !empty( CST      ) ;oPISOutr:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "CST"       ,,CST        ));endif
   if !empty( vBC      ) ;oPISOutr:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vBC"       ,,vBC        ));endif
   if !empty( pPIS     ) ;oPISOutr:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "pPIS"      ,,pPIS       ));endif
   if !empty( qBCProd  ) ;oPISOutr:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "qBCProd"   ,,qBCProd    ));endif
   if !empty( vAliqProd) ;oPISOutr:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vAliqProd" ,,vAliqProd  ));endif
   if !empty( vPIS     ) ;oPISOutr:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vPIS"      ,,vPIS       ));endif
return oPISOutr




**************************************************************************************
METHOD CreatePISST(vBC      ,pPIS     ,qBCProd  ,vAliqProd,vPIS     )
**************************************************************************************

   Local oPISST :=TXMLNodeEx( ):New( HBXML_TYPE_TAG, "PISST" )
   if !empty( vBC       ) ;oPISST:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vBC"       ,,vBC              ));endif
   if !empty( pPIS      ) ;oPISST:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "pPIS"      ,,pPIS             ));endif
   if !empty( qBCProd   ) ;oPISST:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "qBCProd"   ,,qBCProd          ));endif
   if !empty( vAliqProd ) ;oPISST:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vAliqProd" ,,vAliqProd        ));endif
   if !empty( vPIS      ) ;oPISST:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vPIS"      ,,vPIS             ));endif

return  oPISST


**************************************************************************************
METHOD CreateConfins(oCOFINSAliq, oCOFINSQtde,oCOFINSNT,oCOFINSOutr,oCOFINSST )
**************************************************************************************
   Local oCOFINS :=TXMLNodeEx( ):New( HBXML_TYPE_TAG, "COFINS" )

   if Valtype(oCofinsAliq) =="O" ; oCOFINS:AddBelow( oCofinsAliq ); endif
   if Valtype(oCofinsQtde) =="O" ; oCOFINS:AddBelow( oCofinsQtde ); endif
   if Valtype(oCofinsNT  ) =="O" ; oCOFINS:AddBelow( oCofinsNT   ); endif
   if Valtype(oCofinsOutr) =="O" ; oCOFINS:AddBelow( oCofinsOutr ); endif
   if Valtype(oCofinsST  ) =="O" ; oCOFINS:AddBelow( oCofinsST   ); endif

return oCOFINS


**************************************************************************************
METHOD CreateCOFINSAliq( CST     ,vBC     ,pCOFINS ,vCOFINS  )
**************************************************************************************

   Local oCOFINSAliq :=TXMLNodeEx( ):New( HBXML_TYPE_TAG, "COFINSAliq" )
   if !empty( CST     ) ;oCOFINSAliq:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "CST"       ,, CST     ));endif
   if !empty( vBC     ) ;oCOFINSAliq:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vBC"       ,, vBC     ));endif
   if !empty( pCOFINS ) ;oCOFINSAliq:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "pCOFINS"       ,, pCOFINS ));endif
   if !empty( vCOFINS ) ;oCOFINSAliq:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vCOFINS"       ,, vCOFINS ));endif

return  oCOFINSAliq


**************************************************************************************
METHOD CreateCOFINSQtde( CST,qBCProd,vAliqProd,vCOFINS)
**************************************************************************************
   Local oCOFINSQtde :=TXMLNodeEx( ):New( HBXML_TYPE_TAG, "COFINSQtde" )

   if !empty( CST       ) ;oCOFINSQtde:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "CST"       ,, CST       ));endif
   if !empty( qBCProd   ) ;oCOFINSQtde:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "qBCProd"       ,, qBCProd   ));endif
   if !empty( vAliqProd ) ;oCOFINSQtde:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vAliqProd"       ,, vAliqProd ));endif
   if !empty( vCOFINS   ) ;oCOFINSQtde:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vCOFINS"       ,, vCOFINS   ));endif

return oCOFINSQtde



//NT
**************************************************************************************
METHOD CreateCOFINSNT( CST,qBCProd,vAliqProd,vCOFINS)
**************************************************************************************
  Local oCOFINSNT :=TXMLNodeEx( ):New( HBXML_TYPE_TAG, "COFINSNT" )
  if !empty( CST       ) ;oCOFINSNT:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "CST"       ,, CST       ));endif
return  oCOFINSNT


**************************************************************************************
METHOD CreateCOFINSOutr( CST,vBC,pCOFINS,qBCProd,vAliqProd,vCOFINS)
**************************************************************************************
   Local oCOFINSOutr :=TXMLNodeEx( ):New( HBXML_TYPE_TAG, "COFINSOutr" )


   if !empty( CST       ) ;oCOFINSOutr:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "CST"       ,, CST       ));endif
   if !empty( vBC       ) ;oCOFINSOutr:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vBC"       ,, vBC       ));endif
   if !empty( pCOFINS   ) ;oCOFINSOutr:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "pCOFINS"   ,, pCOFINS   ));endif
   if !empty( qBCProd   ) ;oCOFINSOutr:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "qBCProd"   ,, qBCProd   ));endif
   if !empty( vAliqProd ) ;oCOFINSOutr:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vAliqProd" ,, vAliqProd ));endif
   if !empty( vCOFINS   ) ;oCOFINSOutr:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vCOFINS"   ,, vCOFINS   ));endif

return oCOFINSOutr


//COFINSST

**************************************************************************************
METHOD CreateCOFINSST( vBC,pCOFINS,qBCProd,vAliqProd,vCOFINS)
**************************************************************************************
   Local oCOFINSST :=TXMLNodeEx( ):New( HBXML_TYPE_TAG, "COFINSST" )

   if !empty( vBC       ) ;oCOFINSST:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vBC"   ,, vBC       ));endif
   if !empty( pCOFINS   ) ;oCOFINSST:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "pCOFINS"   ,, pCOFINS   ));endif
   if !empty( qBCProd   ) ;oCOFINSST:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "qBCProd"   ,, qBCProd   ));endif
   if !empty( vAliqProd ) ;oCOFINSST:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vAliqProd"   ,, vAliqProd ));endif
   if !empty( vCOFINS   ) ;oCOFINSST:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vCOFINS"   ,, vCOFINS   ));endif

return oCOFINSST


**************************************************************************************
METHOD CreateISSQN(vBC,vAliq,vISSQN,cMunFG,cListServ)
**************************************************************************************

   Local oISSQN :=TXMLNodeEx( ):New( HBXML_TYPE_TAG, "ISSQN" )

   if !empty( vBC       ) ;oISSQN:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vBC"       ,, vBC       ));endif
   if !empty( vAliq     ) ;oISSQN:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vAliq"     ,, vAliq     ));endif
   if !empty( vISSQN    ) ;oISSQN:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vISSQN"    ,, vISSQN    ));endif
   if !empty( cMunFG    ) ;oISSQN:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "cMunFG"    ,, cMunFG    ));endif
   if !empty( cListServ ) ;oISSQN:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "cListServ" ,, cListServ ));endif

return  oISSQN

**************************************************************************************
METHOD CreateImposto(oICMS,oIPI,oPIS, oCOFINS,oISSQN)
**************************************************************************************
   Local oImposto :=TXMLNodeEx( ):New( HBXML_TYPE_TAG, "imposto" )

   if Valtype( oICMS  ) == "O" ; oImposto:AddBelow( oICMS   ) ; endif
   if Valtype( oIPI   ) == "O" ; oImposto:AddBelow( oIPI    ) ; endif
   if Valtype( oPIS   ) == "O" ; oImposto:AddBelow( oPIS    ) ; endif
   if Valtype( oCOFINS) == "O" ; oImposto:AddBelow( oCOFINS ) ; endif
   if Valtype( oISSQN ) == "O" ; oImposto:AddBelow( oISSQN  ) ; endif

return  oImposto


**************************************************************************************
METHOD CreateDet(nItem,oProd,oImposto,infAdProd)
**************************************************************************************
Local hHash := hash()
Local oDet

   hHash["nItem"] := nItem

   odet :=TXMLNodeEx( ):New( HBXML_TYPE_TAG, "det", hHash )

   if Valtype( oProd  ) == "O" ;     oDet:AddBelow( oProd   ) ; endif
   if Valtype( oImposto  ) == "O" ;  oDet:AddBelow( oImposto   ) ; endif
   if Valtype( infAdProd  ) == "O" ; oDet:AddBelow( infAdProd   ) ; endif

   ::oInfNfe:AddBelow(oDet)

return Self


**************************************************************************************
METHOD  CreateICMSTot( vBC, vICMS, vBCST, vST, vProd, vFrete, vSeg, vDesc, vII, vIPI, vPIS, vCOFINS, vOutro, vNF )
**************************************************************************************
   Local oICMSTot :=TXMLNodeEx( ):New( HBXML_TYPE_TAG, "ICMSTot" )

   if !empty( vBC     ) ;oICMSTot:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vBC"      ,, vBC     ));endif
   if !empty( vICMS   ) ;oICMSTot:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vICMS"    ,, vICMS   ));endif
   if !empty( vBCST   ) ;oICMSTot:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vBCST"    ,, vBCST   ));endif
   if !empty( vST     ) ;oICMSTot:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vST"      ,, vST     ));endif
   if !empty( vProd   ) ;oICMSTot:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vProd"    ,, vProd   ));endif
   if !empty( vFrete  ) ;oICMSTot:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vFrete"   ,, vFrete  ));endif
   if !empty( vSeg    ) ;oICMSTot:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vSeg"     ,, vSeg    ));endif
   if !empty( vDesc   ) ;oICMSTot:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vDesc"    ,, vDesc   ));endif
   if !empty( vII     ) ;oICMSTot:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vII"      ,, vII     ));endif
   if !empty( vIPI    ) ;oICMSTot:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vIPI"     ,, vIPI    ));endif
   if !empty( vPIS    ) ;oICMSTot:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vPIS "    ,, vPIS    ));endif
   if !empty( vCOFINS ) ;oICMSTot:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vCOFINS"  ,, vCOFINS ));endif
   if !empty( vOutro  ) ;oICMSTot:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vOutro  " ,, vOutro  ));endif
   if !empty( vNF     ) ;oICMSTot:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vNF"      ,, vNF     ));endif

return oICMSTot

**************************************************************************************
METHOD CreateISSQNtot(vServ, vBC, vISS, vPIS, vCOFINS )
**************************************************************************************

   Local oISSQNtot :=TXMLNodeEx( ):New( HBXML_TYPE_TAG, "ISSQNtot" )

   if !empty( vServ    ) ;oISSQNtot:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vServ"   ,, vServ    ));endif
   if !empty( vBC      ) ;oISSQNtot:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vBC"     ,, vBC      ));endif
   if !empty( vISS     ) ;oISSQNtot:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vISS"    ,, vISS     ));endif
   if !empty( vPIS     ) ;oISSQNtot:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vPIS"    ,, vPIS     ));endif
   if !empty( vCOFINS  ) ;oISSQNtot:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vCOFINS" ,, vCOFINS  ));endif


return oISSQNtot


**************************************************************************************
METHOD CreateretTrib(vRetPIS   ,vRetCOFINS,vRetCSLL  ,vBCIRRF,vIRRF,vBCRetPrev,vRetPrev)
**************************************************************************************
   Local oretTrib :=TXMLNodeEx( ):New( HBXML_TYPE_TAG, "retTrib" )

   if !empty( vRetPIS    ) ;oretTrib:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vRetPIS "   ,, vRetPIS    ));endif
   if !empty( vRetCOFINS ) ;oretTrib:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vRetCOFINS" ,, vRetCOFINS ));endif
   if !empty( vRetCSLL   ) ;oretTrib:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vRetCSLL"   ,, vRetCSLL   ));endif
   if !empty( vBCIRRF    ) ;oretTrib:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vBCIRRF"    ,, vBCIRRF    ));endif
   if !empty( vIRRF      ) ;oretTrib:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vIRRF"      ,, vIRRF      ));endif
   if !empty( vBCRetPrev ) ;oretTrib:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vBCRetPrev" ,, vBCRetPrev ));endif
   if !empty( vRetPrev   ) ;oretTrib:AddBelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vRetPrev"   ,, vRetPrev   ));endif

return oretTrib

**************************************************************************************
METHOD CreateTotal( oICMSTot, oISSQNtot, oretTrib )
**************************************************************************************

   Local ototal :=TXMLNodeEx( ):New( HBXML_TYPE_TAG, "total" )
   if valtype( oICMSTot  ) == "O" ; ototal:addbelow( oICMSTot  ) ; endif
   if valtype( oISSQNtot ) == "O" ; ototal:addbelow( oISSQNtot ) ; endif
   if valtype( oretTrib  ) == "O" ; ototal:addbelow( oretTrib  ) ; endif


   ::oInfNfe:AddBelow(oTotal)
return self


**************************************************************************************
METHOD Createtransp(modFrete,otransporta,oretTransp,oveicTransp,oreboque,ovol,olacres)
**************************************************************************************
   Local otransp :=TXMLNodeEx( ):New( HBXML_TYPE_TAG, "transp" )

   if !empty( modFrete )  ; otransp:addbelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "modFrete" ,, modFrete ) ) ; endif
   if valtype(otransporta) == "O" ; otransp:AddBelow(otransporta) ; endif
   if valtype(oretTransp) == "O" ; otransp:AddBelow(oretTransp) ; endif
   if valtype(oveicTransp) == "O" ; otransp:AddBelow(oveicTransp) ; endif
   if valtype(oreboque) == "O" ; otransp:AddBelow(oreboque) ; endif
   if valtype(ovol) == "O" ; otransp:AddBelow(ovol) ; endif
   if valtype(olacres) == "O" ; otransp:AddBelow(olacres) ; endif

   ::oInfNfe:AddBelow(otransp)


return Self


**************************************************************************************
METHOD Createtransporta(CNPJ      ,CPF       ,xNome ,IE    ,xEnder,xMun  ,UF    )
**************************************************************************************
   Local otransp :=TXMLNodeEx( ):New( HBXML_TYPE_TAG, "transporta" )


   if !empty( CNPJ   ) ; otransp:addbelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "CNPJ"    ,, CNPJ   )) ; endif
   if !empty( CPF    ) ; otransp:addbelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "CPF"     ,, CPF    )) ; endif
   if !empty( xNome  ) ; otransp:addbelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "xNome"   ,, xNome  )) ; endif
   if !empty( IE     ) ; otransp:addbelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "IE"      ,, IE     )) ; endif
   if !empty( xEnder ) ; otransp:addbelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "xEnder"  ,, xEnder )) ; endif
   if !empty( xMun   ) ; otransp:addbelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "xMun"    ,, xMun   )) ; endif
   if !empty( UF     ) ; otransp:addbelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "UF"      ,, UF     )) ; endif

return otransp

**************************************************************************************
METHOD CreateretTransp(vServ,vBCRet,pICMSRet,vICMSRet,CFOP,cMunFG)
**************************************************************************************
   Local oretTransp :=TXMLNodeEx( ):New( HBXML_TYPE_TAG, "retTransp" )

   if !empty( vServ    ) ; oretTransp:addbelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vServ"      ,, vServ   )) ; endif
   if !empty( vBCRet   ) ; oretTransp:addbelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vBCRet"     ,, vBCRet  )) ; endif
   if !empty( pICMSRet ) ; oretTransp:addbelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "pICMSRet"   ,, pICMSRet)) ; endif
   if !empty( vICMSRet ) ; oretTransp:addbelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vICMSRet"   ,, vICMSRet)) ; endif
   if !empty( CFOP     ) ; oretTransp:addbelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "CFOP"       ,, CFOP    )) ; endif
   if !empty( cMunFG   ) ; oretTransp:addbelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "cMunFG"     ,, cMunFG  )) ; endif


return  oretTransp

**************************************************************************************
METHOD CreateveicTransp(placa ,UF    ,RNTC  )
**************************************************************************************
Local oveicTransp :=TXMLNodeEx( ):New( HBXML_TYPE_TAG, "veicTransp" )

   if !empty( placa ) ; oveicTransp:addbelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "placa"  ,, placa)) ; endif
   if !empty( UF    ) ; oveicTransp:addbelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "UF"     ,, UF   )) ; endif
   if !empty( RNTC  ) ; oveicTransp:addbelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "RNTC"   ,, RNTC )) ; endif

return oveicTransp

**************************************************************************************
METHOD Createreboque(placa ,UF    ,RNTC  )
**************************************************************************************
Local oreboque :=TXMLNodeEx( ):New( HBXML_TYPE_TAG, "reboque" )

   if !empty( placa ) ; oreboque:addbelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "placa"  ,, placa)) ; endif
   if !empty( UF    ) ; oreboque:addbelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "UF"     ,, UF   )) ; endif
   if !empty( RNTC  ) ; oreboque:addbelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "RNTC"   ,, RNTC )) ; endif

return oreboque

**************************************************************************************
METHOD Createvol(qVol,esp,marca,nVol,pesoL,pesoB)
**************************************************************************************
Local ovol :=TXMLNodeEx( ):New( HBXML_TYPE_TAG, "vol" )

   if !empty( qVol  ) ; ovol:addbelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "qVol"   ,,qVol  )) ; endif
   if !empty( esp   ) ; ovol:addbelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "esp"    ,,esp   )) ; endif
   if !empty( marca ) ; ovol:addbelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "marca"  ,,marca )) ; endif
   if !empty( nVol  ) ; ovol:addbelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "nVol"   ,,nVol  )) ; endif
   if !empty( pesoL ) ; ovol:addbelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "pesoL"  ,,pesoL )) ; endif
   if !empty( pesoB ) ; ovol:addbelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "pesoB"  ,,pesoB )) ; endif
return oVol

**************************************************************************************
METHOD Createlacres( nLacre  )
**************************************************************************************
Local olacres :=TXMLNodeEx( ):New( HBXML_TYPE_TAG, "lacres" )

	if !empty( nLacre ) ; olacres:addbelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "nLacre",,nLacre ) ) ; endif

return olacres


**************************************************************************************
METHOD Createcobr(oFat,oDup)
**************************************************************************************
   Local ocobr :=TXMLNodeEx( ):New( HBXML_TYPE_TAG, "cobr" )


   if valtype(oFat) == "O" ; ocobr:AddBelow(oFat) ; endif
   if valtype(oDup) == "O" ; ocobr:AddBelow(oDup) ; endif


   ::oInfNfe:AddBelow(ocobr)


   return self

**************************************************************************************
METHOD Createfat(nFat,vOrig,vDesc,vLiq)
**************************************************************************************

   Local ofat :=TXMLNodeEx( ):New( HBXML_TYPE_TAG, "fat" )


   if !empty( nFat  ) ; ofat:addbelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "nFat"   ,, nFat )) ; endif
   if !empty( vOrig ) ; ofat:addbelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vOrig"  ,, vOrig)) ; endif
   if !empty( vDesc ) ; ofat:addbelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vDesc"  ,, vDesc)) ; endif
   if !empty( vLiq  ) ; ofat:addbelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vLiq"   ,, vLiq )) ; endif


return ofat


**************************************************************************************
METHOD Createdup(nDup,dVenc,vDup)
**************************************************************************************

   Local odup :=TXMLNodeEx( ):New( HBXML_TYPE_TAG, "dup" )

   if !empty( nDup  ) ; odup:addbelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "nDup"   ,, nDup  )) ; endif
   if !empty( dVenc ) ; odup:addbelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "dVenc"  ,, dVenc )) ; endif
   if !empty( vDup  ) ; odup:addbelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "vDup"   ,, vDup  )) ; endif

return odup


**************************************************************************************
METHOD CreateinfAdic(infAdFisco,infCpl,oobsCont,oobsFisco,oprocRef)
**************************************************************************************
   Local oinfAdic :=TXMLNodeEx( ):New( HBXML_TYPE_TAG, "infAdic" )

   if !empty( infAdFisco ) ; oinfAdic:addbelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "infAdFisco"  ,, infAdFisco )) ; endif
   if !empty( infCpl     ) ; oinfAdic:addbelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "infCpl"      ,, infCpl     )) ; endif
   if valtype(oobsCont) == "O" ; oinfAdic:AddBelow(oobsCont) ; endif
   if valtype(oobsFisco) == "O" ; oinfAdic:AddBelow(oobsFisco) ; endif
   if valtype(oprocRef) == "O" ; oinfAdic:AddBelow(oprocRef) ; endif

   ::oInfNfe:AddBelow(oinfAdic)

return self




**************************************************************************************
METHOD CreateobsCont(xCampo,xTexto)
**************************************************************************************
   Local hHash:= hash()
   Local oobsCont

   hHash["xCampo"] := xCampo

   oobsCont :=TXMLNodeEx( ):New( HBXML_TYPE_TAG, "obsCont",hHash )

   if !empty( xTexto ) ; oobsCont:addbelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "xTexto" ,, xTexto  )) ; endif

return oobsCont



**************************************************************************************
METHOD CreateobsFisco(xCampo,xTexto )
**************************************************************************************
   Local hHash:= hash()
   Local oobsFisco

   hHash["xCampo"] := xCampo


   oobsFisco :=TXMLNodeEx( ):New( HBXML_TYPE_TAG, "obsFisco",hHash )

   if !empty( xTexto ) ; oobsFisco:addbelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "xTexto" ,, xTexto  )) ; endif


return oobsFisco



**************************************************************************************
METHOD CreateprocRef(nProc,indProc)
**************************************************************************************
   Local oprocRef :=TXMLNodeEx( ):New( HBXML_TYPE_TAG, "procRef" )

   if !empty( nProc   ) ; oprocRef:addbelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "nProc"    ,, nProc   )) ; endif
   if !empty( indProc ) ; oprocRef:addbelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "indProc"  ,, indProc )) ; endif

return oprocRef

**************************************************************************************
METHOD Createexporta(UFEmbarq  ,xLocEmbarq)
**************************************************************************************
   Local oexporta :=TXMLNodeEx( ):New( HBXML_TYPE_TAG, "exporta" )

   if !empty( UFEmbarq   ) ; oexporta:addbelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "UFEmbarq"    ,, UFEmbarq  )) ; endif
   if !empty( xLocEmbarq ) ; oexporta:addbelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "xLocEmbarq"  ,, xLocEmbarq)) ; endif

   ::oInfNfe:AddBelow(oexporta)

return self


**************************************************************************************
METHOD CreateCompra(xNEmp ,xPed  ,xCont )
**************************************************************************************
   Local ocompra :=TXMLNodeEx( ):New( HBXML_TYPE_TAG, "compra" )

   if !empty( xNEmp ) ; ocompra:addbelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "xNEmp"  ,, xNEmp)) ; endif
   if !empty( xPed  ) ; ocompra:addbelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "xPed"   ,, xPed )) ; endif
   if !empty( xCont ) ; ocompra:addbelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "xCont"  ,, xCont)) ; endif

   ::oInfNfe:AddBelow(ocompra)

return self

**************************************************************************************
CLASS ConsReciNFe
**************************************************************************************

   DATA oXml INIT TXmlDocument():New()

   METHOD New(Versao,tpAmb,nRec)

   METHOD Write()

ENDCLASS


**************************************************************************************
METHOD New(Versao,tpAmb,nRec) CLASS consReciNFe
**************************************************************************************
Local hHash :=Hash()
Local oconsReciNFe

   hHash["versao"]:=Versao
   oconsReciNFe:=TXMLNodeEx( ) :New( HBXML_TYPE_TAG, "consReciNFe" ,hHash)


   if !empty( tpAmb   ) ; oconsReciNFe:addbelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "tpAmb"    ,, tpAmb   )) ; endif
   if !empty( nRec ) ; oconsReciNFe:addbelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "nRec"  ,, nRec )) ; endif


   ::oXml:oRoot:AddBelow( TXMLNodeEx():New( HBXML_TYPE_PI,'xml' , ,;
                                      'version="1.0"  encoding="UTF-8"' ) )
 	::oXml:oRoot:AddBelow(oconsReciNFe )
return Self


**************************************************************************************
METHOD Write( cXml ) CLASS  consReciNFe
**************************************************************************************
   local nHandle := fCreate( cXml)

   fwrite(nHandle,@::oXml:ToString( HBXML_STYLE_INDENT + HBXML_STYLE_THREESPACES  ) )
   fclose(nHandle)


return self


**************************************************************************************
CLASS  cancNFe
**************************************************************************************

   DATA oXml INIT TXmlDocument():New()
   DATA ocancNFe

   METHOD New(Versao)
   METHOD CreateinfCanc
   METHOD Write(cFile,oInfCanc)

ENDCLASS

**************************************************************************************
METHOD New(versao) CLASS  cancNFe
**************************************************************************************
   Local hHash :=Hash()

   hHash["versao"]:=Versao
   ::ocancNFe:=TXMLNodeEx( ) :New( HBXML_TYPE_TAG, "cancNFe" ,hHash)

return Self


**************************************************************************************
METHOD CreateinfCanc(Id,tpAmb,xServ,chNFe,nProt,xJust ) CLASS  cancNFe
**************************************************************************************
Local hHash :=Hash()
Local oinfCanc

   hHash["Id"]:=Id
   oinfCanc:=TXMLNodeEx( ) :New( HBXML_TYPE_TAG, "infCanc" ,hHash)
   if !empty( tpAmb ) ; oinfCanc:addbelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "tpAmb"    ,, tpAmb )) ; endif
   if !empty( xServ ) ; oinfCanc:addbelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "xServ"    ,, xServ )) ; endif
   if !empty( chNFe ) ; oinfCanc:addbelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "chNFe"    ,, chNFe )) ; endif
   if !empty( nProt ) ; oinfCanc:addbelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "nProt"    ,, nProt )) ; endif
   if !empty( xJust ) ; oinfCanc:addbelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "xJust"    ,, xJust )) ; endif


return oinfCanc



**************************************************************************************
METHOD Write( cXml,oInfCanc ) CLASS  cancNFe
**************************************************************************************
   local nHandle := fCreate( cXml)

    ::oXml:oRoot:AddBelow( TXMLNodeEx():New( HBXML_TYPE_PI,'xml' , ,;
                                         'version="1.0"  encoding="UTF-8"' ) )
    ::ocancNFe:AddBelow(oInfcanc)
    ::oXml:oRoot:AddBelow(::ocancNFe )
   fwrite(nHandle,@::oXml:ToString( HBXML_STYLE_INDENT + HBXML_STYLE_THREESPACES  ) )
   fclose(nHandle)


return self


//// inutnfe

**************************************************************************************
CLASS  inutNFe
**************************************************************************************
   DATA oXml INIT TXmlDocument():New()
   DATA oinutNFe
   METHOD New(Versao)
   METHOD CreateinfInut
   METHOD Write(cFile,oInfCanc)
ENDCLASS

**************************************************************************************
METHOD New(versao) CLASS  inutNFe
**************************************************************************************
   Local hHash :=Hash()
   hHash["versao"]:=Versao

   ::oinutNFe:=TXMLNodeEx( ) :New( HBXML_TYPE_TAG, "inutNFe" ,hHash)

return Self


**************************************************************************************
METHOD CreateinfInut(Id,tpAmb,xServ,cUF,ano,CNPJ,mod,serie,nNFIni,nNFFin,xJust ) CLASS  inutNFe
**************************************************************************************
  Local hHash :=Hash()
  Local oinfInut

  hHash["Id"]:=Id

  oinfInut:=TXMLNodeEx( ) :New( HBXML_TYPE_TAG, "infInut" ,hHash)
  if !empty( tpAmb  ) ; oinfInut:addbelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "tpAmb"     ,, tpAmb  )) ; endif
  if !empty( xServ  ) ; oinfInut:addbelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "xServ"     ,, xServ  )) ; endif
  if !empty( cUF    ) ; oinfInut:addbelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "cUF"       ,, cUF    )) ; endif
  if !empty( ano    ) ; oinfInut:addbelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "ano"       ,, ano    )) ; endif
  if !empty( CNPJ   ) ; oinfInut:addbelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "CNPJ"      ,, CNPJ   )) ; endif
  if !empty( mod    ) ; oinfInut:addbelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "mod"       ,, mod    )) ; endif
  if !empty( serie  ) ; oinfInut:addbelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "serie"     ,, serie  )) ; endif
  if !empty( nNFIni ) ; oinfInut:addbelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "nNFIni"    ,, nNFIni )) ; endif
  if !empty( nNFFin ) ; oinfInut:addbelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "nNFFin"    ,, nNFFin )) ; endif
  if !empty( xJust  ) ; oinfInut:addbelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "xJust"     ,, xJust  )) ; endif


return oInfInut

**************************************************************************************
METHOD Write( cXml,oInfInut ) CLASS  inutNFe
**************************************************************************************
   local nHandle := fCreate( cXml)

    ::oXml:oRoot:AddBelow( TXMLNodeEx():New( HBXML_TYPE_PI,'xml' , ,;
                                         'version="1.0"  encoding="UTF-8"' ) )
    ::oinutNFe:AddBelow(oInfInut)
    ::oXml:oRoot:AddBelow(::oinutNFe )


   fwrite(nHandle,@::oXml:ToString( HBXML_STYLE_INDENT + HBXML_STYLE_THREESPACES  ) )
   fclose(nHandle)

return self


//

**************************************************************************************
CLASS  consSitNFe
**************************************************************************************
   DATA oXml INIT TXmlDocument():New()

   METHOD New(Versao,tpAmb,nRec)
   METHOD Write()

ENDCLASS



**************************************************************************************
METHOD New(Versao,tpAmb,xServ,chNFe) CLASS consSitNFe
**************************************************************************************
   Local hHash :=Hash()
   Local oconsSitNFe

   hHash["versao"]:=Versao
   oconsSitNFe:=TXMLNodeEx( ) :New( HBXML_TYPE_TAG, "consSitNFe" ,hHash)


   if !empty( tpAmb   ) ; oconsReciNFe:addbelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "tpAmb"    ,, tpAmb   )) ; endif
   if !empty( xServ ) ; oconsReciNFe:addbelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "xServ"  ,, xServ )) ; endif
   if !empty( chNFe ) ; oconsReciNFe:addbelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "chNFe"  ,, chNFe )) ; endif

   ::oXml:oRoot:AddBelow( TXMLNodeEx():New( HBXML_TYPE_PI,'xml' , ,;
                                         'version="1.0"  encoding="UTF-8"' ) )
   ::oXml:oRoot:AddBelow(oconsReciNFe )


return Self


**************************************************************************************
METHOD Write( cXml ) CLASS  consSitNFe
**************************************************************************************
   local nHandle := FCreate( cXml)

   fWrite( nHandle , @::oXml:ToString( HBXML_STYLE_INDENT + HBXML_STYLE_THREESPACES  ) )
   fClose( nHandle )

return self


//

**************************************************************************************
CLASS ConsStatServ
**************************************************************************************

   DATA oXml INIT TXmlDocument():New()

   METHOD New(Versao,tpAmb,nRec)
   METHOD Write()

ENDCLASS


**************************************************************************************
METHOD New(Versao,tpAmb,cUF,xServ) CLASS consStatServ
**************************************************************************************
   Local hHash :=Hash()
   Local oconsStatServ


   hHash["versao"]:=Versao
   oconsSitNFe:=TXMLNodeEx( ) :New( HBXML_TYPE_TAG, "consStatServ" ,hHash)


   if !empty( tpAmb   ) ; oconsStatServ:addbelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "tpAmb"    ,, tpAmb   )) ; endif
   if !empty( cUF ) ; oconsStatServ:addbelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "cUF"  ,, chNFe )) ; endif
   if !empty( xServ ) ; oconsStatServ:addbelow( TXMLNodeEx( ) :New( HBXML_TYPE_TAG,   "xServ"  ,, xServ )) ; endif


    ::oXml:oRoot:AddBelow( TXMLNodeEx():New( HBXML_TYPE_PI,'xml' , ,;
                                         'version="1.0"  encoding="UTF-8"' ) )
    ::oXml:oRoot:AddBelow(oconsStatServ )


return Self

**************************************************************************************
METHOD Write( cXml ) CLASS  consStatServ
**************************************************************************************
   local nHandle := fCreate( cXml)

   fwrite(nHandle,@::oXml:ToString( HBXML_STYLE_INDENT + HBXML_STYLE_THREESPACES  ) )
   fclose(nHandle)


return self


**************************************************************************************
CLASS TXMLNodeEx from TXMLNode
**************************************************************************************

   METHOD New( nType, cName, aAttributes, cData ) CONSTRUCTOR

ENDCLASS


**************************************************************************************
METHOD New( nType, cName, aAttributes, cData ) CLASS TXMLNodeEx
**************************************************************************************
  Local xTemp,cTemp


  if valtype(cData) =="C"
     cData := ConvertText(cData)
  elseif valtype(cData) =="D"
     ctemp := DTos( cData )
     cData := Transform( cTemp,"@R 9999-99-99")
  endif

  ::super:New( nType, cName, aAttributes, cData )

return Self



