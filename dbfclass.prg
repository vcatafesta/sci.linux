#include 'hbclass.ch'

function Main
    local oCal  := tCal():New()
    local aTest := { {date(), '07:00','07:15'} ,;
                     {date(), '07:16','07:30'} }

    local aData := { {'MEL'     , date(), '07:00','07:15'} ,;
                     {'SUSAN'   , date(), '07:31','07:59'} ,;
                     {'DANIEL'  , date(), '08:00','08:30'} }
    local i
    oCal:CreateDbf()
    oCal:FillData( aData )
    for i:= 1 to len( aTest )
        ?i, oCal:SeekData( aTest[ i, 1], aTest[ i, 2], aTest[ i, 3]  ), oCal:cName
    next
    oCal:Close()
return Nil

Class tCal
    data cName init ''
    data cDbf  init 'agenda.dbf'
    data cNtx  init 'agenda.ntx'
    data aDbf  init {{'Name'      , 'C',40, 00} ,;
                     {'date'      , 'D',08,00 } ,;
                     {'time_Start', 'C',05,00 } ,;
                     {'time_End'  , 'C',05,00 } }
    method new() constructor
    method CreateDbf()
    method SeekData( dDate, cTime1, cTime2  )
    Method FillData( aData  )
    Method Close()
endclass
