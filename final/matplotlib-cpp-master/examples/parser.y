%{

#include"main.hpp"

// 初始化参数
double Parameter = 0, draw_start=0, draw_end=0, draw_step=0;
double origin_x = 0.0;
double origin_y = 0.0;
double rot = 0.0;
double scale_x = 1.0;
double scale_y = 1.0;



// 定义变量

#define YYSTYPE struct ExprNode *               //定义语义变量类型为树节点指针,方便同时构造Expression的语法树

// string TokenStr[100] = {"CONST_ID","FUNC","FOR", "T","FROM", "TO", "STEP", "DRAW", "ORIGIN", "SCALE", "ROT", "IS" ,"SIN", "COS", "TAN", "LN" ,"EXP" ,"SQRT", "COMMA", "L_BRACKET", "R_BRACKET", "SEMICO", "ERRTOKEN", "PLUS" "MINUS", "MUL", "DIV","UNSUB", "POWER"};

// 声明变量
extern "C"{
        extern struct Token token;  
}
    

// 声明函数
extern "C"{
        extern int yylex(void);
        int yywrap(void);   
        void yyerror(const char *str);
        extern FILE* yyin;
        extern FILE* yyout;
             
}
struct ExprNode * MakeExprNode(int opcode, ...);
double GetExprValue(struct ExprNode * expr);
void TravelTree(struct ExprNode * root, int indent);
void DrawLoop(double draw_start, double draw_end, double draw_step, struct ExprNode* HorPtr, struct ExprNode* VerPtr);

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
                                draw_start = GetExprValue($4);
                                draw_end = GetExprValue($6);
                                draw_step = GetExprValue($8);
                                std::cout<<"\n——————————————————————变量的值——————————————————————————"<<std::endl;
                                printf("\nrot = %f\n",rot);
                                printf("\ndraw_start = %f, draw_end = %f,draw_step = %f\n", draw_start, draw_end, draw_step);                            
                                printf("\norigin_x = %f, origin_y = %f\n",origin_x,origin_y);
                                printf("\nscale_x = %f, scale_y = %f\n",scale_x,scale_y);
                                std::cout<<"\n————————————————————————————————————————————————————————"<<std::endl;
                                std::cout<<"\n——————————————————————开始绘画——————————————————————————"<<std::endl;
                                DrawLoop(draw_start, draw_end, draw_step, $11, $13);
                                std::cout<<"\n————————————————————————————————————————————————————————"<<std::endl;
                                
                    }
            | ORIGIN IS L_BRACKET Expression COMMA Expression R_BRACKET
                    {
                            origin_x = GetExprValue($4);
                            origin_y = GetExprValue($6);
                            std::cout<<"\n——————————————————————变量的值——————————————————————————"<<std::endl;
                            printf("\nrot = %f\n",rot);
                            printf("\ndraw_start = %f, draw_end = %f,draw_step = %f\n", draw_start, draw_end, draw_step);                            
                            printf("\norigin_x = %f, origin_y = %f\n",origin_x,origin_y);
                            printf("\nscale_x = %f, scale_y = %f\n",scale_x,scale_y);
                            std::cout<<"\n————————————————————————————————————————————————————————"<<std::endl;

                    }
            | SCALE IS L_BRACKET Expression COMMA Expression R_BRACKET
                    {
                            scale_x = GetExprValue($4);
                            scale_y = GetExprValue($6);
                            std::cout<<"\n——————————————————————变量的值——————————————————————————"<<std::endl;
                            printf("\nrot = %f\n",rot);
                            printf("\ndraw_start = %f, draw_end = %f,draw_step = %f\n", draw_start, draw_end, draw_step);                            
                            printf("\norigin_x = %f, origin_y = %f\n",origin_x,origin_y);
                            printf("\nscale_x = %f, scale_y = %f\n",scale_x,scale_y);
                            std::cout<<"\n————————————————————————————————————————————————————————"<<std::endl;
                    }
            | ROT IS Expression
                    {
                        rot = GetExprValue($3);
                            std::cout<<"\n——————————————————————变量的值——————————————————————————"<<std::endl;
                            printf("\nrot = %f\n",rot);
                            printf("\ndraw_start = %f, draw_end = %f,draw_step = %f\n", draw_start, draw_end, draw_step);                            
                            printf("\norigin_x = %f, origin_y = %f\n",origin_x,origin_y);
                            printf("\nscale_x = %f, scale_y = %f\n",scale_x,scale_y);
                            std::cout<<"\n————————————————————————————————————————————————————————"<<std::endl;
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
                        std::cout<<"\n————————————————————————————tree————————————————————————————"<<std::endl;
                        int indent=-4;
                        TravelTree($$, indent);
                        std::cout<<"\n————————————————————————————————————————————————————————————"<<std::endl;
                }
            | Expression MINUS Expression
                {
                        $$ = MakeExprNode(MINUS, $1, $3);
                        std::cout<<"\n————————————————————————————tree————————————————————————————"<<std::endl;
                        int indent=-4;
                        TravelTree($$, indent);
                        std::cout<<"\n————————————————————————————————————————————————————————————"<<std::endl;
                }
            | Expression MUL Expression
                {
                        $$ = MakeExprNode(MUL, $1, $3);
                        std::cout<<"\n————————————————————————————tree————————————————————————————"<<std::endl;
                        int indent=-4;
                        TravelTree($$, indent);
                        std::cout<<"\n————————————————————————————————————————————————————————————"<<std::endl;
                }
            | Expression DIV Expression
                {
                        $$ = MakeExprNode(DIV, $1, $3);
                        std::cout<<"\n————————————————————————————tree————————————————————————————"<<std::endl;
                        int indent=-4;
                        TravelTree($$, indent);
                        std::cout<<"\n————————————————————————————————————————————————————————————"<<std::endl;
                }
            | Expression POWER Expression
                {
                        $$ = MakeExprNode(POWER, $1, $3);
                        std::cout<<"\n————————————————————————————tree————————————————————————————"<<std::endl;
                        int indent=-4;
                        TravelTree($$, indent);
                        std::cout<<"\n————————————————————————————————————————————————————————————"<<std::endl;
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
                        $$ = MakeExprNode(MINUS, MakeExprNode(CONST_ID, 0.0),$2);
                        std::cout<<"\n————————————————————————————tree————————————————————————————"<<std::endl;
                        int indent=0;
                        TravelTree($$, indent);
                        std::cout<<"\n————————————————————————————————————————————————————————————"<<std::endl;
                }
            | FUNC L_BRACKET Expression R_BRACKET   
                {
                        $$ = MakeExprNode(FUNC, $3, token.FuncPtr);
                }
            | ERRTOKEN                              
                {
                        yyerror("error token\n");
                }
            ;


