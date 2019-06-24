int main ()
{
  /* Heap allocated memory.  */
	char *heap1 = (char *)__builtin_malloc( 42 );
	char *heap2 = (char *)__builtin_malloc( 42 );
    if( heap1 > heap2 )
		return 1;
	return 0;
}
