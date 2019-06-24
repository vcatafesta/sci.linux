PROCEDURE Main()

   LOCAL oWnd, oDate, oText

   SET DATE italian
   
   oWnd := QMainWindow()
   oWnd:SetFixedSize( 400, 300 )
   oWnd:setWindowTitle( "Finestra Giovanni" )

   oDate := QDateEdit( oWnd )
   oDate:resize( 200, 30 )
   oDate:move( 50, 50 )
   oDate:Connect( "dateChanged(QDate)" , { |x|oText:setText( CDOW(CToD(oDate:text(x ) ) ) ) } )

   oText := QLabel( oWnd )
   oText:setText( "Change the date" )
   oText:resize( 200, 30 )
   oText:move( 80, 100 )

   oWnd:show()
   QApplication():exec()

   return