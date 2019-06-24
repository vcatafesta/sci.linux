@echo off
:: echo %PATH%
::
::echo HB_COMPILER=%HB_COMPILER%
::echo HARBOUR_VER=%HARBOUR_VER%
::echo HB_INSTALL_PREFIX=%HB_INSTALL_PREFIX%
::echo Compilador Harbour: %HB_INSTALL_PREFIX%
::echo Compilador C++    : %CC_COMPILER%
::
::hbmk2 %1 %2 %3 %4 hbsqlite3.hbc -mt -b -inc -info -debug -cpp -n2 -lhbct -lxhb -lhbwin -lhbgt -lhbnf -lhbxpp -lgtwvg -lhbmemio -lhbgzio -ic:\sci\include
hbmk2 %1 %2 %3 %4 -mt -b -inc -info -debug -cpp -n2 -lhbct -lxhb -lhbwin -lhbgt -lhbnf -lhbxpp -lgtwvg -lleto -lrddleto -lsqlite3 -lhbmemio -lhbgzio -ic:\sci\include 
if not errorlevel 1 %1