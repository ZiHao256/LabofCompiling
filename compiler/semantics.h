#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<math.h>
#include"y.tab.h"

typedef double (*MathFuncPtr)(double);
typedef double (*FuncPtr)(double);

struct Token{
    char * lexeme;              // 记号的字面值
    int type;                   // 记号的种别
    double value;               // 记号的属性值
    double (*FuncPtr)(double);  // 函数地址
};


struct ExprNode{
    // enum OpCode{
    //     PLUS, MINUS, MUL, DIV, POWER, FUNC, CONST_ID
    // };
    // enum Token_Type OpCode;
    union Content{
        struct CaseOperator{
            struct ExprNode *Left, *Right;
        };
        struct CaseFunc{
            struct ExprNode *Child;
            FuncPtr MathFuncPtr;
        };
    };
    
};
extern struct ExprNode * MakeExprNode(enum Token_Type opcode, ...);


