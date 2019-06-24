@echo off
rem set PATH=h:\windows;h:\windows\system;c:\borland\bcc55\bin;c:\harbour\bin;
rem set PATH=h:\windows;h:\windows\system;c:\borland\bcc55\bin;c:\harbouri\bin;%path%
set TEMP=C:\LIXO
set TMP=C:\LIXO
rem set PATH=c:\harbouri\bin;h:\windows;h:\windows\system32
rem call "H:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\bin\vcvars32.bat"
rem set HB_COMPILER=msvc
rem SET HB_CONTRIBLIBS=C:\harbouri\lib\win\msvc
rem hbmk2 %1 %2 %3 %4 -b -info -debug -cpp -n2 -lhbct -lxhb -lhbwin -lhbgt -lhbnf -lhbxpp -lgtwvg -lgtstd -lgtcgi -lgtgui -lgtpca -lgtwin -lgtwvg  -lgtwvt 

rem hbmk2 %1 %2 %3 %4 
bcc32 %1
if not errorlevel 1 %1
