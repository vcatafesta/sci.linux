#include <sci.ch>

SET BLOCO TO {|x,y|
					puts(qout(xtrim("   Bloco    ")))
					puts x
					puts y
					return x
					}, 1, 2

XBLOCO([1,2], {|x,y|
					puts(qout(xtrim("   Bloco    ")))
					puts x
					puts y
					return x
					})

x_eval(1,2, {|x,y|
					puts(qout(xtrim("   Bloco    ")))
					puts x
					puts y
					return x
					})

