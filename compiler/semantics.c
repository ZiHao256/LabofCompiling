#include"semantics.h"
extern double Paramete,start,end, step,
                origin_x,origin_y,
                rot,
                scale_x,scale_y;

extern unsigned int LineNo;
double GetExprValue(struct ExprNode* root);