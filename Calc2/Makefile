all		:	lex.yy.c y.tab.c a.out
lex.yy.c	:	calculette.l 
			flex calculette.l 
y.tab.c		:	calculette.y lex.yy.c
			bison -y -v calculette.y
a.out		:	y.tab.c
			cc y.tab.c -ll -o calculette
clean		:	
			rm -f 	lex.yy.c y.tab.c calculette *~ y.output
