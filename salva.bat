@ECHO OFF
CLS
C:
CD C:\sci\src
ECHO �����������������������������������������������������������������������������͸
ECHO � ����  ����Macrosoft           �Av Castelo Branco, 693 - Pioneiros           �
ECHO � �� ���� ��   Informatica      �Fone (69)3451-3085                           �
ECHO � ��  ��  ��      Ltda          �76976-000/Pimenta Bueno - Rondonia           �
ECHO �����������������������������������������������������������������������������;
ECHO 
ECHO �����������������������������������������������������������������������������͸
ECHO � Insira o disco de backup no drive A: e tecle ENTER para iniciar             �
ECHO �                                                                             �
ECHO � CUIDADO!! Os dados do drive A: serao todos apagados.                        �
ECHO �������������������������������������������������������������������������������
PAUSE >NUL
COMPRIME -EX -RP -SMSIL -&F A:\SCI *.DBF + *.CFG + *.DOC + *.TXT + *.BAT + *.ETI + *.NFF + *.COB + *.DUP
