@ECHO OFF
REM Gerado pela xDev Studio v0.72 as 20/07/2016 @ 11:58:05
REM Compilador .: xHB build 1.2.1 (SimpLex) & BCC 5.5.1
REM Destino ....: C:\Harbour\prg\Main.EXE
REM Perfil .....: Batch file (Relative Paths)

REM **************************************************************************
REM * Setamos abaixo os PATHs necessarios para o correto funcionamento deste *
REM * script. Se voce for executa-lo em  outra CPU, analise as proximas tres *
REM * linhas abaixo para refletirem as corretas configuracoes de sua maquina *
REM **************************************************************************
 SET PATH=C:\xHarbour-BCC.5.5.1\bin;C:\Borland\bcc55\Bin;C:\BORLAND\BCC55\BIN;C:\WATCOM\BINNT;C:\WATCOM\BINW;H:\ProgramData\Oracle\Java\javapath;H:\Windows\system32;H:\Windows;H:\Windows\System32\Wbem;H:\Windows\System32\WindowsPowerShell\v1.0\;H:\Program Files\Intel\WiFi\bin\;H:\Program Files\Common Files\Intel\WirelessCommon\;H:\Program Files (x86)\Windows Kits\8.1\Windows Performance Toolkit\;H:\Program Files\Microsoft SQL Server\120\Tools\Binn\;H:\Program Files\Microsoft SQL Server\130\Tools\Binn\;H:\Program Files\dotnet\;H:\Program Files (x86)\MySQL\MySQL Fabric 1.5 & MySQL Utilities 1.5\;H:\Program Files (x86)\MySQL\MySQL Fabric 1.5 & MySQL Utilities 1.5\Doctrine extensions for PHP\;H:\Users\Administrador.LG\marinas-ide_05_06_64bit;H:\Program Files\jEdit;H:\Program Files\TortoiseSVN\bin;H:\Program Files\Git\cmd;H:\Program Files\Git\mingw64\bin;H:\Program Files\Git\usr\bin;C:\HARBOUR\BIN;H:\Program Files (x86)\CVSNT\
 SET INCLUDE=C:\xHarbour-BCC.5.5.1\include;C:\Borland\bcc55\include;;C:\WATCOM\H;C:\WATCOM\H\NT;C:\WATCOM\H\NT\DIRECTX;C:\WATCOM\H\NT\DDK;C:\HARBOUR\INCLUDE;
 SET LIB=C:\xHarbour-BCC.5.5.1\lib;C:\Borland\bcc55\lib;C:\Borland\bcc55\lib\psdk;;
 SET PATH=C:\xHarbour-BCC.5.5.1\bin;C:\Borland\bcc55\Bin;C:\BORLAND\BCC55\BIN;C:\WATCOM\BINNT;C:\WATCOM\BINW;H:\ProgramData\Oracle\Java\javapath;H:\Windows\system32;H:\Windows;H:\Windows\System32\Wbem;H:\Windows\System32\WindowsPowerShell\v1.0\;H:\Program Files\Intel\WiFi\bin\;H:\Program Files\Common Files\Intel\WirelessCommon\;H:\Program Files (x86)\Windows Kits\8.1\Windows Performance Toolkit\;H:\Program Files\Microsoft SQL Server\120\Tools\Binn\;H:\Program Files\Microsoft SQL Server\130\Tools\Binn\;H:\Program Files\dotnet\;H:\Program Files (x86)\MySQL\MySQL Fabric 1.5 & MySQL Utilities 1.5\;H:\Program Files (x86)\MySQL\MySQL Fabric 1.5 & MySQL Utilities 1.5\Doctrine extensions for PHP\;H:\Users\Administrador.LG\marinas-ide_05_06_64bit;H:\Program Files\jEdit;H:\Program Files\TortoiseSVN\bin;H:\Program Files\Git\cmd;H:\Program Files\Git\mingw64\bin;H:\Program Files\Git\usr\bin;C:\HARBOUR\BIN;H:\Program Files (x86)\CVSNT\
 SET INCLUDE=C:\xHarbour-BCC.5.5.1\include;C:\Borland\bcc55\include;;C:\WATCOM\H;C:\WATCOM\H\NT;C:\WATCOM\H\NT\DIRECTX;C:\WATCOM\H\NT\DDK;C:\HARBOUR\INCLUDE;
 SET LIB=C:\xHarbour-BCC.5.5.1\lib;C:\Borland\bcc55\lib;C:\Borland\bcc55\lib\psdk;;
 SET PATH=C:\xHarbour-BCC.5.5.1\bin;C:\Borland\bcc55\Bin;C:\BORLAND\BCC55\BIN;C:\WATCOM\BINNT;C:\WATCOM\BINW;H:\ProgramData\Oracle\Java\javapath;H:\Windows\system32;H:\Windows;H:\Windows\System32\Wbem;H:\Windows\System32\WindowsPowerShell\v1.0\;H:\Program Files\Intel\WiFi\bin\;H:\Program Files\Common Files\Intel\WirelessCommon\;H:\Program Files (x86)\Windows Kits\8.1\Windows Performance Toolkit\;H:\Program Files\Microsoft SQL Server\120\Tools\Binn\;H:\Program Files\Microsoft SQL Server\130\Tools\Binn\;H:\Program Files\dotnet\;H:\Program Files (x86)\MySQL\MySQL Fabric 1.5 & MySQL Utilities 1.5\;H:\Program Files (x86)\MySQL\MySQL Fabric 1.5 & MySQL Utilities 1.5\Doctrine extensions for PHP\;H:\Users\Administrador.LG\marinas-ide_05_06_64bit;H:\Program Files\jEdit;H:\Program Files\TortoiseSVN\bin;H:\Program Files\Git\cmd;H:\Program Files\Git\mingw64\bin;H:\Program Files\Git\usr\bin;C:\HARBOUR\BIN;H:\Program Files (x86)\CVSNT\
 SET INCLUDE=C:\xHarbour-BCC.5.5.1\include;C:\Borland\bcc55\include;;C:\WATCOM\H;C:\WATCOM\H\NT;C:\WATCOM\H\NT\DIRECTX;C:\WATCOM\H\NT\DDK;C:\HARBOUR\INCLUDE;
 SET LIB=C:\xHarbour-BCC.5.5.1\lib;C:\Borland\bcc55\lib;C:\Borland\bcc55\lib\psdk;;

