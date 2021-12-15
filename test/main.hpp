#include<iostream>
#include<stdio.h>
#include<stdlib.h>
#include<string>
#include<math.h>
#include<stdarg.h>
#include<vector>

typedef double  (*MathFuncPtr)(double);
typedef double  (*FuncPtr)(double);


struct Token{
    char * lexeme;              // 记号的字面值
    int type;                   // 记号的种别
    double value;               // 记号的属性值
    double (*FuncPtr)(double);  // 函数地址
};

struct ExprNode{
    int OpCode;         //PLUS, MINUS, MUL, DIV, POWER, FUNC, CONSTID, T
    union {
        struct {
            struct ExprNode *Left, *Right;
        }CaseOperator;

        struct {
            struct ExprNode *Child;
            FuncPtr MathFuncPtr;
        }CaseFunc;

        double CaseConst;

        double* CaseParm;
    }Content;
    
};

