#include"lex.yy.c"
#include"y.tab.c"
extern int yyparse();
extern FILE *yyin;

int main(){
    yyparse();
    return 0;
}