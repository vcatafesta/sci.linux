:: Compilador Watcom
@echo off
set HB_COMPILER=watcom
SET HB_BUILD_VERBOSE=yes
SET HB_BUILD_CONTRIBS=
SET HB_BUILD_MODE=c
SET HB_BUILD_CONTRIB_DYN=yes
SET CC_COMPILER=C:\WATCOM\BINNT;C:\WATCOM\BINW\;C:\WATCOM\BINL
SET COMPILER_PATH=%CC_COMPILER%
SET HB_PATH=C:\DEV\HB32\WATCOM-32\BIN
SET HARBOUR_VER=%HB_PATH%
SET HB_INSTALL_PREFIX=%HARBOUR_VER%
CALL "c:\watcom\owsetenv.bat"
SET PATH=%HARBOUR_VER%;%COMPILER_PATH%;%PATH%;
::
::echo HB_COMPILER=%HB_COMPILER%
::echo HARBOUR_VER=%HARBOUR_VER%
::echo HB_INSTALL_PREFIX=%HB_INSTALL_PREFIX%
::echo Compilador Harbour: %HB_INSTALL_PREFIX%
::echo Compilador C++    : %CC_COMPILER%
::
SET TEMP=C:\LIXO
SET TMP=C:\LIXO
SET INCLUDE=C:\SCI\INCLUDE;%INCLUDE%
::
rem hbmk2 %1 %2 %3 %4 -w3 -mt -run -b -inc -info -debug -cpp -n2 -lhbct -lxhb -lhbwin -lhbgt -lhbnf -lhbxpp -lgtwvg
rem hbmk2 %1 %2 %3 %4 -run -mt -b -inc -info -debug -n2 -lhbct -lxhb -lhbwin -lhbgt -lhbnf -lhbxpp -lgtwvg -lhbmemio -lhbgzio -ic:\sci\include

