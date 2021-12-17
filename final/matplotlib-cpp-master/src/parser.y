%{

#include"main.hpp"

// 宏定义
#define YYSTYPE struct ExprNode *               //定义语义变量类型为树节点指针,方便同时构造Expression的语法树

// 变量声明

extern struct Token token;  
extern unsigned int LineNo; 
    

// 函数声明

extern "C" int yylex(void);     //yylex
extern int yywrap(void);   
extern void yyerror(const char *str);
extern FILE* yyin;
extern FILE* yyout;
extern unsigned char* yytext;


// 变量定义

double Parameter = 0, draw_start=0, draw_end=0, draw_step=0;
double origin_x = 0.0;
double origin_y = 0.0;
double rot = 0.0;
double scale_x = 1.0;
double scale_y = 1.0;
string color = "random";
string line = "-";


%}

%token CONST_ID FUNC 
%token FOR T FROM TO STEP DRAW ORIGIN SCALE ROT IS 
%token CLEAR NEXT 
%token SIN COS TAN LN EXP SQRT COMMA L_BRACKET R_BRACKET SEMICO ERRTOKEN
%token COLOR RED GREEN BLUE BLACK RANDOM
%token LINE SOLID DASHED DOTTED
%token TITLE STR
%token COMMENT 
%left PLUS MINUS
%left MUL DIV
%right UNSUB
%right POWER
%start Program


