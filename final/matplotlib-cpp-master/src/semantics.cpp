#include"main.hpp"
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
void Next();
void AddTitle(string title);
void AddComment(double x_coord, double y_coord, string comment);

// 变量定义
int filename=0; // 绘制图片的文件名

// 函数定义
struct ExprNode * MakeExprNode(int opcode, ...){
    // 构造以操作符、函数、常数、参数构成的树
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
        // 获得Expr的值
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
        // 输出Expr的语法树
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
        // 绘制一条由点组成的线
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
        
        plt::xkcd(); //漫画效果
        
        // 绘画一组坐标点
        plt::xlim(-10,1010);
        plt::ylim(-10,1010);

        // cout<<color+line<<endl;

        if (color != "random"){
              plt::plot(x,y,color+line);   
        }else{
              plt::plot(x,y,line);    
        }
           
        // cout<<color+line<<endl;

        //给文件名字
        char str[20];
        sprintf(str,"./picture/%d.png",filename);
        // cout<<str<<endl;
        cout << "Saving result to " << filename <<".png"<<endl;
        plt::save(str);

}

void CalCoord(struct ExprNode*HorPtr, struct ExprNode*VerPtr, double &HorCoord, double &VerCoord){
        // 计算实际坐标
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
        // 清空这一张图
        plt::cla();
        plt::xlim(-10,1010);
        plt::ylim(-10,1010);
        //给文件名字
        char str[20];
        sprintf(str,"./picture/%d.png",filename);
        cout << "Saving result to " << filename <<".png"<<endl;
        plt::save(str);
}

void Next(){
        // 绘制下一张图
        filename++;
}

void AddTitle(string title){
        // 增加标题
        title.erase(0,1);
        title.pop_back();
        plt::title(title);
        //给文件名字
        char str[20];
        sprintf(str,"./picture/%d.png",filename);
        // cout<<str<<endl;
        cout << "Saving result to " << filename <<".png"<<endl;
        plt::save(str);
}

void AddComment(double x_coord, double y_coord, string comment){
        // 增加注释
        plt::text(x_coord, y_coord, comment);
        //给文件名字
        char str[20];
        sprintf(str,"./picture/%d.png",filename);
        // cout<<str<<endl;
        cout << "Saving result to " << filename <<".png"<<endl;
        plt::save(str);
}