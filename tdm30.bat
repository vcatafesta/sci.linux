@echo off
PATH=h:\windows;h:\windows\system;C:\MINGW\BIN;C:\DEV\HB30\BIN;
path
set HB_COMPILER=
set HB_INSTALL_PREFIX=C:\DEV\HB30
echo HB_COMPILER=
echo HB_INSTALL_PREFIX=
echo Compilador Harbour: :\DEV\HB30\BIN;
echo Compilador C++    : C:\TDM-GCC-32\BIN
set TEMP=C:\LIXO
set TMP=C:\LIXO
rem set PATH=c:\harbouri\bin;h:\windows;h:\windows\system32
hbmk2 %1 %2 %3 %4 -b -info -debug -cpp -n2 -lhbct -lxhb -lhbwin -lhbgt -lhbnf -lhbxpp -lgtwvg -lgtstd -lgtcgi -lgtgui -lgtpca -lgtwin -lgtwvg  -lgtwvt