REM - Harbour.xCompiler.prg(97) @ 11:58:05:467
ECHO .ÿ
ECHO * (1/3) Compilando projeto.prg
 harbour.exe ".\projeto.prg" /q /o".\projeto.c"   /M  /N -DxHB 
 IF ERRORLEVEL 1 GOTO FIM

REM - Harbour.xCompiler.prg(138) @ 11:58:05:628
 echo  -DxHB  > "b32.bc"
 echo -I"C:\xHarbour-BCC.5.5.1\include;C:\Borland\bcc55\include;;C:\WATCOM\H;C:\WATCOM\H\NT;C:\WATCOM\H\NT\DIRECTX;C:\WATCOM\H\NT\DDK;C:\HARBOUR\INCLUDE;" >> "b32.bc"
 echo -L"C:\xHarbour-BCC.5.5.1\lib;C:\Borland\bcc55\lib;C:\Borland\bcc55\lib\psdk;;;;;" >> "b32.bc"
 echo -o".\projeto.obj" >> "b32.bc"
 echo ".\projeto.c" >> "b32.bc"

REM - Harbour.xCompiler.prg(139) @ 11:58:05:628
ECHO .ÿ
ECHO * (2/3) Compilando projeto.c
 BCC32 -M -c @B32.BC
 IF ERRORLEVEL 1 GOTO FIM

REM - Harbour.xCompiler.prg(285) @ 11:58:05:782
 echo -I"C:\xHarbour-BCC.5.5.1\include;C:\Borland\bcc55\include;;C:\WATCOM\H;C:\WATCOM\H\NT;C:\WATCOM\H\NT\DIRECTX;C:\WATCOM\H\NT\DDK;C:\HARBOUR\INCLUDE;" + > "b32.bc"
 echo -L"C:\xHarbour-BCC.5.5.1\lib;C:\Borland\bcc55\lib;C:\Borland\bcc55\lib\psdk;;;;;" + >> "b32.bc"
 echo -Gn -M -m  -Tpe -s + >> "b32.bc"
 echo c0w32.obj +     >> "b32.bc"
 echo ".\projeto.obj", +  >> "b32.bc"
 echo ".\Main.EXE", +    >> "b32.bc"
 echo ".\Main.map", +    >> "b32.bc"
 echo lang.lib +      >> "b32.bc"
 echo vm.lib +        >> "b32.bc"
 echo rtl.lib +       >> "b32.bc"
 echo rdd.lib +       >> "b32.bc"
 echo macro.lib +     >> "b32.bc"
 echo pp.lib +        >> "b32.bc"
 echo dbfntx.lib +    >> "b32.bc"
 echo dbffpt.lib +    >> "b32.bc"
 echo common.lib +    >> "b32.bc"
 echo gtwin.lib +  >> "b32.bc"
 echo codepage.lib +  >> "b32.bc"
 echo ct.lib +     >> "b32.bc"
 echo tip.lib +     >> "b32.bc"
 echo hsx.lib +     >> "b32.bc"
 echo pcrepos.lib +     >> "b32.bc"
 echo hbsix.lib +     >> "b32.bc"
 echo cw32.lib +      >> "b32.bc"
 echo import32.lib +  >> "b32.bc"
 echo rasapi32.lib + >> "b32.bc"
 echo nddeapi.lib + >> "b32.bc"
 echo iphlpapi.lib + >> "b32.bc"
 echo , >> "b32.bc"

REM - Harbour.xCompiler.prg(286) @ 11:58:05:782
ECHO .ÿ
ECHO * (3/3) Linkando Main.EXE
 ILINK32 @B32.BC
 IF ERRORLEVEL 1 GOTO FIM

:FIM
 ECHO Fim do script de compilacao!
