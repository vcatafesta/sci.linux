PROCEDURE Main()

   LOCAL oWnd
   LOCAL oCalendar
	LOCAL oSBar

   oWnd := QMainWindow()
   oWnd:setWindowTitle( "Finestra di Giovanni" )
   oWnd:resize( 400, 300 )

   oCalendar := QCalendarWidget( oWnd )
   oCalendar:resize( 250, 200 )
   oCalendar:move( 50, 50 )
   oCalendar:setFirstDayOfWeek( 1 )
   oCalendar:setGridVisible( .T. )
	


   oWnd := QMainWindow()
   oWnd:show()

   oWnd:setWindowTitle( "Giovanni" )
   oWnd:resize( 300, 200 )

   oSBar  := QStatusBar( oWnd )
   oWnd:setStatusBar( oSBar )

   oSBar:showMessage( "Harbour-QT Statusbar Ready!" )

   QApplication():exec()

   return

	

   oWnd:show()
   QApplication():exec()

   return