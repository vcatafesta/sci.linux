********************************
Function Main
LOCAL cPath, aDir

REQUEST LETO
RDDSETDEFAULT( "LETO" )

cls
cPath := "//127.0.0.1:2812/"
@  1, 2 say "Leto_Directory( cPaTH, cParam )    Arquivos"

aDir:= Leto_Directory( cPath )
@  2, 2 say "cParam = ' '" + space(25) + str(len( aDir ), 6)

aDir:= Leto_Directory( cPath, "D" )
@  3, 2 say "cParam = 'D'" + space(25) + str(len( aDir ), 6)

aDir:= Leto_Directory( cPath, "H" )
@  4, 2 say "cParam = 'H'" + space(25) + str(len( aDir ), 6)

aDir:= Leto_Directory( cPath, "S" )
@  5, 2 say "cParam = 'S'" + space(25) + str(len( aDir ), 6)

aDir:= Leto_Directory( cPath, "V" )
@  6, 2 say "cParam = 'V'" + space(25) + str(len( aDir ), 6)

? leto_direxist(cPath + "/EMP0008")

? ( leto_Connect( "localhost",,,30000 ) ) < 0 //Default is 120.000 aka 2 minutes.
? ( leto_Connect( "127.0.0.1",,,30000 ) ) < 0 //Default is 120.000 aka 2 minutes.

inkey(0)


return .T.
//Fim