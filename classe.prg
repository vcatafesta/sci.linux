#include "hbclass.ch"

function main()
   local oObject, oBase
   oObject := TAnyClass():New()
   oBase := TClassBase():New()
return nil

class TClassBase
   method New()
   method Test() INLINE Alert( "Test" )
endclass

method TClassBase:New()
	return Self

class TAnyClass from TClassBase
   method New()
endclass

method TAnyClass:New()
   //super:New()
   ::Test()
	main2()
	return Self


/*
 * $Id: clsdata.prg 17835 2012-07-18 13:41:31Z vszakats $
 */

PROCEDURE Main2()
   LOCAL o := HBObject():New()

   QOut( "o:Data1 => ", o:Data1 )
   QOut( "o:ClassData1 => ", o:ClassData1 )
   QOut( "o:Data2 => ", o:Data2 )
   QOut( "o:ClassData2 => ", o:ClassData2 )
   o:Test()

   return

FUNCTION TBaseObject()

   STATIC oClass

   if oClass == NIL
      oClass := HBClass():New( "TBaseObject" )
      oClass:AddData( "Data1" )
      oClass:AddClassData( "ClassData1" )
      oClass:AddMethod( "NewBase", @NewBase() )
      oClass:AddMethod( "Test", @Test() )
      oClass:AddMethod( "Method1", @Method1Base() )
      oClass:AddMethod( "Method2", @Method2Base() )
      oClass:Create()
   endif

   return oClass:Instance()

STATIC FUNCTION NewBase()

   LOCAL self := QSelf()

   ::Data1 := 1
   ::ClassData1 := "A"

   return self

STATIC FUNCTION Test()

   LOCAL self := QSelf()

   QOut( "Inside ::Test() " )
   QOut( "calling ::Method1() " )
   ::Method1()

   return self

STATIC FUNCTION Method1Base()

   LOCAL self := QSelf()

   QOut( "I am Method1 from TBaseObject" )
   ::Method2()

   return self

STATIC FUNCTION Method2Base()

   LOCAL self := QSelf()

   QOut( "I am Method2 from TBaseObject" )

   return self

FUNCTION HBObject()

   STATIC oClass

   if oClass == NIL
      oClass := HBClass():New( "HBObject", "TBaseObject" )
      oClass:AddData( "Data2" )
      oClass:AddClassData( "ClassData2" )
      oClass:AddMethod( "New", @New() )
      oClass:AddMethod( "Method1", @Method1() )
      oClass:AddMethod( "Method2", @Method2() )
      oClass:Create()
   endif

   return oClass:Instance()

STATIC FUNCTION New()

   LOCAL self := QSelf()

   ::TBaseObject:NewBase()
   ::Data1 := 1
   ::ClassData1 := "A"
   ::Data2 := 2
   // ClassData2 override ClassData1
   ::ClassData2 := "B"

   return self

STATIC FUNCTION Method1()

   LOCAL self := QSelf()

   QOut( "I am Method1 from HBObject" )
   ::TBaseObject:Method1()

   return self

STATIC FUNCTION Method2()

   LOCAL self := QSelf()

   QOut( "I am Method2 from HBObject" )

   return self
