Function main()
	vc_for()
   inkey(0)
	//vc_len({1,2,3})
	//for i := 65 to 127
	//	?? vc_chr(i)
	//next	
	//msg("Tecle algo para iniciar", "Macrosoft SCI for Windows", 2)
	ms_cls(31, "²±²")   
   inkey(0)
	
	///dbcreate("TEST.DBF", {{"AUTO", "+", 4, 0}, {"ALL","V", 255, 0}, {"CURRENCY", "Y", 8, 4}})
	//use test shared new
  	//a := dbstruct()
	
	//? vc_printf("%0d %s %s %s %s", {10, "VILMAR", NIL, NIL, "EVILI"})
	//? vc_printf("Result: %s %s %d", {"VILMAR", "EVILI", 2})
	
		
	
#pragma BEGINDUMP
	#include "hbdefs.h"
	#include "hbapi.h"
	#include "hbapigt.h"
	#include "hbapiitm.h"
	#include "hbapistr.h"
	#include "hbapierr.h"
	#include "hbapicdp.h"	
	#include <iostream>
	#include <vector>
	#ifndef __GNUC__
	#include <windows.h>
	#endif
	using namespace std;
	
	char *replicate(char *str, int vezes);
	namespace Array {
    enum Type  {
        Type1T,
        Type2T,
    };

    class ExtandType {
        public:
            virtual Type GetType() = 0;
            virtual ~ExtandType() {} 
    };

    class Type1 : public ExtandType  {
        public:
            Type GetType() { return Type1T;}

            int a;
            string b;
            double c;
    }; 

    class Type2 : public ExtandType  {
        public:
            Type GetType() { return Type2T;}

            int a;
            string b;
            string c;
            double d; // whatever you want
    };
	}
	
	/* 
	 * vsprintf example code
	 * http://code-reference.com/c/stdio.h/vsprintf 
	 */
	 
	#include <stdio.h> /* including standard library */
	#ifndef __GNUC__
	#include <windows.h>
	#endif
	#include <stdarg.h>
	
	int myprintf( char const * format, ... )
	{
	  va_list args;
	  char buffer[200];
	 
	  va_start( args, format );
	  vsprintf( buffer, format, args );
	  va_end( args );
	 
	  return printf("vsprintf example : %s", buffer);
	}
	 
	int testvsprintf(void)
	{
	  char string[] ="Hello";
	 
		myprintf( " %s World\n", string);
	 
		return 0;
	}
	
	HB_FUNC(MSG)
	{
		//MessageBox( GetActiveWindow(), hb_parc(1), hb_parc(2), 0 );		
	}
		
	HB_FUNC( VC_PRINTF)
	{
		PHB_ITEM pArray = hb_param( 2, HB_IT_ARRAY);
		//HB_SIZE itam    = hb_parinfa( 2, 0 );
		HB_SIZE nlen    = hb_arrayLen(pArray ); /* retrieves the array len */
		HB_TYPE xType; 
		HB_SIZE nIndex;
		const char *format = hb_parc(1);
		const char *varc = NULL;
		const char *argc[100];
		int argi[100];
		char buffer[50];
		int varn = 0;
		int n;
		
		vector<Array::ExtandType*>  x;
		vector<const char*> argchar;
		vector<double> argint;	
		
		if(pArray){
			if(HB_IS_ARRAY( pArray))
			{
				for(nIndex = 1; nIndex <= nlen; nIndex++)
				{
					xType = hb_arrayGetType( pArray, nIndex ); /* retrieves the type of an array item */	
					if( xType == HB_IT_STRING )
					{
						varc = hb_arrayGetCPtr(pArray,nIndex );	
						argc[nIndex-1] = varc;	
						argchar.push_back(varc);	
						
					}
					else if( xType == HB_IT_INTEGER )
					{				
						varn = hb_arrayGetND(pArray,nIndex );
						argi[nIndex-1] = varn;					
						argint.push_back(varn);						
					}					
					else if( xType == HB_IT_NIL )
					{				
						argc[nIndex-1] = "\0";		
						argchar.push_back("\0");							
					}										
				}
			}		
		}
		
		//vsprintf( buffer, format, argchar );
		//sprintf( buffer, format, argchar);
		//printf("%s", buffer);							
		
		//cout << argi[0] << endl;							
		//cout << argchar[0] << endl;							
		//system("pause");
		
		n = sprintf( buffer, format, argi[0], argchar[0], argchar[3], argchar[3], argchar[3]);
		if(!buffer || !n){
			hb_errRT_BASE_SubstR( EG_ARG, 1111, NULL, HB_ERR_FUNCNAME, HB_ERR_ARGS_BASEPARAMS );
			hb_ret();
			return;
		}
		*argc = NULL;		
		hb_retc(buffer);
		return;
	}	
