@ECHO OFF
set TEMP=C:\LIXO
set TMP=C:\LIXO
set COMP_PATH=C:\BORLAND\BCC55
set HB_CPU=
set HB_COMPILER=msvc64
set HB_INSTALL_PREFIX=c:\DEV\hb32\%HB_COMPILER%
set PATH=%COMP_PATH%\bin;h:\windows;h:\windows\system;%HB_INSTALL_PREFIX%\BIN;%PATH%
set LIB=%COMP_PATH%\lib;%COMP_PATH%\lib\sdk;
set INCLUDE=%COMP_PATH%\include;
rem call "c:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\bin\x86_amd64\vcvarsx86_amd64.bat"
call "c:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\bin\x86_amd64\vcvarsx86_amd64.bat"
SET HB_CONTRIBLIBS=%HB_INSTALL_PREFIX%\lib
hbmk2 %1 %2 %3 %4 -b -inc -info -debug -cpp -n2 -lhbct -lxhb -lhbwin -lhbgt -lhbnf -lhbxpp -lgtwvg -lgtstd -lgtcgi -lgtgui -lgtpca -lgtwin 
