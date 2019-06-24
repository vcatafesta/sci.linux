@ECHO OFF
set TEMP=C:\LIXO
set TMP=C:\LIXO
set COMP_PATH=C:\MINGW-64
set HB_COMPILER=mingw64
set HB_INSTALL_PREFIX=c:\DEV\hb32\%HB_COMPILER%
set PATH=%COMP_PATH%\bin;h:\windows;h:\windows\system;%HB_INSTALL_PREFIX%\BIN;
set LIB=%COMP_PATH%\lib;%HB_INSTALL_PREFIX%\lib;
set INCLUDE=%COMP_PATH%\include;%HB_INSTALL_PREFIX%\include;
set HB_CPU=x86_64
rem SET HB_CONTRIBLIBS=%HB_INSTALL_PREFIX%\lib
hbmk2 %1 %2 %3 %4 -b -inc -info -debug -cpp -n2 -lhbct -lxhb -lhbwin -lhbgt -lhbnf -lhbxpp -lgtwvg -lgtstd -lgtcgi -lgtgui -lgtpca -lgtwin 
