@ECHO OFF
CLS
C:
CD C:\sci\src
ECHO ÕÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¸
ECHO ³ ÝÝÝÝ  ÝÝÝÝMacrosoft           ³Av Castelo Branco, 693 - Pioneiros           ³
ECHO ³ ÝÝ ÝÝÝÝ ÝÝ   Informatica      ³Fone (69)3451-3085                           ³
ECHO ³ ÝÝ  ÝÝ  ÝÝ      Ltda          ³76976-000/Pimenta Bueno - Rondonia           ³
ECHO ÔÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¾
ECHO 
ECHO ÕÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¸
ECHO ³ Insira o disco de backup no drive A: e tecle ENTER para iniciar             ³
ECHO ³                                                                             ³
ECHO ³ CUIDADO!! Os dados do drive A: serao todos apagados.                        ³
ECHO ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PAUSE >NUL
COMPRIME -EX -RP -SMSIL -&F A:\SCI *.DBF + *.CFG + *.DOC + *.TXT + *.BAT + *.ETI + *.NFF + *.COB + *.DUP
