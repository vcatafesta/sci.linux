#include "Project1.ch"

/*
 * Class TForm1
 */
class TForm1 from TForm

   public:
      method Create constructor

   public Form1

endclass

/*
 * Constructor.
 */
method Create( oOwner ) class TForm1

   Super:Create( oOwner )

   with Self
      :Caption := "Form1"
      :SetPos( 426, 240 )
      :ClientWidth := 544
      :ClientHeight := 411
      :PixelsPerInch := 96
      :TextHeight := 13
   endwith

return
