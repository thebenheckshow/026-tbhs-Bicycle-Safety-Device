CON

  _clkmode = xtal1 + pll16x
  _xinfreq = 5_000_000


  SensePin = 0

  LED = 6
  


  
PUB Start

dira[SensePin]~
dira[LED]~~

outa[LED] := 1


repeat

    outa[LED] := ina[SensePin]
    



