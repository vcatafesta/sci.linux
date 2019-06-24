@echo off
rem 7z.exe a -r c:\backup\sci \sci\*.prg \sci\*.c \sci\*.ch \sci\*.cpp \sci\*.lua \sci\*.go \sci\*.py \sci\*.rb \sci\*.h \sci\*.bat \sci\*.rmk \sci\*.ini
rem 7z.exe -v5m u -r c:\backup\sci%1 \sci\*.* -x!*.nsx -x!*.bak -x!*.dbf -x!*.obj -x!*.tds
7z.exe u -mmt4 -r -bt c:\backup\sci%1 \sci\*.* -x!*.nsx -x!*.bak -x!*.dbf -x!*.obj -x!*.tds
7z.exe u -mmt4 -r -bt c:\backup\sys%1 \sys\sci\*.* -x!*.nsx -x!*.bak -x!*.dbf -x!*.obj -x!*.tds