f/*****
 *
 *   Application: General Purpose Routine
 *   Description: Handles cursor keys on TBrowse
 *     File Name: BROWMOVE.PRG
 *        Author: Luiz Quintela
 *  Date created: 12-29-92
 *     Copyright: 1992 by Computer Associates
 *
 */

#include "inkey.ch"

/*****
 *
 *         Name: TBMoveCursor()
 *  Description: Moves cursor on a TBrowse object
 *       Author: Luiz Quintela
 * Date created: 12-29-92
 *    Copyright: Computer Associates
 *
 *    Arguments: nKey  - Key code
 *             : oBrow - TBrowse object                                                     ³
 * return Value: .T.   - Key was handled by function, .F. otherwise
 *
 */

FUNCTION TBMoveCursor( nKey, oBrow )
   LOCAL nFound
   STATIC aKeys := ;
       { K_DOWN      , {|obj| obj:down()}    ,;
         K_UP        , {|obj| obj:up()}      ,;
         K_PGDN      , {|obj| obj:pageDown()},;
         K_PGUP      , {|obj| obj:pageUp()}  ,;
         K_CTRL_PGUP , {|obj| obj:goTop()}   ,;
         K_CTRL_PGDN , {|obj| obj:goBottom()},;
         K_RIGHT     , {|obj| obj:right()}   ,;
         K_LEFT      , {|obj| obj:left()}    ,;
         K_HOME      , {|obj| obj:home()}    ,;
         K_END       , {|obj| obj:end()}     ,;
         K_CTRL_LEFT , {|obj| obj:panLeft()} ,;
         K_CTRL_RIGHT, {|obj| obj:panRight()},;
         K_CTRL_HOME , {|obj| obj:panHome()} ,;
         K_CTRL_END  , {|obj| obj:panEnd()}   }

   nFound := AScan( aKeys, nKey )
   if (nFound != 0)
      Eval( aKeys[++nFound], oBrow )

   endif
   return (nFound != 0)

// EOF - BROWMOVE.PRG //
