:: cmd.exe /K env.cmd

:: Windows Registry Editor Version 5.00
:: [HKEY_CURRENT_USER\Software\Microsoft\Command Processor]
:: "AutoRun"="%USERPROFILE%\\Dropbox\\dev\\misc\\env.cmd"

::AddConsoleAlias( TEXT("test"), 
::                 TEXT("cd \\<a_very_long_path>\\test"), 
::                 TEXT("cmd.exe"));


@echo off
title "Foo Bar"
doskey np=notepad++.exe $*

:: Temporary system path at cmd startup

set PATH=%PATH%;"C:\Program Files\Sublime Text 2\"

:: Add to path by command

DOSKEY add_python27=set PATH=%PATH%;"C:\Python27\"

:: Commands

::DOSKEY ls=dir /B
DOSKEY sublime=sublime_text $*  

::sublime_text.exe is name of the executable. By adding a temporary entry to system path, we don't have to write the whole directory anymore.
DOSKEY gsp="C:\Program Files (x86)\Sketchpad5\GSP505en.exe"
DOSKEY alias=notepad %USERPROFILE%\Dropbox\alias.cmd

:: Common directories

DOSKEY dropbox=cd "%USERPROFILE%\Dropbox\$*"
DOSKEY research=cd %USERPROFILE%\Dropbox\Research\