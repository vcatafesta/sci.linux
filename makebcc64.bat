@echo off
path=C:\dev\HB32\bcc73\bin;%path%
harbour.exe -n2 str.prg tstring.prg -ic:\sci\include;-iC:\dev\HB32\bcc73\include
bcc64.exe str.c tstring.c -P -Lhbct -Lxhb -Lhbwin -Lhbgt -lhbnf -lhbxpp -lgtwvg -lleto -lrddleto -lhbmemio -lhbgzio 