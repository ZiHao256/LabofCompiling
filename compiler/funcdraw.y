%{

#include"semantics.h"
#define YYSTYPE struct ExprNode*;   //定义语义变量类型为树节点指针

// 初始化参数
double Parameter = 0, start=0, end=0, step=0;
double origin_x = 0.0;
double origin_y = 0.0;
double rot = 0.0;
double scale_x = 1.0;
double scale_y = 1.0;

extern int yylex(void);
extern unsigned char*yytext;
extern struct Token tokens;


%}



%token CONST_ID FUNC FOR T FROM TO STEP DRAW ORIGIN SCALE ROT IS COMMA L_BRACKET R_BRACKET SEMICO ERRTOKEN;
%left PLUS MINUS
%left MUL DIV
%right UNSUB
%right POWER
%start Program


%%
    Program: Program Statement SEMICO
            |
            ;
    
    Statement: FOR T FROM Expression TO Expression STEP Expression DRAW L_BRACKET Expression COMMA Expression R_BRACKET
                    {

                    }
            | ORIGIN IS L_BRACKET Expression COMMA Expression R_BRACKET
                    {

                    }
            | SCALE IS L_BRACKET Expression COMMA Expression R_BRACKET
                    {

                    }
            | ROT IS Expression
                    {
                        
                    }
            ;

    
    Expression: T
            | CONST_ID
            | Expression PLUS Expression
            | Expression MINUS Expression
            | Expression MUL Expression
            | Expression DIV Expression
            | Expression POWER Expression
            | L_BRACKET Expression R_BRACKET
            | PLUS Expression %prec UNSUB
            | MINUS Expression %prec UNSUB
            | FUNC L_BRACKET Expression R_BRACKET
            | ERRTOKEN
            ;


%%
    // 错误处理
void yyerror(char *str){
    fprintf(stderr,"error:%s\n",str);
}

int main(){
    yyparse();
}

    // 生成语法树的一个节点
struct ExprNode * MakeExprNode(enum Token_Type opcode, ...){
    return 0;
}

