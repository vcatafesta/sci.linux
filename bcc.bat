@echo off
set HB_COMPILER=bcc
set CC_COMPILER=C:\Program Files (x86)\Embarcadero\Studio\19.0\bin
set COMPILER_PATH=C:\Program Files (x86)\Embarcadero\Studio\19.0\bin
set HARBOUR_VER=C:\DEV\HB32\BCC73\BIN
set HB_INSTALL_PREFIX=%HARBOUR_VER%
set PATH=%HARBOUR_VER%;%COMPILER_PATH%;%PATH%;
::
::echo HB_COMPILER=%HB_COMPILER%
::echo HARBOUR_VER=%HARBOUR_VER%
::echo HB_INSTALL_PREFIX=%HB_INSTALL_PREFIX%
::echo Compilador Harbour: %HB_INSTALL_PREFIX%
::echo Compilador C++    : %CC_COMPILER%
::
set TEMP=C:\LIXO
set TMP=C:\LIXO
set INCLUDE=C:\SCI\INCLUDE;%INCLUDE%
::
rem hbmk2 %1 %2 %3 %4 -w3 -mt -run -b -inc -info -debug -cpp -n2 -lhbct -lxhb -lhbwin -lhbgt -lhbnf -lhbxpp -lgtwvg
rem hbmk2 %1 %2 %3 %4 -run -mt -b -inc -info -debug -cpp -n2 -lhbct -lxhb -lhbwin -lhbgt -lhbnf -lhbxpp -lgtwvg -lleto -lrddleto -lhbmemio -lhbgzio -ic:\sci\include

