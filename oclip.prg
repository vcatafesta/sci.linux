/*
ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
บ                                o:Clip                                บ
บ             An Object Oriented Extension to Clipper 5.01             บ
บ                 (c) 1991 Peter M. Freese, CyberSoft                  บ
ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ

Version 1.01 - November 8, 1991
*/

EXTERNAL ;
  __IVAR01,__IVAR02,__IVAR03,__IVAR04,__IVAR05,;
  __IVAR06,__IVAR07,__IVAR08,__IVAR09,__IVAR10,;
  __IVAR11,__IVAR12,__IVAR13,__IVAR14,__IVAR15,;
  __IVAR16,__IVAR17,__IVAR18,__IVAR19,__IVAR20,;
  __IVAR21,__IVAR22,__IVAR23,__IVAR24,__IVAR25,;
  __IVAR26,__IVAR27,__IVAR28,__IVAR29,__IVAR30,;
  __IVAR31,__IVAR32,__IVAR33,__IVAR34,__IVAR35,;
  __IVAR36,__IVAR37,__IVAR38,__IVAR39,__IVAR40,;
  __IVAR41,__IVAR42,__IVAR43,__IVAR44,__IVAR45,;
  __IVAR46,__IVAR47,__IVAR48,__IVAR49,__IVAR50
EXTERNAL ;
  __SIVAR01,__SIVAR02,__SIVAR03,__SIVAR04,__SIVAR05,;
  __SIVAR06,__SIVAR07,__SIVAR08,__SIVAR09,__SIVAR10,;
  __SIVAR11,__SIVAR12,__SIVAR13,__SIVAR14,__SIVAR15,;
  __SIVAR16,__SIVAR17,__SIVAR18,__SIVAR19,__SIVAR20,;
  __SIVAR21,__SIVAR22,__SIVAR23,__SIVAR24,__SIVAR25,;
  __SIVAR26,__SIVAR27,__SIVAR28,__SIVAR29,__SIVAR30,;
  __SIVAR31,__SIVAR32,__SIVAR33,__SIVAR34,__SIVAR35,;
  __SIVAR36,__SIVAR37,__SIVAR38,__SIVAR39,__SIVAR40,;
  __SIVAR41,__SIVAR42,__SIVAR43,__SIVAR44,__SIVAR45,;
  __SIVAR46,__SIVAR47,__SIVAR48,__SIVAR49,__SIVAR50

STATIC aClassList := {}, aMethodList := {}, aVarList := {}, nCurrent := 0
STATIC oParent

FUNCTION __DefineClass(cName,bParent)
LOCAL nParent
  oParent := nil
  if(bParent <> nil,oParent:= Eval(bParent),) // ensure parent defined
  AADD(aClassList,UPPER(cName))
  AADD(aMethodList,{ {"__PARENT","__PARENT"} })
  AADD(aVarList,{})
  ++nCurrent
  if bParent <> nil .and. ;
    (nParent := ASCAN(aClassList,UPPER(oParent:ClassName))) <> 0
    aMethodList[nCurrent] := ACLONE(aMethodList[nParent])
    aVarList[nCurrent] := ACLONE(aVarList[nParent])
  end
return oParent

PROCEDURE __AddVar(cName)
  AADD(aVarList[nCurrent],cName)
return

PROCEDURE __AddMethod(cName,cUDF)
LOCAL n
  cName := UPPER(cName)
  n := ASCAN(aMethodList[nCurrent], { |aMethod| aMethod[1] == cName } )
  if n > 0
    aMethodList[nCurrent,n] := {cName,cUDF} // override parent method
  else
    AADD(aMethodList[nCurrent],{cName,cUDF})
  end
return

FUNCTION __MakeClass()
LOCAL i := 0,cVar,s
LOCAL nHandle := __ClassNew(aClassList[nCurrent],LEN(aVarList[nCurrent])+1)
  AEVAL(aMethodList[nCurrent], ;
    {|cMethod| __ClassAdd(nHandle,cMethod[1],cMethod[2]) } )
  while i++ < LEN(aVarList[nCurrent])
    cVar := aVarList[nCurrent,i]
    s := PADL(LTRIM(STR(i+1)),2,"0")
    __ClassAdd(nHandle,cVar,"__IVAR"+s)
    __ClassAdd(nHandle,"_"+cVar,"__SIVAR"+s)
  end
return nHandle

FUNCTION __PARENT(bParent)
LOCAL r,i
  if(LEN(QSELF()[1])>1,ACOPY(QSELF(),QSELF()[1],2,,2),)
  r := EVAL(bParent,QSELF()[1])
  if(LEN(QSELF()[1])>1,ACOPY(QSELF()[1],QSELF(),2,,2),)
return r
