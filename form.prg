*------------------------------------------------------------------------------
* Low Level C Routines
*------------------------------------------------------------------------------
#pragma BEGINDUMP

#include <windows.h>
#include <commctrl.h>
#include "hbapi.h"
#include "hbvm.h"
#include "hbstack.h"
#include "hbapiitm.h"
#include "hbapistr.h"

static char g_szClassName[] = "MyWindowClass";
static HINSTANCE g_hInst = NULL;

LRESULT CALLBACK WndProc (HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam)
{
  static PHB_DYNS Dyns;
  Dyns = 0;

  if ( ! Dyns )
  {
    Dyns = hb_dynsymFind( "EVENTS" );
  }

  hb_vmPushSymbol( Dyns->pSymbol );
  hb_vmPushNil();
  hb_vmPushLong( ( LONG ) hWnd );
  hb_vmPushLong( message );
  hb_vmPushLong( wParam );
  hb_vmPushLong( lParam );
  hb_vmDo( 4 );

  if ( hb_arrayGetType( &hb_stack.return, 1 ) == HB_IT_NIL )
  {
    return DefWindowProc( ( HWND ) hWnd, message, wParam, lParam );
  }
  else
  {
    return 0;
  }
}

HB_FUNC ( EXITPROCESS )
   {
  ExitProcess(0);
   }
HB_FUNC ( LISTVIEW_GETFIRSTITEM )
   {
  hb_retni ( ListView_GetNextItem( (HWND) hb_parnl( 1 )  , -1 ,LVNI_ALL | LVNI_SELECTED) + 1);
   }

HB_FUNC ( INITGUI )
{

  WNDCLASSEX WndClass;
  HANDLE hInstance = GetModuleHandle( NULL );

  g_hInst = hInstance;

  WndClass.cbSize        = sizeof(WNDCLASSEX);
  WndClass.style         =  CS_HREDRAW | CS_VREDRAW | CS_OWNDC;
  WndClass.lpfnWndProc   = WndProc;
  WndClass.cbClsExtra    = 0;
  WndClass.cbWndExtra    = 0;
  WndClass.hInstance     = g_hInst;
  WndClass.hIcon         = LoadIcon(NULL, IDI_APPLICATION);
  WndClass.hCursor       = LoadCursor(NULL, IDC_ARROW);
  WndClass.hbrBackground = (HBRUSH)( COLOR_BTNFACE + 1 );
  WndClass.lpszMenuName  = NULL;
  WndClass.lpszClassName = g_szClassName;
  WndClass.hIconSm       = LoadIcon(NULL, IDI_APPLICATION);

  if(!RegisterClassEx(&WndClass))
  {
  MessageBox(0, "Window Registration Failed!", "Error!",
  MB_ICONEXCLAMATION | MB_OK | MB_SYSTEMMODAL);
  return;
  }

}

HB_FUNC ( INITTOPMOSTFORM )
{

  HWND hwnd;
  int Style;

  Style = WS_MINIMIZEBOX |
    WS_SIZEBOX     |
    WS_CAPTION     |
    WS_MAXIMIZEBOX |
    WS_POPUP       |
    WS_SYSMENU;

  hwnd = CreateWindowEx(WS_EX_TOPMOST , g_szClassName,hb_parc(1),
  Style,
  hb_parni(2),
  hb_parni(3),
  hb_parni(4),
  hb_parni(5),
  NULL,(HMENU)NULL, g_hInst ,NULL);

  if(hwnd == NULL)
  {
  MessageBox(0, "Window Creation Failed!", "Error!",
  MB_ICONEXCLAMATION | MB_OK | MB_SYSTEMMODAL);
  return;
  }

  hb_retnl ((LONG)hwnd);

}

HB_FUNC ( INITFORM )
{

  HWND hwnd;
  int Style;

  Style = WS_MINIMIZEBOX |
    WS_SIZEBOX     |
    WS_CAPTION     |
    WS_MAXIMIZEBOX |
    WS_POPUP       |
    WS_SYSMENU;

  hwnd = CreateWindow(  g_szClassName,hb_parc(1),
  Style,
  hb_parni(2),
  hb_parni(3),
  hb_parni(4),
  hb_parni(5),
  NULL,(HMENU)NULL, g_hInst ,NULL);

  if(hwnd == NULL)
  {
  MessageBox(0, "Window Creation Failed!", "Error!",
  MB_ICONEXCLAMATION | MB_OK | MB_SYSTEMMODAL);
  return;
  }

  hb_retnl ((LONG)hwnd);

}

