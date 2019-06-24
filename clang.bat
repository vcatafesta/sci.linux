@echo off
set HB_COMPILER=clang
set COMPILER_PATH=C:\LLVM5\bin
set HARBOUR_VER=C:\DEV\HB34\CLANG-64\BIN
set HB_INSTALL_PREFIX=%HARBOUR_VER%
set HB_COMPILER=clang64

set PATH=C:\ProgramData\Oracle\Java\javapath;C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;C:\Windows\System32\WindowsPowerShell\v1.0\;C:\Program Files\Notepad++;C:\Program Files\Git\cmd;%HARBOUR_VER%;%COMPILER_PATH%
set TEMP=C:\LIXO
set TMP=C:\LIXO
hbmk2 %1 %2 %3 %4 -mt -run -b -inc -info -debug -n2 -lhbct -lxhb -lhbwin -lhbgt -lhbnf -lhbxpp -lgtwvg