#pragma ENDDUMP	

#pragma BEGINDUMP
	HB_FUNC( VC_CHR )
	{	
		int n = hb_parni(1);
		char *ch = (char *)malloc(sizeof(char));
		ch[1]    = '\0';
		memset(ch, n, 1);			
		// sprintf(ch, "%c", (char) n);
		// sprintf(ch, "%c", n);
		hb_retc(ch);		
	}
#pragma ENDDUMP	

#pragma BEGINDUMP

char *replicate(char *str, int vezes)
{
   int lenstr = (int) strlen(str);
   int tam = lenstr * vezes;
   //char *ptr  = (char*)malloc(tam+1);
   char *ptr = (char*) malloc(tam * sizeof (char *));

   /*
   cout << "====================================" << endl;
   cout << "lenstr: " << lenstr << endl;
   cout << "tam   : " << tam << endl;
   cout << "str #1: " << str[0] <<endl;
   cout << "str #1: " << str[1] <<endl;
   cout << "str #1: " << str <<endl;
   cout << "str #2: " << (char*)str <<endl;
   cout << "ptr   : " << ptr <<endl;
   cout << "strlen ptr :" << strlen(ptr) <<endl;

    */

   int x;
   int y;
   for (x = 0; x < tam;)
      for (y = 0; y < lenstr; y++, x++) {
         ptr[x] = str[y];
      }
   return (ptr);
}
#pragma ENDDUMP		

#pragma BEGINDUMP
	#include "hbdefs.h"
	#include "hbapi.h"
	#include "hbapigt.h"
	#include <iostream>
	#ifndef __GNUC__
	#include <windows.h>
	#endif
	using namespace std;

	HB_FUNC( VC_FOR )
	{
		//char *pItem = "Hello World from C";
		char pItem[] = "Hello World from C";		
		int n;
		for( n=0; n <= 10; ++n )			
			printf("%s %i\n", pItem, n);				
		hb_retc_null();
	}
#pragma ENDDUMP

#pragma BEGINDUMP	
	#include "hbapi.h"
	#include "hbapierr.h"
	#include "hbapiitm.h"
	#include "hbapicdp.h"
	
	HB_FUNC( VC_LEN )
	{
		PHB_ITEM pItem = hb_param( 1, HB_IT_ANY );

		/* NOTE: Double safety to ensure that a parameter was really passed,
					compiler checks this, but a direct hb_vmDo() call
					may not do so. [vszakats] */

		if( pItem )
		{
			if( HB_IS_STRING( pItem ) )
			{
				HB_SIZE nLen = hb_itemGetCLen( pItem );
				PHB_CODEPAGE cdp = hb_vmCDP();
				if( HB_CDP_ISCHARIDX( cdp ) )
					nLen = hb_cdpTextLen( cdp, hb_itemGetCPtr( pItem ), nLen );
				hb_retns( nLen );
				return;
			}
			else if( HB_IS_ARRAY( pItem ) )
			{
				hb_retns( hb_arrayLen( pItem ) );
				return;
			}
			else if( HB_IS_HASH( pItem ) )
			{
				hb_retns( hb_hashLen( pItem ) );
				return;
			}
		}

		hb_errRT_BASE_SubstR( EG_ARG, 1111, NULL, HB_ERR_FUNCNAME, HB_ERR_ARGS_BASEPARAMS );
	}

#pragma ENDDUMP


