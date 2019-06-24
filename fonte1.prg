Function Main()
***************
LOCAL TabelaFonte
LOCAL aModeMenu

TabelaFonte     := Array(25)
TabelaFonte[01] := { || FLreset() }
TabelaFonte[02] := { || VideoMode(3)}
TabelaFonte[03] := { || VideoMode(43)}
TabelaFonte[04] := { || VideoMode(50)}
TabelaFonte[05] := { || FLdigital() }
TabelaFonte[06] := { || FLavantgrd() }
TabelaFonte[07] := { || FL3270() }
TabelaFonte[08] := { || FLbroadway() }
TabelaFonte[09] := { || FLcyrillic() }
TabelaFonte[10] := { || FLpercy() }
TabelaFonte[11] := { || FLlegend() }
TabelaFonte[12] := { || FLcalligra() }
TabelaFonte[13] := { || FLscript2() }
TabelaFonte[14] := { || FLscript1() }
TabelaFonte[15] := { || FLItalic1() }
TabelaFonte[16] := { || FLItalic2() }
TabelaFonte[17] := { || FLRomany() }
TabelaFonte[18] := { || FLOldEng() }
TabelaFonte[19] := { || FLBauhaus() }
TabelaFonte[20] := { || FLBodoni() }
TabelaFonte[21] := { || FLGaramond() }
TabelaFonte[22] := { || FLParkAve() }
TabelaFonte[23] := { || FLComputer() }
TabelaFonte[24] := { || FLGreek() }
TabelaFonte[25] := { || FLHebrew() }

aModeMenu := {"Resetar Fonte Para Normal",;
                    "80x25 Linhas - CGA EGA VGA Somente", ;
                    "80x43 Linhas - EGA & VGA Somente",;
                    "80x50 Linhas - VGA Somente",;
                    "Fonte Digital" ,;
                    "Avante Garde",;
                    "Fonte 3270",;
                    "Fonte Broadway",;
                    "Fonte Cyrillic",;
                    "Fonte Percy",;
                    "Fonte Legenda",;
                    "Fonte Caligrafia",;
                    "Fonte Script1",;
                    "Fonte Script2",;
                    "Fonte Italica1",;
                    "Fonte Italica2",;
                    "Fonte Romana",;
                    "Fonte Ingles Velho",;
                    "Fonte Bauhaus",;
                    "Fonte Bodoni",;
                    "Fonte Garamond",;
						  "Fonte Avenida",;
						  "Fonte Computador",;
						  "Fonte Grego",;
						  "Fonte Hebreu"}

if Argc() != 0
   Eval( TabelaFonte[ Val(Argv(1))] )
   Qout('þ Fonte Setada para ' + aModeMenu[Val(Argv(1))])
   return
endif


While.T.
   SetColor("w+/b")
   Cls
   SetColor("B/w+")
   @ 0,0 Say Repl('Û',80)
   @ 0,0 Say 'Microbras'
   SetColor("w+/b")
   nChoice := AChoice( 01, 10, 23, 45, aModeMenu )
	Do Case
	Case nChoice = 0
		return
	Case VidType() == 0
      Tone(100,2)
      Alert("Erro: Placa de Video Monocromatica." )
	EndCase
   Eval( TabelaFonte[ nChoice] )
Enddo
