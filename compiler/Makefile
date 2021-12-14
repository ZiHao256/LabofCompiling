compiler:
	bison --yacc -dv parser.y
	flex scanner.l
	gcc -o compiler y.tab.c lex.yy.c