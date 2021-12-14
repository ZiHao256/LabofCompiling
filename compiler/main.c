#include"semantics.h"
#include"y.tab.c"
#include"lex.yy.c"

extern int yyparse();
extern FILE *yyin;

int main(){
    yyparse();
    return 0;
}