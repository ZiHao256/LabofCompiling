#include<iostream>
#include<stdio.h>
#include<stdlib.h>
#include<string>
#include<math.h>
#include<stdarg.h>
#include<vector>
#include"../matplotlibcpp.h"

namespace plt = matplotlibcpp;
using namespace std;

// 函数声明
extern struct ExprNode * MakeExprNode(int opcode, ...);
extern double GetExprValue(struct ExprNode * expr);
extern string GetTokenStr(int tokenNum);
extern void TravelTree(struct ExprNode * root, int indent);
extern void DrawLoop(double draw_start, double draw_end, double draw_step, struct ExprNode* HorPtr, struct ExprNode* VerPtr);
extern void CalCoord(struct ExprNode*HorPtr, struct ExprNode*VerPtr, double &HorCoord, double &VerCoord);
extern void Clear();

// 变量定义
typedef double  (*MathFuncPtr)(double);
typedef double  (*FuncPtr)(double);

// token种别和属性
struct Token{
    char * lexeme;              // 记号的字面值
    int type;                   // 记号的种别
    double value;               // 记号的属性值
    double (*FuncPtr)(double);  // 函数地址
};

struct ExprNode{
    int OpCode;         //PLUS, MINUS, MUL, DIV, POWER, FUNC, CONSTID, T
    union {
        // 操作数是两个孩子的内部节点
        struct {
            struct ExprNode *Left, *Right;
        }CaseOperator;
        // 函数调用是一个孩子的内部节点
        struct {
            struct ExprNode *Child;
            FuncPtr MathFuncPtr;
        }CaseFunc;

        //常数和参数是叶子节点
        double CaseConst;   //绑定右值

        double* CaseParm;   //绑定左值
    }Content;
    
};
