@echo off
set HB_INSTALL_PREFIX=C:\DEV\HB32\BCC
set CC_COMPILER=C:\BORLAND\BC45\BIN
PATH=h:\windows;h:\windows\system;h:\windows\syswow64;%CC_COMPILER%;%HB_INSTALL_PREFIX%\BIN;
echo path
set HB_COMPILER=
echo HB_COMPILER
echo HB_INSTALL_PREFIX
echo Compilador Harbour: %HB_INSTALL_PREFIX%\BIN
echo Compilador C++    : %CC_COMPILER%
set TEMP=C:\TEMP
set TMP=C:\TEMP
rem set PATH=c:\harbouri\bin;h:\windows;h:\windows\system32
hbmk2 %1 %2 %3 %4 -b -info -debug -cpp -n2 -lhbct -lxhb -lhbwin -lhbgt -lhbnf -lhbxpp -lgtwvg -lgtstd -lgtcgi -lgtgui -lgtpca -lgtwin -lgtwvg  -lgtwvt

