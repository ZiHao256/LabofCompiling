#include"semantics.hpp"
#include"y.tab.hpp"

// 变量声明

extern double Parameter, draw_start, draw_end, draw_step;
extern double origin_x;
extern double origin_y;
extern double rot;
extern double scale_x;
extern double scale_y; 
extern string color; 
extern string line;   


// 函数声明
struct ExprNode * MakeExprNode(int opcode, ...);
double GetExprValue(struct ExprNode * expr);
string GetTokenStr(int tokenNum);
void TravelTree(struct ExprNode * root, int indent);
void DrawLoop(double draw_start, double draw_end, double draw_step, struct ExprNode* HorPtr, struct ExprNode* VerPtr);
void CalCoord(struct ExprNode*HorPtr, struct ExprNode*VerPtr, double &HorCoord, double &VerCoord);
void Clear();

// 变量定义
int filename=0;

// 函数定义
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
        // 获得操作符token的字符串
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
        vector<double> x(n+1,0),y(n+1,0);

        double x_coord,y_coord;                 //C++引用传值
        int i=0;
        for(Parameter=draw_start; Parameter<draw_end; Parameter+=draw_step){
                CalCoord(HorPtr, VerPtr, x_coord, y_coord);     //计算变换后的坐标
                // cout<<i<<endl;
                x.at(i) = x_coord;
                y.at(i) = y_coord;
                i++;
                if (i==n) break;
        }       
        x.at(n) = x_coord;
        y.at(n) = y_coord;        
        
        // plt::xkcd(); //漫画效果
        
        // 绘画一组坐标点
        plt::xlim(-10,1010);
        plt::ylim(-10,1010);

        if (color != "random"){
            plt::plot(x,y,color+line);    
        }else{
                plt::plot(x,y,line);
        }
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

void Clear(){
        plt::cla();
        plt::xkcd();
        plt::xlim(-10,1010);
        plt::ylim(-10,1010);
        //给文件名字
        char str[20];
        sprintf(str,"./picture/%d.png",filename);
        cout << "Saving result to " << filename <<".png"<<endl;
        filename++;
        plt::save(str);
}