%%
    Program: Program Statement SEMICO
            |
            | error
                {

                }
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
                                std::cout<<"\n\n\n——————————————————————开始绘画——————————————————————————"<<std::endl;
                                DrawLoop(draw_start, draw_end, draw_step, $11, $13);
                                std::cout<<"\n————————————————————————————————————————————————————————\n\n"<<std::endl;
                                
                    }
            | ORIGIN IS L_BRACKET Expression COMMA Expression R_BRACKET
                    {
                            origin_x = GetExprValue($4);
                            origin_y = GetExprValue($6);
                        //     std::cout<<"\n——————————————————————变量的值——————————————————————————"<<std::endl;
                        //     printf("\nrot = %f\n",rot);
                        //     printf("\ndraw_start = %f, draw_end = %f,draw_step = %f\n", draw_start, draw_end, draw_step);                            
                        //     printf("\norigin_x = %f, origin_y = %f\n",origin_x,origin_y);
                        //     printf("\nscale_x = %f, scale_y = %f\n",scale_x,scale_y);
                        //     std::cout<<"\n————————————————————————————————————————————————————————"<<std::endl;

                    }
            | SCALE IS L_BRACKET Expression COMMA Expression R_BRACKET
                    {
                            scale_x = GetExprValue($4);
                            scale_y = GetExprValue($6);
                        //     std::cout<<"\n——————————————————————变量的值——————————————————————————"<<std::endl;
                        //     printf("\nrot = %f\n",rot);
                        //     printf("\ndraw_start = %f, draw_end = %f,draw_step = %f\n", draw_start, draw_end, draw_step);                            
                        //     printf("\norigin_x = %f, origin_y = %f\n",origin_x,origin_y);
                        //     printf("\nscale_x = %f, scale_y = %f\n",scale_x,scale_y);
                        //     std::cout<<"\n————————————————————————————————————————————————————————"<<std::endl;
                    }
            | ROT IS Expression
                    {
                        rot = GetExprValue($3);
                        //     std::cout<<"\n——————————————————————变量的值——————————————————————————"<<std::endl;
                        //     printf("\nrot = %f\n",rot);
                        //     printf("\ndraw_start = %f, draw_end = %f,draw_step = %f\n", draw_start, draw_end, draw_step);                            
                        //     printf("\norigin_x = %f, origin_y = %f\n",origin_x,origin_y);
                        //     printf("\nscale_x = %f, scale_y = %f\n",scale_x,scale_y);
                        //     std::cout<<"\n————————————————————————————————————————————————————————"<<std::endl;
                    }
            | TITLE IS STR
                        {

                                std::cout<<"\n\n\n——————————————————————增加标题——————————————————————————"<<std::endl;
                                AddTitle(token.lexeme);
                                std::cout<<"\n————————————————————————————————————————————————————————\n\n"<<std::endl;                            
                                
                        }
            | COMMENT IS L_BRACKET Expression COMMA Expression COMMA STR R_BRACKET
                        {
                                std::cout<<"\n\n\n——————————————————————增加注释——————————————————————————"<<std::endl;
                                AddComment(GetExprValue($4), GetExprValue($6), token.lexeme);
                                std::cout<<"\n————————————————————————————————————————————————————————\n\n"<<std::endl;                                                            
                        }
            | COLOR IS ColorChoice
            | LINE IS LineChoice
            | CLEAR
                        {
                                std::cout<<"\n\n\n——————————————————————开始清图——————————————————————————"<<std::endl;
                                Clear();
                                std::cout<<"\n————————————————————————————————————————————————————————\n\n"<<std::endl;                            
                        }
            | NEXT
                        {
                                std::cout<<"\n\n\n——————————————————————绘制下一张图——————————————————————"<<std::endl;
                                Next();
                                std::cout<<"\n————————————————————————————————————————————————————————\n\n"<<std::endl;                                                           
                        }   
            ;

    ColorChoice: RED
                        {
                                color = "r";
                        }
                | GREEN
                        {
                                color = "g";
                        }
                | BLUE
                        {
                                color = "b";
                        }
                | BLACK
                        {
                                color = "k";
                        }
                ;

    LineChoice: SOLID
                        {
                                line = "-";
                        }
                | DASHED
                        {
                                line = "--";
                        }
                | DOTTED
                        {
                                line = ":";
                        }
                ;

    Expression: 
            ERRTOKEN                              
                {
                        yyerror("error token!\n");
                }
            | T
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
                        std::cout<<"\n\n\n——————————————————————————ExprTree——————————————————————————"<<std::endl;
                        int indent=-4;
                        TravelTree($$, indent);
                        std::cout<<"\n————————————————————————————————————————————————————————————\n\n"<<std::endl;
                }
            | Expression MINUS Expression
                {
                        $$ = MakeExprNode(MINUS, $1, $3);
                        std::cout<<"\n\n\n——————————————————————————ExprTree——————————————————————————"<<std::endl;
                        int indent=-4;
                        TravelTree($$, indent);
                        std::cout<<"\n————————————————————————————————————————————————————————————\n\n"<<std::endl;
                }
            | Expression MUL Expression
                {
                        $$ = MakeExprNode(MUL, $1, $3);
                        std::cout<<"\n\n\n——————————————————————————ExprTree——————————————————————————"<<std::endl;
                        int indent=-4;
                        TravelTree($$, indent);
                        std::cout<<"\n————————————————————————————————————————————————————————————\n\n"<<std::endl;
                }
            | Expression DIV Expression
                {
                        $$ = MakeExprNode(DIV, $1, $3);
                        std::cout<<"\n\n\n——————————————————————————ExprTree——————————————————————————"<<std::endl;
                        int indent=-4;
                        TravelTree($$, indent);
                        std::cout<<"\n————————————————————————————————————————————————————————————\n\n"<<std::endl;
                }
            | Expression POWER Expression
                {
                        $$ = MakeExprNode(POWER, $1, $3);
                        std::cout<<"\n\n\n——————————————————————————ExprTree——————————————————————————"<<std::endl;
                        int indent=-4;
                        TravelTree($$, indent);
                        std::cout<<"\n————————————————————————————————————————————————————————————\n\n"<<std::endl;
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
                        std::cout<<"\n\n\n——————————————————————————ExprTree——————————————————————————"<<std::endl;
                        int indent=0;
                        TravelTree($$, indent);
                        std::cout<<"\n————————————————————————————————————————————————————————————\n\n"<<std::endl;
                }
            | FUNC L_BRACKET Expression R_BRACKET   
                {
                        $$ = MakeExprNode(FUNC, $3, token.FuncPtr);
                }
            ;


%%
   // 函数定义

int main(int argc, char ** argv){
	if (argc>=2){
	  if ((yyin = fopen(argv[1], "r")) == NULL){
	    printf("Can't open file %s\n", argv[1]);
	    return 1;
	  }
	  if (argc>=3){
	    yyout=fopen(argv[2], "w");
	  }
	}

	// 语法分析驱动程序
        yyparse();	
        

        if(argc>=2){
	  fclose(yyin);
	  if (argc>=3) fclose(yyout);
	}
        return 0;
}
    // 错误处理
void yyerror(const char *str){
        std::cerr<<"\n!!!!!第"<<LineNo<<"行:"<< str <<std::endl;
}

