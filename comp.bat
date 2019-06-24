@echo off
set WAT_COMPILER=C:\WATCOM\BINNT;
set BCC_COMPILER=C:\BORLAND\BCC55\BIN;
PATH=h:\windows;h:\windows\system;%WAT_COMPILER%;%BCC_COMPILER%;
path
echo Compilador C++ Watcom  : %WAT_COMPILER%
echo Compilador C++ Borland : %BCC_COMPILER%
set TEMP=C:\TEMP
set TMP=C:\TEMP
call "c:\watcom\owsetenv.bat"

