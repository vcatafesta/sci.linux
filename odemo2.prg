/*
ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
บ                                o:Clip                                บ
บ             An Object Oriented Extension to Clipper 5.01             บ
บ                 (c) 1991 Peter M. Freese, CyberSoft                  บ
ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ

Version 1.01 - November 8, 1991
*/
#include "oclip.ch"

LOCAL o2 := Sample2():New("World")
        o2:Hello()
        return

//=============================================================
CLASS Sample1
  VAR Who
  METHOD New   = Sample1New
  METHOD Hello = Sample1Hello
ENDCLASS

FUNCTION Sample1New(cWho)
  ::Who := cWho
return Self

FUNCTION Sample1Hello
  ? "Hello",::Who
return Self

//=============================================================
CLASS Sample2 FROM Sample1
  METHOD Hello = Sample2Hello
ENDCLASS

FUNCTION Sample2Hello
  ::parent:Hello()
  ? "Greetings and salutations!"
return Self