HB_FUNC ( INITMODALDIALOG )
{

  HWND parent;
  HWND hwnd;
  int Style;

  parent = (HWND) hb_parnl (6);

  Style = WS_CAPTION	|
    WS_SYSMENU ;

  hwnd = CreateWindow( g_szClassName,hb_parc(1),
  Style,
  hb_parni(2),
  hb_parni(3),
  hb_parni(4),
  hb_parni(5),
  parent,(HMENU)NULL, g_hInst ,NULL);

  if(hwnd == NULL)
  {
  MessageBox(0, "Window Creation Failed!", "Error!",
  MB_ICONEXCLAMATION | MB_OK | MB_SYSTEMMODAL);
  return;
  }

  hb_retnl ((LONG)hwnd);

}

HB_FUNC ( ACTIVATEFORM )
{

  HWND hwnd;
  MSG Msg;

  hwnd = (HWND) hb_parnl (1);

  ShowWindow(hwnd, 1);

  while(GetMessage(&Msg,NULL,0,0) )
  {

  if(!IsWindow(GetActiveWindow()) ||
  !IsDialogMessage(GetActiveWindow(),&Msg))
    {
    TranslateMessage(&Msg);
    DispatchMessage(&Msg);
    }
  }
       
  return;

}

HB_FUNC ( CSHOWCONTROL )
{

  HWND hwnd;
  MSG Msg;

  hwnd = (HWND) hb_parnl (1);

  ShowWindow(hwnd, SW_SHOW);

  return ;
}

HB_FUNC (MAXIMIZE)
{
  ShowWindow((HWND) hb_parnl( 1 ), SW_MAXIMIZE);
}

HB_FUNC (MINIMIZE)
{
  ShowWindow((HWND) hb_parnl( 1 ), SW_MINIMIZE);
}

HB_FUNC (RESTORE)
{
  ShowWindow( (HWND) hb_parnl( 1 ),SW_RESTORE);
}

HB_FUNC ( CHIDECONTROL )
{

  HWND hwnd;
  MSG Msg;

  hwnd = (HWND) hb_parnl (1);

  ShowWindow(hwnd, SW_HIDE);

  return ;
}

HB_FUNC( INITBUTTON )
{
  
  HWND hwnd;
  HWND hbutton;

  hwnd = (HWND) hb_parnl (1);
  
  hbutton = CreateWindow( "button" , hb_parc(2) ,
  WS_CHILD | WS_VISIBLE | BS_PUSHBUTTON | WS_TABSTOP ,
  hb_parni(4), hb_parni(5) ,hb_parni(6) ,hb_parni(7) ,
  hwnd,(HMENU)hb_parni(3) , GetModuleHandle(NULL) , NULL ) ;

  hb_retnl ( (LONG) hbutton );

}

HB_FUNC( INITLABEL )
{
  
  HWND hwnd;
  HWND hbutton;

  hwnd = (HWND) hb_parnl (1);
  
  hbutton = CreateWindow( "static" , hb_parc(2) ,
  WS_CHILD | WS_VISIBLE | BS_PUSHBUTTON ,
  hb_parni(4), hb_parni(5) , hb_parni(6), 28,
  hwnd,(HMENU)hb_parni(3) , GetModuleHandle(NULL) , NULL ) ;

  hb_retnl ( (LONG) hbutton );

}

HB_FUNC( INITCHECKBOX )
{
  
  HWND hwnd;
  HWND hbutton;

  hwnd = (HWND) hb_parnl (1);
  
  hbutton = CreateWindow( "button" , hb_parc(2) ,
  WS_CHILD | WS_VISIBLE | BS_AUTOCHECKBOX | WS_TABSTOP ,
  hb_parni(4), hb_parni(5) , 100, 28,
  hwnd,(HMENU)hb_parni(3) , GetModuleHandle(NULL) , NULL ) ;

  hb_retnl ( (LONG) hbutton );

}

