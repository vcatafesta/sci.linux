@echo off

REM #versao 3.2 mingw64
set HB_COMPILER=mingw64
set COMPILER_PATH=C:\MinGW72\BIN
set HARBOUR_VER=C:\dev\HB32\mingw72-64\bin
set HB_INSTALL_PREFIX=%HARBOUR_VER%

REM #versao 3.4 mingw
REM set HB_COMPILER=mingw
REM set COMPILER_PATH=C:\MINGW\BIN
REM set HARBOUR_VER=C:\HB34.SRC\HARBOUR-CORE\BIN\WIN\MINGW

REM #versao 3.4 msvc
rem set HB_COMPILER=msvc
rem set HARBOUR_VER=C:\HB34.SRC\HARBOUR-CORE\BIN\WIN\MSVC
rem call "c:\Program Files\Microsoft Visual Studio 9.0\VC\bin\vcvars32.bat"

set PATH=%HARBOUR_VER%;%COMPILER_PATH%C:\ProgramData\Oracle\Java\javapath;C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;C:\Windows\System32\WindowsPowerShell\v1.0\;C:\Program Files\Notepad++;C:\Program Files\Git\cmd;
rem call "c:\Program Files\Microsoft Visual Studio 9.0\VC\bin\vcvars32.bat"
set TEMP=C:\LIXO
set TMP=C:\LIXO
rem set PATH=c:\harbouri\bin;h:\windows;h:\windows\system32
rem call "c:\Program Files\Microsoft Visual Studio 9.0\VC\bin\vcvars32.bat"
rem set HB_COMPILER=msvc
rem SET HB_CONTRIBLIBS=C:\harbouri\lib\win\msvc
hbmk2 %1 %2 %3 %4 -mt -run -b -inc -info -debug -cpp -n2 -lhbct -lxhb -lhbwin -lhbgt -lhbnf -lhbxpp -lgtwvg -lhbtip