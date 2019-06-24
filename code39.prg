Set Print On
Set Devi To Print
Qout('CODE-39')
Qout( Chr(27) + Chr(33) + Chr(25))
Qout(;
Chr(27) +;
Chr(40) +;
chr(66) +;
Chr(14) +;
Chr(00) +;
Chr(05) +;
Chr(00) +;
Chr(00) +;
Chr(30) +;
Chr(00) +;
Chr(00) +;
Chr(Asc('0'))+;
Chr(Asc('0'))+;
Chr(Asc('5'))+;
Chr(Asc('8'))+;
Chr(Asc('7'))+;
Chr(Asc('-'))+;
Chr(Asc('A'))
Qout(Chr(10))
Qout()
Qout()
Set Devi To Screen
Set Print Off