HB_FUNC( INITGROUPBOX )
{
  
  HWND hwnd;
  HWND hbutton;

  hwnd = (HWND) hb_parnl (1);
  
  hbutton = CreateWindow( "button" , hb_parc(2) ,
  WS_CHILD | WS_VISIBLE | BS_GROUPBOX ,
  hb_parni(4), hb_parni(5) , hb_parni(6), hb_parni(7),
  hwnd,(HMENU)hb_parni(3) , GetModuleHandle(NULL) , NULL ) ;

  hb_retnl ( (LONG) hbutton );

}

HB_FUNC( INITRADIOGROUP )
{
  
  HWND hwnd;
  HWND hbutton;

  hwnd = (HWND) hb_parnl (1);
  
  hbutton = CreateWindow( "button" , hb_parc(2) ,
  WS_CHILD | WS_VISIBLE | BS_AUTORADIOBUTTON | WS_TABSTOP | WS_GROUP ,
  hb_parni(4), hb_parni(5) , 100, 28,
  hwnd,(HMENU)hb_parni(3) , GetModuleHandle(NULL) , NULL ) ;

  hb_retnl ( (LONG) hbutton );

}

HB_FUNC( INITRADIOBUTTON )
{
  
  HWND hwnd;
  HWND hbutton;

  hwnd = (HWND) hb_parnl (1);
  
  hbutton = CreateWindow( "button" , hb_parc(2) ,
  WS_CHILD | WS_VISIBLE | BS_AUTORADIOBUTTON | WS_TABSTOP ,
  hb_parni(4), hb_parni(5) , 100, 28,
  hwnd,(HMENU)hb_parni(3) , GetModuleHandle(NULL) , NULL ) ;

  hb_retnl ( (LONG) hbutton );

}

HB_FUNC( INITCOMBOBOX )
{
  
  HWND hwnd;
  HWND hbutton;

  hwnd = (HWND) hb_parnl (1);
  
  hbutton = CreateWindow( "COMBOBOX" , "" ,
  WS_CHILD | WS_VISIBLE | CBS_DROPDOWNLIST | WS_TABSTOP ,
  hb_parni(3), hb_parni(4) , hb_parni(5), 150 , 
  hwnd,(HMENU)hb_parni(2) , GetModuleHandle(NULL) , NULL ) ;

  hb_retnl ( (LONG) hbutton );

}

HB_FUNC( INITLISTBOX )
{
  
  HWND hwnd;
  HWND hbutton;

  hwnd = (HWND) hb_parnl (1);
  
  hbutton = CreateWindowEx( WS_EX_CLIENTEDGE, "LISTBOX" , "" ,
  WS_CHILD | WS_VISIBLE | WS_TABSTOP | WS_VSCROLL | LBS_DISABLENOSCROLL,
  hb_parni(3), hb_parni(4) , hb_parni(5), hb_parni(6) ,  
  hwnd,(HMENU)hb_parni(2) , GetModuleHandle(NULL) , NULL ) ;

  hb_retnl ( (LONG) hbutton );

}

HB_FUNC( INITTEXTBOX )
{
  
  HWND hwnd;
  HWND hbutton;

  hwnd = (HWND) hb_parnl (1);
  
  hbutton = CreateWindowEx( WS_EX_CLIENTEDGE, "EDIT" , "" ,
  WS_CHILD | WS_VISIBLE | WS_TABSTOP | ES_AUTOHSCROLL,
  hb_parni(3), hb_parni(4) , hb_parni(5) , 25 ,  
  hwnd,(HMENU)hb_parni(2) , GetModuleHandle(NULL) , NULL ) ;

  hb_retnl ( (LONG) hbutton );

}

HB_FUNC( INITEDITBOX )
{
  
  HWND hwnd;
  HWND hbutton;

  hwnd = (HWND) hb_parnl (1);
  
  hbutton = CreateWindowEx( WS_EX_CLIENTEDGE, "EDIT" , "" ,
  ES_WANTreturn | WS_CHILD | WS_VISIBLE | WS_TABSTOP | ES_MULTILINE | WS_VSCROLL | WS_HSCROLL | ES_AUTOHSCROLL,
  hb_parni(3), hb_parni(4) , hb_parni(5), hb_parni(6) ,  
  hwnd,(HMENU)hb_parni(2) , GetModuleHandle(NULL) , NULL ) ;

  hb_retnl ( (LONG) hbutton );

}

HB_FUNC( SETACTIVEWINDOW )
{
  
  HWND hwnd;

  hwnd = (HWND) hb_parnl (1);

  SetActiveWindow (hwnd);

}

