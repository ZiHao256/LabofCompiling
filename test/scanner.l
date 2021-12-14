%{
    /* 定义声明*/
#include"main.h"
#include"y.tab.h"
unsigned int LineNo;        // 记录行号

    // 定义变量
struct Token token;

    // 定义函数
int yywrap(void){
    return 1;
}

%}
    // 状态
%x comment_entry 

number      [0-9]+(\.[0-9]*)?
ws          [\t]+
newline     \n
comments    "//"|"--"

%%
  /* 第二部分是词法规则部分。 */
  /* 写在这一部分的注释要有前导空格，否则lex编译出错。*/
  /* 翻译规则的形式是：正规式  {动作}
   * 其中，正规式要顶行首写，动作要以C语法写（动作会被拷贝到yylex()函数中，），\
   * 正规式和动作之间要用空白分割。
   */

{comments}                      {BEGIN comment_entry;}
{ws}                            {;}
{newline}                       {LineNo++;}

    /* 关键词 */
"ORIGIN"                        {return (ORIGIN);}
"SCALE"                         {return (SCALE);}
"ROT"                           {return (ROT);}
"IS"                            {return (IS);}
"FOR"                           {return (FOR);}
"FROM"                          {return (FROM);}
"TO"                            {return (TO);}
"STEP"                          {return (STEP);}
"DRAW"                          {return (DRAW);}

    /* 参数 */
"T"                             {return (T);}

    /* 函数 */
"SIN"                           {token.type=FUNC; token.FuncPtr=sin; return (FUNC);}
"COS"                           {token.type=FUNC; token.FuncPtr=cos; return (FUNC);}
"TAN"                           {token.type=FUNC; token.FuncPtr=tan; return (FUNC);}
"LN"                            {token.type=FUNC; token.FuncPtr=log; return (FUNC);}
"EXP"                           {token.type=FUNC; token.FuncPtr=exp; return (FUNC);}
"SQRT"                          {token.type=FUNC; token.FuncPtr=sqrt; return (FUNC);}


    /* 常数 */
{number}                    {token.type = CONST_ID; token.value = atof(yytext); return (CONST_ID);}
"PI"                        {token.type = CONST_ID; token.value = 3.1415926; return (CONST_ID);}
"E"                         {token.type = CONST_ID; token.value = 2.7; return (CONST_ID);}

    /* 分隔符 */
";"                         {return (SEMICO);}
"("                         {return (L_BRACKET);}
")"                         {return (R_BRACKET);}
","                         {return (COMMA);}

    /* 运算符 */
"**"                        {return (POWER);}
"+"                         {return (PLUS);}
"-"                         {return (MINUS);}
"*"                         {return (MUL);}
"/"                         {return (DIV);}

(" "|\t|\n|\r|\f|\v)+       {;}

.                           {return (ERRTOKEN);}


<comment_entry>. ;
<comment_entry>\n   BEGIN 0; LineNo++;

%%

double sin(double num){
    return 1;
}
double cos(double num){
    return 1;
}
double tan(double num){
    return 1;
}
double log(double num){
    return 1;
}
double exp(double num){
    return 1;
}
double sqrt(double num){
    return 1;
}