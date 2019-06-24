 #include "hbclass.ch"

 PROCEDURE Main()

    LOCAL oPerson := Person( "Dave" )

    oPerson:Eyes := "Invalid"

    oPerson:Eyes := "Blue"

    Alert( oPerson:Describe() )
 return

 CLASS Person
    DATA Name INIT ""

    METHOD New() CONSTRUCTOR

    ACCESS Eyes 	INLINE ::pvtEyes
    ASSIGN Eyes(x) 	INLINE Iif( ValType( x ) == 'C' .AND. ;
                 x IN "Blue,Brown,Green", ::pvtEyes := x,; 
                 Alert( "Invalid value" ) )

    // Sample of IN-LINE Method definition
    INLINE METHOD Describe()
       LOCAL cDescription

       if Empty( ::Name )
          cDescription := "I have no name yet."
       else
          cDescription := "My name is: " + ::Name + ";"
       endif

       if ! Empty( ::Eyes )
          cDescription += "my eyes' color is: " + ::Eyes
       endif
    ENDMETHOD

    PRIVATE:
       DATA pvtEyes
 ENDCLASS

 // Sample of normal Method definition.
 METHOD New( cName ) CLASS Person

   ::Name := cName

 return Self
 
