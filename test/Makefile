test:
	bison --yacc -dv parser.y
	flex scanner.l
	gcc -o test y.tab.c lex.yy.c