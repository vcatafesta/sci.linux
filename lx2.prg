Set Print On
Set Devi To Print
Qout('EAN-13')
Qout(;
Chr(27) +;
Chr(40) +;
chr(66) +;
Chr(19) +;
Chr(0)  +;
Chr(0)  +;
Chr(0)  +;
Chr(0)  +;
Chr(10) +;
Chr(00) +;
Chr(00) +;
Chr(48) + ;
Chr(49) + ;
Chr(50) + ;
Chr(51) + ;
Chr(52) + ;
Chr(53) + ;
Chr(54) + ;
Chr(55) + ;
Chr(51) + ;
Chr(52) + ;
Chr(53) + ;
Chr(54) + ;
Chr(55))
Qout(Chr(10))
Qout()
Qout()
Set Devi To Screen
Set Print Off