HB_FUNC (INITLISTVIEW)
{

  HWND hwnd;
  HWND hbutton;

  hwnd = (HWND) hb_parnl (1);

  hbutton = CreateWindowEx(WS_EX_CLIENTEDGE,"SysListView32","",
  LVS_SINGLESEL | LVS_SHOWSELALWAYS | WS_CHILD | WS_TABSTOP | WS_VISIBLE | WS_BORDER | LVS_REPORT,
  hb_parni(3), hb_parni(4) , hb_parni(5), hb_parni(6) ,  
  hwnd,(HMENU)hb_parni(2) , GetModuleHandle(NULL) , NULL ) ;

  ImageList_LoadBitmap(GetModuleHandle(NULL),  0, 16, 1, RGB(255,255,255));
  SendMessage(hbutton,LVM_SETEXTENDEDLISTVIEWSTYLE, 0,LVS_EX_GRIDLINES | LVS_EX_FULLROWSELECT | LVS_EX_HEADERDRAGDROP );

  hb_retnl ( (LONG) hbutton );

}

//-----------------------------------------------------------------------------
// MsgBox ( cText , cTitle )
//-----------------------------------------------------------------------------
HB_FUNC( MSGBOX )
{
   MessageBox( 0, hb_parc( 1 ), hb_parc( 2 ), MB_SYSTEMMODAL );
}

HB_FUNC( POSTQUITMESSAGE )
{
   PostQuitMessage( hb_parnl( 1 ) );
}

HB_FUNC ( INITLISTVIEWCOLUMNS )
  {

  PHB_ITEM wArray;
  PHB_ITEM hArray;
  char *caption;
  HWND hc;
  LV_COLUMN COL;
  int l9;
  int s;
  int vi;

  hc = (HWND) hb_parnl( 1 ) ;

  l9 = hb_parinfa( 2, 0 ) - 1 ;
  hArray = hb_param( 2, HB_IT_ARRAY );
  wArray = hb_param( 3, HB_IT_ARRAY );

  COL.mask=LVCF_FMT | LVCF_WIDTH | LVCF_TEXT |LVCF_SUBITEM;
  COL.fmt=LVCFMT_LEFT;

  for (s = 0 ; s<=l9 ; s=s+1 )
    {

    caption	= hb_itemGetCPtr ( hArray->item.asArray.value->pItems + s );
    vi = hb_itemGetNI   ( wArray->item.asArray.value->pItems + s );		

    COL.cx=vi;
    COL.pszText=caption;
    COL.iSubItem=s;
    ListView_InsertColumn(hc,s,&COL);

    }

  }

HB_FUNC ( ADDLISTVIEWITEMS )
  {

  PHB_ITEM hArray;
  char *caption;
  LV_ITEM LI;
  HWND h;
  int l;
  int s;
  int c;

  h = (HWND) hb_parnl( 1 ) ;
  l = hb_parinfa( 2, 0 ) - 1 ;
  hArray = hb_param( 2, HB_IT_ARRAY );
  c = ListView_GetItemCount (h);
  caption	= hb_itemGetCPtr ( hArray->item.asArray.value->pItems );

  LI.mask=LVif_TEXT ;
  LI.state=0;
  LI.stateMask=0;
        LI.iImage=0;
        LI.iSubItem=0;
  LI.iItem=c; 
  LI.pszText=caption;
  ListView_InsertItem(h,&LI);

  for (s = 1 ; s<=l ; s=s+1 )
    {

    caption	= hb_itemGetCPtr ( hArray->item.asArray.value->pItems + s );
    ListView_SetItemText(h,c,s,caption);

    }

} 

HB_FUNC( INITTABCONTROL )
{

  PHB_ITEM hArray;	
  HWND hwnd;
  HWND hbutton;
  TC_ITEM tie; 
  int l;
  int i;

  l = hb_parinfa( 7, 0 ) - 1 ;
  hArray = hb_param( 7, HB_IT_ARRAY );

  hwnd = (HWND) hb_parnl (1);
  
  hbutton = CreateWindow( WC_TABCONTROL , NULL ,
  WS_CHILD | WS_VISIBLE | BS_PUSHBUTTON | WS_TABSTOP ,
  hb_parni(3), hb_parni(4) , hb_parni(5), hb_parni(6) ,
  hwnd,(HMENU)hb_parni(2) , GetModuleHandle(NULL) , NULL ) ;

  tie.mask = TCif_TEXT | TCif_IMAGE; 
  tie.iImage = -1; 

  for (i = l ; i>=0 ; i=i-1 )
    {
    tie.pszText = hb_itemGetCPtr ( hArray->item.asArray.value->pItems + i );
    TabCtrl_InsertItem(hbutton, 0, &tie); 
    }

  TabCtrl_SetCurSel( hbutton , hb_parni(8) - 1 );

  hb_retnl ( (LONG) hbutton );

}