%%

int main(int argc, char ** argv){
	int c,j=0;
	if (argc>=2){
	  if ((yyin = fopen(argv[1], "r")) == NULL){
	    printf("Can't open file %s\n", argv[1]);
	    return 1;
	  }
	  if (argc>=3){
	    yyout=fopen(argv[2], "w");
	  }
	}

	
        yyparse();	
        
        if(argc>=2){
	  fclose(yyin);
	  if (argc>=3) fclose(yyout);
	}
        return 0;
}
    // 错误处理
void yyerror(const char *str){
    std::cerr<< str <<std::endl;
}

struct ExprNode * MakeExprNode(int opcode, ...){
    va_list ArgPtr;
    struct ExprNode *ExprPtr = new struct ExprNode;
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
                        return (* expr->Content.CaseFunc.MathFuncPtr)(GetExprValue(expr->Content.CaseFunc.Child));
                        break;
                default:
                        return 0.0;      
        }
}

void TravelTree(struct ExprNode * root, int indent){
        indent += 4;
        switch(root->OpCode){
                case CONST_ID:
                        printf("%*s%f\n",indent," ",root->Content.CaseConst);
                        break;
                case FUNC:
                        printf("%*s%p\n",indent," ",root->Content.CaseFunc.MathFuncPtr);
                        TravelTree(root->Content.CaseFunc.Child, indent);
                        break;
                case T:
                        printf("%*sT\n",indent," ");
                        break;
                default:
                        printf("%*s%d\n",indent," ",root->OpCode);
                        TravelTree(root->Content.CaseOperator.Left, indent);
                        TravelTree(root->Content.CaseOperator.Right, indent);
                        break;
        }
}

void DrawLoop(double draw_start, double draw_end, double draw_step, struct ExprNode* HorPtr, struct ExprNode* VerPtr){
        int n = (int) ((draw_end-draw_start)/(draw_step));
        cout<<"\n共"<<n<<"个点"<<endl;
        
}