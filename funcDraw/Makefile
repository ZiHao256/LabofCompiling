test:
	bison --yacc -dv parser.y
	flex -i scanner.l
	g++ -o test y.tab.c lex.yy.c