%{

#include"main.hpp"

// 初始化参数
double Parameter = 0, draw_start=0, draw_end=0, draw_step=0;
double origin_x = 0.0;
double origin_y = 0.0;
double rot = 0.0;
double scale_x = 1.0;
double scale_y = 1.0;
int filename=0;



// 定义变量

#define YYSTYPE struct ExprNode *               //定义语义变量类型为树节点指针,方便同时构造Expression的语法树

// string TokenStr[100] = {"CONST_ID","FUNC","FOR", "T","FROM", "TO", "STEP", "DRAW", "ORIGIN", "SCALE", "ROT", "IS" ,"SIN", "COS", "TAN", "LN" ,"EXP" ,"SQRT", "COMMA", "L_BRACKET", "R_BRACKET", "SEMICO", "ERRTOKEN", "PLUS" "MINUS", "MUL", "DIV","UNSUB", "POWER"};

// 声明变量
extern "C"{
        extern struct Token token;  
        extern unsigned int LineNo; 
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
string GetTokenStr(int tokenNum);
void TravelTree(struct ExprNode * root, int indent);
void DrawLoop(double draw_start, double draw_end, double draw_step, struct ExprNode* HorPtr, struct ExprNode* VerPtr);
void CalCoord(struct ExprNode*HorPtr, struct ExprNode*VerPtr, double &HorCoord, double &VerCoord);

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
                        yyerror("error token!\n");
                }
            ;


%%
        // 函数定义区

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
    std::cerr<<"\n第"<<LineNo<<"行:"<< str <<std::endl;
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
                // 使得在绘图时能获得不断变化的t
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

string GetTokenStr(int tokenNum){
        switch(tokenNum){
                case (int)PLUS:
                        return "PLUS";
                        break;
                case (int)MINUS:
                        return "MINUS";
                        break;
                case (int)POWER:
                        return "POWER";
                        break;
                case (int)MUL:
                        return "MUL";
                        break;
                case (int)DIV:
                        return "DIV";
                        break;
                default:
                        return NULL;
                
        }
}

void TravelTree(struct ExprNode * root, int indent){
        indent += 4;    // 节点前的空格
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
                        printf("%*s",indent," ");
                        cout<<GetTokenStr(root->OpCode)<<endl;
                        TravelTree(root->Content.CaseOperator.Left, indent);
                        TravelTree(root->Content.CaseOperator.Right, indent);
                        break;
        }
}

void DrawLoop(double draw_start, double draw_end, double draw_step, struct ExprNode* HorPtr, struct ExprNode* VerPtr){
        int n = (uint)((draw_end-draw_start)/draw_step);
        cout<<n<<"个点"<<endl;
        vector<double> x(n+1),y(n+1);

        double x_coord,y_coord;
        int i=0;
        for(Parameter=draw_start; Parameter<=draw_end; Parameter+=draw_step){
                
                CalCoord(HorPtr, VerPtr, x_coord, y_coord);

                x.at(i) = x_coord;
                y.at(i) = y_coord;
                i++;
        }        
        // 绘画一组坐标点
        plt::xlim(0,1000);
        plt::ylim(1000,0);
        plt::plot(x,y);
        //给文件名字
        char str[20];
        sprintf(str,"./picture/%d.png",filename);
  
        cout << "Saving result to " << filename <<".png"<<endl;
        filename++;
        plt::save(str);

}

void CalCoord(struct ExprNode*HorPtr, struct ExprNode*VerPtr, double &HorCoord, double &VerCoord){
        double t;
        
        // 点的原始坐标
        HorCoord = GetExprValue(HorPtr);
        VerCoord = GetExprValue(VerPtr);

        // 先比例变换
        HorCoord *= scale_x;
        VerCoord *= scale_y;

        // 旋转变换
        t = HorCoord*cos(rot)+VerCoord*sin(rot);
        VerCoord = VerCoord*cos(rot) - HorCoord*sin(rot);
        HorCoord = t;

        // 平移变换
        HorCoord += origin_x;
        VerCoord += origin_y;
}
