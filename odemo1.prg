/*
ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
บ                                o:Clip                                บ
บ             An Object Oriented Extension to Clipper 5.01             บ
บ                 (c) 1991 Peter M. Freese, CyberSoft                  บ
ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ

Version 1.01 - November 8, 1991
*/
#include "oclip.ch"

LOCAL o1 := Sample1():New("World")
        o1:Hello()
        return

CLASSE Sample1
  VAR Who
  METHOD New
  METHOD Hello
ENDCLASSE

METODO New(cWho)
  ::Who := cWho
return Self

METODO Hello
  ? "Hello",::Who
return Self

