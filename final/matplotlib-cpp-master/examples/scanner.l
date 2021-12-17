%{
#include"semantics.hpp"
#include"y.tab.hpp"

    // 宏定义
#define PI_VALUE 3.1415926
#define E_VALUE 2.7182818

    // 函数声明
extern "C"{
    int yywrap(void);
    int yylex(void);
}
    // 变量定义
unsigned int LineNo = 1;        // 记录行号
struct Token token;

%}
    // 状态
%x comment_entry 

number      [0-9]+(\.[0-9]*)?
ws          [\t]+
newline     \n
comments    "//"|"--"[^\n]*

%%
  /* 第二部分是词法规则部分。 */
  /* 写在这一部分的注释要有前导空格，否则lex编译出错。*/
  /* 翻译规则的形式是：正规式  {动作}
   * 其中，正规式要顶行首写，动作要以C语法写（动作会被拷贝到yylex()函数中，），\
   * 正规式和动作之间要用空白分割。
   */

{comments}                      {BEGIN comment_entry; printf("\n————————————————————————————注释————————————————————————————\n"); printf("%s",yytext);printf("\n————————————————————————————————————————————————————————————\n");}
{ws}                            {;}
{newline}                       {LineNo++; printf("\n");}

    /* 关键词 */
"ORIGIN"                        {printf("(ORIGIN,\"ORIGIN\",0.0,NULL) "); return (ORIGIN);}
"SCALE"                         {printf("(SCALE,\"SCALE\",0.0,NULL) "); return (SCALE);}
"ROT"                           {printf("(ROT,\"ROT\",0.0,NULL) "); return (ROT);}
"IS"                            {printf("(IS,\"IS\",0.0,NULL) ") ; return (IS);}
"FOR"                           {printf("(FOR,\"FOR\",0.0,NULL) "); return (FOR);}
"FROM"                          {printf("(FROM,\"FROM\",0.0,NULL)"); return (FROM);}
"TO"                            {printf("(TO,\"TO\",0.0,NULL) "); return (TO);}
"STEP"                          {printf("(STEP,\"STEP\",0.0,NULL) "); return (STEP);}
"DRAW"                          {printf("(DRAW,\"DRAW\",0.0,NULL) "); return (DRAW);}
"CLEAR"                         {return (CLEAR);}
"COLOR"                         {return (COLOR);}
"RED"                           {return (RED);}
"GREEN"                         {return (GREEN);}
"BLUE"                          {return (BLUE);}
"RANDOM"                        {return (RANDOM);}
"LINE"                          {return (LINE);}
"SOLID"                         {return (SOLID);}
"DASHED"                        {return (DASHED);}
"DOTTED"                        {return (DOTTED);}
    
    /* 参数 */
"T"                             {printf("(T,\"T\",0.0,NULL) "); return (T);}

    /* 函数 */
"SIN"                           {token.type=FUNC; token.FuncPtr=sin; printf("(FUNC,\"SIN\",0.0,%p) ",token.FuncPtr);  return (FUNC);}
"COS"                           {token.type=FUNC; token.FuncPtr=cos; printf("(FUNC,\"COS\",0.0,%p) ",token.FuncPtr); return (FUNC);}
"TAN"                           {token.type=FUNC; token.FuncPtr=tan; printf("(FUNC,\"TAN\",0.0,%p) ",token.FuncPtr); return (FUNC);}
"LN"                            {token.type=FUNC; token.FuncPtr=log; printf("(FUNC,\"LN\",0.0,%p) ",token.FuncPtr); return (FUNC);}
"EXP"                           {token.type=FUNC; token.FuncPtr=exp; printf("(FUNC,\"EXP\",0.0,%p) ",token.FuncPtr); return (FUNC);}
"SQRT"                          {token.type=FUNC; token.FuncPtr=sqrt; printf("(FUNC,\"SQRT\",0.0,%p) ",token.FuncPtr); return (FUNC);}


    /* 常数 */
{number}                    {token.type = CONST_ID; token.value = atof(yytext); printf("(CONST_ID,\"%f\",%f,NULL) ",atof(yytext),atof(yytext)); return (CONST_ID);}
"PI"                        {token.type = CONST_ID; token.value = PI_VALUE; printf("(CONST_ID,\"PI\",%f,NULL) ",PI_VALUE); return (CONST_ID);}
"E"                         {token.type = CONST_ID; token.value = E_VALUE; printf("(CONST_ID,\"E\",%f,NULL) ",E_VALUE); return (CONST_ID);}

    /* 分隔符 */
";"                         {return (SEMICO);}
"("                         {return (L_BRACKET);}
")"                         {return (R_BRACKET);}
","                         {return (COMMA);}

    /* 运算符 */
"**"                        {printf("(POWER,\"**\",0.0,NULL) "); return (POWER);}
"+"                         {printf("(PLUS,\"+\",0.0,NULL) "); return (PLUS);}
"-"                         {printf("(MINUS,\"-\",0.0,NULL) "); return (MINUS);}
"*"                         {printf("(MUL,\"*\",0.0,NULL) "); return (MUL);}
"/"                         {printf("(DIV,\"/\",0.0,NULL) "); return (DIV);}

(" "|\t|\n|\r|\f|\v)+       {;}

.                           {return (ERRTOKEN);}


<comment_entry>. ;
<comment_entry>\n   BEGIN 0; LineNo++;

%%
// 函数定义

int yywrap(void){
    cout<<"\n————————————————————————————输入结束————————————————————————————"<<endl;
    return 1;
}
