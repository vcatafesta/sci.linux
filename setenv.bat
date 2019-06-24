@echo off
rem set PATH=h:\windows;h:\windows\system;c:\borland\bcc55\bin;c:\harbour\bin;
rem set PATH=h:\windows;h:\windows\system;c:\borland\bcc55\bin;c:\harbouri\bin;%path%
set TEMP=C:\LIXO
set TMP=C:\LIXO
set HB_INSTALL_PREFIX=c:\hb34\msvc
set HB_COMPILER=msvc
rem set PATH=c:\harbouri\bin;h:\windows;h:\windows\system32
set PATH=%HB_INSTALL_PREFIX%\bin;h:\windows;h:\windows\system32
call "H:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\bin\vcvars32.bat"
rem SET HB_CONTRIBLIBS=C:\harbouri\lib\win\msvc
rem hbmk2 %1 -b -info -debug -cpp -n2 -lhbct -lxhb -lhbwin -lhbgt -lhbnf -lhbxpp 