HB_FUNC (TABCTRL_SETCURSEL)
{

  HWND hwnd;
  int s;

  hwnd = (HWND) hb_parnl (1);

  s = hb_parni (2);

  TabCtrl_SetCurSel( hwnd , s-1 );

}

HB_FUNC (TABCTRL_GETCURSEL)
{

  HWND hwnd;
  hwnd = (HWND) hb_parnl (1);
  hb_retni ( TabCtrl_GetCurSel( hwnd ) + 1 ) ;

}

HB_FUNC (INITIMAGE)
{
  HWND  h;
  HBITMAP hBitmap;
  HWND hwnd;

  hwnd = (HWND) hb_parnl (1);

  h = CreateWindowEx(0,"static",NULL,
  WS_CHILD | WS_VISIBLE | SS_BITMAP ,
  hb_parni(3), hb_parni(4), 0, 0,
  hwnd,(HMENU)hb_parni(2) , GetModuleHandle(NULL) , NULL ) ;

  hBitmap=LoadImage(0,hb_parc(5),IMAGE_BITMAP,0,0,LR_LOADFROMFILE|LR_CREATEDIBSECTION);

  SendMessage(h,(UINT)STM_SETIMAGE,(WPARAM)IMAGE_BITMAP,(LPARAM)hBitmap);

  hb_retnl ( (LONG) h );

}

HB_FUNC( HIWORD )
{
   hb_retnl( HIWORD( hb_parnl( 1 ) ) );
}
HB_FUNC( LOWORD )
{
   hb_retnl( LOWORD( hb_parnl( 1 ) ) );
}

HB_FUNC ( DESTROYWINDOW )
{
   DestroyWindow( (HWND) hb_parnl( 1 ) );
}
//-----------------------------------------------------------------------------
// MsgInfo ( cText , cTitle )
//-----------------------------------------------------------------------------
HB_FUNC( MSGINFO )
{
   MessageBox( 0, hb_parc(1) , hb_parc(2) , MB_OK | MB_ICONINFORMATION | MB_SYSTEMMODAL);
}
//-----------------------------------------------------------------------------
// MsgStop ( cText , cTitle )
//-----------------------------------------------------------------------------
HB_FUNC( MSGSTOP )
{
   MessageBox( 0 , hb_parc(1) , hb_parc(2) , MB_OK | MB_ICONSTOP | MB_SYSTEMMODAL);
}
//-----------------------------------------------------------------------------
// MsgExclamation ( cText , cTitle )
//-----------------------------------------------------------------------------
HB_FUNC( MSGEXCLAMATION )
{
      MessageBox(0, hb_parc(1), hb_parc(2),
         MB_ICONEXCLAMATION | MB_OK | MB_SYSTEMMODAL);
      return;
}

HB_FUNC( INITMENU )
{

  PHB_ITEM pMenu;
  HMENU hMenu, hSubMenu;
  int i;
  char *caption;
  char *vc;
  int vi ;
  int l2;
  HWND hwnd;

  hwnd = (HWND) hb_parnl (1);

  l2 = hb_parinfa( 2, 0 ) - 1 ;
  pMenu = hb_param( 2, HB_IT_ARRAY );

  hMenu = CreateMenu();

  hSubMenu = CreatePopupMenu();

  for (i = 0 ; i<=l2 ; i=i+1 )
    {

    caption	= hb_itemGetCPtr ( pMenu->item.asArray.value->pItems + i );

    if ( strcmp ( caption , "!" ) == 0 )
      {
                        
      vc = hb_itemGetCPtr ( pMenu->item.asArray.value->pItems + i + 1);
      vi = hb_itemGetNI   ( pMenu->item.asArray.value->pItems + i + 2 );		

        if ( strcmp ( vc , "-" ) == 0 )
        {
        AppendMenu ( hSubMenu ,MF_SEPARATOR , 0 , NULL ) ;
        }
        else
        {
        AppendMenu ( hSubMenu , MF_STRING, vi , vc ) ;
              }

      }

    if ( strcmp ( caption , "#" ) == 0 )
      {
      vc = hb_itemGetCPtr ( pMenu->item.asArray.value->pItems + i + 1);
      AppendMenu(hMenu, MF_STRING | MF_POPUP, (UINT)hSubMenu, vc );

                	hSubMenu = CreatePopupMenu();
      }
    }

  SetMenu(hwnd, hMenu);

}

