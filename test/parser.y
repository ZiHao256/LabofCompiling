%{

#include"main.h"

// 初始化参数
double Parameter = 0, start=0, end=0, step=0;
double origin_x = 0.0;
double origin_y = 0.0;
double rot = 0.0;
double scale_x = 1.0;
double scale_y = 1.0;

// 定义变量

#define YYSTYPE struct ExprNode *               //定义语义变量类型为树节点指针


// 声明变量
extern unsigned char*yytext;
extern struct Token token;      

// 声明函数
struct ExprNode * MakeExprNode(int opcode, ...);
double GetExprValue(struct ExprNode * expr);
void yyerror(char *str);
extern int yylex(void);
extern int yywrap(void);

%}



%token CONST_ID FUNC FOR T FROM TO STEP DRAW ORIGIN SCALE ROT IS SIN COS TAN LN EXP SQRT COMMA L_BRACKET R_BRACKET SEMICO ERRTOKEN;
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
                        rot = GetExprValue($3);
                        printf("%f\n",rot);
                    }
            ;

    
    Expression: T
                {
                        $$ = MakeExprNode(T);
                }
            | CONST_ID
                {
                        $$ = MakeExprNode(CONST_ID, token.value);
                }                           
            | Expression PLUS Expression
                {
                        $$ = MakeExprNode(PLUS, $1, $3);
                }
            | Expression MINUS Expression
                {
                        $$ = MakeExprNode(MINUS, $1, $3);
                }
            | Expression MUL Expression
                {
                        $$ = MakeExprNode(MUL, $1, $3);
                }
            | Expression DIV Expression
                {
                        $$ = MakeExprNode(DIV, $1, $3);
                }
            | Expression POWER Expression
                {
                        $$ = MakeExprNode(POWER, $1, $3);
                }
            | L_BRACKET Expression R_BRACKET
                {
                        $$ = $2;
                }
            | PLUS Expression %prec UNSUB
                {
                        $$ = $2;
                }
            | MINUS Expression %prec UNSUB
                {
                        MakeExprNode(MINUS, MakeExprNode(CONST_ID, 0.0),$2);
                }
            | FUNC L_BRACKET Expression R_BRACKET   
                {
                        MakeExprNode(FUNC, $3, token.FuncPtr);
                }
            | ERRTOKEN                              
                {
                        yyerror("error token\n");
                }
            ;


%%

int main(){
    yyparse();
}
    // 错误处理
void yyerror(char *str){
    fprintf(stderr,"error:%s\n",str);
}

struct ExprNode * MakeExprNode(int opcode, ...){
    va_list ArgPtr;
    struct ExprNode *ExprPtr = malloc(sizeof(struct ExprNode));
    ExprPtr->OpCode = opcode;
    va_start(ArgPtr, opcode);
    switch(opcode){
        case CONST_ID:
                ExprPtr->Content.CaseConst = (double)va_arg(ArgPtr,double);
                break;
        case FUNC:
                ExprPtr->Content.CaseFunc.Child = (struct ExprNode *)va_arg(ArgPtr,struct ExprNode *);
                ExprPtr->Content.CaseFunc.MathFuncPtr = (MathFuncPtr)va_arg(ArgPtr,FuncPtr);
                break;
        case T:
                ExprPtr->Content.CaseParm = &Parameter;
                break;
        default:
                ExprPtr->Content.CaseOperator.Left = (struct ExprNode *)va_arg(ArgPtr,struct ExprNode *);
                ExprPtr->Content.CaseOperator.Right = (struct ExprNode *)va_arg(ArgPtr,struct ExprNode *);
    }
    return ExprPtr;
}

double GetExprValue(struct ExprNode * expr){
        switch(expr->OpCode){
                case CONST_ID:
                        return expr->Content.CaseConst;
                        break;
                case T:
                        return *(expr->Content.CaseParm);
                        break;
                case PLUS:
                        return GetExprValue(expr->Content.CaseOperator.Left) + GetExprValue(expr->Content.CaseOperator.Right);
                        break;
                case MINUS:
                        return GetExprValue(expr->Content.CaseOperator.Left) - GetExprValue(expr->Content.CaseOperator.Right);
                        break;
                case MUL:
                        return GetExprValue(expr->Content.CaseOperator.Left) * GetExprValue(expr->Content.CaseOperator.Right);
                        break;
                case DIV:
                        return GetExprValue(expr->Content.CaseOperator.Left) / GetExprValue(expr->Content.CaseOperator.Right);
                        break;
                case POWER:
                        return pow(GetExprValue(expr->Content.CaseOperator.Left), GetExprValue(expr->Content.CaseOperator.Right));
                        break;   
                case FUNC:
                        return (*expr->Content.CaseFunc.MathFuncPtr)(GetExprValue(expr->Content.CaseFunc.Child));
                        break;      
        }
}