HB_FUNC (ENABLEWINDOW)
{
  HWND hwnd;
  hwnd = (HWND) hb_parnl (1);
  EnableWindow( hwnd , TRUE );	 
}
HB_FUNC (DISABLEWINDOW)
{
  HWND hwnd;
  hwnd = (HWND) hb_parnl (1);
  EnableWindow( hwnd , FALSE );	
}
HB_FUNC (SETFOREGROUNDWINDOW)
{
  HWND hwnd;
  hwnd = (HWND) hb_parnl (1);
  SetForegroundWindow( hwnd );	
}

HB_FUNC (GETFOREGROUNDWINDOW)
{
  HWND x;

  x = GetForegroundWindow() ;
  hb_retnl ((LONG) x );
}

HB_FUNC (GETNEXTWINDOW)
{

  HWND hwnd;
  HWND x;

  hwnd = (HWND) hb_parnl (1);

  x = GetWindow( hwnd, GW_HWNDNEXT	 );

  hb_retnl ((LONG) x );

}

HB_FUNC ( CHECKDLGBUTTON )
{
  CheckDlgButton(
  (HWND) hb_parnl (2),	// handle of dialog box
  hb_parni(1),	// identifier of control
  BST_CHECKED );	// value to set
}

HB_FUNC ( UNCHECKDLGBUTTON )
{
  CheckDlgButton(
  (HWND) hb_parnl (2),	// handle of dialog box
  hb_parni(1),	// identifier of control
  BST_UNCHECKED );	// value to set
}
//-----------------------------------------------------------------------------*
//ComboAddString ( nControlHwnd , cString )
//-----------------------------------------------------------------------------*
HB_FUNC ( COMBOADDSTRING )
{
   char *cString = hb_parc( 2 );
   SendMessage( (HWND) hb_parnl( 1 ), CB_ADDSTRING, 0, (LPARAM) cString );
}
//-----------------------------------------------------------------------------
// ComboSetCurSel ( hwnd,row )
//-----------------------------------------------------------------------------
HB_FUNC ( COMBOSETCURSEL )
{
   SendMessage( (HWND) hb_parnl( 1 ), CB_SETCURSEL, (WPARAM) hb_parni(2)-1, 0);
}
//-----------------------------------------------------------------------------
// ListBoxAddString ( nControlHwnd , cString )
//-----------------------------------------------------------------------------
HB_FUNC ( LISTBOXADDSTRING )
{
   char *cString = hb_parc( 2 );
   SendMessage( (HWND) hb_parnl( 1 ), LB_ADDSTRING, 0, (LPARAM) cString );
}
//-----------------------------------------------------------------------------
// ListBoxSetCurSel ( nControlID )
//-----------------------------------------------------------------------------
HB_FUNC ( LISTBOXSETCURSEL )
{
   SendMessage( (HWND) hb_parnl( 1 ), LB_SETCURSEL, (WPARAM) hb_parni(2)-1, 0);
}
HB_FUNC ( SETDLGITEMTEXT )
{
    SetDlgItemText(
       (HWND) hb_parnl (3) ,	// handle of dialog box
       hb_parni( 1 ),	        // identifier of control
       (LPCTSTR) hb_parc( 2 ) 	// text to set
    );
}


HB_FUNC (CENTER) 
{
 RECT rect;
 int width, height, xres, yres;
 GetWindowRect((HWND) hb_parnl (1), &rect);
 width  = rect.right  - rect.left;
 height = rect.bottom - rect.top;
 xres = GetSystemMetrics(SM_CXSCREEN);
 yres = GetSystemMetrics(SM_CYSCREEN);
 SetWindowPos((HWND) hb_parnl (1), HWND_TOP, (xres - width) / 2,
 (yres - height) / 2, 0, 0, SWP_NOSIZE);
}

HB_FUNC (LISTVIEW_SETCURSEL) 
{
  ListView_SetItemState((HWND) hb_parnl (1), (WPARAM) hb_parni(2)-1 ,LVIS_FOCUSED | LVIS_SELECTED , LVIS_FOCUSED | LVIS_SELECTED );
}

HB_FUNC ( C_SETFOCUS )
{
   hb_retnl( (LONG) SetFocus( (HWND) hb_parnl( 1 ) ) );
}

HB_FUNC ( GETDLGITEMTEXT )
{
   USHORT iLen = 32768;
   char *cText = (char*) hb_xgrab( iLen+1 );

  GetDlgItemText(
  (HWND) hb_parnl (2),	// handle of dialog box
  hb_parni(1),		// identifier of control
  (LPTSTR) cText,       	// address of buffer for text
  iLen                   	// maximum size of string
  );	

   hb_retc( cText );
   hb_xfree( cText );
}
//-----------------------------------------------------------------------------
// IsDlgButtonChecked ( nTextBoxID )
//-----------------------------------------------------------------------------
HB_FUNC ( ISDLGBUTTONCHECKED )
{
  UINT nRes = IsDlgButtonChecked(
                  (HWND) hb_parnl (2), // handle of dialog box
                   hb_parni( 1 )      // button identifier
              );
  if( nRes == BST_CHECKED )
     hb_retl( TRUE );
  else
     hb_retl( FALSE );
}

//-----------------------------------------------------------------------------
// ComboGetCurSel ( nControlHandle )
//-----------------------------------------------------------------------------
HB_FUNC ( COMBOGETCURSEL )
{
hb_retni ( SendMessage( (HWND) hb_parnl( 1 ) , CB_GETCURSEL , 0 , 0 )  + 1 );
}	

//-----------------------------------------------------------------------------
// ListBoxGetCurSel ( nControlHandle )
//-----------------------------------------------------------------------------
HB_FUNC ( LISTBOXGETCURSEL )
{
hb_retni ( SendMessage( (HWND) hb_parnl( 1 ) , LB_GETCURSEL , 0 , 0 )  + 1 );
}	
//-----------------------------------------------------------------------------
// ComboBoxDeleteString ( hwnd , Index )
//-----------------------------------------------------------------------------
HB_FUNC (COMBOBOXDELETESTRING )
{
   SendMessage( (HWND) hb_parnl( 1 ), CB_DELETESTRING, (WPARAM) hb_parni(2)-1, 0);
}
//-----------------------------------------------------------------------------
// ListBoxDeleteString ( hwnd , Index )
//-----------------------------------------------------------------------------
HB_FUNC ( LISTBOXDELETESTRING )
{
   SendMessage( (HWND) hb_parnl( 1 ), LB_DELETESTRING, (WPARAM) hb_parni(2)-1, 0);
}
//-----------------------------------------------------------------------------
// ListViewDeleteString ( hwnd , Index )
//-----------------------------------------------------------------------------
HB_FUNC ( LISTVIEWDELETESTRING )
{
   SendMessage( (HWND) hb_parnl( 1 ),LVM_DELETEITEM , (WPARAM) hb_parni(2)-1, 0);
}

//-----------------------------------------------------------------------------
// ListBoxReset ( nControlHwnd )
//-----------------------------------------------------------------------------
HB_FUNC ( LISTBOXRESET )
{
   SendMessage( (HWND) hb_parnl( 1 ), LB_RESETCONTENT, 0, 0 );
}

//-----------------------------------------------------------------------------
// ListViewReset ( nControlHwnd )
//-----------------------------------------------------------------------------
HB_FUNC ( LISTVIEWRESET )
{
   SendMessage( (HWND) hb_parnl( 1 ), LVM_DELETEALLITEMS , 0, 0 );
}

//-----------------------------------------------------------------------------
// ComboBoxReset ( nControlHwnd )
//-----------------------------------------------------------------------------
HB_FUNC ( COMBOBOXRESET )
{
   SendMessage( (HWND) hb_parnl( 1 ), CB_RESETCONTENT, 0, 0 );
}

HB_FUNC ( SENDMESSAGE )
{
  hb_retnl( (LONG) SendMessage( (HWND) hb_parnl( 1 ), (UINT) hb_parni( 2 ), (WPARAM) hb_parnl( 3 ), (LPARAM) hb_parnl( 4 ) ) );
}

#pragma ENDDUMP